# configs' list (interface -> views)
- Settings
	- Settings properties nodes
		- [x]ColorPicker
		- [x]RadiusChanger
	- Works with nodes
		- [x]Add (default)
		- []Delete
		- []Drag
		- []Return (Ctrl + Z)
	- Animation
- Show output
	- []Count nodes
	- []Count paths
	- [x]Matrix
---
# configs' list (controller -> @)
- calc length paths and show matrix2.0 (switch)
- works orintation graph(default: not orintation)
---
---
1. Функция вычисления веса ребра
	Т.К. при вычислении мы вычисляем вес в пикселях было решено, что это значение делить
	на 10 и выводить десятичной дробью до 10-ых
2. Класс view для отображения веса ребра
3. Алгоримт Дейкстры