








-- -----------------------------------------------------
-- SE NECESITA MYSQL WORKBENCH 8.0
-- -----------------------------------------------------











SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIOS` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NULL,
  `dni` INT NULL,
  `fecha_alta` DATE NULL,
  `fecha_baja` DATE NULL,
  `direccion` VARCHAR(100) NULL,
  `foto_perfil` TEXT NULL,
  `estado_hab_des` TINYINT NULL,
  PRIMARY KEY (`id_usuarios`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `id_usuarios_UNIQUE` (`id_usuarios` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESTADO_CMA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTADO_CMA` (
  `id_estado_cma` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado_cma`),
  UNIQUE INDEX `id_estado_cma_UNIQUE` (`id_estado_cma` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CMA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CMA` (
  `id_cma` INT NOT NULL AUTO_INCREMENT,
  `clase` VARCHAR(255) NOT NULL,
  `limitaciones` VARCHAR(255) NULL,
  `observaciones` VARCHAR(255) NULL,
  `valido_hasta` DATE NOT NULL,
  `usuarios_id` INT NOT NULL,
  `estado_cma_id` INT NOT NULL,
  PRIMARY KEY (`id_cma`),
  INDEX `fk_CMA_ASOCIADOS1_idx` (`usuarios_id` ASC) VISIBLE,
  INDEX `fk_CMA2_ESTADO1_idx` (`estado_cma_id` ASC) VISIBLE,
  UNIQUE INDEX `id_cma_UNIQUE` (`id_cma` ASC) VISIBLE,
  CONSTRAINT `fk_CMA_ASOCIADOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CMA2_ESTADO1`
    FOREIGN KEY (`estado_cma_id`)
    REFERENCES `mydb`.`ESTADO_CMA` (`id_estado_cma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPOS_LICENCIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPOS_LICENCIAS` (
  `id_tipo_licencias` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_licencias`),
  UNIQUE INDEX `id_tipo_licencias_UNIQUE` (`id_tipo_licencias` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LICENCIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LICENCIAS` (
  `id_licencias` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `path` TEXT NULL,
  `usuarios_id` INT NOT NULL,
  `tipo_licencias_id` INT NOT NULL,
  PRIMARY KEY (`id_licencias`),
  INDEX `fk_LICENCIAS_ASOCIADOS_idx` (`usuarios_id` ASC) VISIBLE,
  INDEX `fk_LICENCIAS2_TIPO_LICENCIAS1_idx` (`tipo_licencias_id` ASC) VISIBLE,
  UNIQUE INDEX `id_licencias_UNIQUE` (`id_licencias` ASC) VISIBLE,
  CONSTRAINT `fk_LICENCIAS_ASOCIADOS`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LICENCIAS2_TIPO_LICENCIAS1`
    FOREIGN KEY (`tipo_licencias_id`)
    REFERENCES `mydb`.`TIPOS_LICENCIAS` (`id_tipo_licencias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_RECIBOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_RECIBOS` (
  `id_tipo_recibos` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_recibos`),
  UNIQUE INDEX `id_tipo_recibos_UNIQUE` (`id_tipo_recibos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_PAGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_PAGO` (
  `id_tipo_pago` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `observaciones` TEXT NULL,
  PRIMARY KEY (`id_tipo_pago`),
  UNIQUE INDEX `id_tipo_pago_UNIQUE` (`id_tipo_pago` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUENTA_CORRIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUENTA_CORRIENTE` (
  `id_cuenta_corriente` INT NOT NULL AUTO_INCREMENT,
  `saldo_cuenta` DOUBLE NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_cuenta_corriente`),
  INDEX `fk_SALDOS_USUARIOS11_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_SALDOS_USUARIOS11`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRANSACCIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRANSACCIONES` (
  `id_transacciones` INT NOT NULL AUTO_INCREMENT,
  `monto` DOUBLE NOT NULL,
  `fecha` DATE NOT NULL,
  `motivo` TEXT NULL,
  `tipo_pago_id` INT NULL,
  `cuenta_corriente_id` INT NOT NULL,
  PRIMARY KEY (`id_transacciones`),
  INDEX `fk_TRANSACCIONES_TIPO_PAGO1_idx` (`tipo_pago_id` ASC) VISIBLE,
  UNIQUE INDEX `id_transacciones_UNIQUE` (`id_transacciones` ASC) VISIBLE,
  INDEX `fk_TRANSACCIONES_CUENTA_CORRIENTE1_idx` (`cuenta_corriente_id` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSACCIONES_TIPO_PAGO1`
    FOREIGN KEY (`tipo_pago_id`)
    REFERENCES `mydb`.`TIPO_PAGO` (`id_tipo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRANSACCIONES_CUENTA_CORRIENTE1`
    FOREIGN KEY (`cuenta_corriente_id`)
    REFERENCES `mydb`.`CUENTA_CORRIENTE` (`id_cuenta_corriente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RECIBOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RECIBOS` (
  `id_recibos` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `observaciones` TEXT NULL,
  `tipo_recibos_id` INT NOT NULL,
  `transacciones_id` INT NOT NULL,
  `numero_recibos` INT NOT NULL,
  PRIMARY KEY (`id_recibos`),
  UNIQUE INDEX `id_recibos_UNIQUE` (`id_recibos` ASC) VISIBLE,
  INDEX `fk_RECIBOS_TIPO_RECIBOS1_idx` (`tipo_recibos_id` ASC) VISIBLE,
  INDEX `fk_RECIBOS_TRANSACCIONES1_idx` (`transacciones_id` ASC) VISIBLE,
  UNIQUE INDEX `numero_recibos_UNIQUE` (`numero_recibos` ASC) VISIBLE,
  CONSTRAINT `fk_RECIBOS_TIPO_RECIBOS1`
    FOREIGN KEY (`tipo_recibos_id`)
    REFERENCES `mydb`.`TIPO_RECIBOS` (`id_tipo_recibos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECIBOS_TRANSACCIONES1`
    FOREIGN KEY (`transacciones_id`)
    REFERENCES `mydb`.`TRANSACCIONES` (`id_transacciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESTADOS_AERONAVES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTADOS_AERONAVES` (
  `id_estados_aeronaves` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estados_aeronaves`),
  UNIQUE INDEX `id_estados_aeronaves_UNIQUE` (`id_estados_aeronaves` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AERONAVES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AERONAVES` (
  `id_aeronaves` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `matricula` VARCHAR(45) NOT NULL,
  `potencia` VARCHAR(45) NOT NULL,
  `clase` VARCHAR(45) NOT NULL,
  `fecha_adquisicion` DATE NOT NULL,
  `consumo_por_hora` INT NOT NULL,
  `path_documentacion` TEXT NULL,
  `descripcion` TEXT NULL,
  `path_imagen_aeronave` TEXT NULL,
  `estados_aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_aeronaves`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) VISIBLE,
  INDEX `fk_AERONAVES_ESTADOS_AERONAVES1_idx` (`estados_aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_aeronaves_UNIQUE` (`id_aeronaves` ASC) VISIBLE,
  CONSTRAINT `fk_AERONAVES_ESTADOS_AERONAVES1`
    FOREIGN KEY (`estados_aeronaves_id`)
    REFERENCES `mydb`.`ESTADOS_AERONAVES` (`id_estados_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COMPONENTES_AERONAVES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COMPONENTES_AERONAVES` (
  `id_componente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `marca` VARCHAR(255) NOT NULL,
  `modelo` VARCHAR(255) NOT NULL,
  `horas_usadas` INT NOT NULL,
  `horas_hasta_revision` INT NOT NULL,
  `descripcion` TEXT NULL,
  `aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_componente`),
  INDEX `fk_MOTORES_AERONAVES1_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_componente_UNIQUE` (`id_componente` ASC) VISIBLE,
  CONSTRAINT `fk_MOTORES_AERONAVES1`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_ITINERARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_ITINERARIOS` (
  `id_tipo_itinerarios` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_itinerarios`),
  UNIQUE INDEX `id_tipo_itinerarios_UNIQUE` (`id_tipo_itinerarios` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ITINERARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ITINERARIOS` (
  `id_itinerarios` INT NOT NULL AUTO_INCREMENT,
  `hora_salida` DATETIME NOT NULL,
  `hora_llegada` DATETIME NOT NULL,
  `cantidad_aterrizajes` INT NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `tipo_itinerarios_id` INT NOT NULL,
  `aeronaves_id` INT NOT NULL,
  `RECIBOS_id_recibos` INT NOT NULL,
  PRIMARY KEY (`id_itinerarios`),
  INDEX `fk_ITINERARIOS2_TIPO_ITINERARIOS1_idx` (`tipo_itinerarios_id` ASC) VISIBLE,
  INDEX `fk_ITINERARIOS_AERONAVES1_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_itinerarios_UNIQUE` (`id_itinerarios` ASC) VISIBLE,
  INDEX `fk_ITINERARIOS_RECIBOS1_idx` (`RECIBOS_id_recibos` ASC) VISIBLE,
  CONSTRAINT `fk_ITINERARIOS2_TIPO_ITINERARIOS1`
    FOREIGN KEY (`tipo_itinerarios_id`)
    REFERENCES `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITINERARIOS_AERONAVES1`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITINERARIOS_RECIBOS1`
    FOREIGN KEY (`RECIBOS_id_recibos`)
    REFERENCES `mydb`.`RECIBOS` (`id_recibos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPOS_HABILITACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPOS_HABILITACIONES` (
  `id_tipo_habilitaciones` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_habilitaciones`),
  UNIQUE INDEX `id_tipo_habilitaciones_UNIQUE` (`id_tipo_habilitaciones` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HABILITACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HABILITACIONES` (
  `id_habilitaciones` INT NOT NULL AUTO_INCREMENT,
  `valido_hasta` DATE NOT NULL,
  `path` TEXT NULL,
  `usuarios_id` INT NOT NULL,
  `tipo_habilitaciones_id` INT NOT NULL,
  PRIMARY KEY (`id_habilitaciones`),
  INDEX `fk_HABILITACIONES_ASOCIADOS1_idx` (`usuarios_id` ASC) VISIBLE,
  INDEX `fk_HABILITACIONES2_TIPO_HABILITACION1_idx` (`tipo_habilitaciones_id` ASC) VISIBLE,
  UNIQUE INDEX `id_habilitaciones_UNIQUE` (`id_habilitaciones` ASC) VISIBLE,
  CONSTRAINT `fk_HABILITACIONES_ASOCIADOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HABILITACIONES2_TIPO_HABILITACION1`
    FOREIGN KEY (`tipo_habilitaciones_id`)
    REFERENCES `mydb`.`TIPOS_HABILITACIONES` (`id_tipo_habilitaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ROLES` (
  `id_roles` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_roles`),
  UNIQUE INDEX `id_roles_UNIQUE` (`id_roles` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEDIDAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEDIDAS` (
  `id_medidas` INT NOT NULL AUTO_INCREMENT,
  `medida` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_medidas`),
  UNIQUE INDEX `id_medidas_UNIQUE` (`id_medidas` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTOS` (
  `id_productos` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `stock` DOUBLE NOT NULL,
  `precio` DOUBLE NOT NULL,
  `cantidad_minima` INT NOT NULL,
  `cantidad_maxima` INT NOT NULL,
  `fecha_ultimo_encargue` DATE NOT NULL,
  `medidas_id` INT NOT NULL,
  PRIMARY KEY (`id_productos`),
  INDEX `fk_PRODUCTOS_MEDIDAS1_idx` (`medidas_id` ASC) VISIBLE,
  UNIQUE INDEX `id_productos_UNIQUE` (`id_productos` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTOS_MEDIDAS1`
    FOREIGN KEY (`medidas_id`)
    REFERENCES `mydb`.`MEDIDAS` (`id_medidas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARIOS_tiene_ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIOS_tiene_ROLES` (
  `id_usuarios_tiene_roles` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  `roles_id` INT NOT NULL,
  INDEX `fk_USUARIOS_has_ROLES_ROLES1_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_USUARIOS_has_ROLES_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  PRIMARY KEY (`id_usuarios_tiene_roles`),
  UNIQUE INDEX `id_usuarios_tiene_roles_UNIQUE` (`id_usuarios_tiene_roles` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIOS_has_ROLES_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIOS_has_ROLES_ROLES1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`ROLES` (`id_roles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TARIFAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TARIFAS` (
  `id_tarifas` INT NOT NULL AUTO_INCREMENT,
  `vigente_desde` DATE NOT NULL,
  `importe_vuelo` DOUBLE NOT NULL,
  `importe_instruccion` DOUBLE NOT NULL,
  `aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_tarifas`),
  INDEX `fk_TARIFAS_AERONAVES21_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_tarifas_UNIQUE` (`id_tarifas` ASC) VISIBLE,
  CONSTRAINT `fk_TARIFAS_AERONAVES21`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUOTAS_SOCIALES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUOTAS_SOCIALES` (
  `id_cuotas_sociales` INT NOT NULL AUTO_INCREMENT,
  `mes` DATE NOT NULL,
  PRIMARY KEY (`id_cuotas_sociales`),
  UNIQUE INDEX `id_cuotas_sociales_UNIQUE` (`id_cuotas_sociales` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NOTAS_VUELOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NOTAS_VUELOS` (
  `id_notas_vuelos` INT NOT NULL AUTO_INCREMENT,
  `descripcion` TEXT NOT NULL,
  `fecha` DATE NOT NULL,
  `instructores_id` INT NOT NULL,
  `asociados_id` INT NOT NULL,
  PRIMARY KEY (`id_notas_vuelos`),
  INDEX `fk_NOTAS_VUELOS2_USUARIOS11_idx` (`instructores_id` ASC) VISIBLE,
  INDEX `fk_NOTAS_VUELOS_USUARIOS11_idx` (`asociados_id` ASC) VISIBLE,
  UNIQUE INDEX `id_notas_vuelos_UNIQUE` (`id_notas_vuelos` ASC) VISIBLE,
  CONSTRAINT `fk_NOTAS_VUELOS2_USUARIOS11`
    FOREIGN KEY (`instructores_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTAS_VUELOS_USUARIOS11`
    FOREIGN KEY (`asociados_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DATOS_HISTORICOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DATOS_HISTORICOS` (
  `id_datos_historicos` INT NOT NULL AUTO_INCREMENT,
  `fecha_carga` DATE NOT NULL,
  `descripcion` TEXT NULL,
  `horas_vuelo` INT NOT NULL,
  `cantidad_aterrizajes` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_datos_historicos`),
  INDEX `fk_CARGAR_DATOS_USUARIOS11_idx` (`usuarios_id` ASC) VISIBLE,
  UNIQUE INDEX `id_datos_historicos_UNIQUE` (`id_datos_historicos` ASC) VISIBLE,
  CONSTRAINT `fk_CARGAR_DATOS_USUARIOS11`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CODIGOS_AEROPUERTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CODIGOS_AEROPUERTOS` (
  `id_codigos_aeropuertos` INT NOT NULL AUTO_INCREMENT,
  `codigo_aeropuerto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_codigos_aeropuertos`),
  UNIQUE INDEX `id_codigos_aeropuertos_UNIQUE` (`id_codigos_aeropuertos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ITINERARIOS_tienen_CODIGOS_AEROPUERTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ITINERARIOS_tienen_CODIGOS_AEROPUERTOS` (
  `id_itinerarios_tienen_codigos` INT NOT NULL AUTO_INCREMENT,
  `itinerarios_id` INT NOT NULL,
  `codigos_aeropuertos_id` INT NOT NULL,
  INDEX `fk_ITINERARIOS2_has_codigos_aeropuertos_codigos_aeropuertos_idx` (`codigos_aeropuertos_id` ASC) VISIBLE,
  INDEX `fk_ITINERARIOS2_has_codigos_aeropuertos_ITINERARIOS21_idx` (`itinerarios_id` ASC) VISIBLE,
  PRIMARY KEY (`id_itinerarios_tienen_codigos`),
  UNIQUE INDEX `id_itinerarios_tienen_codigos_UNIQUE` (`id_itinerarios_tienen_codigos` ASC) VISIBLE,
  CONSTRAINT `fk_ITINERARIOS2_has_codigos_aeropuertos_ITINERARIOS21`
    FOREIGN KEY (`itinerarios_id`)
    REFERENCES `mydb`.`ITINERARIOS` (`id_itinerarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITINERARIOS2_has_codigos_aeropuertos_codigos_aeropuertos1`
    FOREIGN KEY (`codigos_aeropuertos_id`)
    REFERENCES `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MOVIMIENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MOVIMIENTOS` (
  `id_movimientos` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `matricula` VARCHAR(100) NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `productos_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_movimientos`),
  INDEX `fk_MOVIMIENTOS_PRODUCTOS1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_MOVIMIENTOS_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  UNIQUE INDEX `id_movimientos_UNIQUE` (`id_movimientos` ASC) VISIBLE,
  CONSTRAINT `fk_MOVIMIENTOS_PRODUCTOS1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `mydb`.`PRODUCTOS` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIMIENTOS_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`REPORTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REPORTES` (
  `id_reportes` INT NOT NULL AUTO_INCREMENT,
  `reportes_falla` TEXT NOT NULL,
  `fecha` DATE NOT NULL,
  `aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_reportes`),
  INDEX `fk_REPORTES_AERONAVES1_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_reportes_UNIQUE` (`id_reportes` ASC) VISIBLE,
  CONSTRAINT `fk_REPORTES_AERONAVES1`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_CUOTAS_SOCIALES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_CUOTAS_SOCIALES` (
  `id_tipo_cuotas_sociales` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `vigencia_desde` DATE NOT NULL,
  `importe` DOUBLE NOT NULL,
  `descripción` TEXT NOT NULL,
  `cuotas_sociales_id` INT NOT NULL,
  PRIMARY KEY (`id_tipo_cuotas_sociales`),
  INDEX `fk_TIPO_CUOTA_SOCIALES_CUOTAS_SOCIALES1_idx` (`cuotas_sociales_id` ASC) VISIBLE,
  UNIQUE INDEX `id_tipo_cuotas_sociales_UNIQUE` (`id_tipo_cuotas_sociales` ASC) VISIBLE,
  CONSTRAINT `fk_TIPO_CUOTA_SOCIALES_CUOTAS_SOCIALES1`
    FOREIGN KEY (`cuotas_sociales_id`)
    REFERENCES `mydb`.`CUOTAS_SOCIALES` (`id_cuotas_sociales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARIOS_pago_CUOTAS_SOCIALES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIOS_pago_CUOTAS_SOCIALES` (
  `id_usuarios_pago_cuota_social` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  `cuotas_sociales_id` INT NOT NULL,
  INDEX `fk_USUARIOS_has_CUOTAS_SOCIALES_CUOTAS_SOCIALES1_idx` (`cuotas_sociales_id` ASC) VISIBLE,
  INDEX `fk_USUARIOS_has_CUOTAS_SOCIALES_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  PRIMARY KEY (`id_usuarios_pago_cuota_social`),
  UNIQUE INDEX `id_usuarios_pago_cuota_social_UNIQUE` (`id_usuarios_pago_cuota_social` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIOS_has_CUOTAS_SOCIALES_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIOS_has_CUOTAS_SOCIALES_CUOTAS_SOCIALES1`
    FOREIGN KEY (`cuotas_sociales_id`)
    REFERENCES `mydb`.`CUOTAS_SOCIALES` (`id_cuotas_sociales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SEGUROS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SEGUROS` (
  `id_seguros` INT NOT NULL AUTO_INCREMENT,
  `fecha_carga` DATE NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `importe` DOUBLE NOT NULL,
  `identificacion` VARCHAR(255) NOT NULL,
  `aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_seguros`),
  INDEX `fk_SEGUROS_AERONAVES1_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_seguros_UNIQUE` (`id_seguros` ASC) VISIBLE,
  CONSTRAINT `fk_SEGUROS_AERONAVES1`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARIOS_tienen_RECIBOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIOS_tienen_RECIBOS` (
  `id_usuarios_tienen_recibos` INT NOT NULL AUTO_INCREMENT,
  `recibos_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  INDEX `fk_USUARIOS_has_VUELOS_RECIBOS_VUELOS_RECIBOS1_idx` (`recibos_id` ASC) VISIBLE,
  PRIMARY KEY (`id_usuarios_tienen_recibos`),
  UNIQUE INDEX `id_usuarios_tienen_recibos_UNIQUE` (`id_usuarios_tienen_recibos` ASC) VISIBLE,
  INDEX `fk_USUARIOS_tienen_RECIBOS_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIOS_has_VUELOS_RECIBOS_VUELOS_RECIBOS1`
    FOREIGN KEY (`recibos_id`)
    REFERENCES `mydb`.`RECIBOS` (`id_recibos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIOS_tienen_RECIBOS_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUENTA_CORRIENTE_HORAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUENTA_CORRIENTE_HORAS` (
  `id_cuenta_corriente_horas` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_cuenta_corriente_horas`),
  INDEX `fk_CUENTA_CORRIENTE_HORAS_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  UNIQUE INDEX `id_cuenta_corriente_horas_UNIQUE` (`id_cuenta_corriente_horas` ASC) VISIBLE,
  CONSTRAINT `fk_CUENTA_CORRIENTE_HORAS_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OPERACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OPERACIONES` (
  `id_operaciones` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `descripcion` TEXT NULL,
  `cantidad_horas` FLOAT NOT NULL,
  `cuenta_corriente_horas_id` INT NOT NULL,
  `aeronaves_id` INT NOT NULL,
  PRIMARY KEY (`id_operaciones`),
  INDEX `fk_MOVIMIENTOS_HORA_VUELO_CUENTA_CORRIENTE_HORAS_ADELANTADA_idx` (`cuenta_corriente_horas_id` ASC) VISIBLE,
  INDEX `fk_OPERACIONES_AERONAVES1_idx` (`aeronaves_id` ASC) VISIBLE,
  UNIQUE INDEX `id_operaciones_UNIQUE` (`id_operaciones` ASC) VISIBLE,
  CONSTRAINT `fk_MOVIMIENTOS_HORA_VUELO_CUENTA_CORRIENTE_HORAS_ADELANTADAS1`
    FOREIGN KEY (`cuenta_corriente_horas_id`)
    REFERENCES `mydb`.`CUENTA_CORRIENTE_HORAS` (`id_cuenta_corriente_horas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OPERACIONES_AERONAVES1`
    FOREIGN KEY (`aeronaves_id`)
    REFERENCES `mydb`.`AERONAVES` (`id_aeronaves`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TARIFA_ESPECIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TARIFA_ESPECIAL` (
  `id_tarifa_especial` INT NOT NULL AUTO_INCREMENT,
  `aplica` TINYINT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_tarifa_especial`),
  INDEX `fk_TARIFA_ESPECIAL_USUARIOS1_idx` (`usuarios_id` ASC) VISIBLE,
  UNIQUE INDEX `id_tarifa_especial_UNIQUE` (`id_tarifa_especial` ASC) VISIBLE,
  CONSTRAINT `fk_TARIFA_ESPECIAL_USUARIOS1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `mydb`.`USUARIOS` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`USUARIOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`USUARIOS` (`id_usuarios`, `nombre`, `apellido`, `email`, `telefono`, `dni`, `fecha_alta`, `fecha_baja`, `direccion`, `foto_perfil`, `estado_hab_des`) VALUES (1, 'Pepito', 'Pepon', 'elpopon@example.com', '464646', 12345678, '2023-11-11', NULL, 'Calle Secundario 985', 'perfildsada2.jpg', 1);
INSERT INTO `mydb`.`USUARIOS` (`id_usuarios`, `nombre`, `apellido`, `email`, `telefono`, `dni`, `fecha_alta`, `fecha_baja`, `direccion`, `foto_perfil`, `estado_hab_des`) VALUES (2, 'Guillermo', 'Williams', 'guille@example.com', '446464', 7777777, '2023-11-11', NULL, 'Calle Secundario 65', 'perfildsada3.jpg', 1);
INSERT INTO `mydb`.`USUARIOS` (`id_usuarios`, `nombre`, `apellido`, `email`, `telefono`, `dni`, `fecha_alta`, `fecha_baja`, `direccion`, `foto_perfil`, `estado_hab_des`) VALUES (3, 'Jhon', 'Pérez', 'juancho@example.com', '4646464', 8888888, '2023-11-11', NULL, 'Calle Secundario 1252', 'perfildsada1.jpg', 1);
INSERT INTO `mydb`.`USUARIOS` (`id_usuarios`, `nombre`, `apellido`, `email`, `telefono`, `dni`, `fecha_alta`, `fecha_baja`, `direccion`, `foto_perfil`, `estado_hab_des`) VALUES (4, 'Prueba', 'Combustible', 'usuariocompracombustible@aero.com', '11111111', 00000001, '2023-11-11', NULL, 'Calle Primaria 123', 'perfil1.jpg', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TIPO_RECIBOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TIPO_RECIBOS` (`id_tipo_recibos`, `tipo`) VALUES (1, 'Recibo de Vuelo');
INSERT INTO `mydb`.`TIPO_RECIBOS` (`id_tipo_recibos`, `tipo`) VALUES (2, 'Recibo de Transacción');
INSERT INTO `mydb`.`TIPO_RECIBOS` (`id_tipo_recibos`, `tipo`) VALUES (3, 'Recibo de Movimientos');
INSERT INTO `mydb`.`TIPO_RECIBOS` (`id_tipo_recibos`, `tipo`) VALUES (4, 'Recibo de Combustible');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TIPO_PAGO`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TIPO_PAGO` (`id_tipo_pago`, `tipo`, `observaciones`) VALUES (1, 'Cheque', NULL);
INSERT INTO `mydb`.`TIPO_PAGO` (`id_tipo_pago`, `tipo`, `observaciones`) VALUES (2, 'Efectivo', NULL);
INSERT INTO `mydb`.`TIPO_PAGO` (`id_tipo_pago`, `tipo`, `observaciones`) VALUES (3, 'Transferencia', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CUENTA_CORRIENTE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CUENTA_CORRIENTE` (`id_cuenta_corriente`, `saldo_cuenta`, `usuarios_id`) VALUES (1, 0, 1);
INSERT INTO `mydb`.`CUENTA_CORRIENTE` (`id_cuenta_corriente`, `saldo_cuenta`, `usuarios_id`) VALUES (2, 0, 2);
INSERT INTO `mydb`.`CUENTA_CORRIENTE` (`id_cuenta_corriente`, `saldo_cuenta`, `usuarios_id`) VALUES (3, 0, 3);
INSERT INTO `mydb`.`CUENTA_CORRIENTE` (`id_cuenta_corriente`, `saldo_cuenta`, `usuarios_id`) VALUES (4, 0, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ESTADOS_AERONAVES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ESTADOS_AERONAVES` (`id_estados_aeronaves`, `estado`) VALUES (1, 'Habilitada');
INSERT INTO `mydb`.`ESTADOS_AERONAVES` (`id_estados_aeronaves`, `estado`) VALUES (2, 'Deshabilitada');
INSERT INTO `mydb`.`ESTADOS_AERONAVES` (`id_estados_aeronaves`, `estado`) VALUES (3, 'En mantenimiento');
INSERT INTO `mydb`.`ESTADOS_AERONAVES` (`id_estados_aeronaves`, `estado`) VALUES (4, 'Fuera de servicio');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`AERONAVES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`AERONAVES` (`id_aeronaves`, `marca`, `modelo`, `matricula`, `potencia`, `clase`, `fecha_adquisicion`, `consumo_por_hora`, `path_documentacion`, `descripcion`, `path_imagen_aeronave`, `estados_aeronaves_id`) VALUES (1, 'Rapidcat', 'catA22', 'ARG-127', '200km/h', 'ClaseA', '2015-10-22', 50, NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`AERONAVES` (`id_aeronaves`, `marca`, `modelo`, `matricula`, `potencia`, `clase`, `fecha_adquisicion`, `consumo_por_hora`, `path_documentacion`, `descripcion`, `path_imagen_aeronave`, `estados_aeronaves_id`) VALUES (2, 'Bogaloo', 'BLOO-3', 'ARG-421', '280km/h', 'ClaseB', '2017-10-22', 55, NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`AERONAVES` (`id_aeronaves`, `marca`, `modelo`, `matricula`, `potencia`, `clase`, `fecha_adquisicion`, `consumo_por_hora`, `path_documentacion`, `descripcion`, `path_imagen_aeronave`, `estados_aeronaves_id`) VALUES (3, 'Apache', '1994-V7', 'ARG-842', '350km/h', 'ClaseC', '2020-10-22', 75, NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`COMPONENTES_AERONAVES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (1, 'Motor', 'Rapidcat', '2012', 70, 120, NULL, 1);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (2, 'Hélice', 'Rapidcat', '2015', 100, 200, NULL, 1);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (3, 'Fuselaje', 'Rapidcat', '2015', 20, 50, NULL, 1);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (4, 'Motor', 'Bogaloo', '2017', 90, 130, NULL, 2);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (5, 'Hélice', 'Bogaloo', '2020', 150, 220, NULL, 2);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (6, 'Fuselaje', 'Bogaloo', '2021', 40, 80, NULL, 2);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (7, 'Motor', 'Apache', '2019', 30, 50, NULL, 3);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (8, 'Hélice', 'Apache', '2018', 50, 80, NULL, 3);
INSERT INTO `mydb`.`COMPONENTES_AERONAVES` (`id_componente`, `nombre`, `marca`, `modelo`, `horas_usadas`, `horas_hasta_revision`, `descripcion`, `aeronaves_id`) VALUES (9, 'Fuselaje', 'Apache', '2012', 10, 120, NULL, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TIPO_ITINERARIOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`, `tipo`) VALUES (1, 'Sólo con instrucción');
INSERT INTO `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`, `tipo`) VALUES (2, 'Doble comando');
INSERT INTO `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`, `tipo`) VALUES (3, 'Travesía');
INSERT INTO `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`, `tipo`) VALUES (4, 'Vuelo por Instrumentos bajo capota');
INSERT INTO `mydb`.`TIPO_ITINERARIOS` (`id_tipo_itinerarios`, `tipo`) VALUES (5, 'Vuelo nocturno');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ROLES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ROLES` (`id_roles`, `tipo`) VALUES (1, 'Asociado');
INSERT INTO `mydb`.`ROLES` (`id_roles`, `tipo`) VALUES (2, 'Instructor');
INSERT INTO `mydb`.`ROLES` (`id_roles`, `tipo`) VALUES (3, 'Gestor');
INSERT INTO `mydb`.`ROLES` (`id_roles`, `tipo`) VALUES (4, 'Cliente');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`USUARIOS_tiene_ROLES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`USUARIOS_tiene_ROLES` (`id_usuarios_tiene_roles`, `usuarios_id`, `roles_id`) VALUES (1, 1, 1);
INSERT INTO `mydb`.`USUARIOS_tiene_ROLES` (`id_usuarios_tiene_roles`, `usuarios_id`, `roles_id`) VALUES (2, 2, 2);
INSERT INTO `mydb`.`USUARIOS_tiene_ROLES` (`id_usuarios_tiene_roles`, `usuarios_id`, `roles_id`) VALUES (3, 3, 3);
INSERT INTO `mydb`.`USUARIOS_tiene_ROLES` (`id_usuarios_tiene_roles`, `usuarios_id`, `roles_id`) VALUES (4, 4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TARIFAS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TARIFAS` (`id_tarifas`, `vigente_desde`, `importe_vuelo`, `importe_instruccion`, `aeronaves_id`) VALUES (1, '2023-11-06', 5000, 700, 1);
INSERT INTO `mydb`.`TARIFAS` (`id_tarifas`, `vigente_desde`, `importe_vuelo`, `importe_instruccion`, `aeronaves_id`) VALUES (2, '2023-11-06', 6500, 1000, 2);
INSERT INTO `mydb`.`TARIFAS` (`id_tarifas`, `vigente_desde`, `importe_vuelo`, `importe_instruccion`, `aeronaves_id`) VALUES (3, '2023-11-06', 8000, 2000, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CODIGOS_AEROPUERTOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`, `codigo_aeropuerto`) VALUES (1, 'LIN');
INSERT INTO `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`, `codigo_aeropuerto`) VALUES (2, 'AER1(test)');
INSERT INTO `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`, `codigo_aeropuerto`) VALUES (3, 'AER2(test)');
INSERT INTO `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`, `codigo_aeropuerto`) VALUES (4, 'AER3(test)');
INSERT INTO `mydb`.`CODIGOS_AEROPUERTOS` (`id_codigos_aeropuertos`, `codigo_aeropuerto`) VALUES (5, 'AER4(test)');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`SEGUROS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`SEGUROS` (`id_seguros`, `fecha_carga`, `fecha_vencimiento`, `importe`, `identificacion`, `aeronaves_id`) VALUES (1, '2023-06-15 00:00:00', '2023-07-15', 10000, 'Seguro completo', 1);
INSERT INTO `mydb`.`SEGUROS` (`id_seguros`, `fecha_carga`, `fecha_vencimiento`, `importe`, `identificacion`, `aeronaves_id`) VALUES (2, '2023-06-07 00:00:00', '2023-07-07', 7500, 'Seguro completo', 2);
INSERT INTO `mydb`.`SEGUROS` (`id_seguros`, `fecha_carga`, `fecha_vencimiento`, `importe`, `identificacion`, `aeronaves_id`) VALUES (3, '2023-06-01 00:00:00', '2023-07-01', 12000, 'Seguro todoriesgo', 3);

COMMIT;

