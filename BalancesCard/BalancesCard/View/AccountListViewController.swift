//
//  AccountListViewController.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import UIKit

final class AccountListViewController: UIViewController {
    private var accountViewModel = AccountViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        accountViewModel.loadAccountsJson { viewModel, errorStr in
            guard let vm = viewModel else {
                return
            }
            for institution in vm.institutions {
                print(institution.name)
                for account in institution.accounts {
                    print(account.nickname)
                }
            }
        }
        // Do any additional setup after loading the view.
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
