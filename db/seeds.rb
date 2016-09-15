if Sector.all.count == 0
  Sector.create name: 'Informática'
  Sector.create name: 'Recursos Humanos'
  Sector.create name: 'Financeiro'
  Sector.create name: 'Comercial'
end

if Employee.all.count == 0
  Employee.create sector: Sector.find_by(name: 'Informatica'),      name: 'Rodrigo Maia',     sex: 'M', birth_date: Date.new(1980, 3,  1)
  Employee.create sector: Sector.find_by(name: 'Informatica'),      name: 'Carolina Mendes',  sex: 'F', birth_date: Date.new(1985, 10, 17)
  Employee.create sector: Sector.find_by(name: 'Recursos Humanos'), name: 'Eloiza Barros',    sex: 'F', birth_date: Date.new(1973, 4,  11)
  Employee.create sector: Sector.find_by(name: 'Recursos Humanos'), name: 'Robson Ruiz',      sex: 'M', birth_date: Date.new(1995, 11, 13)
  Employee.create sector: Sector.find_by(name: 'Financeiro'),       name: 'Danielle Freitas', sex: 'F', birth_date: Date.new(1988, 6,  30)
  Employee.create sector: Sector.find_by(name: 'Comercial'),        name: 'Luiz Padilha',     sex: 'M', birth_date: Date.new(1966, 8,  3)
end

if ContactType.all.count == 0
  ContactType.create name: 'Residencial'
  ContactType.create name: 'Comercial'
  ContactType.create name: 'Celular'
end
