""" unit test for csvgen.py """
from csvgen import importcsv
file_name='/home/irisowner/dev/data/Educational_Attainment_small.csv'
file_name='/home/irisowner/dev/data/10k_diabetes_small 2.csv'
file_name='/home/irisowner/dev/data/test_header.csv'
importcsv(file_name,connect_line='iris+emb:///')
file_name='/home/irisowner/dev/data/test_noheader.csv'
importcsv(file_name,connect_line='iris+emb:///',header=False)
