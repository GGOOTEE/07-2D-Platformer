extends Node2D

# Buttons
func SubtractPressed():
	get_node("/root/SaveSystem").DisplayValue -= 1

func AddPressed():
	get_node("/root/SaveSystem").DisplayValue += 1

func SavePressed():
	get_node("/root/SaveSystem").saveValue("Values", "ValueOne")

func LoadPressed():
	get_node("/root/SaveSystem").loadValue("Values", "ValueOne")
