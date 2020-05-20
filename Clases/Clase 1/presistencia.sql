CREATE DATABASE if NOT EXISTS persistencia;
USE persistencia;

CREATE TABLE if NOT EXISTS departamentos (
     codDepto VARCHAR(4) NOT NULL,
     nombreDepto VARCHAR(20),
     ciudad VARCHAR(15),
     codDirector VARCHAR(12),
     PRIMARY KEY(codDepto)
) ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE if NOT EXISTS empleados (
    nDIEmp VARCHAR(12) NOT NULL,
    codDepto VARCHAR(4) NOT NULL,
    nomEmp VARCHAR(30),
    sexEmp VARCHAR(1),
    fecNac DATE,
    fecIncorporacion DATE,
    salEmp FLOAT,
    comisionEmp FLOAT,
    cargoEmp VARCHAR(12),
    jefeID VARCHAR(12),
    PRIMARY KEY(nDIEmp),
    FOREIGN KEY fk_codigo_Depto(codDepto) REFERENCES departamentos(codDepto)
) ENGINE=InnoDB AUTO_INCREMENT=1;


INSERT INTO `departamentos` (`codDepto`, `nombreDepto`, `ciudad`, `codDirector`) VALUES 
('11', 'Baufest', 'Castelar', '24'),
('12', 'Google', 'Marcos Paz', '25'), 
('13', 'Facebook', 'La cueva', '26');

INSERT INTO `departamentos` (`codDepto`, `nombreDepto`, `ciudad`, `codDirector`) VALUES 
('2', 'Ejercicio14', 'Casa', '11');

INSERT INTO `departamentos` (`codDepto`, `nombreDepto`, `ciudad`, `codDirector`) VALUES 
('3', 'Ejercicio14x2', 'Casa', '11');


INSERT INTO `empleados` (`nDIEmp`, `codDepto`, `nomEmp`, `sexEmp`, `fecNac`, `fecIncorporacion`, `salEmp`, `comisionEmp`, `cargoEmp`, `jefeID`) VALUES 
('24', '11', 'Joaquin', 'M', '1998-11-24', '2015-03-02', '75000.00', '20000', 'CEO', '24'), 
('124', '13', 'Pabloski', 'M', '2000-02-24', '2015-03-18', '60000.00', '30000', 'Vice CEO', '24'),
('125', '12', 'Flor', 'F', '1992-06-03', '2020-01-16', '45000.00', '50000', 'Cafetera', '24'),
('126', '11', 'Tiago', 'M', '1998-11-24', '2015-03-02', '75000.00', '20000', 'CEO', '2416'), 
('127', '11', 'Aye', 'M', '1998-11-24', '2015-03-02', '75000.00', '20000', 'CEO', '2416');


/* Consulta 1 */
SELECT * from empleados;

/* Consulta 2 */
SELECT departamentos.nombreDepto as 'Nombre del departamento' from departamentos;

/* Consulta 3 */
select nomEmp as 'Nombre de empleado', cargoEmp as 'Cargo del empleado', salEmp from empleados
order by salEmp DESC;

/* Consulta 4 */ 
SELECT * from empleados where salEmp < comisionEmp;

/* Consulta 5 */
SELECT * FROM empleados where comisionEmp <= (salEmp * 0.3);

/* Consulta 6 */
select nomEmp as Empleado, cargoEmp as Cargo from empleados
where nomEmp between"j%" and "z%"
order by cargoEmp asc;

/* Consulta 7 */
select nomEmp as Empleado from empleados
where not nomEmp like "%na%";

/* Consulta 9 */
select nomEmp as Empleado from empleados
where nomEmp like "m%" and (salEmp >= 800000 or comisionEmp >= 800000) and cargoEmp = "ventas";

/* Consulta 9 */
select nomEmp as Empleado, salEmp as Sueldo from empleados
order by salEmp  asc limit 1;

/* Consulta 10 */

select max(salEmp) as 'Salario Maximo', min(salEmp) as 'Salario Minimo', (max(salEmp) - min(salEmp)) as 'Diferencia' from empleados;

/* Consulta 11 */
SELECT D.codDepto, E.sexEmp, COUNT(E.nomEmp)
FROM empleados as E, departamentos as D
Where D.codDepto = E.codDepto
GROUP BY D.codDepto, E. sexEmp;

/* Consulta 12 */
select D.nombreDepto as 'Departamento' , COUNT(E.nomEmp) as CantEmpleados
FROM empleados as E, departamentos as D
where D.codDepto = E.codDepto
GROUP BY D.codDepto
having CantEmpleados >= 3;

/* Consulta 13 */ 
SELECT E.jefeID as CodigoJefe, E.nomEmp as 'NombreJefe', (select count(*) -1 from empleados where empleados.jefeID = CodigoJefe) as CantEmpleados
from empleados as E, departamentos as D
where E.jefeID = E.nDIEmp
group by E.jefeID
HAVING CantEmpleados >= 2;

/* Consulta 14 */
select D.nombreDepto as 'Departamento sin empleados', SUM(CASE WHEN E.codDepto = D.codDepto THEN 1 ELSE 0 END) AS CantEmpleados
from departamentos as D, empleados as E
group by D.codDepto
having 0 = CantEmpleados;

/* Consulta 15 */
Select D.nombreDepto as 'Departamento', SUM(E.salEmp) as SalarioTotal
from departamentos as D, empleados as E
where E.codDepto = D.codDepto
group by D.nombreDepto
limit 1;





