#include<iostream>
#include<fstream>

void write()
{
    std::ofstream fout;
    fout.open("data.csv", std::ios::app);  
	//assert(!fout.fail());
	fout << "check check" <<std::endl;
	fout.close();
}

int main()
{
    std::ofstream fout;
	fout.open("data.csv", std::ios::out);
	fout.close();
    write();
    return 0;
}

