extends Node

var unlocked = [true,true,true,true,true] #[false,false,false,false,false]
var actived =[false,false,false,false,false]
var dict = {"fire":0, "wind":1, "projection":2, "invert":3, "propagate":4}
var name_dict = {
	0 : "fire",
	1 : "wind",
	2 : "projection",
	3 : "invert",
	4 : "propagate"
}
func is_piment_unlocked(id):
	return unlocked[id]
