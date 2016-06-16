#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<cassert>
#include<fstream>
#include<sstream>
#include<string>
using namespace std;

int w;
double threshold;

ifstream fm, fr, fn;
istringstream strin;
string line, chr;
char ori;
int pos, nuniq;
double nmulti;

string tchr;
char tori;
int tpos, motif_pos;

double a[5], b[5];

int main(int argc, char* argv[]) {
  if (argc != 7) {
    printf("Usage: calcMotifRate w threshold name.motifs name_res.site_info name_naive.site_info output_file\n");
    exit(-1);
  }

  w = atoi(argv[1]);
  threshold = atof(argv[2]);

  memset(a, 0, sizeof(a));
  memset(b, 0, sizeof(b));

  fm.open(argv[3]);
  fr.open(argv[4]);
  fn.open(argv[5]);

  int cnt = 0;
  while (getline(fr, line)) {
    strin.clear(); strin.str(line);
    strin>> chr>> ori>> pos>> nuniq>> nmulti;

    getline(fm, line);
    strin.clear(); strin.str(line);
    strin>> tchr>> tori>> tpos>> motif_pos;
    assert(tchr == chr && tori == ori && tpos == pos);
    
    int value = abs(motif_pos) <= w;

    if (nuniq >= threshold) {
      a[0] += value;
      ++b[0];
    }
    
    if (nmulti >= threshold && nuniq == 0) {
      a[1] += value;
      ++b[1];
    }

    if (nuniq + nmulti >= threshold && nuniq < threshold) {
      a[3] += value;
      ++b[3];
    }

    getline(fn, line);
    strin.clear(); strin.str(line);
    strin>> tchr>> tori>> tpos>> nuniq>> nmulti;
    assert(tchr == chr && tori == ori && tpos == pos);

    if (nmulti >= threshold && nuniq == 0) {
      a[2] += value;
      ++b[2];
    }

    if (nuniq + nmulti >= threshold && nuniq < threshold) {
      a[4] += value;
      ++b[4];
    }

    ++cnt;
    if (cnt % 1000000 == 0) printf("FIN %d\n", cnt);
  }

  fm.close();
  fr.close();
  fn.close();

  FILE *fo = fopen(argv[6], "w");
  fprintf(fo, "\tUnique\tPROBer_m\tNaive_m\tPROBer_e\tNaive_e\n");
  fprintf(fo, "Total sites");
  for (int i = 0; i < 5; ++i) fprintf(fo, "\t%.0f", b[i]);
  fprintf(fo, "\nUGCAUG");
  for (int i = 0; i < 5; ++i) fprintf(fo, "\t%.2f%%", a[i] * 100.0 / b[i]);
  fprintf(fo, "\n");
  fclose(fo);

  return 0;
}
