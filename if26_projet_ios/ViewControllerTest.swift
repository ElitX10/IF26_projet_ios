//
//  ViewControllerTest.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 29/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

class ViewControllerTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pokemonDAO = PokemonDAO.init()
        if pokemonDAO.getAllPokemon().count == 0 {
            pokemonDAO.loadFirstGen()
        }
    }
    
    @IBAction func clicktest() {
        let pokemonDAO = PokemonDAO.init()
        let pokemons = pokemonDAO.getAllPokemon()
        for pokemon in pokemons {
            print("le pokemon \(pokemon.getId()) est : \(pokemon.getNom())")
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
