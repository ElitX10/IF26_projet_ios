//
//  ViewControllerTest.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 29/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class ViewControllerTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pokemonDAO = PokemonDAO.init()
        if pokemonDAO.getAllPokemon().count == 0 {
            pokemonDAO.loadFirstGen()
        }
    }
    
    @IBAction func clicktest() {
        let dresseurDAO = DresseurDAO.init()
        
        print("------------ liste des pokemons ---------")
        let pokemonDAO = PokemonDAO.init()
        let pokemons = pokemonDAO.getAllPokemon()
        for pokemon in pokemons {
            print(pokemon.toString())
        }
        
        let dresseur1 = dresseurDAO.getDresseurById(id: 1)
        let dresseur2 = dresseurDAO.getDresseurByPseudo(pseudo: "Elitx2")
        let dresseur3 = dresseurDAO.getDresseurByPseudo(pseudo: "fefef")
        print("------------ liste des dresseurs ---------")
        print(dresseur1?.toString() ?? "")
        print(dresseur2?.toString() ?? "")
        print(dresseur3?.toString() ?? "")
        
        let pokestopDAO = PokestopDAO.init()
        let pokestops = pokestopDAO.getAllPokestop()
        print("------------ liste des pokestops ---------")
        for poke in pokestops{
            print(poke.toString())
        }
        print("------------ pokestop 1 ---------")
        var pokestop = pokestopDAO.getPokestop(id: 1)
        print(pokestop?.toString() ?? "")
        print("------------ pokestop 1 modifier ---------")
        pokestop?.setNom(nom: "nom modifié")
        pokestopDAO.update(pokestop: pokestop!)
        pokestop = pokestopDAO.getPokestop(id: 1)
        print(pokestop?.toString() ?? "")
        
        print("------------ liste localisation pokestop id 1 ---------")
        let localisationDAO = LocalisationDAO.init()
        var localisations = localisationDAO.getLocalisations(pokestop_id: (pokestop?.getId())!)
        for localisation in localisations{
            print(localisation.toString())
        }
        print("------------ delete localisation ---------")
        localisationDAO.delete(id: 2)
        localisations = localisationDAO.getLocalisations(pokestop_id: (pokestop?.getId())!)
        for localisation in localisations{
            print(localisation.toString())
        }
        
        print("------------ delete pokestop ---------")
        pokestopDAO.deletePokestop(id: (pokestop?.getId())!)
        pokestop = pokestopDAO.getPokestop(id: 1)
        print(pokestop?.toString() ?? "le pokestop à été supprimé")
        print("------------ deleted localisation ----------")
        do{
            for row in try localisationDAO.dataBase.prepare(localisationDAO.LOCALISATION_TABLE.filter(DataBaseHelper.ID_POKESTOP_LOCALISATION == 1)){
                print("------ \(row[DataBaseHelper.ID_LOCALISATION]) -----")
            }
        }catch{
            print(error)
        }
        localisations = localisationDAO.getLocalisations(pokestop_id: 1)
        for localisation in localisations{
            print(localisation.toString())
        }
        
        
//        print("le pokemon \(pokemon?.getId() ?? -1) est : \(pokemon?.getNom() ?? "")")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
