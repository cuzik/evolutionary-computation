#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Graphics
import numpy as np
import matplotlib.pyplot as plt 
from scipy.interpolate import spline


file_names = []

file_names += ['log_bests_individuals_fitness']
file_names += ['log_average_fitness']
# file_names += ['log_diversity']

labels = []

labels += ['Bests Individuals Fitness']
labels += ['Average Fitness']
labels += ['Diversity']







def graphic_gen_smooth(vetor, title, labels):
	fig = plt.figure()
	for i in vetor:
		a = np.linspace(0, len(i)-1, len(i)*50)
		power_smooth = spline(range(0,len(i)), i, a)
		plt.plot(a, power_smooth)
	plt.legend(labels)
	plt.title(title)
	plt.xlabel('Generation')
	plt.ylabel('Fitness')
	plt.show()


def graphic_gen(vetor, title, labels):
	fig = plt.figure()
	for i in vetor:
		plt.plot(i)
	plt.legend(labels)
	plt.title(title)
	plt.xlabel('Generation')
	plt.ylabel('Fitness')
	plt.show()






times = []

for file_name in file_names:
	a = open('logs/' + file_name)
	times_aux = []
	for i in a:
		times_aux += [float(i)]
	times += [times_aux]



graphic_gen(times,'Grafico de Convergencia', labels)
# graphic_gen_smooth(times,'Grafico de Convergencia', labels)