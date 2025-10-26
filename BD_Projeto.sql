CREATE DATABASE Aggran;
USE Aggran;

CREATE TABLE cadastro (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nomeResponsavel VARCHAR(50) NOT NULL,
    nomeEmpresa VARCHAR(50) DEFAULT NULL,
	cnpj VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT chkEmail CHECK(email LIKE '%@%.%'),
    telefone CHAR(18),
	tipoProducao VARCHAR(10),
    CONSTRAINT tipoProducao CHECK(email IN ('Lavoura', 'Pastagem', 'Perene')),
    cep VARCHAR(14) NOT NULL,
	logradouro VARCHAR(40) NOT NULL,
	numero INT NOT NULL,
	complemento VARCHAR(40),
	bairro VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    uf CHAR(2) NOT NULL,
    tamanhoTerreno DECIMAL,
    dataCadastro DATETIME DEFAULT current_timestamp,
	senha VARCHAR(255) NOT NULL
);

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    statusCliente VARCHAR(10),
    CONSTRAINT chkCliente CHECK (statusCliente IN ('Ativo', 'Inativo')),
    dataStatus DATETIME DEFAULT current_timestamp,
    dataCadastro DATETIME DEFAULT current_timestamp,
    fkidCadastro INT NOT NULL,
    CONSTRAINT fkcadastroUsuario FOREIGN KEY (fkidCadastro) REFERENCES Cadastro(idCadastro)
);

CREATE TABLE LoteSensor (
	idloteSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroLote INT UNIQUE
);

CREATE TABLE Sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroSensor CHAR(20) NOT NULL UNIQUE,
	latitudeSensor DECIMAL(9,6),
	longitudeSensor DECIMAL (9,6),
    fkidCadastro INT,
    fkidloteSensor INT,
    CONSTRAINT fksensorCadastro FOREIGN KEY (fkidCadastro) REFERENCES Cadastro(idCadastro),
    CONSTRAINT fkloteSensor FOREIGN KEY (fkidloteSensor) REFERENCES LoteSensor(idloteSensor)
);

CREATE TABLE usuarioSensor (
	idUsuarioSensor INT,
	fkidUsuario INT NOT NULL,
    fkidSensor INT NOT NULL,
    PRIMARY KEY (fkidUsuario, fkidSensor),
    CONSTRAINT fkUsuarioUsuarioSensor FOREIGN KEY (fkidUsuario) REFERENCES Usuario(idUsuario),
    CONSTRAINT fkSensorUsuarioSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);


CREATE TABLE statusSensor (
	idManutencao INT PRIMARY KEY AUTO_INCREMENT,
    statusSensor VARCHAR(10),
    CONSTRAINT chkstatus CHECK (statusSensor IN ('Manutenção', 'Para uso', 'Em uso')),
    tipoFalha VARCHAR(30),
    CONSTRAINT chktipoFalha CHECK (tipoFalha IN ('Sensor', 'Arduino', 'Jumpers', 'Software', 'Pinos', 'Sem falhas')),
    descricao VARCHAR(150),
    dataStatus DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkstatusSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);

CREATE TABLE registro (
	idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    umidadeSolo DECIMAL(5,2),
    dataRegistro DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkregistroSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);

SELECT umidadeSolo FROM registro;
