-- /script SetCVar("language.2", "pl")
local strings =
{
    CRUTCH_BHB_AGHAEDH_OF_THE_SOLSTICE = "Aghaedh Przesilenia",
    CRUTCH_BHB_ANALA_TUWHA = "Anal'a Tu'wha",
    CRUTCH_BHB_ANSUUL_THE_TORMENTOR = "Ansuul Dręczycielka",
    CRUTCH_BHB_ANTHELMIRS_CONSTRUCT = "Konstrukt Anthelmir",
    CRUTCH_BHB_ARADROS_THE_AWAKENED = "Aradros Przebudzony",
    CRUTCH_BHB_ARCHDRUID_DEVYRIC = "Arcydruid Devyrik",
    CRUTCH_BHB_ARCHIVIST_ERNARDE = "Archiwista Ernarde",
    CRUTCH_BHB_ARKASIS_THE_MAD_ALCHEMIST = "Arkasis Szalony Alchemik",
    CRUTCH_BHB_ASSEMBLY_GENERAL = "Generał Montażu",
    CRUTCH_BHB_ATARUS = "Atarus",
    CRUTCH_BHB_BALORGH = "Balorgh",
    CRUTCH_BHB_CAILLAOIFE = "Caillaoife",
    CRUTCH_BHB_CAPTAIN_GEMINUS = "Kapitan Geminus",
    CRUTCH_BHB_CAPTAIN_NUMIRRIL = "Kapitan Numirril",
    CRUTCH_BHB_CAPTAIN_VROL = "Kapitan Vrol",
    CRUTCH_BHB_CHAMPION_MARCAULD = "Czempion Marcauld",
    CRUTCH_BHB_CORRUPTION_OF_ROOT = "Wypaczenie Korzenia",
    CRUTCH_BHB_CORRUPTION_OF_STONE = "Wypaczenie Kamienia",
    CRUTCH_BHB_COUNCILOR_VANDACIA = "Radny Vandacia",
    CRUTCH_BHB_DARKSHARD = "Odłamek Mroku",
    CRUTCH_BHB_DEATHS_LEVIATHAN = "Moloch Śmierci",
    CRUTCH_BHB_DOMIHAUS_THE_BLOODYHORNED = "Domihaus Krwaworogi",
    CRUTCH_BHB_DOYLEMISH_IRONHEART = "Doylemish Żelaznosercy",
    CRUTCH_BHB_DROZAKAR = "Dro'zakar",
    CRUTCH_BHB_EARTHEN_HEART_KNIGHT = "Rycerz Serca Ziemi",
    CRUTCH_BHB_EARTHGORE_AMALGAM = "Amalgamat Ziemioszramy",
    CRUTCH_BHB_ELIAM_MERICK = "Eliam Merick",
    CRUTCH_BHB_ETERNAL_AEGIS = "Wieczna Egida",
    CRUTCH_BHB_EXARCHANIC_YASEYLA = "Egzarchaniczka Yaseyla",
    CRUTCH_BHB_FLAMEHERALD_BAHSEI = "Heroldka Płomienia Bahsei",
    CRUTCH_BHB_FOREMAN_BRADIGGAN = "Brygadzista Braddigan",
    CRUTCH_BHB_GHEMVAS_THE_HARBINGER = "Ghemvas Herold",
    CRUTCH_BHB_GRUNDWULF = "Grundwulf",
    CRUTCH_BHB_HAKGRYM_THE_HOWLER = "Hakgrym Wyjec",
    CRUTCH_BHB_HEDGE_MAZE_GUARDIAN = "Strażnik Krzewiastego Labiryntu",
    CRUTCH_BHB_HIATH_THE_BATTLEMASTER = "Hiath Mistrz Bitwy",
    CRUTCH_BHB_HUNTERKILLER_NEGATRIX = "Łowca-Zabójca Negatrix",
    CRUTCH_BHB_IBOMEZ_THE_FLESH_SCULPTOR = "Ibomez Rzeźbiarz Ciała",
    CRUTCH_BHB_ICESTALKER = "Lodołowca",
    CRUTCH_BHB_JAILER_MELITUS = "Strażnik Więzienny Melitus",
    CRUTCH_BHB_KEEPER_OF_THE_KILN = "Dozorca Pieca",
    CRUTCH_BHB_KJALNAR_TOMBSKALD = "Kjalnar Grobowy Skald",
    CRUTCH_BHB_KOVAN_GIRYON = "Kovan Giryon",
    CRUTCH_BHB_KUJO_KETHBA = "Kujo Kethba",
    CRUTCH_BHB_LAATVULON = "Laatvulon",
    CRUTCH_BHB_LADY_BELAIN = "Lady Belain",
    CRUTCH_BHB_LADY_THORN = "Pani Cierni",
    CRUTCH_BHB_LOKKESTIIZ = "Lokkestiiz",
    CRUTCH_BHB_LORD_FALGRAVN = "Lord Falgravn",
    CRUTCH_BHB_LORD_WARDEN_DUSK = "Lord Strażnik Zmierzchu",
    CRUTCH_BHB_LYLANAR = "Lylanar",
    CRUTCH_BHB_MAARSELOK = "Maarselok",
    CRUTCH_BHB_MAGMA_INCARNATE = "Wcielenie Magmy",
    CRUTCH_BHB_MALIGALIG = "Maligalig",
    CRUTCH_BHB_MATRIARCH_ALDIS = "Matriarcha Aldis",
    CRUTCH_BHB_MATRIARCH_LLADI_TELVANNI = "Matrona Lladi Telvanni",
    CRUTCH_BHB_MAVUS_TALNARITH = "Mavus Talnarith",
    CRUTCH_BHB_MOLAG_KENA = "Molag Kena",
    CRUTCH_BHB_MULAAMNIR = "Mulaamnir",
    CRUTCH_BHB_MYLENNE_MOONCALLER = "Mylenne Wywoływaczka Księżyca",
    CRUTCH_BHB_NAHVIINTAAS = "Nahviintaas",
    CRUTCH_BHB_NERIENETH = "Nerien'eth",
    CRUTCH_BHB_OAXILTSO = "Oaxiltso",
    CRUTCH_BHB_ONDAGORE_THE_MAD = "Ondagore Szalony",
    CRUTCH_BHB_OVERFIEND = "Zaklątwiak",
    CRUTCH_BHB_OZEZAN_THE_INFERNO = "Ozezan Piekielny",
    CRUTCH_BHB_PINNACLE_FACTOTUM = "Najdoskonalsze Faktotum",
    CRUTCH_BHB_PISHNA_LONGSHOT = "Pishna Długi Strzał",
    CRUTCH_BHB_PYROTURGE_ENCRATIS = "Piroturg Encratis",
    CRUTCH_BHB_QUINTUS_VERRES = "Quintus Verres",
    CRUTCH_BHB_RA_KOTU = "Ra Kotu",
    CRUTCH_BHB_RAKKHAT = "Rakkhat",
    CRUTCH_BHB_REACTOR = "Reaktor",
    CRUTCH_BHB_REEF_GUARDIAN = "Strażnik Rafy",
    CRUTCH_BHB_RIFTMASTER_NAQRI = "Mistrz Szczelin Naqri",
    CRUTCH_BHB_ROKSA_THE_WARPED = "Roksa Wypaczona",
    CRUTCH_BHB_SAINT_OLMS_THE_JUST = "Święty Olms Sprawiedliwy",
    CRUTCH_BHB_SARYDIL = "Sarydil",
    CRUTCH_BHB_SCORION_BROODLORD = "Skorion Władca Roju",
    CRUTCH_BHB_SENTINEL_AKSALAZ = "Wartownik Aksalaz",
    CRUTCH_BHB_SHADE_OF_SIRORIA = "Cień Sirorii",
    CRUTCH_BHB_SHATTERED_CHAMPION = "Strzaskany Czempion",
    CRUTCH_BHB_SITHERA = "Sithera",
    CRUTCH_BHB_STONEHEART = "Kamienne Serce",
    CRUTCH_BHB_STORMBORN_REVENANT = "Burzowy Ożywieniec",
    CRUTCH_BHB_SYMPHONY_OF_BLADES = "Symfonia Ostrzy",
    CRUTCH_BHB_TARCYR = "Tarcyr",
    CRUTCH_BHB_TASKMASTER_VICCIA = "Nadzorczyni Viccia",
    CRUTCH_BHB_THE_BLIND = "Ślepa",
    CRUTCH_BHB_THE_MAGE = "Mag",
    CRUTCH_BHB_THE_PYRELORD = "Władca Stosu",
    CRUTCH_BHB_THE_SCAVENGING_MAW = "Żerująca Paszcza",
    CRUTCH_BHB_THE_STONEKEEPER = "Strażnik Kamienia",
    CRUTCH_BHB_THE_WARRIOR = "Wojownik",
    CRUTCH_BHB_THE_WEEPING_WOMAN = "Płacząca Kobieta",
    CRUTCH_BHB_THOAT_REPLICANUM = "Tho'at Replicanum",
    CRUTCH_BHB_THOAT_SHARD = "Odłamek Tho'at",
    CRUTCH_BHB_THURVOKUN = "Thurvokun",
    CRUTCH_BHB_TIDEBORN_TALERIA = "Taleria Dziecię Fal",
    CRUTCH_BHB_TREEMINDER_NAKESH = "Opiekunka Drzew Na-Kesh",
    CRUTCH_BHB_VALINNA = "Valinna",
    CRUTCH_BHB_VAMPIRE_LORD_THISA = "władczyni wampirów Thisa",
    CRUTCH_BHB_VARALLION = "Varallion",
    CRUTCH_BHB_VAULT_PROTECTOR = "Protektor Krypty",
    CRUTCH_BHB_VELIDRETH = "Velidreth",
    CRUTCH_BHB_VORIA_THE_HEARTTHIEF = "Voria Złodziejka-Serc",
    CRUTCH_BHB_VYKOSA_THE_ASCENDANT = "Vykosa Wschodząca",
    CRUTCH_BHB_WARLORD_TZOGVIN = "Watażka Tzogvin",
    CRUTCH_BHB_XALVAKKA = "Xalvakka",
    CRUTCH_BHB_YANDIR_THE_BUTCHER = "Yandir Rzeźnik",
    CRUTCH_BHB_YOLNAHKRIIN = "Yolnahkriin",
    CRUTCH_BHB_ZAAN_THE_SCALECALLER = "Zaan Łuskowata",
    CRUTCH_BHB_ZBAZA = "Z'Baza",
    CRUTCH_BHB_ZELVRAAK_THE_UNBREATHING = "Zelvraak Nieoddychający",
    CRUTCH_BHB_ZHAJHASSA_THE_FORGOTTEN = "Zhaj'hassa Zapomniany",
}

for stringId, stringValue in pairs(strings) do
    SafeAddString(_G[stringId], stringValue, 2)
end
