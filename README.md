# evolutionary-computation [WIP]
On this repository you find my projects for evolutionary computation class


## Run


```
$ ruby sample2.rb
```




## [TODO]:


params:

- `type` -> in {:int, :flt, :bin, :prm}
- `info` -> number of informations
- `indv` -> number of individuals
- `bnds` -> [inf, sup] only to `type` iqual :int or :flt
- `divr` -> I dont know this yet
- `selc` -> (:roulette, :tournament)
- `eltm` -> (:yes, :no)
- `crss` if `type` is :bin -> (:one, :two, :uni)
		 if `type` is :prm -> :PMX
		 if `type` is :int -> (:one, :two, :uni)
		 if `type` is :flt -> (:blx, :uni, :art)
- `mutc` if `type` is :bin -> :bit-flip
		 if `type` is :prm -> :swap-mut
		 if `type` is :int -> :rand-val
		 if `type` is :flt -> :mut-gaus


[DONE]

`graphics` -> python
