$planGUID = "1a14e85a-b601-4f68-85b7-93df40f1e526"
powercfg /Import $PWD\..\Misc\powerplan $planGUID
powercfg /setactive $planGUID
powercfg /h off