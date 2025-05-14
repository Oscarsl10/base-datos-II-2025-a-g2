CREATE INDEX idx_socio_email ON Socios(email);
CREATE INDEX idx_clase_instructor ON ClasesGrupales(id_instructor);
CREATE INDEX idx_reservas_socio ON ReservasClase(id_socio);