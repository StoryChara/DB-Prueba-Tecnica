-- ¿Cuántos docentes activos hay en la Facultad de Ingeniería?
SELECT COUNT(*) AS profesores_activos FROM mydb.profesor WHERE activo = 1;

-- ¿Cuáles son los cursos que se dictaron en un periodo dado?
SET @year = 2025; SET @trimestre = 1;
SELECT cursos.nombre FROM mydb.curso AS cursos JOIN mydb.curso_periodo AS periodo ON cursos.idcurso = periodo.id_curso WHERE @year = 2025 AND @trimestre = 1;

-- ¿Cuál es la lista de estudiantes para un periodo actual?
SELECT CONCAT_WS(' ',estudiante.nombres, estudiante.apellidos) AS estudiantes_activos FROM mydb.estudiante WHERE activo = 1;

-- ¿Cuál es el promedio de las calificaciones obtenidas en un curso los últimos 5 años?
SET @actual_year = 2025; SET @curso = 'Historia Moderna';

SELECT ROUND(AVG(estudiante_inscrito.nota_obtenida), 1) AS calificacion_promedio
FROM mydb.inscrito AS estudiante_inscrito
JOIN mydb.grupo AS grupo_curso ON estudiante_inscrito.id_grupo = grupo_curso.idgrupo
JOIN mydb.curso_periodo AS curso_periodo ON grupo_curso.id_curso_periodo = curso_periodo.idcurso_periodo
JOIN mydb.curso AS curso ON curso_periodo.id_curso = curso.idcurso
WHERE curso_periodo.year >= @actual_year - 5 AND curso.nombre = @curso;

-- ¿Cuál sería el procedimiento para crear un nuevo curso y asignarle un docente?
SET @nombre_curso_nuevo = 'Base de Datos'; SET @ID_profesor = 'jdoe'; SET @grupo = 5; SET @year = 2025; SET @trimestre = 3;
INSERT INTO mydb.curso(nombre) VALUES (@nombre_curso_nuevo);
INSERT INTO mydb.curso_periodo (id_curso, year, trimestre) VALUES (last_insert_id(), @year, @trimestre);
INSERT INTO mydb.grupo (id_curso_periodo, profesor_encargado, numero_de_grupo) VALUES (last_insert_id(), @ID_profesor,  @grupo);