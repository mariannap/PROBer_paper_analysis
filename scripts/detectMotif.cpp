#include<cstdio>
#include<cstring>
#include<cctype>
#include<cstdlib>
#include<cassert>
#include<string>
#include<vector>
#include<fstream>
#include<sstream>
using namespace std;

class Genome {
public:
  Genome(const char* file, const char* motif, int w) {
    this->motif = motif;
    this->w = w;
    
    chr = seq = ""; len = 0;

    string line;
    fin.open(file);
    while (getline(fin, line) && line[0] != '>');
    assert(line[0] == '>');
    chr_name = line.substr(1, line.find_first_of(' ') - 1);
  }

  ~Genome() { fin.close(); }

  void seek(const string& chr) {
    string line;

    assert(this->chr != chr);

    seq = "";
    while (fin.good() && this->chr != chr) {
      this->chr = chr_name;
      while (getline(fin, line) && line[0] != '>') {
        assert(!isspace(line[0]) && line[0] != '#' && !isspace(line[line.length() - 1]));
        if (this->chr == chr) {
          int llen = line.length();
          for (int i = 0; i < llen; ++i) line[i] = toupper(line[i]);
          seq += line;
        }
      }
      if (fin.good() && line[0] == '>') {
        chr_name = line.substr(1, line.find_first_of(' ') - 1);
      }
    }
    
    len = seq.length();
    assert(len > 0);
  }

  int locateMotif(const string& chr, char ori, int pos) {
    if (this->chr != chr) seek(chr);
    
    int center, start, end;
    char c;

    center = pos;
    start = center - w;
    end = center + w;
    for (int i = start; i <= end; ++i) {
      c = (i >= 0 && i < len) ? seq[i] : 'N';
      if (ori == '+') context[i - start] = c;
      else context[end - i] = complement(c);
    }
    context[w + w + 1] = 0;
    
    const char* ptr = strstr(context, motif);

    return (ptr == NULL ? w + w : int(ptr - context) - w);
  }

private:
  const char* motif;
  int w;

  int len;
  ifstream fin;
  string chr, chr_name, seq;

  char context[1005];

  char complement(char c) { 
    switch(c) { 
    case 'A': return 'T';
    case 'C': return 'G';
    case 'G': return 'C';
    case 'T': return 'A';
    }
    return 'N';
  }
};

int w;

int main(int argc, char* argv[]) {
  if (argc != 6) {
    printf("Usage: detectMotif reference.fa motif w input.site_info output.txt\n");
    exit(-1);
  }

  string line, chr;
  int pos;
  char ori;

  Genome *genome = new Genome(argv[1], argv[2], atoi(argv[3]));

  ifstream fin(argv[4]);
  ofstream fout(argv[5]);

  int cnt = 0;
  while (getline(fin, line)) {
    istringstream strin(line);
    strin>> chr>> ori>> pos;
    fout<< chr<< ' '<< ori<< ' '<< pos<< '\t'<< genome->locateMotif(chr, ori, pos)<< endl;
    ++cnt;
    if (cnt % 1000000 == 0) printf("FIN %d\n", cnt);
  }
  fin.close();
  fout.close();

  delete genome;

  return 0;
}
