const Sequelize = require('sequelize');
const { Op } = require("sequelize");

const sequelize = new Sequelize('prueba', 'root', "",{
  host: 'localhost',
  dialect: 'mariadb' /* one of 'mysql' | 'mariadb' | 'postgres' | 'mssql' */
});

sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });



class Users extends Sequelize.Model {}
Users.init({
    Nombre: Sequelize.STRING,
    Apellido:Sequelize.STRING,
    Edad:Sequelize.INTEGER
}, { sequelize, modelName: 'Ejercicio3' });
  
  
  /* crea usuario*/
sequelize.sync()
    .then(() => Users.create({
        Nombre: 'Joaquin',
        Apellido: 'Pettinari',
        Edad: 21
    }))
    .then(jane => {
        console.log("Agregado a \n")
        console.log(jane.toJSON());
    })
    .then(() => Users.create({   
        Nombre: 'Micaela',
        Apellido: 'Lopez',
        Edad: 20
    }))
    .then(jane => {
        console.log("Agregado a \n")
        console.log(jane.toJSON());
    })
    .then(() => Users.create({   
        Nombre: 'Silvina',
        Apellido: 'Alvarez',
        Edad: 40
    }))
    .then(jane => {
        console.log("Agregado a \n")
        console.log(jane.toJSON());
    })
    .then(() => {
        Users.update({ Nombre: "Modificado" }, {
            where: {
                [Op.or]: [
                    { Edad: 40 },
                    { Nombre: 'Micaela' }
                  ]
            }
        }).then(() => {
            console.log("Hice la actualización");
        });

    })
    
  
