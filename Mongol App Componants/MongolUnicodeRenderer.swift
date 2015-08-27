/*
* Chimee Mongol Unicode Rendering Engine for iOS
*
* Version 1.1.2
*
* Current version needs to be used with Almas font glyphs
* copied to PUA starting at \uE360. To use different glyph
* encodings, adjust the Glyph.* static final constants below.
* These PUA encodings are only to be used internally for glyph
* selection. All external text should use Unicode.
*/

class MongolUnicodeRenderer {
    
    // Singleton
    // This class is immutable
    static let sharedInstance = MongolUnicodeRenderer()
    
    enum Location {
        case ISOLATE, INITIAL, MEDIAL, FINAL, NOT_MONGOLIAN
    }
    
    struct Uni {
        // Class constants
        static let ZWJ: UInt32 = 0x200d // Zero-width joiner
        static let NNBS: UInt32 = 0x202F // Narrow No-Break Space
        // Unicode Mongolian Values
        static let MONGOLIAN_BIRGA: UInt32 = 0x1800
        static let MONGOLIAN_ELLIPSIS: UInt32 = 0x1801
        static let MONGOLIAN_COMMA: UInt32 = 0x1802
        static let MONGOLIAN_FULL_STOP: UInt32 = 0x1803
        static let MONGOLIAN_COLON: UInt32 = 0x1804
        static let MONGOLIAN_FOUR_DOTS: UInt32 = 0x1805
        static let MONGOLIAN_NIRUGU: UInt32 = 0x180a
        static let FVS1: UInt32 = 0x180b
        static let FVS2: UInt32 = 0x180c
        static let FVS3: UInt32 = 0x180d
        static let MVS: UInt32 = 0x180e // MONGOLIAN_VOWEL_SEPARATOR
        static let MONGOLIAN_DIGIT_ZERO: UInt32 = 0x1810
        static let MONGOLIAN_DIGIT_ONE: UInt32 = 0x1811
        static let MONGOLIAN_DIGIT_TWO: UInt32 = 0x1812
        static let MONGOLIAN_DIGIT_THREE: UInt32 = 0x1813
        static let MONGOLIAN_DIGIT_FOUR: UInt32 = 0x1814
        static let MONGOLIAN_DIGIT_FIVE: UInt32 = 0x1815
        static let MONGOLIAN_DIGIT_SIX: UInt32 = 0x1816
        static let MONGOLIAN_DIGIT_SEVEN: UInt32 = 0x1817
        static let MONGOLIAN_DIGIT_EIGHT: UInt32 = 0x1818
        static let MONGOLIAN_DIGIT_NINE: UInt32 = 0x1819
        static let A: UInt32 = 0x1820 // MONGOLIAN_LETTER_xx
        static let E: UInt32 = 0x1821
        static let I: UInt32 = 0x1822
        static let O: UInt32 = 0x1823
        static let U: UInt32 = 0x1824
        static let OE: UInt32 = 0x1825
        static let UE: UInt32 = 0x1826
        static let EE: UInt32 = 0x1827
        static let NA: UInt32 = 0x1828
        static let ANG: UInt32 = 0x1829
        static let BA: UInt32 = 0x182A
        static let PA: UInt32 = 0x182B
        static let QA: UInt32 = 0x182C
        static let GA: UInt32 = 0x182D
        static let MA: UInt32 = 0x182E
        static let LA: UInt32 = 0x182F
        static let SA: UInt32 = 0x1830
        static let SHA: UInt32 = 0x1831
        static let TA: UInt32 = 0x1832
        static let DA: UInt32 = 0x1833
        static let CHA: UInt32 = 0x1834
        static let JA: UInt32 = 0x1835
        static let YA: UInt32 = 0x1836
        static let RA: UInt32 = 0x1837
        static let WA: UInt32 = 0x1838
        static let FA: UInt32 = 0x1839
        static let KA: UInt32 = 0x183A
        static let KHA: UInt32 = 0x183B
        static let TSA: UInt32 = 0x183C
        static let ZA: UInt32 = 0x183D
        static let HAA: UInt32 = 0x183E
        static let ZRA: UInt32 = 0x183F
        static let LHA: UInt32 = 0x1840
        static let ZHI: UInt32 = 0x1841
        static let CHI: UInt32 = 0x1842
        
    }
    
    private struct Glyph {
        
        // static let CURSOR_HOLDER: UInt32 = 0xE359 // arbitrary unused char
        static let CURSOR_HOLDER: UInt32 = UInt32("|")
        
        // Private Use Area glyph values
        static let NOTDEF: UInt32 = 0xE360
        static let BIRGA: UInt32 = 0xE364
        static let ELLIPSIS: UInt32 = 0xE365
        static let COMMA: UInt32 = 0xE366
        static let FULL_STOP: UInt32 = 0xE367
        static let COLON: UInt32 = 0xE368
        static let FOUR_DOTS: UInt32 = 0xE369
        static let NIRUGU: UInt32 = 0xE36E
        static let ZERO: UInt32 = 0xE374
        static let ONE: UInt32 = 0xE375
        static let TWO: UInt32 = 0xE376
        static let THREE: UInt32 = 0xE377
        static let FOUR: UInt32 = 0xE378
        static let FIVE: UInt32 = 0xE379
        static let SIX: UInt32 = 0xE37A
        static let SEVEN: UInt32 = 0xE37B
        static let EIGHT: UInt32 = 0xE37C
        static let NINE: UInt32 = 0xE37D
        static let QUESTION_EXCLAMATION: UInt32 = 0xE37E
        static let EXCLAMATION_QUESTION: UInt32 = 0xE37F
        static let ISOL_A: UInt32 = 0xE384
        static let ISOL_A_FVS1: UInt32 = 0xE385
        static let INIT_A: UInt32 = 0xE386
        static let MEDI_A: UInt32 = 0xE387
        static let MEDI_A_FVS1: UInt32 = 0xE388
        static let FINA_A: UInt32 = 0xE389
        static let FINA_A_FVS1: UInt32 = 0xE38A
        static let FINA_A_FVS2: UInt32 = 0xE38B
        static let ISOL_E: UInt32 = 0xE38C
        static let ISOL_E_FVS1: UInt32 = 0xE38D
        static let INIT_E: UInt32 = 0xE38E
        static let INIT_E_FVS1: UInt32 = 0xE38F
        static let MEDI_E: UInt32 = 0xE390
        static let FINA_E: UInt32 = 0xE391
        static let FINA_E_FVS1: UInt32 = 0xE392
        static let FINA_E_FVS2: UInt32 = 0xE393
        static let ISOL_I: UInt32 = 0xE394
        static let ISOL_I_FVS1: UInt32 = 0xE395
        static let INIT_I: UInt32 = 0xE396
        static let INIT_I_FVS1: UInt32 = 0xE397
        static let MEDI_I: UInt32 = 0xE398
        static let MEDI_I_FVS1: UInt32 = 0xE399
        // TODO Glyph.MEDI_I_FVS2 and Glyph.MEDI_I_FVS3 have not been standardized in Unicode yet
        // Matching them to Baiti
        static let MEDI_I_FVS3: UInt32 = 0xE39A
        static let FINA_I: UInt32 = 0xE39B
        static let ISOL_O: UInt32 = 0xE39C
        static let ISOL_O_FVS1: UInt32 = 0xE39D
        static let INIT_O: UInt32 = 0xE39E
        static let INIT_O_FVS1: UInt32 = 0xE39F
        static let MEDI_O: UInt32 = 0xE3A0
        static let MEDI_O_FVS1: UInt32 = 0xE3A1
        static let FINA_O: UInt32 = 0xE3A2
        static let FINA_O_FVS1: UInt32 = 0xE3A3
        static let ISOL_U: UInt32 = 0xE3A6  // Using Init U gliph
        static let ISOL_U_FVS1: UInt32 = 0xE3A4
        static let ISOL_U_FVS2: UInt32 = 0xE3A5
        static let INIT_U: UInt32 = 0xE3A6
        static let INIT_U_FVS1: UInt32 = 0xE3A7
        static let MEDI_U: UInt32 = 0xE3A8
        static let MEDI_U_FVS1: UInt32 = 0xE3A9
        static let FINA_U: UInt32 = 0xE3AA
        static let FINA_U_FVS1: UInt32 = 0xE3AB
        static let ISOL_OE: UInt32 = 0xE3AC
        static let ISOL_OE_FVS1: UInt32 = 0xE3AD
        static let INIT_OE: UInt32 = 0xE3AE
        static let MEDI_OE: UInt32 = 0xE3AF
        static let MEDI_OE_FVS1: UInt32 = 0xE3B0
        static let MEDI_OE_FVS2: UInt32 = 0xE3B1
        static let FINA_OE: UInt32 = 0xE3B2
        static let FINA_OE_FVS1: UInt32 = 0xE3B3
        static let ISOL_UE: UInt32 = 0xE3B6
        static let ISOL_UE_FVS2: UInt32 = 0xE3C3
        static let ISOL_UE_FVS3: UInt32 = 0xE3B5
        static let INIT_UE: UInt32 = 0xE3B6
        static let MEDI_UE: UInt32 = 0xE3B7
        static let MEDI_UE_FVS1: UInt32 = 0xE3B8
        static let MEDI_UE_FVS2: UInt32 = 0xE3B9
        static let FINA_UE: UInt32 = 0xE3BA
        static let FINA_UE_FVS1: UInt32 = 0xE3BB
        static let ISOL_EE: UInt32 = 0xE3BC
        static let ISOL_EE_FVS1: UInt32 = 0xE3BD
        static let INIT_EE: UInt32 = 0xE3BE
        static let INIT_EE_FVS1: UInt32 = 0xE3BF
        static let MEDI_EE: UInt32 = 0xE3C0
        static let FINA_EE: UInt32 = 0xE3C1
        static let INIT_UE_FVS1: UInt32 = 0xE3C2
        static let ISOL_UE_FVS1: UInt32 = 0xE3B4
        static let ISOL_NA: UInt32 = 0xE3C4
        static let ISOL_NA_FVS1: UInt32 = 0xE3C5
        static let INIT_NA: UInt32 = 0xE3C6
        static let INIT_NA_FVS1: UInt32 = 0xE3C7
        static let MEDI_NA: UInt32 = 0xE3C8
        static let MEDI_NA_FVS1: UInt32 = 0xE3C9
        static let MEDI_NA_FVS2: UInt32 = 0xE3C8 // same as medial na
        static let FINA_NA: UInt32 = 0xE3CA
        static let FINA_NA_FVS1: UInt32 = 0xE3CB
        static let ISOL_ANG: UInt32 = 0xE3CC
        static let INIT_ANG: UInt32 = 0xE3CD
        static let MEDI_ANG: UInt32 = 0xE3CE
        static let FINA_ANG: UInt32 = 0xE3CF
        static let MEDI_ANG_MEDI_QA: UInt32 = 0xE3D0
        static let MEDI_ANG_MEDI_GA: UInt32 = 0xE3D1
        static let MEDI_ANG_MEDI_MA: UInt32 = 0xE3D2
        static let MEDI_ANG_MEDI_LA: UInt32 = 0xE3D3
        static let ISOL_BA: UInt32 = 0xE3D4
        static let INIT_BA: UInt32 = 0xE3D5
        static let MEDI_BA: UInt32 = 0xE3D6
        static let FINA_BA: UInt32 = 0xE3D7
        static let INIT_BA_FINA_A: UInt32 = 0xE3D8
        static let INIT_BA_MEDI_A: UInt32 = 0xE3D9
        static let MEDI_BA_MEDI_A: UInt32 = 0xE3DA
        static let MEDI_BA_FINA_A: UInt32 = 0xE3DB
        static let INIT_BA_FINA_E: UInt32 = 0xE3DC
        static let INIT_BA_MEDI_E: UInt32 = 0xE3DD
        static let MEDI_BA_MEDI_E: UInt32 = 0xE3DE
        static let MEDI_BA_FINA_E: UInt32 = 0xE3DF
        static let INIT_BA_FINA_I: UInt32 = 0xE3E0
        static let INIT_BA_MEDI_I: UInt32 = 0xE3E1
        static let MEDI_BA_MEDI_I: UInt32 = 0xE3E2
        static let MEDI_BA_FINA_I: UInt32 = 0xE3E3
        static let INIT_BA_FINA_O: UInt32 = 0xE3E4
        static let INIT_BA_MEDI_O: UInt32 = 0xE3E5
        static let MEDI_BA_MEDI_O: UInt32 = 0xE3E6
        static let MEDI_BA_FINA_O: UInt32 = 0xE3E7
        static let INIT_BA_FINA_U: UInt32 = 0xE3E8
        static let INIT_BA_MEDI_U: UInt32 = 0xE3E9
        static let MEDI_BA_MEDI_U: UInt32 = 0xE3EA
        static let MEDI_BA_FINA_U: UInt32 = 0xE3EB
        static let INIT_BA_FINA_OE: UInt32 = 0xE3EC
        static let INIT_BA_MEDI_OE: UInt32 = 0xE3ED
        static let MEDI_BA_MEDI_OE: UInt32 = 0xE3EE
        static let MEDI_BA_FINA_OE: UInt32 = 0xE3EF
        static let MEDI_BA_FINA_OE_FVS1: UInt32 = 0xE3F0
        static let INIT_BA_FINA_UE: UInt32 = 0xE3F1
        static let INIT_BA_MEDI_UE: UInt32 = 0xE3F2
        static let MEDI_BA_MEDI_UE: UInt32 = 0xE3F3
        static let MEDI_BA_FINA_UE: UInt32 = 0xE3F4
        static let MEDI_BA_FINA_UE_FVS1: UInt32 = 0xE3F5
        static let INIT_BA_FINA_EE: UInt32 = 0xE3F6
        static let INIT_BA_MEDI_EE: UInt32 = 0xE3F7
        static let MEDI_BA_MEDI_EE: UInt32 = 0xE3F8
        static let MEDI_BA_FINA_EE: UInt32 = 0xE3F9
        static let MEDI_BA_MEDI_MA: UInt32 = 0xE3FA
        static let MEDI_BA_MEDI_LA: UInt32 = 0xE3FB
        static let ISOL_PA: UInt32 = 0xE3FC
        static let INIT_PA: UInt32 = 0xE3FD
        static let MEDI_PA: UInt32 = 0xE3FE
        static let FINA_PA: UInt32 = 0xE3FF
        static let INIT_PA_FINA_A: UInt32 = 0xE400
        static let INIT_PA_MEDI_A: UInt32 = 0xE401
        static let MEDI_PA_MEDI_A: UInt32 = 0xE402
        static let MEDI_PA_FINA_A: UInt32 = 0xE403
        static let INIT_PA_FINA_E: UInt32 = 0xE404
        static let INIT_PA_MEDI_E: UInt32 = 0xE405
        static let MEDI_PA_MEDI_E: UInt32 = 0xE406
        static let MEDI_PA_FINA_E: UInt32 = 0xE407
        static let INIT_PA_FINA_I: UInt32 = 0xE408
        static let INIT_PA_MEDI_I: UInt32 = 0xE409
        static let MEDI_PA_MEDI_I: UInt32 = 0xE40A
        static let MEDI_PA_FINA_I: UInt32 = 0xE40B
        static let INIT_PA_FINA_O: UInt32 = 0xE40C
        static let INIT_PA_MEDI_O: UInt32 = 0xE40D
        static let MEDI_PA_MEDI_O: UInt32 = 0xE40E
        static let MEDI_PA_FINA_O: UInt32 = 0xE40F
        static let INIT_PA_FINA_U: UInt32 = 0xE410
        static let INIT_PA_MEDI_U: UInt32 = 0xE411
        static let MEDI_PA_MEDI_U: UInt32 = 0xE412
        static let MEDI_PA_FINA_U: UInt32 = 0xE413
        static let INIT_PA_FINA_OE: UInt32 = 0xE414
        static let INIT_PA_MEDI_OE: UInt32 = 0xE415
        static let MEDI_PA_MEDI_OE: UInt32 = 0xE416
        static let MEDI_PA_FINA_OE: UInt32 = 0xE417
        static let MEDI_PA_FINA_OE_FVS1: UInt32 = 0xE418
        static let INIT_PA_FINA_UE: UInt32 = 0xE419
        static let INIT_PA_MEDI_UE: UInt32 = 0xE41A
        static let MEDI_PA_MEDI_UE: UInt32 = 0xE41B
        static let MEDI_PA_FINA_UE: UInt32 = 0xE41C
        static let MEDI_PA_FINA_UE_FVS1: UInt32 = 0xE41D
        static let INIT_PA_FINA_EE: UInt32 = 0xE41E
        static let INIT_PA_MEDI_EE: UInt32 = 0xE41F
        static let MEDI_PA_MEDI_EE: UInt32 = 0xE420
        static let MEDI_PA_FINA_EE: UInt32 = 0xE421
        static let MEDI_PA_MEDI_MA: UInt32 = 0xE422
        static let MEDI_PA_MEDI_LA: UInt32 = 0xE423
        static let ISOL_QA: UInt32 = 0xE424
        static let ISOL_QA_FVS3: UInt32 = 0xE425 // TODO matching Baiti
        static let INIT_QA: UInt32 = 0xE426
        static let INIT_QA_FVS1: UInt32 = 0xE427
        static let MEDI_QA: UInt32 = 0xE428
        static let MEDI_QA_FVS1: UInt32 = 0xE429
        static let MEDI_QA_FVS2: UInt32 = 0xE42A
        static let FINA_QA: UInt32 = 0xE42B
        static let FINA_QA_FVS1: UInt32 = 0xE42C
        static let FINA_QA_FVS2: UInt32 = 0xE42D
        static let INIT_QA_FINA_E: UInt32 = 0xE42E
        static let INIT_QA_MEDI_E: UInt32 = 0xE42F
        static let MEDI_QA_MEDI_E: UInt32 = 0xE430
        static let MEDI_QA_FINA_E: UInt32 = 0xE431
        static let INIT_QA_FINA_I: UInt32 = 0xE432
        static let INIT_QA_MEDI_I: UInt32 = 0xE433
        static let MEDI_QA_MEDI_I: UInt32 = 0xE434
        static let MEDI_QA_FINA_I: UInt32 = 0xE435
        static let INIT_QA_FINA_OE: UInt32 = 0xE436
        static let INIT_QA_MEDI_OE: UInt32 = 0xE437
        static let MEDI_QA_MEDI_OE: UInt32 = 0xE438
        static let MEDI_QA_FINA_OE: UInt32 = 0xE439
        static let MEDI_QA_FINA_OE_FVS1: UInt32 = 0xE43A
        static let INIT_QA_FINA_UE: UInt32 = 0xE43B
        static let INIT_QA_MEDI_UE: UInt32 = 0xE43C
        static let MEDI_QA_MEDI_UE: UInt32 = 0xE43D
        static let MEDI_QA_FINA_UE: UInt32 = 0xE43E
        static let MEDI_QA_FINA_UE_FVS1: UInt32 = 0xE43F
        static let INIT_QA_FINA_EE: UInt32 = 0xE440
        static let INIT_QA_MEDI_EE: UInt32 = 0xE441
        static let MEDI_QA_MEDI_EE: UInt32 = 0xE442
        static let MEDI_QA_FINA_EE: UInt32 = 0xE443
        static let ISOL_GA: UInt32 = 0xE444
        static let ISOL_GA_FVS3: UInt32 = 0xE445 // TODO not in Baiti
        static let INIT_GA: UInt32 = 0xE446
        static let INIT_GA_FVS1: UInt32 = 0xE447
        static let MEDI_GA: UInt32 = 0xE448
        static let MEDI_GA_FVS1: UInt32 = 0xE449
        static let MEDI_GA_FVS2: UInt32 = 0xE448 // TODO matching Baiti, not using \uE44A
        static let FINA_GA: UInt32 = 0xE44B
        static let FINA_GA_FVS1: UInt32 = 0xE44B // TODO matching Baiti
        static let FINA_GA_FVS3: UInt32 = 0xE44C // TODO matching Baiti
        static let FINA_GA_FVS2: UInt32 = 0xE44D
        static let INIT_GA_FINA_E: UInt32 = 0xE44E
        static let INIT_GA_MEDI_E: UInt32 = 0xE44F
        static let MEDI_GA_MEDI_E: UInt32 = 0xE450
        static let MEDI_GA_FINA_E: UInt32 = 0xE451
        static let INIT_GA_FINA_I: UInt32 = 0xE452
        static let INIT_GA_MEDI_I: UInt32 = 0xE453
        static let MEDI_GA_MEDI_I: UInt32 = 0xE454
        static let MEDI_GA_FINA_I: UInt32 = 0xE455
        static let INIT_GA_FINA_OE: UInt32 = 0xE456
        static let INIT_GA_MEDI_OE: UInt32 = 0xE457
        static let MEDI_GA_MEDI_OE: UInt32 = 0xE458
        static let MEDI_GA_FINA_OE: UInt32 = 0xE459
        static let MEDI_GA_FINA_OE_FVS1: UInt32 = 0xE45A
        static let INIT_GA_FINA_UE: UInt32 = 0xE45B
        static let INIT_GA_MEDI_UE: UInt32 = 0xE45C
        static let MEDI_GA_MEDI_UE: UInt32 = 0xE45D
        static let MEDI_GA_FINA_UE: UInt32 = 0xE45E
        static let MEDI_GA_FINA_UE_FVS1: UInt32 = 0xE45F
        static let INIT_GA_FINA_EE: UInt32 = 0xE460
        static let INIT_GA_MEDI_EE: UInt32 = 0xE461
        static let MEDI_GA_MEDI_EE: UInt32 = 0xE462
        static let MEDI_GA_FINA_EE: UInt32 = 0xE463
        static let MEDI_GA_MEDI_MA: UInt32 = 0xE464
        static let MEDI_GA_MEDI_LA: UInt32 = 0xE465
        static let ISOL_MA: UInt32 = 0xE466
        static let INIT_MA: UInt32 = 0xE467
        static let MEDI_MA: UInt32 = 0xE468
        static let FINA_MA: UInt32 = 0xE469
        static let ISOL_LA: UInt32 = 0xE46A
        static let INIT_LA: UInt32 = 0xE46B
        static let MEDI_LA: UInt32 = 0xE46C
        static let FINA_LA: UInt32 = 0xE46D
        static let ISOL_SA: UInt32 = 0xE46E
        static let INIT_SA: UInt32 = 0xE46F
        static let MEDI_SA: UInt32 = 0xE470
        static let FINA_SA: UInt32 = 0xE471
        static let ISOL_SHA: UInt32 = 0xE472
        static let INIT_SHA: UInt32 = 0xE473
        static let MEDI_SHA: UInt32 = 0xE474
        static let FINA_SHA: UInt32 = 0xE475
        static let ISOL_TA: UInt32 = 0xE476
        static let ISOL_TA_FVS1: UInt32 = 0xE477
        static let INIT_TA: UInt32 = 0xE478
        static let MEDI_TA: UInt32 = 0xE479
        static let MEDI_TA_FVS1: UInt32 = 0xE47A
        static let MEDI_TA_FVS2: UInt32 = 0xE47B
        static let FINA_TA: UInt32 = 0xE47C
        static let ISOL_DA: UInt32 = 0xE47D
        static let INIT_DA: UInt32 = 0xE47E
        static let INIT_DA_FVS1: UInt32 = 0xE47F
        static let MEDI_DA: UInt32 = 0xE480
        static let MEDI_DA_FVS1: UInt32 = 0xE481
        static let FINA_DA: UInt32 = 0xE482
        static let FINA_DA_FVS1: UInt32 = 0xE483
        static let ISOL_CHA: UInt32 = 0xE484
        static let INIT_CHA: UInt32 = 0xE485
        static let MEDI_CHA: UInt32 = 0xE486
        static let FINA_CHA: UInt32 = 0xE487
        static let ISOL_JA: UInt32 = 0xE488
        static let ISOL_JA_FVS1: UInt32 = 0xE489
        static let INIT_JA: UInt32 = 0xE48A
        static let MEDI_JA: UInt32 = 0xE48B
        static let FINA_JA: UInt32 = 0xE48C
        static let FINA_JA_FVS1: UInt32 = 0xE491 // same as Glyph.FINA_YA
        static let ISOL_YA: UInt32 = 0xE48D
        static let INIT_YA: UInt32 = 0xE48E
        static let INIT_YA_FVS1: UInt32 = 0xE48F
        static let MEDI_YA: UInt32 = 0xE398 // same as Glyph.MEDI_I
        static let MEDI_YA_FVS1: UInt32 = 0xE490 // TODO matching Baiti
        static let FINA_YA: UInt32 = 0xE491
        static let ISOL_RA: UInt32 = 0xE492
        static let INIT_RA: UInt32 = 0xE493
        static let MEDI_RA: UInt32 = 0xE494
        static let FINA_RA: UInt32 = 0xE495
        static let ISOL_WA: UInt32 = 0xE496
        static let INIT_WA: UInt32 = 0xE497
        static let WORD_U: UInt32 = 0xE498
        static let MEDI_WA_FVS1: UInt32 = 0xE499 // TODO matching Baiti
        static let FINA_WA_FVS1: UInt32 = 0xE49A // TODO matching Baiti
        static let FINA_WA: UInt32 = 0xE49B // TODO matching Baiti
        static let ISOL_FA: UInt32 = 0xE49C
        static let INIT_FA: UInt32 = 0xE49D
        static let MEDI_FA: UInt32 = 0xE49E
        static let FINA_FA: UInt32 = 0xE49F
        static let INIT_FA_FINA_A: UInt32 = 0xE4A0
        static let INIT_FA_MEDI_A: UInt32 = 0xE4A1
        static let MEDI_FA_MEDI_A: UInt32 = 0xE4A2
        static let MEDI_FA_FINA_A: UInt32 = 0xE4A3
        static let INIT_FA_FINA_E: UInt32 = 0xE4A4
        static let INIT_FA_MEDI_E: UInt32 = 0xE4A5
        static let MEDI_FA_MEDI_E: UInt32 = 0xE4A6
        static let MEDI_FA_FINA_E: UInt32 = 0xE4A7
        static let INIT_FA_FINA_I: UInt32 = 0xE4A8
        static let INIT_FA_MEDI_I: UInt32 = 0xE4A9
        static let MEDI_FA_MEDI_I: UInt32 = 0xE4AA
        static let MEDI_FA_FINA_I: UInt32 = 0xE4AB
        static let INIT_FA_FINA_O: UInt32 = 0xE4AC
        static let INIT_FA_MEDI_O: UInt32 = 0xE4AD
        static let MEDI_FA_MEDI_O: UInt32 = 0xE4AE
        static let MEDI_FA_FINA_O: UInt32 = 0xE4AF
        static let INIT_FA_FINA_U: UInt32 = 0xE4B0
        static let INIT_FA_MEDI_U: UInt32 = 0xE4B1
        static let MEDI_FA_MEDI_U: UInt32 = 0xE4B2
        static let MEDI_FA_FINA_U: UInt32 = 0xE4B3
        static let INIT_FA_FINA_OE: UInt32 = 0xE4B4
        static let INIT_FA_MEDI_OE: UInt32 = 0xE4B5
        static let MEDI_FA_MEDI_OE: UInt32 = 0xE4B6
        static let MEDI_FA_FINA_OE: UInt32 = 0xE4B7
        static let MEDI_FA_FINA_OE_FVS1: UInt32 = 0xE4B8
        static let INIT_FA_FINA_UE: UInt32 = 0xE4B9
        static let INIT_FA_MEDI_UE: UInt32 = 0xE4BA
        static let MEDI_FA_MEDI_UE: UInt32 = 0xE4BB
        static let MEDI_FA_FINA_UE: UInt32 = 0xE4BC
        static let MEDI_FA_FINA_UE_FVS1: UInt32 = 0xE4BD
        static let INIT_FA_FINA_EE: UInt32 = 0xE4BE
        static let INIT_FA_MEDI_EE: UInt32 = 0xE4BF
        static let MEDI_FA_MEDI_EE: UInt32 = 0xE4C0
        static let MEDI_FA_FINA_EE: UInt32 = 0xE4C1
        static let MEDI_FA_MEDI_MA: UInt32 = 0xE4C2
        static let MEDI_FA_MEDI_LA: UInt32 = 0xE4C3
        static let ISOL_KA: UInt32 = 0xE4C4
        static let INIT_KA: UInt32 = 0xE4C5
        static let MEDI_KA: UInt32 = 0xE4C6
        static let FINA_KA: UInt32 = 0xE4C7
        static let INIT_KA_FINA_A: UInt32 = 0xE4C8
        static let INIT_KA_MEDI_A: UInt32 = 0xE4C9
        static let MEDI_KA_MEDI_A: UInt32 = 0xE4CA
        static let MEDI_KA_FINA_A: UInt32 = 0xE4CB
        static let INIT_KA_FINA_E: UInt32 = 0xE4CC
        static let INIT_KA_MEDI_E: UInt32 = 0xE4CD
        static let MEDI_KA_MEDI_E: UInt32 = 0xE4CE
        static let MEDI_KA_FINA_E: UInt32 = 0xE4CF
        static let INIT_KA_FINA_I: UInt32 = 0xE4D0
        static let INIT_KA_MEDI_I: UInt32 = 0xE4D1
        static let MEDI_KA_MEDI_I: UInt32 = 0xE4D2
        static let MEDI_KA_FINA_I: UInt32 = 0xE4D3
        static let INIT_KA_FINA_O: UInt32 = 0xE4D4
        static let INIT_KA_MEDI_O: UInt32 = 0xE4D5
        static let MEDI_KA_MEDI_O: UInt32 = 0xE4D6
        static let MEDI_KA_FINA_O: UInt32 = 0xE4D7
        static let INIT_KA_FINA_U: UInt32 = 0xE4D8
        static let INIT_KA_MEDI_U: UInt32 = 0xE4D9
        static let MEDI_KA_MEDI_U: UInt32 = 0xE4DA
        static let MEDI_KA_FINA_U: UInt32 = 0xE4DB
        static let INIT_KA_FINA_OE: UInt32 = 0xE4DC
        static let INIT_KA_MEDI_OE: UInt32 = 0xE4DD
        static let MEDI_KA_MEDI_OE: UInt32 = 0xE4DE
        static let MEDI_KA_FINA_OE: UInt32 = 0xE4DF
        static let MEDI_KA_FINA_OE_FVS1: UInt32 = 0xE4E0
        static let INIT_KA_FINA_UE: UInt32 = 0xE4E1
        static let INIT_KA_MEDI_UE: UInt32 = 0xE4E2
        static let MEDI_KA_MEDI_UE: UInt32 = 0xE4E3
        static let MEDI_KA_FINA_UE: UInt32 = 0xE4E4
        static let MEDI_KA_FINA_UE_FVS1: UInt32 = 0xE4E5
        static let INIT_KA_FINA_EE: UInt32 = 0xE4E6
        static let INIT_KA_MEDI_EE: UInt32 = 0xE4E7
        static let MEDI_KA_MEDI_EE: UInt32 = 0xE4E8
        static let MEDI_KA_FINA_EE: UInt32 = 0xE4E9
        static let MEDI_KA_MEDI_MA: UInt32 = 0xE4EA
        static let MEDI_KA_MEDI_LA: UInt32 = 0xE4EB
        static let ISOL_KHA: UInt32 = 0xE4EC
        static let INIT_KHA: UInt32 = 0xE4ED
        static let MEDI_KHA: UInt32 = 0xE4EE
        static let FINA_KHA: UInt32 = 0xE4EF
        static let INIT_KHA_FINA_A: UInt32 = 0xE4F0
        static let INIT_KHA_MEDI_A: UInt32 = 0xE4F1
        static let MEDI_KHA_MEDI_A: UInt32 = 0xE4F2
        static let MEDI_KHA_FINA_A: UInt32 = 0xE4F3
        static let INIT_KHA_FINA_E: UInt32 = 0xE4F4
        static let INIT_KHA_MEDI_E: UInt32 = 0xE4F5
        static let MEDI_KHA_MEDI_E: UInt32 = 0xE4F6
        static let MEDI_KHA_FINA_E: UInt32 = 0xE4F7
        static let INIT_KHA_FINA_I: UInt32 = 0xE4F8
        static let INIT_KHA_MEDI_I: UInt32 = 0xE4F9
        static let MEDI_KHA_MEDI_I: UInt32 = 0xE4FA
        static let MEDI_KHA_FINA_I: UInt32 = 0xE4FB
        static let INIT_KHA_FINA_O: UInt32 = 0xE4FC
        static let INIT_KHA_MEDI_O: UInt32 = 0xE4FD
        static let MEDI_KHA_MEDI_O: UInt32 = 0xE4FE
        static let MEDI_KHA_FINA_O: UInt32 = 0xE4FF
        static let INIT_KHA_FINA_U: UInt32 = 0xE500
        static let INIT_KHA_MEDI_U: UInt32 = 0xE501
        static let MEDI_KHA_MEDI_U: UInt32 = 0xE502
        static let MEDI_KHA_FINA_U: UInt32 = 0xE503
        static let INIT_KHA_FINA_OE: UInt32 = 0xE504
        static let INIT_KHA_MEDI_OE: UInt32 = 0xE505
        static let MEDI_KHA_MEDI_OE: UInt32 = 0xE506
        static let MEDI_KHA_FINA_OE: UInt32 = 0xE507
        static let MEDI_KHA_FINA_OE_FVS1: UInt32 = 0xE508
        static let INIT_KHA_FINA_UE: UInt32 = 0xE509
        static let INIT_KHA_MEDI_UE: UInt32 = 0xE50A
        static let MEDI_KHA_MEDI_UE: UInt32 = 0xE50B
        static let MEDI_KHA_FINA_UE: UInt32 = 0xE50C
        static let MEDI_KHA_FINA_UE_FVS1: UInt32 = 0xE50D
        static let INIT_KHA_FINA_EE: UInt32 = 0xE50E
        static let INIT_KHA_MEDI_EE: UInt32 = 0xE50F
        static let MEDI_KHA_MEDI_EE: UInt32 = 0xE510
        static let MEDI_KHA_FINA_EE: UInt32 = 0xE511
        static let MEDI_KHA_MEDI_MA: UInt32 = 0xE512
        static let MEDI_KHA_MEDI_LA: UInt32 = 0xE513
        static let ISOL_TSA: UInt32 = 0xE514
        static let INIT_TSA: UInt32 = 0xE515
        static let MEDI_TSA: UInt32 = 0xE516
        static let FINA_TSA: UInt32 = 0xE517
        static let ISOL_ZA: UInt32 = 0xE518
        static let INIT_ZA: UInt32 = 0xE519
        static let MEDI_ZA: UInt32 = 0xE51A
        static let FINA_ZA: UInt32 = 0xE51B
        static let ISOL_HAA: UInt32 = 0xE51C
        static let INIT_HAA: UInt32 = 0xE51D
        static let MEDI_HAA: UInt32 = 0xE51E
        static let FINA_HAA: UInt32 = 0xE51F
        static let ISOL_ZRA: UInt32 = 0xE520
        static let INIT_ZRA: UInt32 = 0xE521
        static let MEDI_ZRA: UInt32 = 0xE522
        static let FINA_ZRA: UInt32 = 0xE523
        static let ISOL_LHA: UInt32 = 0xE524
        static let INIT_LHA: UInt32 = 0xE525
        static let MEDI_LHA: UInt32 = 0xE526
        static let FINA_LHA: UInt32 = 0xE527
        static let ISOL_ZHI: UInt32 = 0xE528
        static let INIT_ZHI: UInt32 = 0xE529
        static let MEDI_ZHI: UInt32 = 0xE52A
        static let FINA_ZHI: UInt32 = 0xE52B
        static let ISOL_CHI: UInt32 = 0xE52C
        static let INIT_CHI: UInt32 = 0xE52D
        static let MEDI_CHI: UInt32 = 0xE52E
        static let FINA_CHI: UInt32 = 0xE52F
        static let FINA_SA_FVS1: UInt32 = 0xE530
        static let FINA_SA_FVS2: UInt32 = 0xE531
        static let FINA_BA_FVS1: UInt32 = 0xE532
        static let WORD_UU: UInt32 = 0xE533
        static let WORD_BUU: UInt32 = 0xE534
        static let MEDI_BA_MEDI_OE_FVS1: UInt32 = 0xE535
        static let MEDI_BA_MEDI_UE_FVS1: UInt32 = 0xE536
        static let MEDI_PA_MEDI_OE_FVS1: UInt32 = 0xE537
        static let MEDI_PA_MEDI_UE_FVS1: UInt32 = 0xE538
        static let MEDI_QA_MEDI_OE_FVS1: UInt32 = 0xE539
        static let MEDI_QA_MEDI_UE_FVS1: UInt32 = 0xE53A
        static let MEDI_GA_MEDI_OE_FVS1: UInt32 = 0xE53B
        static let MEDI_GA_MEDI_UE_FVS1: UInt32 = 0xE53C
        static let MEDI_FA_MEDI_OE_FVS1: UInt32 = 0xE53D
        static let MEDI_FA_MEDI_UE_FVS1: UInt32 = 0xE53E
        static let MEDI_KA_MEDI_OE_FVS1: UInt32 = 0xE53F
        static let MEDI_KA_MEDI_UE_FVS1: UInt32 = 0xE540
        static let MEDI_KHA_MEDI_OE_FVS1: UInt32 = 0xE541
        static let MEDI_KHA_MEDI_UE_FVS1: UInt32 = 0xE542
        static let MEDI_MA_MEDI_MA: UInt32 = 0xE544
        static let MEDI_MA_MEDI_LA: UInt32 = 0xE545
        static let MEDI_LA_MEDI_LA: UInt32 = 0xE546
        static let MEDI_ANG_MEDI_NA_FVS1: UInt32 = 0xE547
        static let MEDI_ANG_FINA_QA: UInt32 = 0xE548
        static let MEDI_ANG_FINA_GA: UInt32 = 0xE549
        static let MEDI_BA_MEDI_QA: UInt32 = 0xE54A
        static let MEDI_BA_MEDI_GA: UInt32 = 0xE54B
        static let MEDI_PA_MEDI_QA: UInt32 = 0xE54C
        static let MEDI_PA_MEDI_GA: UInt32 = 0xE54D
        static let MEDI_FA_MEDI_QA: UInt32 = 0xE54E
        static let MEDI_FA_MEDI_GA: UInt32 = 0xE54F
        static let MEDI_KA_MEDI_QA: UInt32 = 0xE550
        static let MEDI_KA_MEDI_GA: UInt32 = 0xE551
        static let MEDI_KHA_MEDI_QA: UInt32 = 0xE552
        static let MEDI_KHA_MEDI_GA: UInt32 = 0xE553
        static let MEDI_BA_MEDI_NA_FVS1: UInt32 = 0xE554
        static let MEDI_PA_MEDI_NA_FVS1: UInt32 = 0xE555
        static let MEDI_GA_MEDI_NA_FVS1: UInt32 = 0xE556
        static let MEDI_FA_MEDI_NA_FVS1: UInt32 = 0xE557
        static let MEDI_KA_MEDI_NA_FVS1: UInt32 = 0xE558
        static let MEDI_KHA_MEDI_NA_FVS1: UInt32 = 0xE559
        static let INIT_QA_FINA_OE_FVS1: UInt32 = 0xE55A
        static let INIT_QA_FINA_UE_FVS1: UInt32 = 0xE55B
        static let INIT_GA_FINA_OE_FVS1: UInt32 = 0xE55C
        static let INIT_GA_FINA_UE_FVS1: UInt32 = 0xE55D
        static let INIT_QA_MEDI_OE_FVS1: UInt32 = 0xE55E
        static let INIT_QA_MEDI_UE_FVS1: UInt32 = 0xE55F
        static let INIT_GA_MEDI_OE_FVS1: UInt32 = 0xE560
        static let INIT_GA_MEDI_UE_FVS1: UInt32 = 0xE561
        static let ISOL_QA_FVS2: UInt32 = 0xE564
        static let INIT_QA_FVS2: UInt32 = 0xE565
        static let ISOL_QA_FVS1: UInt32 = 0xE566 // TODO matching Baiti
        static let INIT_QA_FVS3: UInt32 = 0xE567
        static let MEDI_QA_FVS3: UInt32 = 0xE568
        static let INIT_QA_FVS1_FINA_E: UInt32 = 0xE569
        static let INIT_QA_FVS1_MEDI_E: UInt32 = 0xE56A
        static let MEDI_QA_FVS1_MEDI_E: UInt32 = 0xE56B
        static let MEDI_QA_FVS1_FINA_E: UInt32 = 0xE56C
        static let INIT_QA_FVS1_FINA_I: UInt32 = 0xE56D
        static let INIT_QA_FVS1_MEDI_I: UInt32 = 0xE56E
        static let MEDI_QA_FVS1_MEDI_I: UInt32 = 0xE56F
        static let MEDI_QA_FVS1_FINA_I: UInt32 = 0xE570
        static let INIT_QA_FVS1_FINA_OE: UInt32 = 0xE571
        static let INIT_QA_FVS1_MEDI_OE: UInt32 = 0xE572
        static let MEDI_QA_FVS1_MEDI_OE: UInt32 = 0xE573
        static let MEDI_QA_FVS1_FINA_OE: UInt32 = 0xE574
        static let MEDI_QA_FVS1_FINA_OE_FVS1: UInt32 = 0xE575
        static let INIT_QA_FVS1_FINA_UE: UInt32 = 0xE576
        static let INIT_QA_FVS1_MEDI_UE: UInt32 = 0xE577
        static let MEDI_QA_FVS1_MEDI_UE: UInt32 = 0xE578
        static let MEDI_QA_FVS1_FINA_UE: UInt32 = 0xE579
        static let MEDI_QA_FVS1_FINA_UE_FVS1: UInt32 = 0xE57A
        static let INIT_QA_FVS1_FINA_EE: UInt32 = 0xE57B
        static let INIT_QA_FVS1_MEDI_EE: UInt32 = 0xE57C
        static let MEDI_QA_FVS1_MEDI_EE: UInt32 = 0xE57D
        static let MEDI_QA_FVS1_FINA_EE: UInt32 = 0xE57E
        static let ISOL_GA_FVS1: UInt32 = 0xE57F // TODO matching Baiti
        static let ISOL_GA_FVS2: UInt32 = 0xE580 // TODO matching Baiti
        static let INIT_GA_FVS3: UInt32 = 0xE581 // TODO not in Baiti
        static let INIT_GA_FVS2: UInt32 = 0xE582 // TODO matching Baiti
        static let MEDI_GA_FVS3: UInt32 = 0xE583
        static let MEDI_WA: UInt32 = 0xE584 // TODO matching Baiti
        static let INIT_A_FVS1: UInt32 = 0xE585
        // TODO Glyph.MEDI_I_FVS2 and Glyph.MEDI_I_FVS3 have not been standardized in Unicode yet
        // Matching to Baiti
        static let MEDI_I_FVS2: UInt32 = 0xE586
        static let FINA_NA_FVS2: UInt32 = 0xE587
        static let BIRGA_1: UInt32 = 0xE588
        static let BIRGA_2: UInt32 = 0xE589
        static let BIRGA_3: UInt32 = 0xE58A
        static let BIRGA_4: UInt32 = 0xE58B
        static let NIRUGU_FVS2: UInt32 = 0xE58F
        static let NIRUGU_FVS3: UInt32 = 0xE590
        static let INIT_GA_FVS1_FINA_E: UInt32 = 0xE594
        static let INIT_GA_FVS1_MEDI_E: UInt32 = 0xE595
        static let MEDI_GA_FVS1_MEDI_E: UInt32 = 0xE596
        static let MEDI_GA_FVS1_FINA_E: UInt32 = 0xE597
        static let INIT_GA_FVS1_FINA_I: UInt32 = 0xE598
        static let INIT_GA_FVS1_MEDI_I: UInt32 = 0xE599
        static let MEDI_GA_FVS1_MEDI_I: UInt32 = 0xE59A
        static let MEDI_GA_FVS1_FINA_I: UInt32 = 0xE59B
        static let INIT_GA_FVS1_FINA_OE: UInt32 = 0xE59C
        static let INIT_GA_FVS1_MEDI_OE: UInt32 = 0xE59D
        static let MEDI_GA_FVS1_MEDI_OE: UInt32 = 0xE59E
        static let MEDI_GA_FVS1_FINA_OE: UInt32 = 0xE59F
        static let MEDI_GA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5A0
        static let INIT_GA_FVS1_FINA_UE: UInt32 = 0xE5A1
        static let INIT_GA_FVS1_MEDI_UE: UInt32 = 0xE5A2
        static let MEDI_GA_FVS1_MEDI_UE: UInt32 = 0xE5A3
        static let MEDI_GA_FVS1_FINA_UE: UInt32 = 0xE5A4
        static let MEDI_GA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5A5
        static let INIT_GA_FVS1_FINA_EE: UInt32 = 0xE5A6
        static let INIT_GA_FVS1_MEDI_EE: UInt32 = 0xE5A7
        static let MEDI_GA_FVS1_MEDI_EE: UInt32 = 0xE5A8
        static let MEDI_GA_FVS1_FINA_EE: UInt32 = 0xE5A9
        static let MEDI_QA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5AA
        static let MEDI_QA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5AB
        static let MEDI_GA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5AC
        static let MEDI_GA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5AD
        static let INIT_BA_FINA_OE_FVS1: UInt32 = 0xE5B4
        static let INIT_BA_FINA_UE_FVS1: UInt32 = 0xE5B5
        static let INIT_BA_MEDI_OE_FVS1: UInt32 = 0xE5B6
        static let INIT_BA_MEDI_UE_FVS1: UInt32 = 0xE5B7
        static let INIT_PA_FINA_OE_FVS1: UInt32 = 0xE5B8
        static let INIT_PA_FINA_UE_FVS1: UInt32 = 0xE5B9
        static let INIT_PA_MEDI_OE_FVS1: UInt32 = 0xE5BA
        static let INIT_PA_MEDI_UE_FVS1: UInt32 = 0xE5BB
        static let INIT_QA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5BC
        static let INIT_QA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5BD
        static let INIT_QA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5BE
        static let INIT_QA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5BF
        static let INIT_GA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5C0
        static let INIT_GA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5C1
        static let INIT_GA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5C2
        static let INIT_GA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5C3
        static let INIT_FA_FINA_OE_FVS1: UInt32 = 0xE5C4
        static let INIT_FA_FINA_UE_FVS1: UInt32 = 0xE5C5
        static let INIT_FA_MEDI_OE_FVS1: UInt32 = 0xE5C6
        static let INIT_FA_MEDI_UE_FVS1: UInt32 = 0xE5C7
        static let INIT_KA_FINA_OE_FVS1: UInt32 = 0xE5C8
        static let INIT_KA_FINA_UE_FVS1: UInt32 = 0xE5C9
        static let INIT_KA_MEDI_OE_FVS1: UInt32 = 0xE5CA
        static let INIT_KA_MEDI_UE_FVS1: UInt32 = 0xE5CB
        static let INIT_KHA_FINA_OE_FVS1: UInt32 = 0xE5CC
        static let INIT_KHA_FINA_UE_FVS1: UInt32 = 0xE5CD
        static let INIT_KHA_MEDI_OE_FVS1: UInt32 = 0xE5CE
        static let INIT_KHA_MEDI_UE_FVS1: UInt32 = 0xE5CF
    }
    
    private static let isolateDictionary = [
        // Single letters
        ScalarString(Uni.A) : ScalarString(Glyph.ISOL_A),
        ScalarString([Uni.A, Uni.FVS1]) : ScalarString(Glyph.ISOL_A_FVS1),
        ScalarString(Uni.E) : ScalarString(Glyph.ISOL_E),
        ScalarString([Uni.E, Uni.FVS1]) : ScalarString(Glyph.ISOL_E_FVS1),
        ScalarString(Uni.I) : ScalarString(Glyph.ISOL_I),
        ScalarString([Uni.I, Uni.FVS1]) : ScalarString(Glyph.ISOL_I_FVS1),
        ScalarString(Uni.O) : ScalarString(Glyph.ISOL_O),
        ScalarString([Uni.O, Uni.FVS1]) : ScalarString(Glyph.ISOL_O_FVS1),
        ScalarString(Uni.U) : ScalarString(Glyph.ISOL_U),
        ScalarString([Uni.U, Uni.FVS1]) : ScalarString(Glyph.ISOL_U_FVS1),
        ScalarString([Uni.U, Uni.FVS2]) : ScalarString(Glyph.ISOL_U_FVS2),  // I am adding this myself
        ScalarString(Uni.OE) : ScalarString(Glyph.ISOL_OE),
        ScalarString([Uni.OE, Uni.FVS1]) : ScalarString(Glyph.ISOL_OE_FVS1),
        ScalarString(Uni.UE) : ScalarString(Glyph.ISOL_UE),
        ScalarString([Uni.UE, Uni.FVS1]) : ScalarString(Glyph.ISOL_UE_FVS1),
        ScalarString([Uni.UE, Uni.FVS2]) : ScalarString(Glyph.ISOL_UE_FVS2),
        ScalarString([Uni.UE, Uni.FVS3]) : ScalarString(Glyph.ISOL_UE_FVS3),  // I am adding this myself
        ScalarString(Uni.EE) : ScalarString(Glyph.ISOL_EE),
        ScalarString([Uni.EE, Uni.FVS1]) : ScalarString(Glyph.ISOL_EE_FVS1),
        ScalarString(Uni.NA) : ScalarString(Glyph.ISOL_NA),
        ScalarString([Uni.NA, Uni.FVS1]) : ScalarString(Glyph.ISOL_NA_FVS1),
        ScalarString(Uni.ANG) : ScalarString(Glyph.ISOL_ANG),
        ScalarString(Uni.BA) : ScalarString(Glyph.ISOL_BA),
        ScalarString(Uni.PA) : ScalarString(Glyph.ISOL_PA),
        ScalarString(Uni.QA) : ScalarString(Glyph.ISOL_QA),
        ScalarString([Uni.QA, Uni.FVS1]) : ScalarString(Glyph.ISOL_QA_FVS1),
        ScalarString([Uni.QA, Uni.FVS2]) : ScalarString(Glyph.ISOL_QA_FVS2),
        ScalarString([Uni.QA, Uni.FVS3]) : ScalarString(Glyph.ISOL_QA_FVS3),
        ScalarString(Uni.GA) : ScalarString(Glyph.ISOL_GA),
        ScalarString([Uni.GA, Uni.FVS1]) : ScalarString(Glyph.ISOL_GA_FVS1),
        ScalarString([Uni.GA, Uni.FVS2]) : ScalarString(Glyph.ISOL_GA_FVS2),
        ScalarString([Uni.GA, Uni.FVS3]) : ScalarString(Glyph.ISOL_GA_FVS3),
        ScalarString(Uni.MA) : ScalarString(Glyph.ISOL_MA),
        ScalarString(Uni.LA) : ScalarString(Glyph.ISOL_LA),
        ScalarString(Uni.SA) : ScalarString(Glyph.ISOL_SA),
        ScalarString(Uni.SHA) : ScalarString(Glyph.ISOL_SHA),
        ScalarString(Uni.TA) : ScalarString(Glyph.ISOL_TA),
        ScalarString([Uni.TA, Uni.FVS1]) : ScalarString(Glyph.ISOL_TA_FVS1),
        ScalarString(Uni.DA) : ScalarString(Glyph.ISOL_DA),
        ScalarString(Uni.CHA) : ScalarString(Glyph.ISOL_CHA),
        ScalarString(Uni.JA) : ScalarString(Glyph.ISOL_JA),
        ScalarString([Uni.JA, Uni.FVS1]) : ScalarString(Glyph.ISOL_JA_FVS1),
        ScalarString(Uni.YA) : ScalarString(Glyph.ISOL_YA),
        ScalarString(Uni.RA) : ScalarString(Glyph.ISOL_RA),
        ScalarString(Uni.WA) : ScalarString(Glyph.ISOL_WA),
        ScalarString(Uni.FA) : ScalarString(Glyph.ISOL_FA),
        ScalarString(Uni.KA) : ScalarString(Glyph.ISOL_KA),
        ScalarString(Uni.KHA) : ScalarString(Glyph.ISOL_KHA),
        ScalarString(Uni.TSA) : ScalarString(Glyph.ISOL_TSA),
        ScalarString(Uni.ZA) : ScalarString(Glyph.ISOL_ZA),
        ScalarString(Uni.HAA) : ScalarString(Glyph.ISOL_HAA),
        ScalarString(Uni.ZRA) : ScalarString(Glyph.ISOL_ZRA),
        ScalarString(Uni.LHA) : ScalarString(Glyph.ISOL_LHA),
        ScalarString(Uni.ZHI) : ScalarString(Glyph.ISOL_ZHI),
        ScalarString(Uni.CHI) : ScalarString(Glyph.ISOL_CHI),
        
        // Double letters
        ScalarString([Uni.BA, Uni.A]) : ScalarString(Glyph.INIT_BA_FINA_A),
        ScalarString([Uni.BA, Uni.E]) : ScalarString(Glyph.INIT_BA_FINA_E),
        ScalarString([Uni.BA, Uni.I]) : ScalarString(Glyph.INIT_BA_FINA_I),
        ScalarString([Uni.BA, Uni.O]) : ScalarString(Glyph.INIT_BA_FINA_O),
        ScalarString([Uni.BA, Uni.U]) : ScalarString(Glyph.INIT_BA_FINA_U),
        ScalarString([Uni.BA, Uni.OE]) : ScalarString(Glyph.INIT_BA_FINA_OE),
        ScalarString([Uni.BA, Uni.UE]) : ScalarString(Glyph.INIT_BA_FINA_UE),
        ScalarString([Uni.BA, Uni.EE]) : ScalarString(Glyph.INIT_BA_FINA_EE),
        ScalarString([Uni.PA, Uni.A]) : ScalarString(Glyph.INIT_PA_FINA_A),
        ScalarString([Uni.PA, Uni.E]) : ScalarString(Glyph.INIT_PA_FINA_E),
        ScalarString([Uni.PA, Uni.I]) : ScalarString(Glyph.INIT_PA_FINA_I),
        ScalarString([Uni.PA, Uni.O]) : ScalarString(Glyph.INIT_PA_FINA_O),
        ScalarString([Uni.PA, Uni.U]) : ScalarString(Glyph.INIT_PA_FINA_U),
        ScalarString([Uni.PA, Uni.OE]) : ScalarString(Glyph.INIT_PA_FINA_OE),
        ScalarString([Uni.PA, Uni.UE]) : ScalarString(Glyph.INIT_PA_FINA_UE),
        ScalarString([Uni.PA, Uni.EE]) : ScalarString(Glyph.INIT_PA_FINA_EE),
        ScalarString([Uni.QA, Uni.E]) : ScalarString(Glyph.INIT_QA_FINA_E),
        ScalarString([Uni.QA, Uni.I]) : ScalarString(Glyph.INIT_QA_FINA_I),
        ScalarString([Uni.QA, Uni.OE]) : ScalarString(Glyph.INIT_QA_FINA_OE),
        ScalarString([Uni.QA, Uni.UE]) : ScalarString(Glyph.INIT_QA_FINA_UE),
        ScalarString([Uni.QA, Uni.EE]) : ScalarString(Glyph.INIT_QA_FINA_EE),
        ScalarString([Uni.GA, Uni.E]) : ScalarString(Glyph.INIT_GA_FINA_E),
        ScalarString([Uni.GA, Uni.I]) : ScalarString(Glyph.INIT_GA_FINA_I),
        ScalarString([Uni.GA, Uni.OE]) : ScalarString(Glyph.INIT_GA_FINA_OE),
        ScalarString([Uni.GA, Uni.UE]) : ScalarString(Glyph.INIT_GA_FINA_UE),
        ScalarString([Uni.GA, Uni.EE]) : ScalarString(Glyph.INIT_GA_FINA_EE),
        ScalarString([Uni.FA, Uni.A]) : ScalarString(Glyph.INIT_FA_FINA_A),
        ScalarString([Uni.FA, Uni.E]) : ScalarString(Glyph.INIT_FA_FINA_E),
        ScalarString([Uni.FA, Uni.I]) : ScalarString(Glyph.INIT_FA_FINA_I),
        ScalarString([Uni.FA, Uni.O]) : ScalarString(Glyph.INIT_FA_FINA_O),
        ScalarString([Uni.FA, Uni.U]) : ScalarString(Glyph.INIT_FA_FINA_U),
        ScalarString([Uni.FA, Uni.OE]) : ScalarString(Glyph.INIT_FA_FINA_OE),
        ScalarString([Uni.FA, Uni.UE]) : ScalarString(Glyph.INIT_FA_FINA_UE),
        ScalarString([Uni.FA, Uni.EE]) : ScalarString(Glyph.INIT_FA_FINA_EE),
        ScalarString([Uni.KA, Uni.A]) : ScalarString(Glyph.INIT_KA_FINA_A),
        ScalarString([Uni.KA, Uni.E]) : ScalarString(Glyph.INIT_KA_FINA_E),
        ScalarString([Uni.KA, Uni.I]) : ScalarString(Glyph.INIT_KA_FINA_I),
        ScalarString([Uni.KA, Uni.O]) : ScalarString(Glyph.INIT_KA_FINA_O),
        ScalarString([Uni.KA, Uni.U]) : ScalarString(Glyph.INIT_KA_FINA_U),
        ScalarString([Uni.KA, Uni.OE]) : ScalarString(Glyph.INIT_KA_FINA_OE),
        ScalarString([Uni.KA, Uni.UE]) : ScalarString(Glyph.INIT_KA_FINA_UE),
        ScalarString([Uni.KA, Uni.EE]) : ScalarString(Glyph.INIT_KA_FINA_EE),
        ScalarString([Uni.KHA, Uni.A]) : ScalarString(Glyph.INIT_KHA_FINA_A),
        ScalarString([Uni.KHA, Uni.E]) : ScalarString(Glyph.INIT_KHA_FINA_E),
        ScalarString([Uni.KHA, Uni.I]) : ScalarString(Glyph.INIT_KHA_FINA_I),
        ScalarString([Uni.KHA, Uni.O]) : ScalarString(Glyph.INIT_KHA_FINA_O),
        ScalarString([Uni.KHA, Uni.U]) : ScalarString(Glyph.INIT_KHA_FINA_U),
        ScalarString([Uni.KHA, Uni.OE]) : ScalarString(Glyph.INIT_KHA_FINA_OE),
        ScalarString([Uni.KHA, Uni.UE]) : ScalarString(Glyph.INIT_KHA_FINA_UE),
        ScalarString([Uni.KHA, Uni.EE]) : ScalarString(Glyph.INIT_KHA_FINA_EE),
        ScalarString([Uni.QA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FINA_OE_FVS1),
        ScalarString([Uni.QA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FINA_UE_FVS1),
        ScalarString([Uni.GA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FINA_OE_FVS1),
        ScalarString([Uni.GA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FINA_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_E),
        ScalarString([Uni.QA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_I),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_OE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_UE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_EE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_E),
        ScalarString([Uni.GA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_I),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_OE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_UE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_EE),
        ScalarString([Uni.BA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_BA_FINA_OE_FVS1),
        ScalarString([Uni.BA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_BA_FINA_UE_FVS1),
        ScalarString([Uni.PA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_PA_FINA_OE_FVS1),
        ScalarString([Uni.PA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_PA_FINA_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_OE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FVS1_FINA_UE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_OE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FVS1_FINA_UE_FVS1),
        ScalarString([Uni.FA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_FA_FINA_OE_FVS1),
        ScalarString([Uni.FA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_FA_FINA_UE_FVS1),
        ScalarString([Uni.KA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_KA_FINA_OE_FVS1),
        ScalarString([Uni.KA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_KA_FINA_UE_FVS1),
        ScalarString([Uni.KHA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_KHA_FINA_OE_FVS1),
        ScalarString([Uni.KHA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_KHA_FINA_UE_FVS1),
        
        // BUU exception (no tooth on first UE)
        ScalarString([Uni.BA, Uni.UE, Uni.UE]) : ScalarString([Glyph.INIT_BA_MEDI_U, Glyph.FINA_UE]),
        
        // Catch other chars
        ScalarString(Glyph.CURSOR_HOLDER) : ScalarString(Glyph.CURSOR_HOLDER),
        ScalarString(Uni.MONGOLIAN_NIRUGU) : ScalarString(Glyph.NIRUGU),
        ScalarString(Uni.ZWJ) : ScalarString(""),
        ScalarString(Uni.NNBS) : ScalarString(Uni.NNBS),
        ScalarString(Uni.MVS) : ScalarString(""),
        ScalarString(Uni.FVS1) : ScalarString(""),
        ScalarString(Uni.FVS2) : ScalarString(""),
        ScalarString(Uni.FVS3) : ScalarString("")
    ]
    
    private static let initialDictionary = [
        ScalarString(Uni.A) : ScalarString(Glyph.INIT_A),
        ScalarString([Uni.A, Uni.FVS1]) : ScalarString(Glyph.INIT_A_FVS1),
        ScalarString(Uni.E) : ScalarString(Glyph.INIT_E),
        ScalarString([Uni.E, Uni.FVS1]) : ScalarString(Glyph.INIT_E_FVS1),
        ScalarString(Uni.I) : ScalarString(Glyph.INIT_I),
        ScalarString([Uni.I, Uni.FVS1]) : ScalarString(Glyph.INIT_I_FVS1),
        ScalarString(Uni.O) : ScalarString(Glyph.INIT_O),
        ScalarString([Uni.O, Uni.FVS1]) : ScalarString(Glyph.INIT_O_FVS1),
        ScalarString(Uni.U) : ScalarString(Glyph.INIT_U),
        ScalarString([Uni.U, Uni.FVS1]) : ScalarString(Glyph.INIT_U_FVS1),
        ScalarString(Uni.OE) : ScalarString(Glyph.INIT_OE),
        ScalarString(Uni.UE) : ScalarString(Glyph.INIT_UE),
        ScalarString(Uni.EE) : ScalarString(Glyph.INIT_EE),
        ScalarString([Uni.EE, Uni.FVS1]) : ScalarString(Glyph.INIT_EE_FVS1),
        ScalarString([Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_UE_FVS1),
        ScalarString(Uni.NA) : ScalarString(Glyph.INIT_NA),
        // TODO when is Uni.NA, Uni.FVS1 ever used?
        ScalarString([Uni.NA, Uni.FVS1]) : ScalarString(Glyph.INIT_NA_FVS1),
        ScalarString(Uni.ANG) : ScalarString(Glyph.INIT_ANG),
        ScalarString(Uni.BA) : ScalarString(Glyph.INIT_BA),
        ScalarString([Uni.BA, Uni.A]) : ScalarString(Glyph.INIT_BA_MEDI_A),
        ScalarString([Uni.BA, Uni.E]) : ScalarString(Glyph.INIT_BA_MEDI_E),
        ScalarString([Uni.BA, Uni.I]) : ScalarString(Glyph.INIT_BA_MEDI_I),
        ScalarString([Uni.BA, Uni.O]) : ScalarString(Glyph.INIT_BA_MEDI_O),
        ScalarString([Uni.BA, Uni.U]) : ScalarString(Glyph.INIT_BA_MEDI_U),
        ScalarString([Uni.BA, Uni.OE]) : ScalarString(Glyph.INIT_BA_MEDI_OE),
        ScalarString([Uni.BA, Uni.UE]) : ScalarString(Glyph.INIT_BA_MEDI_UE),
        ScalarString([Uni.BA, Uni.EE]) : ScalarString(Glyph.INIT_BA_MEDI_EE),
        ScalarString(Uni.PA) : ScalarString(Glyph.INIT_PA),
        ScalarString([Uni.PA, Uni.A]) : ScalarString(Glyph.INIT_PA_MEDI_A),
        ScalarString([Uni.PA, Uni.E]) : ScalarString(Glyph.INIT_PA_MEDI_E),
        ScalarString([Uni.PA, Uni.I]) : ScalarString(Glyph.INIT_PA_MEDI_I),
        ScalarString([Uni.PA, Uni.O]) : ScalarString(Glyph.INIT_PA_MEDI_O),
        ScalarString([Uni.PA, Uni.U]) : ScalarString(Glyph.INIT_PA_MEDI_U),
        ScalarString([Uni.PA, Uni.OE]) : ScalarString(Glyph.INIT_PA_MEDI_OE),
        ScalarString([Uni.PA, Uni.UE]) : ScalarString(Glyph.INIT_PA_MEDI_UE),
        ScalarString([Uni.PA, Uni.EE]) : ScalarString(Glyph.INIT_PA_MEDI_EE),
        ScalarString(Uni.QA) : ScalarString(Glyph.INIT_QA),
        ScalarString([Uni.QA, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FVS1),
        ScalarString([Uni.QA, Uni.E]) : ScalarString(Glyph.INIT_QA_MEDI_E),
        ScalarString([Uni.QA, Uni.I]) : ScalarString(Glyph.INIT_QA_MEDI_I),
        ScalarString([Uni.QA, Uni.OE]) : ScalarString(Glyph.INIT_QA_MEDI_OE),
        ScalarString([Uni.QA, Uni.UE]) : ScalarString(Glyph.INIT_QA_MEDI_UE),
        ScalarString([Uni.QA, Uni.EE]) : ScalarString(Glyph.INIT_QA_MEDI_EE),
        ScalarString(Uni.GA) : ScalarString(Glyph.INIT_GA),
        ScalarString([Uni.GA, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FVS1),
        ScalarString([Uni.GA, Uni.E]) : ScalarString(Glyph.INIT_GA_MEDI_E),
        ScalarString([Uni.GA, Uni.I]) : ScalarString(Glyph.INIT_GA_MEDI_I),
        ScalarString([Uni.GA, Uni.OE]) : ScalarString(Glyph.INIT_GA_MEDI_OE),
        ScalarString([Uni.GA, Uni.UE]) : ScalarString(Glyph.INIT_GA_MEDI_UE),
        ScalarString([Uni.GA, Uni.EE]) : ScalarString(Glyph.INIT_GA_MEDI_EE),
        ScalarString(Uni.MA) : ScalarString(Glyph.INIT_MA),
        ScalarString(Uni.LA) : ScalarString(Glyph.INIT_LA),
        ScalarString(Uni.SA) : ScalarString(Glyph.INIT_SA),
        ScalarString(Uni.SHA) : ScalarString(Glyph.INIT_SHA),
        ScalarString(Uni.TA) : ScalarString(Glyph.INIT_TA),
        ScalarString(Uni.DA) : ScalarString(Glyph.INIT_DA),
        ScalarString([Uni.DA, Uni.FVS1]) : ScalarString(Glyph.INIT_DA_FVS1),
        ScalarString(Uni.CHA) : ScalarString(Glyph.INIT_CHA),
        ScalarString(Uni.JA) : ScalarString(Glyph.INIT_JA),
        ScalarString(Uni.YA) : ScalarString(Glyph.INIT_YA),
        ScalarString([Uni.YA, Uni.FVS1]) : ScalarString(Glyph.INIT_YA_FVS1),
        ScalarString(Uni.RA) : ScalarString(Glyph.INIT_RA),
        ScalarString(Uni.WA) : ScalarString(Glyph.INIT_WA),
        ScalarString(Uni.FA) : ScalarString(Glyph.INIT_FA),
        ScalarString([Uni.FA, Uni.A]) : ScalarString(Glyph.INIT_FA_MEDI_A),
        ScalarString([Uni.FA, Uni.E]) : ScalarString(Glyph.INIT_FA_MEDI_E),
        ScalarString([Uni.FA, Uni.I]) : ScalarString(Glyph.INIT_FA_MEDI_I),
        ScalarString([Uni.FA, Uni.O]) : ScalarString(Glyph.INIT_FA_MEDI_O),
        ScalarString([Uni.FA, Uni.U]) : ScalarString(Glyph.INIT_FA_MEDI_U),
        ScalarString([Uni.FA, Uni.OE]) : ScalarString(Glyph.INIT_FA_MEDI_OE),
        ScalarString([Uni.FA, Uni.UE]) : ScalarString(Glyph.INIT_FA_MEDI_UE),
        ScalarString([Uni.FA, Uni.EE]) : ScalarString(Glyph.INIT_FA_MEDI_EE),
        ScalarString(Uni.KA) : ScalarString(Glyph.INIT_KA),
        ScalarString([Uni.KA, Uni.A]) : ScalarString(Glyph.INIT_KA_MEDI_A),
        ScalarString([Uni.KA, Uni.E]) : ScalarString(Glyph.INIT_KA_MEDI_E),
        ScalarString([Uni.KA, Uni.I]) : ScalarString(Glyph.INIT_KA_MEDI_I),
        ScalarString([Uni.KA, Uni.O]) : ScalarString(Glyph.INIT_KA_MEDI_O),
        ScalarString([Uni.KA, Uni.U]) : ScalarString(Glyph.INIT_KA_MEDI_U),
        ScalarString([Uni.KA, Uni.OE]) : ScalarString(Glyph.INIT_KA_MEDI_OE),
        ScalarString([Uni.KA, Uni.UE]) : ScalarString(Glyph.INIT_KA_MEDI_UE),
        ScalarString([Uni.KA, Uni.EE]) : ScalarString(Glyph.INIT_KA_MEDI_EE),
        ScalarString(Uni.KHA) : ScalarString(Glyph.INIT_KHA),
        ScalarString([Uni.KHA, Uni.A]) : ScalarString(Glyph.INIT_KHA_MEDI_A),
        ScalarString([Uni.KHA, Uni.E]) : ScalarString(Glyph.INIT_KHA_MEDI_E),
        ScalarString([Uni.KHA, Uni.I]) : ScalarString(Glyph.INIT_KHA_MEDI_I),
        ScalarString([Uni.KHA, Uni.O]) : ScalarString(Glyph.INIT_KHA_MEDI_O),
        ScalarString([Uni.KHA, Uni.U]) : ScalarString(Glyph.INIT_KHA_MEDI_U),
        ScalarString([Uni.KHA, Uni.OE]) : ScalarString(Glyph.INIT_KHA_MEDI_OE),
        ScalarString([Uni.KHA, Uni.UE]) : ScalarString(Glyph.INIT_KHA_MEDI_UE),
        ScalarString([Uni.KHA, Uni.EE]) : ScalarString(Glyph.INIT_KHA_MEDI_EE),
        ScalarString(Uni.TSA) : ScalarString(Glyph.INIT_TSA),
        ScalarString(Uni.ZA) : ScalarString(Glyph.INIT_ZA),
        ScalarString(Uni.HAA) : ScalarString(Glyph.INIT_HAA),
        ScalarString(Uni.ZRA) : ScalarString(Glyph.INIT_ZRA),
        ScalarString(Uni.LHA) : ScalarString(Glyph.INIT_LHA),
        ScalarString(Uni.ZHI) : ScalarString(Glyph.INIT_ZHI),
        ScalarString(Uni.CHI) : ScalarString(Glyph.INIT_CHI),
        ScalarString([Uni.QA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_MEDI_OE_FVS1),
        ScalarString([Uni.QA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_MEDI_UE_FVS1),
        ScalarString([Uni.GA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_MEDI_OE_FVS1),
        ScalarString([Uni.GA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_MEDI_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS2]) : ScalarString(Glyph.INIT_QA_FVS2),
        ScalarString([Uni.QA, Uni.FVS3]) : ScalarString(Glyph.INIT_QA_FVS3),
        ScalarString([Uni.QA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_E),
        ScalarString([Uni.QA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_I),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_OE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_UE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_EE),
        ScalarString([Uni.GA, Uni.FVS2]) : ScalarString(Glyph.INIT_GA_FVS2),
        ScalarString([Uni.GA, Uni.FVS3]) : ScalarString(Glyph.INIT_GA_FVS3),
        ScalarString([Uni.GA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_E),
        ScalarString([Uni.GA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_I),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_OE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_UE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_EE),
        ScalarString([Uni.BA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_BA_MEDI_OE_FVS1),
        ScalarString([Uni.BA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_BA_MEDI_UE_FVS1),
        ScalarString([Uni.PA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_PA_MEDI_OE_FVS1),
        ScalarString([Uni.PA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_PA_MEDI_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_OE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_QA_FVS1_MEDI_UE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_OE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_GA_FVS1_MEDI_UE_FVS1),
        ScalarString([Uni.FA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_FA_MEDI_OE_FVS1),
        ScalarString([Uni.FA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_FA_MEDI_UE_FVS1),
        ScalarString([Uni.KA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_KA_MEDI_OE_FVS1),
        ScalarString([Uni.KA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_KA_MEDI_UE_FVS1),
        ScalarString([Uni.KHA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.INIT_KHA_MEDI_OE_FVS1),
        ScalarString([Uni.KHA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.INIT_KHA_MEDI_UE_FVS1),
        
        // Catch other chars
        ScalarString(Glyph.CURSOR_HOLDER) : ScalarString(Glyph.CURSOR_HOLDER),
        ScalarString(Uni.MONGOLIAN_NIRUGU) : ScalarString(Glyph.NIRUGU),
        ScalarString(Uni.ZWJ) : ScalarString(""),
        ScalarString(Uni.NNBS) : ScalarString(Uni.NNBS),
        ScalarString(Uni.MVS) : ScalarString(""),
        ScalarString(Uni.FVS1) : ScalarString(""),
        ScalarString(Uni.FVS2) : ScalarString(""),
        ScalarString(Uni.FVS3) : ScalarString("")
    ]
    
    private static let medialDictionary = [
        ScalarString(Uni.A) : ScalarString(Glyph.MEDI_A),
        ScalarString([Uni.A, Uni.FVS1]) : ScalarString(Glyph.MEDI_A_FVS1),
        ScalarString(Uni.E) : ScalarString(Glyph.MEDI_E),
        ScalarString(Uni.I) : ScalarString(Glyph.MEDI_I),
        ScalarString([Uni.I, Uni.FVS1]) : ScalarString(Glyph.MEDI_I_FVS1),
        ScalarString([Uni.I, Uni.FVS2]) : ScalarString(Glyph.MEDI_I_FVS2),
        ScalarString([Uni.I, Uni.FVS3]) : ScalarString(Glyph.MEDI_I_FVS3),
        ScalarString(Uni.O) : ScalarString(Glyph.MEDI_O),
        ScalarString([Uni.O, Uni.FVS1]) : ScalarString(Glyph.MEDI_O_FVS1),
        ScalarString(Uni.U) : ScalarString(Glyph.MEDI_U),
        ScalarString([Uni.U, Uni.FVS1]) : ScalarString(Glyph.MEDI_U_FVS1),
        ScalarString(Uni.OE) : ScalarString(Glyph.MEDI_OE),
        ScalarString([Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_OE_FVS1),
        ScalarString([Uni.OE, Uni.FVS2]) : ScalarString(Glyph.MEDI_OE_FVS2),
        ScalarString(Uni.UE) : ScalarString(Glyph.MEDI_UE),
        ScalarString([Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_UE_FVS1),
        ScalarString([Uni.UE, Uni.FVS2]) : ScalarString(Glyph.MEDI_UE_FVS2),
        ScalarString(Uni.EE) : ScalarString(Glyph.MEDI_EE),
        ScalarString(Uni.NA) : ScalarString(Glyph.MEDI_NA),
        ScalarString([Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_NA_FVS1),
        ScalarString([Uni.NA, Uni.FVS2]) : ScalarString(Glyph.MEDI_NA_FVS2),
        ScalarString(Uni.ANG) : ScalarString(Glyph.MEDI_ANG),
        ScalarString([Uni.ANG, Uni.QA]) : ScalarString(Glyph.MEDI_ANG_MEDI_QA),
        ScalarString([Uni.ANG, Uni.QA, Uni.FVS1]) : ScalarString(Glyph.MEDI_ANG_MEDI_QA),
        ScalarString([Uni.ANG, Uni.GA]) : ScalarString(Glyph.MEDI_ANG_MEDI_GA),
        ScalarString([Uni.ANG, Uni.GA, Uni.FVS1]) : ScalarString(Glyph.MEDI_ANG_MEDI_GA),
        ScalarString([Uni.ANG, Uni.MA]) : ScalarString(Glyph.MEDI_ANG_MEDI_MA),
        ScalarString([Uni.ANG, Uni.LA]) : ScalarString(Glyph.MEDI_ANG_MEDI_LA),
        ScalarString([Uni.ANG, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_ANG_MEDI_NA_FVS1),
        ScalarString(Uni.BA) : ScalarString(Glyph.MEDI_BA),
        ScalarString([Uni.BA, Uni.A]) : ScalarString(Glyph.MEDI_BA_MEDI_A),
        ScalarString([Uni.BA, Uni.E]) : ScalarString(Glyph.MEDI_BA_MEDI_E),
        ScalarString([Uni.BA, Uni.I]) : ScalarString(Glyph.MEDI_BA_MEDI_I),
        ScalarString([Uni.BA, Uni.O]) : ScalarString(Glyph.MEDI_BA_MEDI_O),
        ScalarString([Uni.BA, Uni.U]) : ScalarString(Glyph.MEDI_BA_MEDI_U),
        ScalarString([Uni.BA, Uni.OE]) : ScalarString(Glyph.MEDI_BA_MEDI_OE),
        ScalarString([Uni.BA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_BA_MEDI_OE_FVS1),
        ScalarString([Uni.BA, Uni.UE]) : ScalarString(Glyph.MEDI_BA_MEDI_UE),
        ScalarString([Uni.BA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_BA_MEDI_UE_FVS1),
        ScalarString([Uni.BA, Uni.EE]) : ScalarString(Glyph.MEDI_BA_MEDI_EE),
        ScalarString([Uni.BA, Uni.MA]) : ScalarString(Glyph.MEDI_BA_MEDI_MA),
        ScalarString([Uni.BA, Uni.LA]) : ScalarString(Glyph.MEDI_BA_MEDI_LA),
        ScalarString([Uni.BA, Uni.QA]) : ScalarString(Glyph.MEDI_BA_MEDI_QA),
        ScalarString([Uni.BA, Uni.GA]) : ScalarString(Glyph.MEDI_BA_MEDI_GA),
        ScalarString([Uni.BA, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_BA_MEDI_NA_FVS1),
        ScalarString(Uni.PA) : ScalarString(Glyph.MEDI_PA),
        ScalarString([Uni.PA, Uni.A]) : ScalarString(Glyph.MEDI_PA_MEDI_A),
        ScalarString([Uni.PA, Uni.E]) : ScalarString(Glyph.MEDI_PA_MEDI_E),
        ScalarString([Uni.PA, Uni.I]) : ScalarString(Glyph.MEDI_PA_MEDI_I),
        ScalarString([Uni.PA, Uni.O]) : ScalarString(Glyph.MEDI_PA_MEDI_O),
        ScalarString([Uni.PA, Uni.U]) : ScalarString(Glyph.MEDI_PA_MEDI_U),
        ScalarString([Uni.PA, Uni.OE]) : ScalarString(Glyph.MEDI_PA_MEDI_OE),
        ScalarString([Uni.PA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_PA_MEDI_OE_FVS1),
        ScalarString([Uni.PA, Uni.UE]) : ScalarString(Glyph.MEDI_PA_MEDI_UE),
        ScalarString([Uni.PA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_PA_MEDI_UE_FVS1),
        ScalarString([Uni.PA, Uni.EE]) : ScalarString(Glyph.MEDI_PA_MEDI_EE),
        ScalarString([Uni.PA, Uni.MA]) : ScalarString(Glyph.MEDI_PA_MEDI_MA),
        ScalarString([Uni.PA, Uni.LA]) : ScalarString(Glyph.MEDI_PA_MEDI_LA),
        ScalarString([Uni.PA, Uni.QA]) : ScalarString(Glyph.MEDI_PA_MEDI_QA),
        ScalarString([Uni.PA, Uni.GA]) : ScalarString(Glyph.MEDI_PA_MEDI_GA),
        ScalarString([Uni.PA, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_PA_MEDI_NA_FVS1),
        ScalarString(Uni.QA) : ScalarString(Glyph.MEDI_QA),
        ScalarString([Uni.QA, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_E),
        ScalarString([Uni.QA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_I),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_OE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_OE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_UE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.MEDI_QA_FVS1_MEDI_EE),
        ScalarString([Uni.QA, Uni.FVS2]) : ScalarString(Glyph.MEDI_QA_FVS2),
        ScalarString([Uni.QA, Uni.FVS3]) : ScalarString(Glyph.MEDI_QA_FVS3),
        ScalarString([Uni.QA, Uni.E]) : ScalarString(Glyph.MEDI_QA_MEDI_E),
        ScalarString([Uni.QA, Uni.I]) : ScalarString(Glyph.MEDI_QA_MEDI_I),
        ScalarString([Uni.QA, Uni.OE]) : ScalarString(Glyph.MEDI_QA_MEDI_OE),
        ScalarString([Uni.QA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_MEDI_OE_FVS1),
        ScalarString([Uni.QA, Uni.UE]) : ScalarString(Glyph.MEDI_QA_MEDI_UE),
        ScalarString([Uni.QA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_MEDI_UE_FVS1),
        ScalarString([Uni.QA, Uni.EE]) : ScalarString(Glyph.MEDI_QA_MEDI_EE),
        ScalarString(Uni.GA) : ScalarString(Glyph.MEDI_GA),
        ScalarString([Uni.GA, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_E),
        ScalarString([Uni.GA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_I),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_OE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_OE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_UE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_UE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.MEDI_GA_FVS1_MEDI_EE),
        ScalarString([Uni.GA, Uni.FVS2]) : ScalarString(Glyph.MEDI_GA_FVS2),
        ScalarString([Uni.GA, Uni.FVS3]) : ScalarString(Glyph.MEDI_GA_FVS3),
        ScalarString([Uni.GA, Uni.FVS3, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_MEDI_NA_FVS1),
        ScalarString([Uni.GA, Uni.FVS3, Uni.MA]) : ScalarString(Glyph.MEDI_GA_MEDI_MA),
        ScalarString([Uni.GA, Uni.FVS3, Uni.LA]) : ScalarString(Glyph.MEDI_GA_MEDI_LA),
        ScalarString([Uni.GA, Uni.E]) : ScalarString(Glyph.MEDI_GA_MEDI_E),
        ScalarString([Uni.GA, Uni.I]) : ScalarString(Glyph.MEDI_GA_MEDI_I),
        ScalarString([Uni.GA, Uni.OE]) : ScalarString(Glyph.MEDI_GA_MEDI_OE),
        ScalarString([Uni.GA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_MEDI_OE_FVS1),
        ScalarString([Uni.GA, Uni.UE]) : ScalarString(Glyph.MEDI_GA_MEDI_UE),
        ScalarString([Uni.GA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_MEDI_UE_FVS1),
        ScalarString([Uni.GA, Uni.EE]) : ScalarString(Glyph.MEDI_GA_MEDI_EE),
        ScalarString(Uni.MA) : ScalarString(Glyph.MEDI_MA),
        ScalarString([Uni.MA, Uni.MA]) : ScalarString(Glyph.MEDI_MA_MEDI_MA),
        ScalarString([Uni.MA, Uni.LA]) : ScalarString(Glyph.MEDI_MA_MEDI_LA),
        ScalarString(Uni.LA) : ScalarString(Glyph.MEDI_LA),
        ScalarString([Uni.LA, Uni.LA]) : ScalarString(Glyph.MEDI_LA_MEDI_LA),
        ScalarString(Uni.SA) : ScalarString(Glyph.MEDI_SA),
        ScalarString(Uni.SHA) : ScalarString(Glyph.MEDI_SHA),
        ScalarString(Uni.TA) : ScalarString(Glyph.MEDI_TA),
        ScalarString([Uni.TA, Uni.FVS1]) : ScalarString(Glyph.MEDI_TA_FVS1),
        ScalarString([Uni.TA, Uni.FVS2]) : ScalarString(Glyph.MEDI_TA_FVS2),
        ScalarString(Uni.DA) : ScalarString(Glyph.MEDI_DA),
        ScalarString([Uni.DA, Uni.FVS1]) : ScalarString(Glyph.MEDI_DA_FVS1),
        ScalarString([Uni.CHA]) : ScalarString(Glyph.MEDI_CHA),
        ScalarString(Uni.JA) : ScalarString(Glyph.MEDI_JA),
        ScalarString(Uni.YA) : ScalarString(Glyph.MEDI_YA),
        ScalarString([Uni.YA, Uni.FVS1]) : ScalarString(Glyph.MEDI_YA_FVS1),
        ScalarString(Uni.RA) : ScalarString(Glyph.MEDI_RA),
        ScalarString(Uni.WA) : ScalarString(Glyph.MEDI_WA),
        ScalarString([Uni.WA, Uni.FVS1]) : ScalarString(Glyph.MEDI_WA_FVS1),
        ScalarString(Uni.FA) : ScalarString(Glyph.MEDI_FA),
        ScalarString([Uni.FA, Uni.A]) : ScalarString(Glyph.MEDI_FA_MEDI_A),
        ScalarString([Uni.FA, Uni.E]) : ScalarString(Glyph.MEDI_FA_MEDI_E),
        ScalarString([Uni.FA, Uni.I]) : ScalarString(Glyph.MEDI_FA_MEDI_I),
        ScalarString([Uni.FA, Uni.O]) : ScalarString(Glyph.MEDI_FA_MEDI_O),
        ScalarString([Uni.FA, Uni.U]) : ScalarString(Glyph.MEDI_FA_MEDI_U),
        ScalarString([Uni.FA, Uni.OE]) : ScalarString(Glyph.MEDI_FA_MEDI_OE),
        ScalarString([Uni.FA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_FA_MEDI_OE_FVS1),
        ScalarString([Uni.FA, Uni.UE]) : ScalarString(Glyph.MEDI_FA_MEDI_UE),
        ScalarString([Uni.FA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_FA_MEDI_UE_FVS1),
        ScalarString([Uni.FA, Uni.EE]) : ScalarString(Glyph.MEDI_FA_MEDI_EE),
        ScalarString([Uni.FA, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_FA_MEDI_NA_FVS1),
        ScalarString([Uni.FA, Uni.MA]) : ScalarString(Glyph.MEDI_FA_MEDI_MA),
        ScalarString([Uni.FA, Uni.LA]) : ScalarString(Glyph.MEDI_FA_MEDI_LA),
        ScalarString([Uni.FA, Uni.QA]) : ScalarString(Glyph.MEDI_FA_MEDI_QA),
        ScalarString([Uni.FA, Uni.GA]) : ScalarString(Glyph.MEDI_FA_MEDI_GA),
        ScalarString(Uni.KA) : ScalarString(Glyph.MEDI_KA),
        ScalarString([Uni.KA, Uni.A]) : ScalarString(Glyph.MEDI_KA_MEDI_A),
        ScalarString([Uni.KA, Uni.E]) : ScalarString(Glyph.MEDI_KA_MEDI_E),
        ScalarString([Uni.KA, Uni.I]) : ScalarString(Glyph.MEDI_KA_MEDI_I),
        ScalarString([Uni.KA, Uni.O]) : ScalarString(Glyph.MEDI_KA_MEDI_O),
        ScalarString([Uni.KA, Uni.U]) : ScalarString(Glyph.MEDI_KA_MEDI_U),
        ScalarString([Uni.KA, Uni.OE]) : ScalarString(Glyph.MEDI_KA_MEDI_OE),
        ScalarString([Uni.KA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KA_MEDI_OE_FVS1),
        ScalarString([Uni.KA, Uni.UE]) : ScalarString(Glyph.MEDI_KA_MEDI_UE),
        ScalarString([Uni.KA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KA_MEDI_UE_FVS1),
        ScalarString([Uni.KA, Uni.EE]) : ScalarString(Glyph.MEDI_KA_MEDI_EE),
        ScalarString([Uni.KA, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_KA_MEDI_NA_FVS1),
        ScalarString([Uni.KA, Uni.QA]) : ScalarString(Glyph.MEDI_KA_MEDI_QA),
        ScalarString([Uni.KA, Uni.GA]) : ScalarString(Glyph.MEDI_KA_MEDI_GA),
        ScalarString([Uni.KA, Uni.MA]) : ScalarString(Glyph.MEDI_KA_MEDI_MA),
        ScalarString([Uni.KA, Uni.LA]) : ScalarString(Glyph.MEDI_KA_MEDI_LA),
        ScalarString(Uni.KHA) : ScalarString(Glyph.MEDI_KHA),
        ScalarString([Uni.KHA, Uni.A]) : ScalarString(Glyph.MEDI_KHA_MEDI_A),
        ScalarString([Uni.KHA, Uni.E]) : ScalarString(Glyph.MEDI_KHA_MEDI_E),
        ScalarString([Uni.KHA, Uni.I]) : ScalarString(Glyph.MEDI_KHA_MEDI_I),
        ScalarString([Uni.KHA, Uni.O]) : ScalarString(Glyph.MEDI_KHA_MEDI_O),
        ScalarString([Uni.KHA, Uni.U]) : ScalarString(Glyph.MEDI_KHA_MEDI_U),
        ScalarString([Uni.KHA, Uni.OE]) : ScalarString(Glyph.MEDI_KHA_MEDI_OE),
        ScalarString([Uni.KHA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KHA_MEDI_OE_FVS1),
        ScalarString([Uni.KHA, Uni.UE]) : ScalarString(Glyph.MEDI_KHA_MEDI_UE),
        ScalarString([Uni.KHA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KHA_MEDI_UE_FVS1),
        ScalarString([Uni.KHA, Uni.EE]) : ScalarString(Glyph.MEDI_KHA_MEDI_EE),
        ScalarString([Uni.KHA, Uni.NA, Uni.FVS1]) : ScalarString(Glyph.MEDI_KHA_MEDI_NA_FVS1),
        ScalarString([Uni.KHA, Uni.QA]) : ScalarString(Glyph.MEDI_KHA_MEDI_QA),
        ScalarString([Uni.KHA, Uni.GA]) : ScalarString(Glyph.MEDI_KHA_MEDI_GA),
        ScalarString([Uni.KHA, Uni.MA]) : ScalarString(Glyph.MEDI_KHA_MEDI_MA),
        ScalarString([Uni.KHA, Uni.LA]) : ScalarString(Glyph.MEDI_KHA_MEDI_LA),
        ScalarString(Uni.TSA) : ScalarString(Glyph.MEDI_TSA),
        ScalarString(Uni.ZA) : ScalarString(Glyph.MEDI_ZA),
        ScalarString(Uni.HAA) : ScalarString(Glyph.MEDI_HAA),
        ScalarString(Uni.ZRA) : ScalarString(Glyph.MEDI_ZRA),
        ScalarString(Uni.LHA) : ScalarString(Glyph.MEDI_LHA),
        ScalarString(Uni.ZHI) : ScalarString(Glyph.MEDI_ZHI),
        ScalarString(Uni.CHI) : ScalarString(Glyph.MEDI_CHI),
        
        // MVS
        ScalarString([Uni.NA, Uni.MVS]) : ScalarString(Glyph.FINA_NA_FVS1),
        ScalarString([Uni.ANG, Uni.QA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_QA),
        ScalarString([Uni.ANG, Uni.FVS1, Uni.QA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_QA),
        ScalarString([Uni.ANG, Uni.FVS1, Uni.GA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_GA),
        ScalarString([Uni.ANG, Uni.GA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_GA),
        ScalarString([Uni.BA, Uni.MVS]) : ScalarString(Glyph.FINA_BA),
        ScalarString([Uni.PA, Uni.MVS]) : ScalarString(Glyph.FINA_PA),
        ScalarString([Uni.QA, Uni.MVS]) : ScalarString(Glyph.FINA_QA),
        ScalarString([Uni.GA, Uni.MVS]) : ScalarString(Glyph.FINA_GA_FVS3),
        ScalarString([Uni.MA, Uni.MVS]) : ScalarString(Glyph.FINA_MA),
        ScalarString([Uni.LA, Uni.MVS]) : ScalarString(Glyph.FINA_LA),
        ScalarString([Uni.SA, Uni.MVS]) : ScalarString(Glyph.FINA_SA),
        ScalarString([Uni.SA, Uni.FVS1, Uni.MVS]) : ScalarString(Glyph.FINA_SA_FVS1),
        ScalarString([Uni.SHA, Uni.MVS]) : ScalarString(Glyph.FINA_SHA),
        ScalarString([Uni.TA, Uni.MVS]) : ScalarString(Glyph.FINA_TA),
        ScalarString([Uni.DA, Uni.MVS]) : ScalarString(Glyph.FINA_DA_FVS1),
        ScalarString([Uni.CHA, Uni.MVS]) : ScalarString(Glyph.FINA_CHA),
        ScalarString([Uni.JA, Uni.MVS]) : ScalarString(Glyph.FINA_JA_FVS1),
        ScalarString([Uni.YA, Uni.MVS]) : ScalarString(Glyph.FINA_YA),
        ScalarString([Uni.I, Uni.MVS]) : ScalarString(Glyph.FINA_YA), // It may be a substitute for YA
        ScalarString([Uni.RA, Uni.MVS]) : ScalarString(Glyph.FINA_RA),
        ScalarString([Uni.WA, Uni.MVS]) : ScalarString(Glyph.FINA_WA),
        ScalarString([Uni.FA, Uni.MVS]) : ScalarString(Glyph.FINA_FA),
        ScalarString([Uni.KA, Uni.MVS]) : ScalarString(Glyph.FINA_KA),
        ScalarString([Uni.KHA, Uni.MVS]) : ScalarString(Glyph.FINA_KHA),
        ScalarString([Uni.TSA, Uni.MVS]) : ScalarString(Glyph.FINA_TSA),
        ScalarString([Uni.ZA, Uni.MVS]) : ScalarString(Glyph.FINA_ZA),
        ScalarString([Uni.HAA, Uni.MVS]) : ScalarString(Glyph.FINA_HAA),
        ScalarString([Uni.ZRA, Uni.MVS]) : ScalarString(Glyph.FINA_ZRA),
        ScalarString([Uni.LHA, Uni.MVS]) : ScalarString(Glyph.FINA_LHA),
        ScalarString([Uni.ZHI, Uni.MVS]) : ScalarString(Glyph.FINA_ZHI),
        ScalarString([Uni.CHI, Uni.MVS]) : ScalarString(Glyph.FINA_CHI),
        
        // Catch other chars
        ScalarString(Glyph.CURSOR_HOLDER) : ScalarString(Glyph.CURSOR_HOLDER),
        ScalarString(Uni.MONGOLIAN_NIRUGU) : ScalarString(Glyph.NIRUGU),
        ScalarString(Uni.ZWJ) : ScalarString(""),
        ScalarString(Uni.NNBS) : ScalarString(Uni.NNBS),
        ScalarString(Uni.MVS) : ScalarString(""),
        ScalarString(Uni.FVS1) : ScalarString(""),
        ScalarString(Uni.FVS2) : ScalarString(""),
        ScalarString(Uni.FVS3) : ScalarString("")
    ]
    
    private static let finalDictionary = [
        ScalarString(Uni.A) : ScalarString(Glyph.FINA_A),
        ScalarString([Uni.A, Uni.FVS1]) : ScalarString(Glyph.FINA_A_FVS1),
        ScalarString([Uni.A, Uni.FVS2]) : ScalarString(Glyph.FINA_A_FVS2),
        ScalarString(Uni.E) : ScalarString(Glyph.FINA_E),
        ScalarString([Uni.E, Uni.FVS1]) : ScalarString(Glyph.FINA_E_FVS1),
        ScalarString([Uni.E, Uni.FVS2]) : ScalarString(Glyph.FINA_E_FVS2),
        ScalarString(Uni.I) : ScalarString(Glyph.FINA_I),
        ScalarString(Uni.O) : ScalarString(Glyph.FINA_O),
        ScalarString([Uni.O, Uni.FVS1]) : ScalarString(Glyph.FINA_O_FVS1),
        ScalarString(Uni.U) : ScalarString(Glyph.FINA_U),
        ScalarString([Uni.U, Uni.FVS1]) : ScalarString(Glyph.FINA_U_FVS1),
        ScalarString(Uni.OE) : ScalarString(Glyph.FINA_OE),
        ScalarString([Uni.OE, Uni.FVS1]) : ScalarString(Glyph.FINA_OE_FVS1),
        ScalarString(Uni.UE) : ScalarString(Glyph.FINA_UE),
        ScalarString([Uni.UE, Uni.FVS1]) : ScalarString(Glyph.FINA_UE_FVS1),
        ScalarString(Uni.EE) : ScalarString(Glyph.FINA_EE),
        ScalarString(Uni.NA) : ScalarString(Glyph.FINA_NA),
        ScalarString([Uni.NA, Uni.FVS1]) : ScalarString(Glyph.FINA_NA_FVS1),
        ScalarString(Uni.ANG) : ScalarString(Glyph.FINA_ANG),
        ScalarString(Uni.BA) : ScalarString(Glyph.FINA_BA),
        ScalarString([Uni.BA, Uni.A]) : ScalarString(Glyph.MEDI_BA_FINA_A),
        ScalarString([Uni.BA, Uni.E]) : ScalarString(Glyph.MEDI_BA_FINA_E),
        ScalarString([Uni.BA, Uni.I]) : ScalarString(Glyph.MEDI_BA_FINA_I),
        ScalarString([Uni.BA, Uni.O]) : ScalarString(Glyph.MEDI_BA_FINA_O),
        ScalarString([Uni.BA, Uni.U]) : ScalarString(Glyph.MEDI_BA_FINA_U),
        ScalarString([Uni.BA, Uni.OE]) : ScalarString(Glyph.MEDI_BA_FINA_OE),
        ScalarString([Uni.BA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_BA_FINA_OE_FVS1),
        ScalarString([Uni.BA, Uni.UE]) : ScalarString(Glyph.MEDI_BA_FINA_UE),
        ScalarString([Uni.BA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_BA_FINA_UE_FVS1),
        ScalarString([Uni.BA, Uni.EE]) : ScalarString(Glyph.MEDI_BA_FINA_EE),
        ScalarString(Uni.PA) : ScalarString(Glyph.FINA_PA),
        ScalarString([Uni.PA, Uni.A]) : ScalarString(Glyph.MEDI_PA_FINA_A),
        ScalarString([Uni.PA, Uni.E]) : ScalarString(Glyph.MEDI_PA_FINA_E),
        ScalarString([Uni.PA, Uni.I]) : ScalarString(Glyph.MEDI_PA_FINA_I),
        ScalarString([Uni.PA, Uni.O]) : ScalarString(Glyph.MEDI_PA_FINA_O),
        ScalarString([Uni.PA, Uni.U]) : ScalarString(Glyph.MEDI_PA_FINA_U),
        ScalarString([Uni.PA, Uni.OE]) : ScalarString(Glyph.MEDI_PA_FINA_OE),
        ScalarString([Uni.PA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_PA_FINA_OE_FVS1),
        ScalarString([Uni.PA, Uni.UE]) : ScalarString(Glyph.MEDI_PA_FINA_UE),
        ScalarString([Uni.PA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_PA_FINA_UE_FVS1),
        ScalarString([Uni.PA, Uni.EE]) : ScalarString(Glyph.MEDI_PA_FINA_EE),
        ScalarString(Uni.QA) : ScalarString(Glyph.FINA_QA),
        ScalarString([Uni.QA, Uni.FVS1]) : ScalarString(Glyph.FINA_QA_FVS1),
        ScalarString([Uni.QA, Uni.FVS2]) : ScalarString(Glyph.FINA_QA_FVS2),
        ScalarString([Uni.QA, Uni.E]) : ScalarString(Glyph.MEDI_QA_FINA_E),
        ScalarString([Uni.QA, Uni.I]) : ScalarString(Glyph.MEDI_QA_FINA_I),
        ScalarString([Uni.QA, Uni.OE]) : ScalarString(Glyph.MEDI_QA_FINA_OE),
        ScalarString([Uni.QA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FINA_OE_FVS1),
        ScalarString([Uni.QA, Uni.UE]) : ScalarString(Glyph.MEDI_QA_FINA_UE),
        ScalarString([Uni.QA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FINA_UE_FVS1),
        ScalarString([Uni.QA, Uni.EE]) : ScalarString(Glyph.MEDI_QA_FINA_EE),
        ScalarString(Uni.GA) : ScalarString(Glyph.FINA_GA),
        ScalarString([Uni.GA, Uni.FVS1]) : ScalarString(Glyph.FINA_GA_FVS1),
        ScalarString([Uni.GA, Uni.FVS2]) : ScalarString(Glyph.FINA_GA_FVS2),
        // TODO The FSV3 is just to make it compatible with Baiti
        ScalarString([Uni.GA, Uni.FVS3]) : ScalarString(Glyph.FINA_GA_FVS3),
        ScalarString([Uni.GA, Uni.E]) : ScalarString(Glyph.MEDI_GA_FINA_E),
        ScalarString([Uni.GA, Uni.I]) : ScalarString(Glyph.MEDI_GA_FINA_I),
        ScalarString([Uni.GA, Uni.OE]) : ScalarString(Glyph.MEDI_GA_FINA_OE),
        ScalarString([Uni.GA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FINA_OE_FVS1),
        ScalarString([Uni.GA, Uni.UE]) : ScalarString(Glyph.MEDI_GA_FINA_UE),
        ScalarString([Uni.GA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FINA_UE_FVS1),
        ScalarString([Uni.GA, Uni.EE]) : ScalarString(Glyph.MEDI_GA_FINA_EE),
        ScalarString(Uni.MA) : ScalarString(Glyph.FINA_MA),
        ScalarString(Uni.LA) : ScalarString(Glyph.FINA_LA),
        ScalarString(Uni.SA) : ScalarString(Glyph.FINA_SA),
        ScalarString(Uni.SHA) : ScalarString(Glyph.FINA_SHA),
        ScalarString(Uni.TA) : ScalarString(Glyph.FINA_TA),
        ScalarString(Uni.DA) : ScalarString(Glyph.FINA_DA),
        ScalarString([Uni.DA, Uni.FVS1]) : ScalarString(Glyph.FINA_DA_FVS1),
        ScalarString(Uni.CHA) : ScalarString(Glyph.FINA_CHA),
        ScalarString(Uni.JA) : ScalarString(Glyph.FINA_JA),
        ScalarString([Uni.JA, Uni.FVS1]) : ScalarString(Glyph.FINA_JA_FVS1),
        ScalarString(Uni.YA) : ScalarString(Glyph.FINA_YA),
        ScalarString(Uni.RA) : ScalarString(Glyph.FINA_RA),
        ScalarString(Uni.WA) : ScalarString(Glyph.FINA_WA),
        ScalarString([Uni.WA, Uni.FVS1]) : ScalarString(Glyph.FINA_WA_FVS1),
        ScalarString(Uni.FA) : ScalarString(Glyph.FINA_FA),
        ScalarString([Uni.FA, Uni.A]) : ScalarString(Glyph.MEDI_FA_FINA_A),
        ScalarString([Uni.FA, Uni.E]) : ScalarString(Glyph.MEDI_FA_FINA_E),
        ScalarString([Uni.FA, Uni.I]) : ScalarString(Glyph.MEDI_FA_FINA_I),
        ScalarString([Uni.FA, Uni.O]) : ScalarString(Glyph.MEDI_FA_FINA_O),
        ScalarString([Uni.FA, Uni.U]) : ScalarString(Glyph.MEDI_FA_FINA_U),
        ScalarString([Uni.FA, Uni.OE]) : ScalarString(Glyph.MEDI_FA_FINA_OE),
        ScalarString([Uni.FA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_FA_FINA_OE_FVS1),
        ScalarString([Uni.FA, Uni.UE]) : ScalarString(Glyph.MEDI_FA_FINA_UE),
        ScalarString([Uni.FA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_FA_FINA_UE_FVS1),
        ScalarString([Uni.FA, Uni.EE]) : ScalarString(Glyph.MEDI_FA_FINA_EE),
        ScalarString(Uni.KA) : ScalarString(Glyph.FINA_KA),
        ScalarString([Uni.KA, Uni.A]) : ScalarString(Glyph.MEDI_KA_FINA_A),
        ScalarString([Uni.KA, Uni.E]) : ScalarString(Glyph.MEDI_KA_FINA_E),
        ScalarString([Uni.KA, Uni.I]) : ScalarString(Glyph.MEDI_KA_FINA_I),
        ScalarString([Uni.KA, Uni.O]) : ScalarString(Glyph.MEDI_KA_FINA_O),
        ScalarString([Uni.KA, Uni.U]) : ScalarString(Glyph.MEDI_KA_FINA_U),
        ScalarString([Uni.KA, Uni.OE]) : ScalarString(Glyph.MEDI_KA_FINA_OE),
        ScalarString([Uni.KA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KA_FINA_OE_FVS1),
        ScalarString([Uni.KA, Uni.UE]) : ScalarString(Glyph.MEDI_KA_FINA_UE),
        ScalarString([Uni.KA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KA_FINA_UE_FVS1),
        ScalarString([Uni.KA, Uni.EE]) : ScalarString(Glyph.MEDI_KA_FINA_EE),
        ScalarString(Uni.KHA) : ScalarString(Glyph.FINA_KHA),
        ScalarString([Uni.KHA, Uni.A]) : ScalarString(Glyph.MEDI_KHA_FINA_A),
        ScalarString([Uni.KHA, Uni.E]) : ScalarString(Glyph.MEDI_KHA_FINA_E),
        ScalarString([Uni.KHA, Uni.I]) : ScalarString(Glyph.MEDI_KHA_FINA_I),
        ScalarString([Uni.KHA, Uni.O]) : ScalarString(Glyph.MEDI_KHA_FINA_O),
        ScalarString([Uni.KHA, Uni.U]) : ScalarString(Glyph.MEDI_KHA_FINA_U),
        ScalarString([Uni.KHA, Uni.OE]) : ScalarString(Glyph.MEDI_KHA_FINA_OE),
        ScalarString([Uni.KHA, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KHA_FINA_OE_FVS1),
        ScalarString([Uni.KHA, Uni.UE]) : ScalarString(Glyph.MEDI_KHA_FINA_UE),
        ScalarString([Uni.KHA, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_KHA_FINA_UE_FVS1),
        ScalarString([Uni.KHA, Uni.EE]) : ScalarString(Glyph.MEDI_KHA_FINA_EE),
        ScalarString(Uni.TSA) : ScalarString(Glyph.FINA_TSA),
        ScalarString(Uni.ZA) : ScalarString(Glyph.FINA_ZA),
        ScalarString(Uni.HAA) : ScalarString(Glyph.FINA_HAA),
        ScalarString(Uni.ZRA) : ScalarString(Glyph.FINA_ZRA),
        ScalarString(Uni.LHA) : ScalarString(Glyph.FINA_LHA),
        ScalarString(Uni.ZHI) : ScalarString(Glyph.FINA_ZHI),
        ScalarString(Uni.CHI) : ScalarString(Glyph.FINA_CHI),
        ScalarString([Uni.SA, Uni.FVS1]) : ScalarString(Glyph.FINA_SA_FVS1),
        ScalarString([Uni.SA, Uni.FVS2]) : ScalarString(Glyph.FINA_SA_FVS2),
        ScalarString([Uni.BA, Uni.FVS1]) : ScalarString(Glyph.FINA_BA_FVS1),
        ScalarString([Uni.ANG, Uni.QA]) : ScalarString(Glyph.MEDI_ANG_FINA_QA),
        ScalarString([Uni.ANG, Uni.GA]) : ScalarString(Glyph.MEDI_ANG_FINA_GA),
        ScalarString([Uni.QA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_E),
        ScalarString([Uni.QA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_I),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_OE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_OE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_UE),
        ScalarString([Uni.QA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_UE_FVS1),
        ScalarString([Uni.QA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.MEDI_QA_FVS1_FINA_EE),
        ScalarString([Uni.NA, Uni.FVS2]) : ScalarString(Glyph.FINA_NA_FVS2),
        ScalarString([Uni.GA, Uni.FVS1, Uni.E]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_E),
        ScalarString([Uni.GA, Uni.FVS1, Uni.I]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_I),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_OE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.OE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_OE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_UE),
        ScalarString([Uni.GA, Uni.FVS1, Uni.UE, Uni.FVS1]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_UE_FVS1),
        ScalarString([Uni.GA, Uni.FVS1, Uni.EE]) : ScalarString(Glyph.MEDI_GA_FVS1_FINA_EE),
        
        // Final Vowel+YI rule (drop the Y),
        // (preFormatter catches final Consonant+YI),
        ScalarString([Uni.YA, Uni.I]) : ScalarString(Glyph.FINA_I),
        
        // MVS
        // TODO handle MVS in preFormatter()?
        ScalarString([Uni.NA, Uni.MVS]) : ScalarString(Glyph.FINA_NA_FVS1),
        ScalarString([Uni.ANG, Uni.QA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_QA),
        ScalarString([Uni.ANG, Uni.FVS1, Uni.QA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_QA),
        ScalarString([Uni.ANG, Uni.FVS1, Uni.GA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_GA),
        ScalarString([Uni.ANG, Uni.GA, Uni.MVS]) : ScalarString(Glyph.MEDI_ANG_FINA_GA),
        ScalarString([Uni.QA, Uni.MVS]) : ScalarString(Glyph.FINA_QA),
        ScalarString([Uni.GA, Uni.MVS]) : ScalarString(Glyph.FINA_GA_FVS3),
        ScalarString([Uni.MA, Uni.MVS]) : ScalarString(Glyph.FINA_MA),
        ScalarString([Uni.LA, Uni.MVS]) : ScalarString(Glyph.FINA_LA),
        ScalarString([Uni.JA, Uni.MVS]) : ScalarString(Glyph.FINA_JA_FVS1),
        ScalarString([Uni.YA, Uni.MVS]) : ScalarString(Glyph.FINA_YA),
        ScalarString([Uni.I, Uni.MVS]) : ScalarString(Glyph.FINA_YA), // I may be a substitute for YA
        ScalarString([Uni.RA, Uni.MVS]) : ScalarString(Glyph.FINA_RA),
        ScalarString([Uni.WA, Uni.MVS]) : ScalarString(Glyph.FINA_WA),
        
        // Catch other chars
        ScalarString(Glyph.CURSOR_HOLDER) : ScalarString(Glyph.CURSOR_HOLDER),
        ScalarString(Uni.MONGOLIAN_NIRUGU) : ScalarString(Glyph.NIRUGU),
        ScalarString(Uni.ZWJ) : ScalarString(""),
        ScalarString(Uni.NNBS) : ScalarString(Uni.NNBS),
        ScalarString(Uni.MVS) : ScalarString(""),
        ScalarString(Uni.FVS1) : ScalarString(""),
        ScalarString(Uni.FVS2) : ScalarString(""),
        ScalarString(Uni.FVS3) : ScalarString("")
    ]
    
    private static let suffixDictionary = [
        
        // Vocative Case
        ScalarString(Uni.A) : ScalarString(Glyph.FINA_A_FVS1),
        ScalarString(Uni.E) : ScalarString(Glyph.FINA_E_FVS1),
        
        // Genetive Case
        // YIN
        ScalarString([Uni.YA, Uni.I, Uni.NA]) : ScalarString([Glyph.INIT_YA_FVS1, Glyph.MEDI_I, Glyph.FINA_NA]),
        // UN
        ScalarString([Uni.U, Uni.NA]) : ScalarString([Glyph.INIT_U_FVS1, Glyph.FINA_NA]),
        // UEN
        ScalarString([Uni.UE, Uni.NA]) : ScalarString([Glyph.INIT_UE_FVS1, Glyph.FINA_NA]),
        // U
        ScalarString(Uni.U) : ScalarString(Glyph.ISOL_U_FVS2),
        // UE
        ScalarString(Uni.UE) : ScalarString(Glyph.ISOL_UE_FVS3),
        
        // Accusative Case
        // I
        ScalarString(Uni.I) : ScalarString(Glyph.ISOL_I_FVS1),
        // YI
        ScalarString([Uni.YA, Uni.I]) : ScalarString([Glyph.INIT_YA_FVS1, Glyph.FINA_I]),
        
        // Dative-Locative Case
        // DU
        ScalarString([Uni.DA, Uni.U]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.FINA_U]),
        // DUE
        ScalarString([Uni.DA, Uni.UE]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.FINA_UE]),
        // TU
        ScalarString([Uni.TA, Uni.U]) : ScalarString([Glyph.INIT_TA, Glyph.FINA_U]),
        // TUE
        ScalarString([Uni.TA, Uni.UE]) : ScalarString([Glyph.INIT_TA, Glyph.FINA_UE]),
        // DUR
        ScalarString([Uni.DA, Uni.U, Uni.RA]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_U, Glyph.FINA_RA]),
        // DUER
        ScalarString([Uni.DA, Uni.UE, Uni.RA]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_UE, Glyph.FINA_RA]),
        // TUR
        ScalarString([Uni.TA, Uni.U, Uni.RA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_U, Glyph.FINA_RA]),
        // TUER
        ScalarString([Uni.TA, Uni.UE, Uni.RA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_UE, Glyph.FINA_RA]),
        // DAQI
        ScalarString([Uni.DA, Uni.A, Uni.QA, Uni.I]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_A, Glyph.MEDI_QA_FINA_I]),
        // DEQI
        ScalarString([Uni.DA, Uni.E, Uni.QA, Uni.I]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_E, Glyph.MEDI_QA_FINA_I]),
        
        // Ablative Case
        // ACHA
        ScalarString([Uni.A, Uni.CHA, Uni.A]) : ScalarString([Glyph.INIT_A_FVS1, Glyph.MEDI_CHA, Glyph.FINA_A]),
        // ECHE
        ScalarString([Uni.E, Uni.CHA, Uni.E]) : ScalarString([Glyph.INIT_E, Glyph.MEDI_CHA, Glyph.FINA_E]),
        
        // Instrumental Case
        // BAR
        ScalarString([Uni.BA, Uni.A, Uni.RA]) : ScalarString([Glyph.INIT_BA_MEDI_A, Glyph.FINA_RA]),
        // BER
        ScalarString([Uni.BA, Uni.E, Uni.RA]) : ScalarString([Glyph.INIT_BA_MEDI_E, Glyph.FINA_RA]),
        // IYAR
        ScalarString([Uni.I, Uni.YA, Uni.A, Uni.RA]) : ScalarString([Glyph.INIT_I_FVS1, Glyph.MEDI_I, Glyph.MEDI_A, Glyph.FINA_RA]),
        // IYER
        ScalarString([Uni.I, Uni.YA, Uni.E, Uni.RA]) : ScalarString([Glyph.INIT_I_FVS1, Glyph.MEDI_I, Glyph.MEDI_E, Glyph.FINA_RA]),
        
        // Comitative Case
        // TAI
        ScalarString([Uni.TA, Uni.A, Uni.I]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_A, Glyph.FINA_I]),
        ScalarString([Uni.TA, Uni.A, Uni.YA, Uni.I]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_A, Glyph.FINA_I]),
        // TEI
        ScalarString([Uni.TA, Uni.E, Uni.I]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_E, Glyph.FINA_I]),
        ScalarString([Uni.TA, Uni.E, Uni.YA, Uni.I]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_E, Glyph.FINA_I]),
        // LUG-A
        ScalarString([Uni.LA, Uni.U, Uni.GA, Uni.MVS, Uni.A]) : ScalarString([Glyph.INIT_LA, Glyph.MEDI_U, Glyph.FINA_GA_FVS3, Glyph.FINA_A_FVS2]),
        // LUEGE
        ScalarString([Uni.LA, Uni.UE, Uni.GA, Uni.E]) : ScalarString([Glyph.INIT_LA, Glyph.MEDI_UE, Glyph.MEDI_GA_FINA_E]),
        
        // Reflexive Case
        // BAN
        ScalarString([Uni.BA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_BA_MEDI_A, Glyph.FINA_NA]),
        // BEN
        ScalarString([Uni.BA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_BA_MEDI_E, Glyph.FINA_NA]),
        // IYAN
        ScalarString([Uni.I, Uni.YA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_I_FVS1, Glyph.MEDI_I, Glyph.MEDI_A, Glyph.FINA_NA]),
        // IYEN
        ScalarString([Uni.I, Uni.YA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_I_FVS1, Glyph.MEDI_I, Glyph.MEDI_E, Glyph.FINA_NA]),
        
        // Reflexive+Accusative
        // YUGAN
        ScalarString([Uni.YA, Uni.U, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_YA, Glyph.MEDI_U, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        // YUEGEN
        ScalarString([Uni.YA, Uni.UE, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_YA, Glyph.MEDI_UE, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        
        // Reflexive+Dative-Locative
        // DAGAN
        ScalarString([Uni.DA, Uni.A, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_A, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        // DEGEN
        ScalarString([Uni.DA, Uni.E, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_DA_FVS1, Glyph.MEDI_E, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        // TAGAN
        ScalarString([Uni.TA, Uni.A, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_A, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        // TEGEN
        ScalarString([Uni.TA, Uni.E, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_E, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        
        // Reflexive+Ablative
        // ACHAGAN
        ScalarString([Uni.A, Uni.CHA, Uni.A, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_A_FVS1, Glyph.MEDI_CHA, Glyph.MEDI_A, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        // ECHEGEN
        ScalarString([Uni.E, Uni.CHA, Uni.E, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_E, Glyph.MEDI_CHA, Glyph.MEDI_E, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        
        // Reflexive+Comitative
        // TAIGAN
        ScalarString([Uni.TA, Uni.A, Uni.I, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_A, Glyph.MEDI_I_FVS3, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        ScalarString([Uni.TA, Uni.A, Uni.YA, Uni.I, Uni.GA, Uni.A, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_A, Glyph.MEDI_I_FVS3, Glyph.MEDI_GA_FVS1, Glyph.MEDI_A, Glyph.FINA_NA]),
        // TEIGEN
        ScalarString([Uni.TA, Uni.E, Uni.I, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_E, Glyph.MEDI_I_FVS3, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        ScalarString([Uni.TA, Uni.E, Uni.YA, Uni.I, Uni.GA, Uni.E, Uni.NA]) : ScalarString([Glyph.INIT_TA, Glyph.MEDI_E, Glyph.MEDI_I_FVS3, Glyph.MEDI_GA_MEDI_E, Glyph.FINA_NA]),
        
        // Plural
        // UD
        ScalarString([Uni.U, Uni.DA]) : ScalarString([Glyph.INIT_U_FVS1, Glyph.FINA_DA]),
        // UED
        ScalarString([Uni.UE, Uni.DA]) : ScalarString([Glyph.INIT_UE_FVS1, Glyph.FINA_DA]),
        // NUGUD
        ScalarString([Uni.NA, Uni.U, Uni.GA, Uni.U, Uni.DA]) : ScalarString([Glyph.INIT_NA, Glyph.MEDI_U, Glyph.MEDI_GA_FVS1, Glyph.MEDI_U, Glyph.FINA_DA]),
        // NUEGUED
        ScalarString([Uni.NA, Uni.UE, Uni.GA, Uni.UE, Uni.DA]) : ScalarString([Glyph.INIT_NA, Glyph.MEDI_UE, Glyph.MEDI_GA_MEDI_UE, Glyph.FINA_DA]),
        // NAR
        ScalarString([Uni.NA, Uni.A, Uni.RA]) : ScalarString([Glyph.INIT_NA, Glyph.MEDI_A, Glyph.FINA_RA]),
        // NER
        ScalarString([Uni.NA, Uni.E, Uni.RA]) : ScalarString([Glyph.INIT_NA, Glyph.MEDI_E, Glyph.FINA_RA]),
        
        // Question partical
        // UU
        ScalarString([Uni.U, Uni.U]) : ScalarString([Glyph.WORD_UU]),
        // UEUE
        ScalarString([Uni.UE, Uni.UE]) : ScalarString([Glyph.WORD_UU])
    ]
    
    // MARK: unicodeToGlyphs
    
    func unicodeToGlyphs(unicodeString: String) -> String {
        
        let inputString: ScalarString = ScalarString(unicodeString)
        var outputString: ScalarString = ScalarString()
        var subString: ScalarString = ScalarString()
        
        if inputString.isEmpty {
            return ""
        }
        
        // Loop through characters in string
        //let charArray = [Character](inputString)
        var isMongolSubString: Bool = isMongolian(inputString.startsWith()!)
        for scalar in inputString {
            
            if isMongolian(scalar) || scalar == Uni.NNBS || scalar == Glyph.CURSOR_HOLDER {
                
                // TODO make the same changes in Android here
                if !isMongolSubString {
                    
                    outputString.append(subString)
                    subString.clear()
                    
                }
                
                subString.append(scalar)
                isMongolSubString = true
                
            } else { // non-Mongol character
                
                if (isMongolSubString) {
                    // break up word from suffixes
                    let parts = subString.split(atChar: Uni.NNBS)
                    
                    for (var j = 0; j < parts.count; j++) {
                        
                        if (j == 0) { // this is the main word
                            
                            // Convert mongol word to glyphs and add to output string
                            outputString.append(convertWord(parts[j]))
                            
                        } else { // these are the suffixes
                            // remove cursor holder character
                            let tempSuffix = parts[j].removingAllInstancesOfChar(Glyph.CURSOR_HOLDER)
                            outputString.append(Uni.NNBS)
                            
                            if let renderedSuffix = MongolUnicodeRenderer.suffixDictionary[tempSuffix] {
                                
                                outputString.append(renderedSuffix)
                                if parts[j].contains(Glyph.CURSOR_HOLDER) {
                                    outputString.append(Glyph.CURSOR_HOLDER)
                                }
                                
                            } else {
                                outputString.append(convertWord(parts[j]))
                            }
                        }
                    }
                    
                    // reset substring
                    subString.set("")
                    subString.append(scalar)
                    
                } else {
                    // Add nonMongol char to string
                    subString.append(scalar)
                }
                isMongolSubString = false
            }
        }
        
        // Add any final substring
        if !subString.isEmpty {
            
            if (isMongolSubString) {
                // TODO this is not DRY code - see above
                // break up word from suffixes
                let parts = subString.split(atChar: Uni.NNBS)
                
                for (var j = 0; j < parts.count; j++) {
                    
                    if (j == 0) { // this is the main word
                        
                        // Convert mongol word to glyphs and add to output string
                        outputString.append(convertWord(parts[j]))
                        
                    } else { // these are the suffixes
                        // remove cursor holder character
                        let tempSuffix = parts[j].removingAllInstancesOfChar(Glyph.CURSOR_HOLDER)
                        outputString.append(Uni.NNBS)
                        
                        if let renderedSuffix = MongolUnicodeRenderer.suffixDictionary[tempSuffix] {
                            
                            outputString.append(renderedSuffix)
                            if parts[j].contains(Glyph.CURSOR_HOLDER) {
                                outputString.append(Glyph.CURSOR_HOLDER)
                            }
                            
                        } else {
                            outputString.append(convertWord(parts[j]))
                        }
                    }
                }
                
            } else {
                // Add nonMongol chars to string
                outputString.append(subString)
            }
        }
        
        return outputString.toString()
    }
    
    
    private func convertWord(mongolWord: ScalarString) -> ScalarString {
        
        // Error checking
        if mongolWord.length == 0 {
            return mongolWord
        }
        
        let MAXIMUM_SEARCH_LENGTH = 4 // max length in Dictionary is 4(?).
        var formattedMongolWord = ScalarString()
        var returnString = ScalarString()
        
        // Check if cursor holder is present
        let startsWithCursorHolder = mongolWord.startsWith() ==  Glyph.CURSOR_HOLDER
        let endsWithCursorHolder = mongolWord.endsWith() ==  Glyph.CURSOR_HOLDER
        if startsWithCursorHolder && mongolWord.length == 1 { // input is the cursor itself
            return mongolWord
        } else if (startsWithCursorHolder) {
            formattedMongolWord = mongolWord.substring(1)
        } else if (endsWithCursorHolder) {
            formattedMongolWord = mongolWord.substring(0, mongolWord.length - 1)
        } else {
            formattedMongolWord = mongolWord
        }
        
        // apply rules
        formattedMongolWord = preFormatter(formattedMongolWord)
        
        // Check whole word in isolate table
        if formattedMongolWord.length <= MAXIMUM_SEARCH_LENGTH {
            if let value = MongolUnicodeRenderer.isolateDictionary[formattedMongolWord] {
                
                returnString.append(value)
                
                if (startsWithCursorHolder) {
                    returnString.insert(Glyph.CURSOR_HOLDER, atIndex: 0)
                } else if (endsWithCursorHolder) {
                    returnString.append(Glyph.CURSOR_HOLDER)
                }
                
                return returnString
            }
        }
        
        // initialize variables
        var initialEndIndex = 0
        var finalStartIndex = 0
        var medialStartIndex = 0
        var medialEndIndex = 0
        
        // Find longest matching initial (search long to short) TODO is this slow?
        var subString = ScalarString()
        var match = ScalarString()
        var start: Int
        if formattedMongolWord.length > MAXIMUM_SEARCH_LENGTH {
            start = MAXIMUM_SEARCH_LENGTH
        } else {
            start = formattedMongolWord.length - 1
        }
        for (var i = start; i > 0; i--) {
            subString = formattedMongolWord.substring(0, i)
            if let value = MongolUnicodeRenderer.initialDictionary[subString] {
                match = value
                initialEndIndex = i
                break
            }
        }
        
        if startsWithCursorHolder {
            returnString.append(Glyph.CURSOR_HOLDER)
        }
        returnString.append(match)
        
        // Find longest matching final (search long to short) TODO is this slow?
        var finalGlyph = ScalarString()
        if formattedMongolWord.length > MAXIMUM_SEARCH_LENGTH + initialEndIndex {
            start = formattedMongolWord.length - MAXIMUM_SEARCH_LENGTH
        } else {
            start = initialEndIndex
        }
        for (var i = start; i < formattedMongolWord.length; i++) {
            subString = formattedMongolWord.substring(i) // TODO do this in Android too
            if let value = MongolUnicodeRenderer.finalDictionary[subString] {
                finalGlyph = value
                finalStartIndex = i
                break
            }
        }
        
        // Find string of medials (search long to short) TODO is this slow?
        match.clear()
        medialStartIndex = initialEndIndex
        medialEndIndex = finalStartIndex // substring endindex is exclusive
        var matchFound = false
        while (medialStartIndex < finalStartIndex) {
            
            if (medialStartIndex + MAXIMUM_SEARCH_LENGTH < medialEndIndex) {
                start = medialStartIndex + MAXIMUM_SEARCH_LENGTH
            } else {
                start = medialEndIndex
            }
            for (var i = start; i > medialStartIndex; i--) {
                subString = formattedMongolWord.substring(medialStartIndex, i)
                if let value = MongolUnicodeRenderer.medialDictionary[subString] {
                    match = value
                    medialStartIndex = i
                    matchFound = true
                    break
                }
            }
            if (!matchFound) {
                // println("medial not found")
                break
            }
            returnString.append(match)
            match.clear()
        }
        
        // Return [ini + med + fin]
        returnString.append(finalGlyph)
        if (endsWithCursorHolder) {
            returnString.append(Glyph.CURSOR_HOLDER)
        }
        return returnString
        
    }
    
    // MARK: Formatting rules
    
    func preFormatter(mongolWord: ScalarString) -> ScalarString {
        
        // This method applies context based formatting rules by adding the appropriate FVS character
        // TODO This method is slow because every rule has to loop through the word. However, this was intentional in order to separate the rules for easier debugging
        
        
        var word = ScalarString()
        word.append(mongolWord)
        
        // MVS rule (only formats A/E after the MVS)
        // Consonant before is formatted by lookup table
        // If A/E is not final then ignore MVS (mingg-a -> minggan)
        for (var i = word.length - 2; i >= 0; i--) {
            if (word.charAt(i) == Uni.MVS) {
                // following char is a vowel
                if (i == word.length - 2
                    && (word.charAt(i + 1) == Uni.A || word.charAt(i + 1) == Uni.E)) {
                        // insert FVS2 (this is the lower form of FVS1)
                        word.insert(Uni.FVS2, atIndex: i + 2)
                } else if (i == word.length - 2 && (word.charAt(i + 1) == Uni.ZWJ)) {
                    // This will still allow consonant to display correctly
                } else { // following letter is not final A/E or ZWJ
                    // ignore MVS
                    word.removeCharAt(i)
                }
            }
        }
        
        // Only allow the NG/B/P/F/K/KH and G/Q ligature if A/O/U or MVS follows
        for (var i = word.length - 3; i >= 0; i--) {
            // this char is NG/B/P/F/K/KH
            if (word.charAt(i) == Uni.ANG || word.charAt(i) == Uni.BA || word.charAt(i) == Uni.PA || word.charAt(i) == Uni.FA || word.charAt(i) == Uni.KA || word.charAt(i) == Uni.KHA) {
                // following char is Q/G
                if (word.charAt(i + 1) == Uni.QA || word.charAt(i + 1) == Uni.GA) {
                    // following char is not A/O/U or MVS (MVS allows NG+G/Q ligature)
                    if (!isMasculineVowel(word.charAt(i + 2)) && word.charAt(i + 2) != Uni.MVS) {
                        // insert ZWJ to prevent ligature between NG/B/P/F/K/KH and G/Q
                        word.insert(Uni.ZWJ, atIndex: i + 1)
                    }
                }
            }
        }
        
        // *** OE/UE long tooth in first syllable for non ligatures rule ***
        // (long tooth ligatures are handled by the hash tables)
        if (word.length > 2) {
            // second char is OE or UE
            if (word.charAt(1) == Uni.OE || word.charAt(1) == Uni.UE) {
                // first char not a vowel or ligature consonant (B/P/Q/G/F/K/KH)
                if (!isVowel(word.charAt(0)) && word.charAt(0) != Uni.BA && word.charAt(0) != Uni.PA && word.charAt(0) != Uni.QA && word.charAt(0) != Uni.GA && word.charAt(0) != Uni.FA && word.charAt(0) != Uni.KA && word.charAt(0) != Uni.KHA) {
                    if (!isFVS(word.charAt(2))) {
                        // insert FVS1 after OE/UE
                        word.insert(Uni.FVS1, atIndex: 2)
                    }
                }
                // second char is FVS and third char is OE or UE
            } else if (isFVS(word.charAt(1)) && word.length > 3 && (word.charAt(2) == Uni.OE || word.charAt(2) == Uni.UE)) {
                // first char not a vowel or ligature consonant (B/P/Q/G/F/K/KH)
                if (!isVowel(word.charAt(0)) && word.charAt(0) != Uni.BA && word.charAt(0) != Uni.PA && word.charAt(0) != Uni.QA && word.charAt(0) != Uni.GA && word.charAt(0) != Uni.FA && word.charAt(0) != Uni.KA && word.charAt(0) != Uni.KHA) {
                    if (!isFVS(word.charAt(3))) {
                        // insert FVS1 after OE/UE
                        word.insert(Uni.FVS1, atIndex: 3)
                    }
                }
            }
        }
        
        // *** medial N rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == Uni.NA) {
                // following char is a vowel
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1
                    word.insert(Uni.FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** medial D rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == Uni.DA) {
                // following char is a vowel
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1
                    word.insert(Uni.FVS1, atIndex: i + 1)
                }
            }
        }
        
        // GA rules
        if (word.charAt(0) == Uni.GA) {
            
            // Initial GA
            if (word.length > 1 && isConsonant(word.charAt(1))) {
                // *** Initial GA before consonant rule ***
                // make it a feminine initial GA
                word.insert(Uni.FVS2, atIndex: 1)
            }
        }
        for (var i = word.length - 1; i > 0; i--) {
            if (word.charAt(i) == Uni.GA) {
                
                // final GA
                var isMasculineWord = false
                if (i == word.length - 1) {
                    
                    // **** feminine final GA rule ****
                    for (var j = i - 1; j >= 0; j--) {
                        // vowel I also defaults to feminine
                        if (isMasculineVowel(word.charAt(j))) {
                            isMasculineWord = true
                            break
                        }
                    }
                    if (!isMasculineWord) {
                        // make it a feminine final GA
                        word.insert(Uni.FVS2, atIndex: i + 1)
                    }
                    
                } else { // medial GA
                    
                    // **** dotted medial masculine GA rule ****
                    if (isMasculineVowel(word.charAt(i + 1))) {
                        // add the dots
                        word.insert(Uni.FVS1, atIndex: i + 1)
                        
                        // **** feminine medial GA rule ****
                    } else if (isConsonant(word.charAt(i + 1))) {
                        var isFeminineWord = false
                        isMasculineWord = false
                        
                        
                        if (isConsonant(word.charAt(i - 1)) || word.charAt(i - 1) == Uni.ZWJ) {
                            // This means we have consonant+GA+consonant (ex. ANGGLI)
                            // Although the whole word may not actually be feminine, still use the feminine medial GA
                            isFeminineWord = true
                        }else{
                            // check before GA for gender of vowel
                            for (var j = i - 1; j >= 0; j--) {
                                if (isFeminineVowel(word.charAt(j))) {
                                    isFeminineWord = true
                                    break
                                } else if (isMasculineVowel(word.charAt(j))) {
                                    isMasculineWord = true
                                    break
                                }
                            }
                        }
                        
                        
                        if (isFeminineWord) {
                            // make it a feminine medial GA
                            word.insert(Uni.FVS3, atIndex: i + 1)
                        } else if (!isMasculineWord) {
                            
                            // couldn't be determined by looking before
                            // so check after GA for no masculine vowel
                            isMasculineWord = false
                            for (var j = i + 1; j < word.length; j++) {
                                // vowel I also defaults to feminine
                                if (isMasculineVowel(word.charAt(j))) {
                                    isMasculineWord = true
                                    break
                                }
                            }
                            if (!isMasculineWord) {
                                // make it a feminine medial GA, Thus, I defaults to feminine GA
                                word.insert(Uni.FVS3, atIndex: i + 1)
                            }
                        }
                    }
                }
                
            }
        } // End of GA rules
        
        // *** medial Y rule ***
        // upturn the Y before any vowel except I (when YI follows vowel)
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == Uni.YA) {
                let nextChar = word.charAt(i + 1)
                let prevChar = word.charAt(i - 1)
                // following char is a vowel besides I (or previous char is consonant)
                if ((isVowel(nextChar) && nextChar != Uni.I) || (!isVowel(prevChar)) && !isFVS(nextChar) && nextChar != Uni.MVS) {
                    // insert FVS1 (hooked Y)
                    word.insert(Uni.FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** medial W rule ***
        // Use the hooked W before any vowel
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == Uni.WA) {
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1 (hooked W)
                    word.insert(Uni.FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** AI, EI, OI, UI medial I diphthong rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == Uni.I) {
                // previous char is a masculine vowel or E and next char is not FVS
                if ((isMasculineVowel(word.charAt(i - 1)) || word.charAt(i - 1) == Uni.E)
                    && !isFVS(word.charAt(i + 1))) {
                        // insert FVS3 (double tooth medial I)
                        word.insert(Uni.FVS3, atIndex: i + 1)
                }
            }
        }
        
        return word
    }
    
    // MARK: Boolean methods
    
    func isVowel(character: UInt32) -> Bool {
        return character >= Uni.A && character <= Uni.EE
    }
    
    func isMasculineVowel(character: UInt32) -> Bool {
        return (character == Uni.A || character == Uni.O || character == Uni.U)
    }
    
    func isFeminineVowel(character: UInt32) -> Bool {
        return (character == Uni.E || character == Uni.EE || character == Uni.OE || character == Uni.UE)
    }
    
    func isConsonant(character: UInt32) -> Bool {
        return (character >= Uni.NA && character <= Uni.CHI)
    }
    
    func isFVS(character: UInt32) -> Bool {
        return (character >= Uni.FVS1 && character <= Uni.FVS3)
    }
    
    func isMongolian(character: UInt32) -> Bool {
        // Mongolian letters, MVS, FVS1-3, NIRUGU, ZWJ, (but not NNBS)
        return ((character >= Uni.A && character <= Uni.CHI) || (character >= Uni.MONGOLIAN_NIRUGU && character <= Uni.MVS) || character == Uni.ZWJ)
    }
    
    func isBGDRS(character: UInt32) -> Bool {
        // This method is not used internally, only for external use.
        return (character == Uni.BA || character == Uni.GA || character == Uni.DA
            || character == Uni.RA || character == Uni.SA)
    }
    
    func isMongolianAlphabet(character: UInt32) -> Bool {
        // This method is not used internally, only for external use.
        return (character >= Uni.A && character <= Uni.CHI)
    }
    
    func isMongolianGlyphAlphabet(character: UInt32) -> Bool {
        return (character >= Glyph.ISOL_A && character <= Glyph.INIT_KHA_MEDI_UE_FVS1)
    }
    
    func isMasculineWord(word: ScalarString) -> Bool {
        // This method is not used internally, only for external use.
        if (word.isEmpty) {
            return false
        }
        
        for (var i = word.length - 1; i >= 0; i--) {
            if (word.charAt(i) == Uni.A || word.charAt(i) == Uni.O || word.charAt(i) == Uni.U) {
                return true
            }
        }
        return false
    }
    
    func isFeminineWord(word: ScalarString) -> Bool {
        // This method is not used internally, only for external use.
        if (word.isEmpty) {
            return false
        }
        
        for (var i = word.length - 1; i >= 0; i--) {
            if (word.charAt(i) == Uni.E || word.charAt(i) == Uni.OE || word.charAt(i) == Uni.UE
                || word.charAt(i) == Uni.EE) {
                    return true
            }
        }
        return false
    }
    
    
}
