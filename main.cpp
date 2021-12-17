#include <iostream>
#include <stdio.h>
#include <cstring>
#include <sstream>
#include <vector>
using namespace std;

void splitStr(string str)
{
    string word = "";
    for (auto x : str) 
    {
        if (x == ' ')
        {
            cout << word << endl;
            word = "";
        }
        else {
            word = word + x;
        }
    }
    cout << word << endl;
}

string getfile(string filename)
{
    char line[128];
    string str;

    // Open pipe to file
    FILE* pipe = popen("./getflight OSBACKUP.RND", "r");
    if (!pipe) {
      return "popen failed!";
    }
    // read till end of process:
    while (fgets(line, 128, pipe)) {
       str += line;
    }
    pclose(pipe);
    return str;
}

float diff (float a, float b)
{
  float r;
  r=a-b;
  return r;
}

int main ()
{
  float z;
  z = diff(2.5,6);
  cout << "The result is " << z << endl;
  splitStr(getfile("OSBACKUP.RND"));
}