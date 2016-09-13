#!/usr/bin/env Rscript

argv = commandArgs(TRUE)
if (length(argv) != 4) {
	 cat("Usage: plot_ROC_sasa ground_truth_dir exclude_bp experiment_prefix output_name\n")
	 q(status = 1)
}

library(PRROC)

collectTruth = function(name, ground_truth_dir, exclude_bp) {
	truth = scan(sprintf("%s/yeast_%s.structure", ground_truth_dir, name), what = 0)
	isAC = scan(sprintf("%s/yeast_%s.isac", ground_truth_dir, name), what = 0)
	
	# load sasa
	data = read.table(sprintf("%s/yeast_%s.silvi.sasa", ground_truth_dir, name))
	sasa = rep(-1.0, length(truth))
	sasa[data[,1]] = data[,3]

	# true positives and negatives
	tp = isAC & truth == 1 & sasa > 2.0
	tn = isAC & truth == 0
	idx = tp | tn

	# select positions used for plotting
	pos = which(idx[1:(length(truth) - exclude_bp)])

	return(list(truth = truth, pos = pos))
}

collectPROBer = function(pos, file_name) {
	prober = scan(file_name, what = "", skip = pos, nlines = 1)
	as.numeric(prober[3:length(prober)])
}

collectScore = function(pos, file_name) {
	scan(file_name, what = 0.0, skip = pos - 1, nlines = 1)
}

calculateROC = function(id, estList, truthList) {
	pos = truthList[[id]]$pos
	truth = truthList[[id]]$truth
	roc.curve(estList[[id]][pos], weights.class0 = truth[pos], curve = T)
}

calculatePR = function(id, estList, truthList) {
	pos = truthList[[id]]$pos
	truth = truthList[[id]]$truth
	pr.curve(estList[[id]][pos], weights.class0 = truth[pos], curve = T)
}

plotROC = function(id, output_name, rRNAs, PROBerRocs, ModseqRocs, icSHAPERocs) {
	pdf(sprintf("%s_%s_ROC.pdf", output_name, rRNAs[id]))

	par(oma = c(0, 0, 0, 0), mar = c(5, 4, 0, 0) + 0.1)
	plot(PROBerRocs[[id]], lwd = 1, col = "red", auc.main = F, main = "") #rRNAs[id])
	plot(ModseqRocs[[id]], lwd = 1, col = "green", add = T)
	plot(icSHAPERocs[[id]], lwd = 1, col = "orange", add = T)


	legends = c(as.expression(bquote(paste("PROBer, AUC = ", .(sprintf("%.2f", PROBerRocs[[id]]$auc))))))
	legends = c(legends, as.expression(bquote(paste("Mod-seq, AUC = ", .(sprintf("%.2f", ModseqRocs[[id]]$auc))))),
							as.expression(bquote(paste("icSHAPE, AUC = ", .(sprintf("%.2f", icSHAPERocs[[id]]$auc))))))

	colors = c("red", "green", "orange")

	legend("bottomright", legend = legends, lty = 1, col = colors)

	null = dev.off()

	cat(sprintf("PROBer = %.2f, Mod-seq = %.2f, icSHAPE = %.2f\n", PROBerRocs[[id]]$auc, ModseqRocs[[id]]$auc, icSHAPERocs[[id]]$auc))

	return(NULL)
}

plotPR = function(id, output_name, rRNAs, PROBerPrs, ModseqPrs, icSHAPEPrs) {
	pdf(sprintf("%s_%s_PR.pdf", output_name, rRNAs[id]))

	par(oma = c(0, 0, 0, 0), mar = c(5, 4, 0, 0) + 0.1)
	plot(PROBerPrs[[id]], lwd = 1, col = "red", auc.main = F, main = "") #rRNAs[id])
	plot(ModseqPrs[[id]], lwd = 1, col = "green", add = T)
	plot(icSHAPEPrs[[id]], lwd = 1, col = "orange", add = T)


	legends = c(as.expression(bquote(paste("PROBer, AUC = ", .(sprintf("%.2f", PROBerPrs[[id]]$auc.integral))))))
	legends = c(legends, as.expression(bquote(paste("Mod-seq, AUC = ", .(sprintf("%.2f", ModseqPrs[[id]]$auc.integral))))),
							as.expression(bquote(paste("icSHAPE, AUC = ", .(sprintf("%.2f", icSHAPEPrs[[id]]$auc.integral))))))

	colors = c("red", "green", "orange")

	legend("bottomright", legend = legends, lty = 1, col = colors)

	null = dev.off()

	cat(sprintf("PROBer = %.2f, Mod-seq = %.2f, icSHAPE = %.2f\n", PROBerPrs[[id]]$auc.integral, ModseqPrs[[id]]$auc.integral, icSHAPEPrs[[id]]$auc.integral))

	return(NULL)
}

fileList = c(sprintf("%s_PROBer.beta", argv[3]), sprintf("%s_%s.scores", argv[3], c("Modseq", "icSHAPE")))

rRNAs = c("18S", "25S")
rowList = 36:37

truthList = lapply(rRNAs, collectTruth, argv[1], as.numeric(argv[2]))

PROBerList = lapply(rowList, collectPROBer, fileList[1])
ModseqList = lapply(rowList, collectScore, fileList[2])
icSHAPEList = lapply(rowList, collectScore, fileList[3])

PROBerRocs = lapply(1:2, calculateROC, PROBerList, truthList)
ModseqRocs = lapply(1:2, calculateROC, ModseqList, truthList)
icSHAPERocs = lapply(1:2, calculateROC, icSHAPEList, truthList)


PROBerPrs = lapply(1:2, calculatePR, PROBerList, truthList)
ModseqPrs = lapply(1:2, calculatePR, ModseqList, truthList)
icSHAPEPrs = lapply(1:2, calculatePR, icSHAPEList, truthList)

cat("ROCs\n")
null_vec = lapply(1:2, plotROC, argv[4], rRNAs, PROBerRocs, ModseqRocs, icSHAPERocs)
cat("PRs\n")
null_vec = lapply(1:2, plotPR, argv[4], rRNAs, PROBerPrs, ModseqPrs, icSHAPEPrs)
