//
//  DataBaseHelper.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class DataBaseHelper: NSObject {
    let DATABASE_NAME = "pokeappdb";
    
    // nom des tables de la BDD :
    public static let DRESSEUR_TABLE = Table("dresseur");
    public static let POKEMON_TABLE = Table("pokemon");
    public static let POKESTOP_TABLE = Table("pokestop");
    public static let LOCALISATION_TABLE = Table("localisation");
    
    // nom colonnes table dresseur :
    public static let ID_DRESSEUR = Expression<Int>("id");
    public static let PSEUDO_DRESSEUR = Expression<String>("pseudo");
    public static let MOT_DE_PASSE_DRESSEUR = Expression<String>("password");
    
    // nom colonnes table pokemon :
    public static let ID_POKEMON = Expression<Int>("id");
    public static let NOM_POKEMON = Expression<String>("nom");
    
    // nom colonnes table pokestop :
    public static let ID_POKESTOP = Expression<Int>("id");
    public static let NOM_POKESTOP = Expression<String>("nom");
    public static let IS_GYM_POKESTOP = Expression<Bool>("is_gym");
    public static let LATITUDE_POKESTOP = Expression<String>("latitude");
    public static let LONGITUDE_POKESTOP = Expression<String>("longitude");
    public static let ID_DRESSEUR_POKESTOP = Expression<Int>("dresseur_id");
    
    // nom colonnes table localisation :
    public static let ID_LOCALISATION = Expression<Int>("id");
    public static let ID_POKEMON_LOCALISATION = Expression<Int>("pokemon_id");
    public static let ID_DRESSEUR_LOCALISATION = Expression<Int>("dresseur_id");
    public static let ID_POKESTOP_LOCALISATION = Expression<Int>("pokestop_id");
    public static let TIME_LOCALISATION = Expression<String>("time");
    
    // commandes de création des tables :
    let CREATE_DRESSEUR_TABLE = DRESSEUR_TABLE.create(ifNotExists: true){ table in
        table.column(ID_DRESSEUR, primaryKey: .autoincrement)
        table.column(PSEUDO_DRESSEUR, unique: true)
        table.column(MOT_DE_PASSE_DRESSEUR)
    }
    
    let CREATE_POKEMON_TABLE = POKEMON_TABLE.create(ifNotExists: true){ table in
        table.column(ID_POKEMON, primaryKey: true)
        table.column(NOM_POKEMON, unique: true)
    }
    
    let CREATE_POKESTOP_TABLE = POKESTOP_TABLE.create(ifNotExists: true){ table in
        table.column(ID_POKESTOP, primaryKey: .autoincrement)
        table.column(NOM_POKESTOP)
        table.column(IS_GYM_POKESTOP, defaultValue: false)
        table.column(LATITUDE_POKESTOP)
        table.column(LONGITUDE_POKESTOP)
        table.column(ID_DRESSEUR_POKESTOP, references: DRESSEUR_TABLE, ID_DRESSEUR)
    }
    
    let CREATE_LOCALISATION_TABLE = LOCALISATION_TABLE.create(ifNotExists: true){ table in
        table.column(ID_LOCALISATION, primaryKey: .autoincrement)
        table.column(ID_POKEMON_LOCALISATION)
        table.column(ID_DRESSEUR_LOCALISATION)
        table.column(ID_POKESTOP_LOCALISATION)
        table.column(TIME_LOCALISATION)
        table.foreignKey(ID_POKEMON_LOCALISATION, references: POKEMON_TABLE, ID_DRESSEUR)
        table.foreignKey(ID_DRESSEUR_LOCALISATION, references: DRESSEUR_TABLE, ID_DRESSEUR)
        table.foreignKey(ID_POKESTOP_LOCALISATION, references: POKESTOP_TABLE, ID_POKESTOP, delete: .cascade)
    }
    
    var dataBase: Connection!
    
    override init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(DATABASE_NAME).appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.dataBase = base;
        }catch {
            print (error)
        }
        
        do{
            try self.dataBase.run(CREATE_DRESSEUR_TABLE)
            try self.dataBase.run(CREATE_POKEMON_TABLE)
            try self.dataBase.run(CREATE_POKESTOP_TABLE)
            try self.dataBase.run(CREATE_LOCALISATION_TABLE)
        }catch{
            print(error)
        }
    }

}
