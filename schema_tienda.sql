

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/*CONSULTES*/

/*01-05*/

SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
DESCRIBE producto;
SELECT nombre, precio, TRUNCATE(precio*1.13,2) FROM producto;
SELECT nombre AS 'nom de producto', precio AS 'euros', TRUNCATE(precio*1.13,2) AS 'dòl
ars nord-americans(USD)' FROM producto;

/*06-10*/

SELECT UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre, UPPER(LEFT(nombre,2)) FROM fabricante;
SELECT nombre, ROUND(precio) from producto;
SELECT nombre, TRUNCATE(precio,0) from producto;

/*11-15*/

SELECT codigo_fabricante FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

/*16-20*/

SELECT nombre FROM fabricante LIMIT 5;
SELECT nombre FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante=2;

/*21-25*/

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto 
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

SELECT producto.nombre, producto.precio, fabricante.nombre  FROM producto 
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY fabricante.nombre;

SELECT producto.codigo, producto.nombre, producto.precio,fabricante.codigo, fabricante.nombre  FROM producto 
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

SELECT producto.nombre AS Producto, producto.precio, fabricante.nombre AS Fabricante  FROM producto 
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY producto.precio 
LIMIT 1;

SELECT producto.nombre, producto.precio, fabricante.nombre  FROM producto 
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY producto.precio DESC
LIMIT 1;

/*26-30*/
SELECT producto.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre='Lenovo';

SELECT producto.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre='Crucial' AND producto.precio>200;

SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hewlett-Packard' OR fabricante.nombre='Seagate';

SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre IN ('Asus','Hewlett-Packard','Seagate');

SELECT producto.nombre, producto.precio FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE RIGHT(fabricante.nombre,1)='e';

/*31*/
SELECT producto.nombre, producto.precio FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante. codigo 
WHERE fabricante.nombre LIKE '%w%';

/*32*/
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante. codigo 
WHERE producto.precio >= '180'
ORDER BY producto.precio DESC, producto.nombre ASC;

/*33*/
SELECT fabricante.codigo, fabricante.nombre FROM fabricante WHERE fabricante.codigo = ANY(SELECT codigo_fabricante FROM producto);

/*34*/
SELECT fabricante.nombre, producto.nombre
FROM fabricante
LEFT JOIN producto
	ON fabricante.codigo = producto.codigo_fabricante
ORDER BY fabricante.nombre;

/*35*/
SELECT fabricante.nombre, producto.nombre
FROM fabricante
LEFT JOIN producto
	ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.nombre IS NULL;

/*36*/
SELECT *
FROM fabricante
LEFT JOIN producto
	ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Lenovo';

/*37*/
SELECT *
FROM producto

WHERE producto.precio = (
	SELECT MAX(producto.precio) 
    FROM producto 
    LEFT JOIN fabricante
		ON fabricante.codigo = producto.codigo_fabricante 
	WHERE fabricante.nombre='Lenovo'
);

/*38*/
SELECT	producto.nombre
FROM fabricante
LEFT JOIN producto
	ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio DESC
LIMIT 1;

/*39*/
SELECT	producto.nombre
FROM fabricante
LEFT JOIN producto
	ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY producto.precio ASC
LIMIT 1;

/*40*/
SELECT *
FROM producto

WHERE producto.precio >= (
	SELECT MAX(producto.precio) 
    FROM producto 
    LEFT JOIN fabricante
		ON fabricante.codigo = producto.codigo_fabricante 
	WHERE fabricante.nombre='Lenovo');


/*41*/
SELECT *
FROM producto
LEFT JOIN fabricante
	ON fabricante.codigo = producto.codigo_fabricante  
WHERE fabricante.nombre='Asus'

AND producto.precio > (
	SELECT AVG(producto.precio) 
    FROM producto 
    LEFT JOIN fabricante
		ON fabricante.codigo = producto.codigo_fabricante 
	WHERE fabricante.nombre='Asus');



