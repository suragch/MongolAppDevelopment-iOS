/*
* Chimee Mongol Unicode Rendering Engine
* Version 1.0 (port of Java version 2.1.7)
*
* Current version needs to be used with Almas font glyphs
* copied to PUA starting at \uE360. To use different glyph
* encodings, adjust the GLYPH_* static final constants below.
* These PUA encodings are only to be used internally for glyph
* selection. All external text should use Unicode.
*/

import Foundation

class TempRenderer {
    
    
    // static final constants are declared at end of class for readability
    
    // private class variables
    var isolateDictionary = [ScalarString: ScalarString]() // <Unicode, glyph>
    var initialDictionary = [ScalarString: ScalarString]() // <Unicode, glyph>
    var medialDictionary = [ScalarString: ScalarString]() // <Unicode, glyph>
    var finalDictionary = [ScalarString: ScalarString]() // <Unicode, glyph>
    var suffixDictionary = [ScalarString: ScalarString]() // <Unicode, complete_suffix_glyph_string>
    
    
    
    enum Location {
        case ISOLATE, INITIAL, MEDIAL, FINAL, NOT_MONGOLIAN
    }
    
    // Class constants
    let EMPTY_STRING = ScalarString()
    let ZWJ: UInt32 = 0x200d // Zero-width joiner
    let NNBS: UInt32 = 0x202F // Narrow No-Break Space
    // Unicode Mongolian Values
    let MONGOLIAN_BIRGA: UInt32 = 0x1800
    let MONGOLIAN_ELLIPSIS: UInt32 = 0x1801
    let MONGOLIAN_COMMA: UInt32 = 0x1802
    let MONGOLIAN_FULL_STOP: UInt32 = 0x1803
    let MONGOLIAN_COLON: UInt32 = 0x1804
    let MONGOLIAN_FOUR_DOTS: UInt32 = 0x1805
    let MONGOLIAN_NIRUGU: UInt32 = 0x180a
    let FVS1: UInt32 = 0x180b
    let FVS2: UInt32 = 0x180c
    let FVS3: UInt32 = 0x180d
    let MVS: UInt32 = 0x180e // MONGOLIAN_VOWEL_SEPARATOR
    let MONGOLIAN_DIGIT_ZERO: UInt32 = 0x1810
    let MONGOLIAN_DIGIT_ONE: UInt32 = 0x1811
    let MONGOLIAN_DIGIT_TWO: UInt32 = 0x1812
    let MONGOLIAN_DIGIT_THREE: UInt32 = 0x1813
    let MONGOLIAN_DIGIT_FOUR: UInt32 = 0x1814
    let MONGOLIAN_DIGIT_FIVE: UInt32 = 0x1815
    let MONGOLIAN_DIGIT_SIX: UInt32 = 0x1816
    let MONGOLIAN_DIGIT_SEVEN: UInt32 = 0x1817
    let MONGOLIAN_DIGIT_EIGHT: UInt32 = 0x1818
    let MONGOLIAN_DIGIT_NINE: UInt32 = 0x1819
    let UNI_A: UInt32 = 0x1820 // MONGOLIAN_LETTER_xx
    let UNI_E: UInt32 = 0x1821
    let UNI_I: UInt32 = 0x1822
    let UNI_O: UInt32 = 0x1823
    let UNI_U: UInt32 = 0x1824
    let UNI_OE: UInt32 = 0x1825
    let UNI_UE: UInt32 = 0x1826
    let UNI_EE: UInt32 = 0x1827
    let UNI_NA: UInt32 = 0x1828
    let UNI_ANG: UInt32 = 0x1829
    let UNI_BA: UInt32 = 0x182A
    let UNI_PA: UInt32 = 0x182B
    let UNI_QA: UInt32 = 0x182C
    let UNI_GA: UInt32 = 0x182D
    let UNI_MA: UInt32 = 0x182E
    let UNI_LA: UInt32 = 0x182F
    let UNI_SA: UInt32 = 0x1830
    let UNI_SHA: UInt32 = 0x1831
    let UNI_TA: UInt32 = 0x1832
    let UNI_DA: UInt32 = 0x1833
    let UNI_CHA: UInt32 = 0x1834
    let UNI_JA: UInt32 = 0x1835
    let UNI_YA: UInt32 = 0x1836
    let UNI_RA: UInt32 = 0x1837
    let UNI_WA: UInt32 = 0x1838
    let UNI_FA: UInt32 = 0x1839
    let UNI_KA: UInt32 = 0x183A
    let UNI_KHA: UInt32 = 0x183B
    let UNI_TSA: UInt32 = 0x183C
    let UNI_ZA: UInt32 = 0x183D
    let UNI_HAA: UInt32 = 0x183E
    let UNI_ZRA: UInt32 = 0x183F
    let UNI_LHA: UInt32 = 0x1840
    let UNI_ZHI: UInt32 = 0x1841
    let UNI_CHI: UInt32 = 0x1842
    
    // Private Use Area glyph values
    // let CURSOR_HOLDER: UInt32 = 0xE359 // arbitrary unused char
    let CURSOR_HOLDER: UInt32 = UInt32("|")
    
    private let GLYPH_NOTDEF: UInt32 = 0xE360
    private let GLYPH_BIRGA: UInt32 = 0xE364
    private let GLYPH_ELLIPSIS: UInt32 = 0xE365
    private let GLYPH_COMMA: UInt32 = 0xE366
    private let GLYPH_FULL_STOP: UInt32 = 0xE367
    private let GLYPH_COLON: UInt32 = 0xE368
    private let GLYPH_FOUR_DOTS: UInt32 = 0xE369
    private let GLYPH_NIRUGU: UInt32 = 0xE36E
    private let GLYPH_ZERO: UInt32 = 0xE374
    private let GLYPH_ONE: UInt32 = 0xE375
    private let GLYPH_TWO: UInt32 = 0xE376
    private let GLYPH_THREE: UInt32 = 0xE377
    private let GLYPH_FOUR: UInt32 = 0xE378
    private let GLYPH_FIVE: UInt32 = 0xE379
    private let GLYPH_SIX: UInt32 = 0xE37A
    private let GLYPH_SEVEN: UInt32 = 0xE37B
    private let GLYPH_EIGHT: UInt32 = 0xE37C
    private let GLYPH_NINE: UInt32 = 0xE37D
    private let GLYPH_QUESTION_EXCLAMATION: UInt32 = 0xE37E
    private let GLYPH_EXCLAMATION_QUESTION: UInt32 = 0xE37F
    private let GLYPH_ISOL_A: UInt32 = 0xE384
    private let GLYPH_ISOL_A_FVS1: UInt32 = 0xE385
    private let GLYPH_INIT_A: UInt32 = 0xE386
    private let GLYPH_MEDI_A: UInt32 = 0xE387
    private let GLYPH_MEDI_A_FVS1: UInt32 = 0xE388
    private let GLYPH_FINA_A: UInt32 = 0xE389
    private let GLYPH_FINA_A_FVS1: UInt32 = 0xE38A
    private let GLYPH_FINA_A_FVS2: UInt32 = 0xE38B
    private let GLYPH_ISOL_E: UInt32 = 0xE38C
    private let GLYPH_ISOL_E_FVS1: UInt32 = 0xE38D
    private let GLYPH_INIT_E: UInt32 = 0xE38E
    private let GLYPH_INIT_E_FVS1: UInt32 = 0xE38F
    private let GLYPH_MEDI_E: UInt32 = 0xE390
    private let GLYPH_FINA_E: UInt32 = 0xE391
    private let GLYPH_FINA_E_FVS1: UInt32 = 0xE392
    private let GLYPH_FINA_E_FVS2: UInt32 = 0xE393
    private let GLYPH_ISOL_I: UInt32 = 0xE394
    private let GLYPH_ISOL_I_FVS1: UInt32 = 0xE395
    private let GLYPH_INIT_I: UInt32 = 0xE396
    private let GLYPH_INIT_I_FVS1: UInt32 = 0xE397
    private let GLYPH_MEDI_I: UInt32 = 0xE398
    private let GLYPH_MEDI_I_FVS1: UInt32 = 0xE399
    // TODO GLYPH_MEDI_I_FVS2 and GLYPH_MEDI_I_FVS3 have not been standardized in Unicode yet
    // Matching them to Baiti
    private let GLYPH_MEDI_I_FVS3: UInt32 = 0xE39A
    private let GLYPH_FINA_I: UInt32 = 0xE39B
    private let GLYPH_ISOL_O: UInt32 = 0xE39C
    private let GLYPH_ISOL_O_FVS1: UInt32 = 0xE39D
    private let GLYPH_INIT_O: UInt32 = 0xE39E
    private let GLYPH_INIT_O_FVS1: UInt32 = 0xE39F
    private let GLYPH_MEDI_O: UInt32 = 0xE3A0
    private let GLYPH_MEDI_O_FVS1: UInt32 = 0xE3A1
    private let GLYPH_FINA_O: UInt32 = 0xE3A2
    private let GLYPH_FINA_O_FVS1: UInt32 = 0xE3A3
    private let GLYPH_ISOL_U: UInt32 = 0xE3A6  // Using Init U gliph
    private let GLYPH_ISOL_U_FVS1: UInt32 = 0xE3A4
    private let GLYPH_ISOL_U_FVS2: UInt32 = 0xE3A5
    private let GLYPH_INIT_U: UInt32 = 0xE3A6
    private let GLYPH_INIT_U_FVS1: UInt32 = 0xE3A7
    private let GLYPH_MEDI_U: UInt32 = 0xE3A8
    private let GLYPH_MEDI_U_FVS1: UInt32 = 0xE3A9
    private let GLYPH_FINA_U: UInt32 = 0xE3AA
    private let GLYPH_FINA_U_FVS1: UInt32 = 0xE3AB
    private let GLYPH_ISOL_OE: UInt32 = 0xE3AC
    private let GLYPH_ISOL_OE_FVS1: UInt32 = 0xE3AD
    private let GLYPH_INIT_OE: UInt32 = 0xE3AE
    private let GLYPH_MEDI_OE: UInt32 = 0xE3AF
    private let GLYPH_MEDI_OE_FVS1: UInt32 = 0xE3B0
    private let GLYPH_MEDI_OE_FVS2: UInt32 = 0xE3B1
    private let GLYPH_FINA_OE: UInt32 = 0xE3B2
    private let GLYPH_FINA_OE_FVS1: UInt32 = 0xE3B3
    private let GLYPH_ISOL_UE: UInt32 = 0xE3B6
    private let GLYPH_ISOL_UE_FVS2: UInt32 = 0xE3C3
    private let GLYPH_ISOL_UE_FVS3: UInt32 = 0xE3B5
    private let GLYPH_INIT_UE: UInt32 = 0xE3B6
    private let GLYPH_MEDI_UE: UInt32 = 0xE3B7
    private let GLYPH_MEDI_UE_FVS1: UInt32 = 0xE3B8
    private let GLYPH_MEDI_UE_FVS2: UInt32 = 0xE3B9
    private let GLYPH_FINA_UE: UInt32 = 0xE3BA
    private let GLYPH_FINA_UE_FVS1: UInt32 = 0xE3BB
    private let GLYPH_ISOL_EE: UInt32 = 0xE3BC
    private let GLYPH_ISOL_EE_FVS1: UInt32 = 0xE3BD
    private let GLYPH_INIT_EE: UInt32 = 0xE3BE
    private let GLYPH_INIT_EE_FVS1: UInt32 = 0xE3BF
    private let GLYPH_MEDI_EE: UInt32 = 0xE3C0
    private let GLYPH_FINA_EE: UInt32 = 0xE3C1
    private let GLYPH_INIT_UE_FVS1: UInt32 = 0xE3C2
    private let GLYPH_ISOL_UE_FVS1: UInt32 = 0xE3B4
    private let GLYPH_ISOL_NA: UInt32 = 0xE3C4
    private let GLYPH_ISOL_NA_FVS1: UInt32 = 0xE3C5
    private let GLYPH_INIT_NA: UInt32 = 0xE3C6
    private let GLYPH_INIT_NA_FVS1: UInt32 = 0xE3C7
    private let GLYPH_MEDI_NA: UInt32 = 0xE3C8
    private let GLYPH_MEDI_NA_FVS1: UInt32 = 0xE3C9
    private let GLYPH_MEDI_NA_FVS2: UInt32 = 0xE3C8 // same as medial na
    private let GLYPH_FINA_NA: UInt32 = 0xE3CA
    private let GLYPH_FINA_NA_FVS1: UInt32 = 0xE3CB
    private let GLYPH_ISOL_ANG: UInt32 = 0xE3CC
    private let GLYPH_INIT_ANG: UInt32 = 0xE3CD
    private let GLYPH_MEDI_ANG: UInt32 = 0xE3CE
    private let GLYPH_FINA_ANG: UInt32 = 0xE3CF
    private let GLYPH_MEDI_ANG_MEDI_QA: UInt32 = 0xE3D0
    private let GLYPH_MEDI_ANG_MEDI_GA: UInt32 = 0xE3D1
    private let GLYPH_MEDI_ANG_MEDI_MA: UInt32 = 0xE3D2
    private let GLYPH_MEDI_ANG_MEDI_LA: UInt32 = 0xE3D3
    private let GLYPH_ISOL_BA: UInt32 = 0xE3D4
    private let GLYPH_INIT_BA: UInt32 = 0xE3D5
    private let GLYPH_MEDI_BA: UInt32 = 0xE3D6
    private let GLYPH_FINA_BA: UInt32 = 0xE3D7
    private let GLYPH_INIT_BA_FINA_A: UInt32 = 0xE3D8
    private let GLYPH_INIT_BA_MEDI_A: UInt32 = 0xE3D9
    private let GLYPH_MEDI_BA_MEDI_A: UInt32 = 0xE3DA
    private let GLYPH_MEDI_BA_FINA_A: UInt32 = 0xE3DB
    private let GLYPH_INIT_BA_FINA_E: UInt32 = 0xE3DC
    private let GLYPH_INIT_BA_MEDI_E: UInt32 = 0xE3DD
    private let GLYPH_MEDI_BA_MEDI_E: UInt32 = 0xE3DE
    private let GLYPH_MEDI_BA_FINA_E: UInt32 = 0xE3DF
    private let GLYPH_INIT_BA_FINA_I: UInt32 = 0xE3E0
    private let GLYPH_INIT_BA_MEDI_I: UInt32 = 0xE3E1
    private let GLYPH_MEDI_BA_MEDI_I: UInt32 = 0xE3E2
    private let GLYPH_MEDI_BA_FINA_I: UInt32 = 0xE3E3
    private let GLYPH_INIT_BA_FINA_O: UInt32 = 0xE3E4
    private let GLYPH_INIT_BA_MEDI_O: UInt32 = 0xE3E5
    private let GLYPH_MEDI_BA_MEDI_O: UInt32 = 0xE3E6
    private let GLYPH_MEDI_BA_FINA_O: UInt32 = 0xE3E7
    private let GLYPH_INIT_BA_FINA_U: UInt32 = 0xE3E8
    private let GLYPH_INIT_BA_MEDI_U: UInt32 = 0xE3E9
    private let GLYPH_MEDI_BA_MEDI_U: UInt32 = 0xE3EA
    private let GLYPH_MEDI_BA_FINA_U: UInt32 = 0xE3EB
    private let GLYPH_INIT_BA_FINA_OE: UInt32 = 0xE3EC
    private let GLYPH_INIT_BA_MEDI_OE: UInt32 = 0xE3ED
    private let GLYPH_MEDI_BA_MEDI_OE: UInt32 = 0xE3EE
    private let GLYPH_MEDI_BA_FINA_OE: UInt32 = 0xE3EF
    private let GLYPH_MEDI_BA_FINA_OE_FVS1: UInt32 = 0xE3F0
    private let GLYPH_INIT_BA_FINA_UE: UInt32 = 0xE3F1
    private let GLYPH_INIT_BA_MEDI_UE: UInt32 = 0xE3F2
    private let GLYPH_MEDI_BA_MEDI_UE: UInt32 = 0xE3F3
    private let GLYPH_MEDI_BA_FINA_UE: UInt32 = 0xE3F4
    private let GLYPH_MEDI_BA_FINA_UE_FVS1: UInt32 = 0xE3F5
    private let GLYPH_INIT_BA_FINA_EE: UInt32 = 0xE3F6
    private let GLYPH_INIT_BA_MEDI_EE: UInt32 = 0xE3F7
    private let GLYPH_MEDI_BA_MEDI_EE: UInt32 = 0xE3F8
    private let GLYPH_MEDI_BA_FINA_EE: UInt32 = 0xE3F9
    private let GLYPH_MEDI_BA_MEDI_MA: UInt32 = 0xE3FA
    private let GLYPH_MEDI_BA_MEDI_LA: UInt32 = 0xE3FB
    private let GLYPH_ISOL_PA: UInt32 = 0xE3FC
    private let GLYPH_INIT_PA: UInt32 = 0xE3FD
    private let GLYPH_MEDI_PA: UInt32 = 0xE3FE
    private let GLYPH_FINA_PA: UInt32 = 0xE3FF
    private let GLYPH_INIT_PA_FINA_A: UInt32 = 0xE400
    private let GLYPH_INIT_PA_MEDI_A: UInt32 = 0xE401
    private let GLYPH_MEDI_PA_MEDI_A: UInt32 = 0xE402
    private let GLYPH_MEDI_PA_FINA_A: UInt32 = 0xE403
    private let GLYPH_INIT_PA_FINA_E: UInt32 = 0xE404
    private let GLYPH_INIT_PA_MEDI_E: UInt32 = 0xE405
    private let GLYPH_MEDI_PA_MEDI_E: UInt32 = 0xE406
    private let GLYPH_MEDI_PA_FINA_E: UInt32 = 0xE407
    private let GLYPH_INIT_PA_FINA_I: UInt32 = 0xE408
    private let GLYPH_INIT_PA_MEDI_I: UInt32 = 0xE409
    private let GLYPH_MEDI_PA_MEDI_I: UInt32 = 0xE40A
    private let GLYPH_MEDI_PA_FINA_I: UInt32 = 0xE40B
    private let GLYPH_INIT_PA_FINA_O: UInt32 = 0xE40C
    private let GLYPH_INIT_PA_MEDI_O: UInt32 = 0xE40D
    private let GLYPH_MEDI_PA_MEDI_O: UInt32 = 0xE40E
    private let GLYPH_MEDI_PA_FINA_O: UInt32 = 0xE40F
    private let GLYPH_INIT_PA_FINA_U: UInt32 = 0xE410
    private let GLYPH_INIT_PA_MEDI_U: UInt32 = 0xE411
    private let GLYPH_MEDI_PA_MEDI_U: UInt32 = 0xE412
    private let GLYPH_MEDI_PA_FINA_U: UInt32 = 0xE413
    private let GLYPH_INIT_PA_FINA_OE: UInt32 = 0xE414
    private let GLYPH_INIT_PA_MEDI_OE: UInt32 = 0xE415
    private let GLYPH_MEDI_PA_MEDI_OE: UInt32 = 0xE416
    private let GLYPH_MEDI_PA_FINA_OE: UInt32 = 0xE417
    private let GLYPH_MEDI_PA_FINA_OE_FVS1: UInt32 = 0xE418
    private let GLYPH_INIT_PA_FINA_UE: UInt32 = 0xE419
    private let GLYPH_INIT_PA_MEDI_UE: UInt32 = 0xE41A
    private let GLYPH_MEDI_PA_MEDI_UE: UInt32 = 0xE41B
    private let GLYPH_MEDI_PA_FINA_UE: UInt32 = 0xE41C
    private let GLYPH_MEDI_PA_FINA_UE_FVS1: UInt32 = 0xE41D
    private let GLYPH_INIT_PA_FINA_EE: UInt32 = 0xE41E
    private let GLYPH_INIT_PA_MEDI_EE: UInt32 = 0xE41F
    private let GLYPH_MEDI_PA_MEDI_EE: UInt32 = 0xE420
    private let GLYPH_MEDI_PA_FINA_EE: UInt32 = 0xE421
    private let GLYPH_MEDI_PA_MEDI_MA: UInt32 = 0xE422
    private let GLYPH_MEDI_PA_MEDI_LA: UInt32 = 0xE423
    private let GLYPH_ISOL_QA: UInt32 = 0xE424
    private let GLYPH_ISOL_QA_FVS3: UInt32 = 0xE425 // TODO matching Baiti
    private let GLYPH_INIT_QA: UInt32 = 0xE426
    private let GLYPH_INIT_QA_FVS1: UInt32 = 0xE427
    private let GLYPH_MEDI_QA: UInt32 = 0xE428
    private let GLYPH_MEDI_QA_FVS1: UInt32 = 0xE429
    private let GLYPH_MEDI_QA_FVS2: UInt32 = 0xE42A
    private let GLYPH_FINA_QA: UInt32 = 0xE42B
    private let GLYPH_FINA_QA_FVS1: UInt32 = 0xE42C
    private let GLYPH_FINA_QA_FVS2: UInt32 = 0xE42D
    private let GLYPH_INIT_QA_FINA_E: UInt32 = 0xE42E
    private let GLYPH_INIT_QA_MEDI_E: UInt32 = 0xE42F
    private let GLYPH_MEDI_QA_MEDI_E: UInt32 = 0xE430
    private let GLYPH_MEDI_QA_FINA_E: UInt32 = 0xE431
    private let GLYPH_INIT_QA_FINA_I: UInt32 = 0xE432
    private let GLYPH_INIT_QA_MEDI_I: UInt32 = 0xE433
    private let GLYPH_MEDI_QA_MEDI_I: UInt32 = 0xE434
    private let GLYPH_MEDI_QA_FINA_I: UInt32 = 0xE435
    private let GLYPH_INIT_QA_FINA_OE: UInt32 = 0xE436
    private let GLYPH_INIT_QA_MEDI_OE: UInt32 = 0xE437
    private let GLYPH_MEDI_QA_MEDI_OE: UInt32 = 0xE438
    private let GLYPH_MEDI_QA_FINA_OE: UInt32 = 0xE439
    private let GLYPH_MEDI_QA_FINA_OE_FVS1: UInt32 = 0xE43A
    private let GLYPH_INIT_QA_FINA_UE: UInt32 = 0xE43B
    private let GLYPH_INIT_QA_MEDI_UE: UInt32 = 0xE43C
    private let GLYPH_MEDI_QA_MEDI_UE: UInt32 = 0xE43D
    private let GLYPH_MEDI_QA_FINA_UE: UInt32 = 0xE43E
    private let GLYPH_MEDI_QA_FINA_UE_FVS1: UInt32 = 0xE43F
    private let GLYPH_INIT_QA_FINA_EE: UInt32 = 0xE440
    private let GLYPH_INIT_QA_MEDI_EE: UInt32 = 0xE441
    private let GLYPH_MEDI_QA_MEDI_EE: UInt32 = 0xE442
    private let GLYPH_MEDI_QA_FINA_EE: UInt32 = 0xE443
    private let GLYPH_ISOL_GA: UInt32 = 0xE444
    private let GLYPH_ISOL_GA_FVS3: UInt32 = 0xE445 // TODO not in Baiti
    private let GLYPH_INIT_GA: UInt32 = 0xE446
    private let GLYPH_INIT_GA_FVS1: UInt32 = 0xE447
    private let GLYPH_MEDI_GA: UInt32 = 0xE448
    private let GLYPH_MEDI_GA_FVS1: UInt32 = 0xE449
    private let GLYPH_MEDI_GA_FVS2: UInt32 = 0xE448 // TODO matching Baiti, not using
    // \uE44A
    private let GLYPH_FINA_GA: UInt32 = 0xE44B
    private let GLYPH_FINA_GA_FVS1: UInt32 = 0xE44B // TODO matching Baiti
    private let GLYPH_FINA_GA_FVS3: UInt32 = 0xE44C // TODO matching Baiti
    private let GLYPH_FINA_GA_FVS2: UInt32 = 0xE44D
    private let GLYPH_INIT_GA_FINA_E: UInt32 = 0xE44E
    private let GLYPH_INIT_GA_MEDI_E: UInt32 = 0xE44F
    private let GLYPH_MEDI_GA_MEDI_E: UInt32 = 0xE450
    private let GLYPH_MEDI_GA_FINA_E: UInt32 = 0xE451
    private let GLYPH_INIT_GA_FINA_I: UInt32 = 0xE452
    private let GLYPH_INIT_GA_MEDI_I: UInt32 = 0xE453
    private let GLYPH_MEDI_GA_MEDI_I: UInt32 = 0xE454
    private let GLYPH_MEDI_GA_FINA_I: UInt32 = 0xE455
    private let GLYPH_INIT_GA_FINA_OE: UInt32 = 0xE456
    private let GLYPH_INIT_GA_MEDI_OE: UInt32 = 0xE457
    private let GLYPH_MEDI_GA_MEDI_OE: UInt32 = 0xE458
    private let GLYPH_MEDI_GA_FINA_OE: UInt32 = 0xE459
    private let GLYPH_MEDI_GA_FINA_OE_FVS1: UInt32 = 0xE45A
    private let GLYPH_INIT_GA_FINA_UE: UInt32 = 0xE45B
    private let GLYPH_INIT_GA_MEDI_UE: UInt32 = 0xE45C
    private let GLYPH_MEDI_GA_MEDI_UE: UInt32 = 0xE45D
    private let GLYPH_MEDI_GA_FINA_UE: UInt32 = 0xE45E
    private let GLYPH_MEDI_GA_FINA_UE_FVS1: UInt32 = 0xE45F
    private let GLYPH_INIT_GA_FINA_EE: UInt32 = 0xE460
    private let GLYPH_INIT_GA_MEDI_EE: UInt32 = 0xE461
    private let GLYPH_MEDI_GA_MEDI_EE: UInt32 = 0xE462
    private let GLYPH_MEDI_GA_FINA_EE: UInt32 = 0xE463
    private let GLYPH_MEDI_GA_MEDI_MA: UInt32 = 0xE464
    private let GLYPH_MEDI_GA_MEDI_LA: UInt32 = 0xE465
    private let GLYPH_ISOL_MA: UInt32 = 0xE466
    private let GLYPH_INIT_MA: UInt32 = 0xE467
    private let GLYPH_MEDI_MA: UInt32 = 0xE468
    private let GLYPH_FINA_MA: UInt32 = 0xE469
    private let GLYPH_ISOL_LA: UInt32 = 0xE46A
    private let GLYPH_INIT_LA: UInt32 = 0xE46B
    private let GLYPH_MEDI_LA: UInt32 = 0xE46C
    private let GLYPH_FINA_LA: UInt32 = 0xE46D
    private let GLYPH_ISOL_SA: UInt32 = 0xE46E
    private let GLYPH_INIT_SA: UInt32 = 0xE46F
    private let GLYPH_MEDI_SA: UInt32 = 0xE470
    private let GLYPH_FINA_SA: UInt32 = 0xE471
    private let GLYPH_ISOL_SHA: UInt32 = 0xE472
    private let GLYPH_INIT_SHA: UInt32 = 0xE473
    private let GLYPH_MEDI_SHA: UInt32 = 0xE474
    private let GLYPH_FINA_SHA: UInt32 = 0xE475
    private let GLYPH_ISOL_TA: UInt32 = 0xE476
    private let GLYPH_ISOL_TA_FVS1: UInt32 = 0xE477
    private let GLYPH_INIT_TA: UInt32 = 0xE478
    private let GLYPH_MEDI_TA: UInt32 = 0xE479
    private let GLYPH_MEDI_TA_FVS1: UInt32 = 0xE47A
    private let GLYPH_MEDI_TA_FVS2: UInt32 = 0xE47B
    private let GLYPH_FINA_TA: UInt32 = 0xE47C
    private let GLYPH_ISOL_DA: UInt32 = 0xE47D
    private let GLYPH_INIT_DA: UInt32 = 0xE47E
    private let GLYPH_INIT_DA_FVS1: UInt32 = 0xE47F
    private let GLYPH_MEDI_DA: UInt32 = 0xE480
    private let GLYPH_MEDI_DA_FVS1: UInt32 = 0xE481
    private let GLYPH_FINA_DA: UInt32 = 0xE482
    private let GLYPH_FINA_DA_FVS1: UInt32 = 0xE483
    private let GLYPH_ISOL_CHA: UInt32 = 0xE484
    private let GLYPH_INIT_CHA: UInt32 = 0xE485
    private let GLYPH_MEDI_CHA: UInt32 = 0xE486
    private let GLYPH_FINA_CHA: UInt32 = 0xE487
    private let GLYPH_ISOL_JA: UInt32 = 0xE488
    private let GLYPH_ISOL_JA_FVS1: UInt32 = 0xE489
    private let GLYPH_INIT_JA: UInt32 = 0xE48A
    private let GLYPH_MEDI_JA: UInt32 = 0xE48B
    private let GLYPH_FINA_JA: UInt32 = 0xE48C
    private let GLYPH_FINA_JA_FVS1: UInt32 = 0xE491 // same as GLYPH_FINA_YA
    private let GLYPH_ISOL_YA: UInt32 = 0xE48D
    private let GLYPH_INIT_YA: UInt32 = 0xE48E
    private let GLYPH_INIT_YA_FVS1: UInt32 = 0xE48F
    private let GLYPH_MEDI_YA: UInt32 = 0xE398 // same as GLYPH_MEDI_I
    private let GLYPH_MEDI_YA_FVS1: UInt32 = 0xE490 // TODO matching Baiti
    private let GLYPH_FINA_YA: UInt32 = 0xE491
    private let GLYPH_ISOL_RA: UInt32 = 0xE492
    private let GLYPH_INIT_RA: UInt32 = 0xE493
    private let GLYPH_MEDI_RA: UInt32 = 0xE494
    private let GLYPH_FINA_RA: UInt32 = 0xE495
    private let GLYPH_ISOL_WA: UInt32 = 0xE496
    private let GLYPH_INIT_WA: UInt32 = 0xE497
    private let GLYPH_WORD_U: UInt32 = 0xE498
    private let GLYPH_MEDI_WA_FVS1: UInt32 = 0xE499 // TODO matching Baiti
    private let GLYPH_FINA_WA_FVS1: UInt32 = 0xE49A // TODO matching Baiti
    private let GLYPH_FINA_WA: UInt32 = 0xE49B // TODO matching Baiti
    private let GLYPH_ISOL_FA: UInt32 = 0xE49C
    private let GLYPH_INIT_FA: UInt32 = 0xE49D
    private let GLYPH_MEDI_FA: UInt32 = 0xE49E
    private let GLYPH_FINA_FA: UInt32 = 0xE49F
    private let GLYPH_INIT_FA_FINA_A: UInt32 = 0xE4A0
    private let GLYPH_INIT_FA_MEDI_A: UInt32 = 0xE4A1
    private let GLYPH_MEDI_FA_MEDI_A: UInt32 = 0xE4A2
    private let GLYPH_MEDI_FA_FINA_A: UInt32 = 0xE4A3
    private let GLYPH_INIT_FA_FINA_E: UInt32 = 0xE4A4
    private let GLYPH_INIT_FA_MEDI_E: UInt32 = 0xE4A5
    private let GLYPH_MEDI_FA_MEDI_E: UInt32 = 0xE4A6
    private let GLYPH_MEDI_FA_FINA_E: UInt32 = 0xE4A7
    private let GLYPH_INIT_FA_FINA_I: UInt32 = 0xE4A8
    private let GLYPH_INIT_FA_MEDI_I: UInt32 = 0xE4A9
    private let GLYPH_MEDI_FA_MEDI_I: UInt32 = 0xE4AA
    private let GLYPH_MEDI_FA_FINA_I: UInt32 = 0xE4AB
    private let GLYPH_INIT_FA_FINA_O: UInt32 = 0xE4AC
    private let GLYPH_INIT_FA_MEDI_O: UInt32 = 0xE4AD
    private let GLYPH_MEDI_FA_MEDI_O: UInt32 = 0xE4AE
    private let GLYPH_MEDI_FA_FINA_O: UInt32 = 0xE4AF
    private let GLYPH_INIT_FA_FINA_U: UInt32 = 0xE4B0
    private let GLYPH_INIT_FA_MEDI_U: UInt32 = 0xE4B1
    private let GLYPH_MEDI_FA_MEDI_U: UInt32 = 0xE4B2
    private let GLYPH_MEDI_FA_FINA_U: UInt32 = 0xE4B3
    private let GLYPH_INIT_FA_FINA_OE: UInt32 = 0xE4B4
    private let GLYPH_INIT_FA_MEDI_OE: UInt32 = 0xE4B5
    private let GLYPH_MEDI_FA_MEDI_OE: UInt32 = 0xE4B6
    private let GLYPH_MEDI_FA_FINA_OE: UInt32 = 0xE4B7
    private let GLYPH_MEDI_FA_FINA_OE_FVS1: UInt32 = 0xE4B8
    private let GLYPH_INIT_FA_FINA_UE: UInt32 = 0xE4B9
    private let GLYPH_INIT_FA_MEDI_UE: UInt32 = 0xE4BA
    private let GLYPH_MEDI_FA_MEDI_UE: UInt32 = 0xE4BB
    private let GLYPH_MEDI_FA_FINA_UE: UInt32 = 0xE4BC
    private let GLYPH_MEDI_FA_FINA_UE_FVS1: UInt32 = 0xE4BD
    private let GLYPH_INIT_FA_FINA_EE: UInt32 = 0xE4BE
    private let GLYPH_INIT_FA_MEDI_EE: UInt32 = 0xE4BF
    private let GLYPH_MEDI_FA_MEDI_EE: UInt32 = 0xE4C0
    private let GLYPH_MEDI_FA_FINA_EE: UInt32 = 0xE4C1
    private let GLYPH_MEDI_FA_MEDI_MA: UInt32 = 0xE4C2
    private let GLYPH_MEDI_FA_MEDI_LA: UInt32 = 0xE4C3
    private let GLYPH_ISOL_KA: UInt32 = 0xE4C4
    private let GLYPH_INIT_KA: UInt32 = 0xE4C5
    private let GLYPH_MEDI_KA: UInt32 = 0xE4C6
    private let GLYPH_FINA_KA: UInt32 = 0xE4C7
    private let GLYPH_INIT_KA_FINA_A: UInt32 = 0xE4C8
    private let GLYPH_INIT_KA_MEDI_A: UInt32 = 0xE4C9
    private let GLYPH_MEDI_KA_MEDI_A: UInt32 = 0xE4CA
    private let GLYPH_MEDI_KA_FINA_A: UInt32 = 0xE4CB
    private let GLYPH_INIT_KA_FINA_E: UInt32 = 0xE4CC
    private let GLYPH_INIT_KA_MEDI_E: UInt32 = 0xE4CD
    private let GLYPH_MEDI_KA_MEDI_E: UInt32 = 0xE4CE
    private let GLYPH_MEDI_KA_FINA_E: UInt32 = 0xE4CF
    private let GLYPH_INIT_KA_FINA_I: UInt32 = 0xE4D0
    private let GLYPH_INIT_KA_MEDI_I: UInt32 = 0xE4D1
    private let GLYPH_MEDI_KA_MEDI_I: UInt32 = 0xE4D2
    private let GLYPH_MEDI_KA_FINA_I: UInt32 = 0xE4D3
    private let GLYPH_INIT_KA_FINA_O: UInt32 = 0xE4D4
    private let GLYPH_INIT_KA_MEDI_O: UInt32 = 0xE4D5
    private let GLYPH_MEDI_KA_MEDI_O: UInt32 = 0xE4D6
    private let GLYPH_MEDI_KA_FINA_O: UInt32 = 0xE4D7
    private let GLYPH_INIT_KA_FINA_U: UInt32 = 0xE4D8
    private let GLYPH_INIT_KA_MEDI_U: UInt32 = 0xE4D9
    private let GLYPH_MEDI_KA_MEDI_U: UInt32 = 0xE4DA
    private let GLYPH_MEDI_KA_FINA_U: UInt32 = 0xE4DB
    private let GLYPH_INIT_KA_FINA_OE: UInt32 = 0xE4DC
    private let GLYPH_INIT_KA_MEDI_OE: UInt32 = 0xE4DD
    private let GLYPH_MEDI_KA_MEDI_OE: UInt32 = 0xE4DE
    private let GLYPH_MEDI_KA_FINA_OE: UInt32 = 0xE4DF
    private let GLYPH_MEDI_KA_FINA_OE_FVS1: UInt32 = 0xE4E0
    private let GLYPH_INIT_KA_FINA_UE: UInt32 = 0xE4E1
    private let GLYPH_INIT_KA_MEDI_UE: UInt32 = 0xE4E2
    private let GLYPH_MEDI_KA_MEDI_UE: UInt32 = 0xE4E3
    private let GLYPH_MEDI_KA_FINA_UE: UInt32 = 0xE4E4
    private let GLYPH_MEDI_KA_FINA_UE_FVS1: UInt32 = 0xE4E5
    private let GLYPH_INIT_KA_FINA_EE: UInt32 = 0xE4E6
    private let GLYPH_INIT_KA_MEDI_EE: UInt32 = 0xE4E7
    private let GLYPH_MEDI_KA_MEDI_EE: UInt32 = 0xE4E8
    private let GLYPH_MEDI_KA_FINA_EE: UInt32 = 0xE4E9
    private let GLYPH_MEDI_KA_MEDI_MA: UInt32 = 0xE4EA
    private let GLYPH_MEDI_KA_MEDI_LA: UInt32 = 0xE4EB
    private let GLYPH_ISOL_KHA: UInt32 = 0xE4EC
    private let GLYPH_INIT_KHA: UInt32 = 0xE4ED
    private let GLYPH_MEDI_KHA: UInt32 = 0xE4EE
    private let GLYPH_FINA_KHA: UInt32 = 0xE4EF
    private let GLYPH_INIT_KHA_FINA_A: UInt32 = 0xE4F0
    private let GLYPH_INIT_KHA_MEDI_A: UInt32 = 0xE4F1
    private let GLYPH_MEDI_KHA_MEDI_A: UInt32 = 0xE4F2
    private let GLYPH_MEDI_KHA_FINA_A: UInt32 = 0xE4F3
    private let GLYPH_INIT_KHA_FINA_E: UInt32 = 0xE4F4
    private let GLYPH_INIT_KHA_MEDI_E: UInt32 = 0xE4F5
    private let GLYPH_MEDI_KHA_MEDI_E: UInt32 = 0xE4F6
    private let GLYPH_MEDI_KHA_FINA_E: UInt32 = 0xE4F7
    private let GLYPH_INIT_KHA_FINA_I: UInt32 = 0xE4F8
    private let GLYPH_INIT_KHA_MEDI_I: UInt32 = 0xE4F9
    private let GLYPH_MEDI_KHA_MEDI_I: UInt32 = 0xE4FA
    private let GLYPH_MEDI_KHA_FINA_I: UInt32 = 0xE4FB
    private let GLYPH_INIT_KHA_FINA_O: UInt32 = 0xE4FC
    private let GLYPH_INIT_KHA_MEDI_O: UInt32 = 0xE4FD
    private let GLYPH_MEDI_KHA_MEDI_O: UInt32 = 0xE4FE
    private let GLYPH_MEDI_KHA_FINA_O: UInt32 = 0xE4FF
    private let GLYPH_INIT_KHA_FINA_U: UInt32 = 0xE500
    private let GLYPH_INIT_KHA_MEDI_U: UInt32 = 0xE501
    private let GLYPH_MEDI_KHA_MEDI_U: UInt32 = 0xE502
    private let GLYPH_MEDI_KHA_FINA_U: UInt32 = 0xE503
    private let GLYPH_INIT_KHA_FINA_OE: UInt32 = 0xE504
    private let GLYPH_INIT_KHA_MEDI_OE: UInt32 = 0xE505
    private let GLYPH_MEDI_KHA_MEDI_OE: UInt32 = 0xE506
    private let GLYPH_MEDI_KHA_FINA_OE: UInt32 = 0xE507
    private let GLYPH_MEDI_KHA_FINA_OE_FVS1: UInt32 = 0xE508
    private let GLYPH_INIT_KHA_FINA_UE: UInt32 = 0xE509
    private let GLYPH_INIT_KHA_MEDI_UE: UInt32 = 0xE50A
    private let GLYPH_MEDI_KHA_MEDI_UE: UInt32 = 0xE50B
    private let GLYPH_MEDI_KHA_FINA_UE: UInt32 = 0xE50C
    private let GLYPH_MEDI_KHA_FINA_UE_FVS1: UInt32 = 0xE50D
    private let GLYPH_INIT_KHA_FINA_EE: UInt32 = 0xE50E
    private let GLYPH_INIT_KHA_MEDI_EE: UInt32 = 0xE50F
    private let GLYPH_MEDI_KHA_MEDI_EE: UInt32 = 0xE510
    private let GLYPH_MEDI_KHA_FINA_EE: UInt32 = 0xE511
    private let GLYPH_MEDI_KHA_MEDI_MA: UInt32 = 0xE512
    private let GLYPH_MEDI_KHA_MEDI_LA: UInt32 = 0xE513
    private let GLYPH_ISOL_TSA: UInt32 = 0xE514
    private let GLYPH_INIT_TSA: UInt32 = 0xE515
    private let GLYPH_MEDI_TSA: UInt32 = 0xE516
    private let GLYPH_FINA_TSA: UInt32 = 0xE517
    private let GLYPH_ISOL_ZA: UInt32 = 0xE518
    private let GLYPH_INIT_ZA: UInt32 = 0xE519
    private let GLYPH_MEDI_ZA: UInt32 = 0xE51A
    private let GLYPH_FINA_ZA: UInt32 = 0xE51B
    private let GLYPH_ISOL_HAA: UInt32 = 0xE51C
    private let GLYPH_INIT_HAA: UInt32 = 0xE51D
    private let GLYPH_MEDI_HAA: UInt32 = 0xE51E
    private let GLYPH_FINA_HAA: UInt32 = 0xE51F
    private let GLYPH_ISOL_ZRA: UInt32 = 0xE520
    private let GLYPH_INIT_ZRA: UInt32 = 0xE521
    private let GLYPH_MEDI_ZRA: UInt32 = 0xE522
    private let GLYPH_FINA_ZRA: UInt32 = 0xE523
    private let GLYPH_ISOL_LHA: UInt32 = 0xE524
    private let GLYPH_INIT_LHA: UInt32 = 0xE525
    private let GLYPH_MEDI_LHA: UInt32 = 0xE526
    private let GLYPH_FINA_LHA: UInt32 = 0xE527
    private let GLYPH_ISOL_ZHI: UInt32 = 0xE528
    private let GLYPH_INIT_ZHI: UInt32 = 0xE529
    private let GLYPH_MEDI_ZHI: UInt32 = 0xE52A
    private let GLYPH_FINA_ZHI: UInt32 = 0xE52B
    private let GLYPH_ISOL_CHI: UInt32 = 0xE52C
    private let GLYPH_INIT_CHI: UInt32 = 0xE52D
    private let GLYPH_MEDI_CHI: UInt32 = 0xE52E
    private let GLYPH_FINA_CHI: UInt32 = 0xE52F
    private let GLYPH_FINA_SA_FVS1: UInt32 = 0xE530
    private let GLYPH_FINA_SA_FVS2: UInt32 = 0xE531
    private let GLYPH_FINA_BA_FVS1: UInt32 = 0xE532
    private let GLYPH_WORD_UU: UInt32 = 0xE533
    private let GLYPH_WORD_BUU: UInt32 = 0xE534
    private let GLYPH_MEDI_BA_MEDI_OE_FVS1: UInt32 = 0xE535
    private let GLYPH_MEDI_BA_MEDI_UE_FVS1: UInt32 = 0xE536
    private let GLYPH_MEDI_PA_MEDI_OE_FVS1: UInt32 = 0xE537
    private let GLYPH_MEDI_PA_MEDI_UE_FVS1: UInt32 = 0xE538
    private let GLYPH_MEDI_QA_MEDI_OE_FVS1: UInt32 = 0xE539
    private let GLYPH_MEDI_QA_MEDI_UE_FVS1: UInt32 = 0xE53A
    private let GLYPH_MEDI_GA_MEDI_OE_FVS1: UInt32 = 0xE53B
    private let GLYPH_MEDI_GA_MEDI_UE_FVS1: UInt32 = 0xE53C
    private let GLYPH_MEDI_FA_MEDI_OE_FVS1: UInt32 = 0xE53D
    private let GLYPH_MEDI_FA_MEDI_UE_FVS1: UInt32 = 0xE53E
    private let GLYPH_MEDI_KA_MEDI_OE_FVS1: UInt32 = 0xE53F
    private let GLYPH_MEDI_KA_MEDI_UE_FVS1: UInt32 = 0xE540
    private let GLYPH_MEDI_KHA_MEDI_OE_FVS1: UInt32 = 0xE541
    private let GLYPH_MEDI_KHA_MEDI_UE_FVS1: UInt32 = 0xE542
    private let GLYPH_MEDI_MA_MEDI_MA: UInt32 = 0xE544
    private let GLYPH_MEDI_MA_MEDI_LA: UInt32 = 0xE545
    private let GLYPH_MEDI_LA_MEDI_LA: UInt32 = 0xE546
    private let GLYPH_MEDI_ANG_MEDI_NA_FVS1: UInt32 = 0xE547
    private let GLYPH_MEDI_ANG_FINA_QA: UInt32 = 0xE548
    private let GLYPH_MEDI_ANG_FINA_GA: UInt32 = 0xE549
    private let GLYPH_MEDI_BA_MEDI_QA: UInt32 = 0xE54A
    private let GLYPH_MEDI_BA_MEDI_GA: UInt32 = 0xE54B
    private let GLYPH_MEDI_PA_MEDI_QA: UInt32 = 0xE54C
    private let GLYPH_MEDI_PA_MEDI_GA: UInt32 = 0xE54D
    private let GLYPH_MEDI_FA_MEDI_QA: UInt32 = 0xE54E
    private let GLYPH_MEDI_FA_MEDI_GA: UInt32 = 0xE54F
    private let GLYPH_MEDI_KA_MEDI_QA: UInt32 = 0xE550
    private let GLYPH_MEDI_KA_MEDI_GA: UInt32 = 0xE551
    private let GLYPH_MEDI_KHA_MEDI_QA: UInt32 = 0xE552
    private let GLYPH_MEDI_KHA_MEDI_GA: UInt32 = 0xE553
    private let GLYPH_MEDI_BA_MEDI_NA_FVS1: UInt32 = 0xE554
    private let GLYPH_MEDI_PA_MEDI_NA_FVS1: UInt32 = 0xE555
    private let GLYPH_MEDI_GA_MEDI_NA_FVS1: UInt32 = 0xE556
    private let GLYPH_MEDI_FA_MEDI_NA_FVS1: UInt32 = 0xE557
    private let GLYPH_MEDI_KA_MEDI_NA_FVS1: UInt32 = 0xE558
    private let GLYPH_MEDI_KHA_MEDI_NA_FVS1: UInt32 = 0xE559
    private let GLYPH_INIT_QA_FINA_OE_FVS1: UInt32 = 0xE55A
    private let GLYPH_INIT_QA_FINA_UE_FVS1: UInt32 = 0xE55B
    private let GLYPH_INIT_GA_FINA_OE_FVS1: UInt32 = 0xE55C
    private let GLYPH_INIT_GA_FINA_UE_FVS1: UInt32 = 0xE55D
    private let GLYPH_INIT_QA_MEDI_OE_FVS1: UInt32 = 0xE55E
    private let GLYPH_INIT_QA_MEDI_UE_FVS1: UInt32 = 0xE55F
    private let GLYPH_INIT_GA_MEDI_OE_FVS1: UInt32 = 0xE560
    private let GLYPH_INIT_GA_MEDI_UE_FVS1: UInt32 = 0xE561
    private let GLYPH_ISOL_QA_FVS2: UInt32 = 0xE564
    private let GLYPH_INIT_QA_FVS2: UInt32 = 0xE565
    private let GLYPH_ISOL_QA_FVS1: UInt32 = 0xE566 // TODO matching Baiti
    private let GLYPH_INIT_QA_FVS3: UInt32 = 0xE567
    private let GLYPH_MEDI_QA_FVS3: UInt32 = 0xE568
    private let GLYPH_INIT_QA_FVS1_FINA_E: UInt32 = 0xE569
    private let GLYPH_INIT_QA_FVS1_MEDI_E: UInt32 = 0xE56A
    private let GLYPH_MEDI_QA_FVS1_MEDI_E: UInt32 = 0xE56B
    private let GLYPH_MEDI_QA_FVS1_FINA_E: UInt32 = 0xE56C
    private let GLYPH_INIT_QA_FVS1_FINA_I: UInt32 = 0xE56D
    private let GLYPH_INIT_QA_FVS1_MEDI_I: UInt32 = 0xE56E
    private let GLYPH_MEDI_QA_FVS1_MEDI_I: UInt32 = 0xE56F
    private let GLYPH_MEDI_QA_FVS1_FINA_I: UInt32 = 0xE570
    private let GLYPH_INIT_QA_FVS1_FINA_OE: UInt32 = 0xE571
    private let GLYPH_INIT_QA_FVS1_MEDI_OE: UInt32 = 0xE572
    private let GLYPH_MEDI_QA_FVS1_MEDI_OE: UInt32 = 0xE573
    private let GLYPH_MEDI_QA_FVS1_FINA_OE: UInt32 = 0xE574
    private let GLYPH_MEDI_QA_FVS1_FINA_OE_FVS1: UInt32 = 0xE575
    private let GLYPH_INIT_QA_FVS1_FINA_UE: UInt32 = 0xE576
    private let GLYPH_INIT_QA_FVS1_MEDI_UE: UInt32 = 0xE577
    private let GLYPH_MEDI_QA_FVS1_MEDI_UE: UInt32 = 0xE578
    private let GLYPH_MEDI_QA_FVS1_FINA_UE: UInt32 = 0xE579
    private let GLYPH_MEDI_QA_FVS1_FINA_UE_FVS1: UInt32 = 0xE57A
    private let GLYPH_INIT_QA_FVS1_FINA_EE: UInt32 = 0xE57B
    private let GLYPH_INIT_QA_FVS1_MEDI_EE: UInt32 = 0xE57C
    private let GLYPH_MEDI_QA_FVS1_MEDI_EE: UInt32 = 0xE57D
    private let GLYPH_MEDI_QA_FVS1_FINA_EE: UInt32 = 0xE57E
    private let GLYPH_ISOL_GA_FVS1: UInt32 = 0xE57F // TODO matching Baiti
    private let GLYPH_ISOL_GA_FVS2: UInt32 = 0xE580 // TODO matching Baiti
    private let GLYPH_INIT_GA_FVS3: UInt32 = 0xE581 // TODO not in Baiti
    private let GLYPH_INIT_GA_FVS2: UInt32 = 0xE582 // TODO matching Baiti
    private let GLYPH_MEDI_GA_FVS3: UInt32 = 0xE583
    private let GLYPH_MEDI_WA: UInt32 = 0xE584 // TODO matching Baiti
    private let GLYPH_INIT_A_FVS1: UInt32 = 0xE585
    // TODO GLYPH_MEDI_I_FVS2 and GLYPH_MEDI_I_FVS3 have not been standardized in Unicode yet
    // Matching to Baiti
    private let GLYPH_MEDI_I_FVS2: UInt32 = 0xE586
    private let GLYPH_FINA_NA_FVS2: UInt32 = 0xE587
    private let GLYPH_BIRGA_1: UInt32 = 0xE588
    private let GLYPH_BIRGA_2: UInt32 = 0xE589
    private let GLYPH_BIRGA_3: UInt32 = 0xE58A
    private let GLYPH_BIRGA_4: UInt32 = 0xE58B
    private let GLYPH_NIRUGU_FVS2: UInt32 = 0xE58F
    private let GLYPH_NIRUGU_FVS3: UInt32 = 0xE590
    private let GLYPH_INIT_GA_FVS1_FINA_E: UInt32 = 0xE594
    private let GLYPH_INIT_GA_FVS1_MEDI_E: UInt32 = 0xE595
    private let GLYPH_MEDI_GA_FVS1_MEDI_E: UInt32 = 0xE596
    private let GLYPH_MEDI_GA_FVS1_FINA_E: UInt32 = 0xE597
    private let GLYPH_INIT_GA_FVS1_FINA_I: UInt32 = 0xE598
    private let GLYPH_INIT_GA_FVS1_MEDI_I: UInt32 = 0xE599
    private let GLYPH_MEDI_GA_FVS1_MEDI_I: UInt32 = 0xE59A
    private let GLYPH_MEDI_GA_FVS1_FINA_I: UInt32 = 0xE59B
    private let GLYPH_INIT_GA_FVS1_FINA_OE: UInt32 = 0xE59C
    private let GLYPH_INIT_GA_FVS1_MEDI_OE: UInt32 = 0xE59D
    private let GLYPH_MEDI_GA_FVS1_MEDI_OE: UInt32 = 0xE59E
    private let GLYPH_MEDI_GA_FVS1_FINA_OE: UInt32 = 0xE59F
    private let GLYPH_MEDI_GA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5A0
    private let GLYPH_INIT_GA_FVS1_FINA_UE: UInt32 = 0xE5A1
    private let GLYPH_INIT_GA_FVS1_MEDI_UE: UInt32 = 0xE5A2
    private let GLYPH_MEDI_GA_FVS1_MEDI_UE: UInt32 = 0xE5A3
    private let GLYPH_MEDI_GA_FVS1_FINA_UE: UInt32 = 0xE5A4
    private let GLYPH_MEDI_GA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5A5
    private let GLYPH_INIT_GA_FVS1_FINA_EE: UInt32 = 0xE5A6
    private let GLYPH_INIT_GA_FVS1_MEDI_EE: UInt32 = 0xE5A7
    private let GLYPH_MEDI_GA_FVS1_MEDI_EE: UInt32 = 0xE5A8
    private let GLYPH_MEDI_GA_FVS1_FINA_EE: UInt32 = 0xE5A9
    private let GLYPH_MEDI_QA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5AA
    private let GLYPH_MEDI_QA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5AB
    private let GLYPH_MEDI_GA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5AC
    private let GLYPH_MEDI_GA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5AD
    private let GLYPH_INIT_BA_FINA_OE_FVS1: UInt32 = 0xE5B4
    private let GLYPH_INIT_BA_FINA_UE_FVS1: UInt32 = 0xE5B5
    private let GLYPH_INIT_BA_MEDI_OE_FVS1: UInt32 = 0xE5B6
    private let GLYPH_INIT_BA_MEDI_UE_FVS1: UInt32 = 0xE5B7
    private let GLYPH_INIT_PA_FINA_OE_FVS1: UInt32 = 0xE5B8
    private let GLYPH_INIT_PA_FINA_UE_FVS1: UInt32 = 0xE5B9
    private let GLYPH_INIT_PA_MEDI_OE_FVS1: UInt32 = 0xE5BA
    private let GLYPH_INIT_PA_MEDI_UE_FVS1: UInt32 = 0xE5BB
    private let GLYPH_INIT_QA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5BC
    private let GLYPH_INIT_QA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5BD
    private let GLYPH_INIT_QA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5BE
    private let GLYPH_INIT_QA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5BF
    private let GLYPH_INIT_GA_FVS1_FINA_OE_FVS1: UInt32 = 0xE5C0
    private let GLYPH_INIT_GA_FVS1_FINA_UE_FVS1: UInt32 = 0xE5C1
    private let GLYPH_INIT_GA_FVS1_MEDI_OE_FVS1: UInt32 = 0xE5C2
    private let GLYPH_INIT_GA_FVS1_MEDI_UE_FVS1: UInt32 = 0xE5C3
    private let GLYPH_INIT_FA_FINA_OE_FVS1: UInt32 = 0xE5C4
    private let GLYPH_INIT_FA_FINA_UE_FVS1: UInt32 = 0xE5C5
    private let GLYPH_INIT_FA_MEDI_OE_FVS1: UInt32 = 0xE5C6
    private let GLYPH_INIT_FA_MEDI_UE_FVS1: UInt32 = 0xE5C7
    private let GLYPH_INIT_KA_FINA_OE_FVS1: UInt32 = 0xE5C8
    private let GLYPH_INIT_KA_FINA_UE_FVS1: UInt32 = 0xE5C9
    private let GLYPH_INIT_KA_MEDI_OE_FVS1: UInt32 = 0xE5CA
    private let GLYPH_INIT_KA_MEDI_UE_FVS1: UInt32 = 0xE5CB
    private let GLYPH_INIT_KHA_FINA_OE_FVS1: UInt32 = 0xE5CC
    private let GLYPH_INIT_KHA_FINA_UE_FVS1: UInt32 = 0xE5CD
    private let GLYPH_INIT_KHA_MEDI_OE_FVS1: UInt32 = 0xE5CE
    private let GLYPH_INIT_KHA_MEDI_UE_FVS1: UInt32 = 0xE5CF
    
    init() {
        
        // This is a lot of initialization. Possibly slow?
        initIsolated()
        initInitial()
        initMedial()
        initFinal()
        initSuffixes()
        
    }
    
    
    
    
    
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
            
            if isMongolian(scalar) || scalar == NNBS || scalar == CURSOR_HOLDER {
                
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
                    let parts = subString.split(atChar: NNBS)
                    
                    for (var j = 0; j < parts.count; j++) {
                        
                        if (j == 0) { // this is the main word
                            
                            // Convert mongol word to glyphs and add to output string
                            outputString.append(convertWord(parts[j]))
                            
                        } else { // these are the suffixes
                            // remove cursor holder character
                            let tempSuffix = parts[j].removingAllInstancesOfChar(CURSOR_HOLDER)
                            outputString.append(NNBS)
                            
                            if let renderedSuffix = suffixDictionary[tempSuffix] {
                                
                                outputString.append(renderedSuffix)
                                if parts[j].contains(CURSOR_HOLDER) {
                                    outputString.append(CURSOR_HOLDER)
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
                let parts = subString.split(atChar: NNBS)
                
                for (var j = 0; j < parts.count; j++) {
                    
                    if (j == 0) { // this is the main word
                        
                        // Convert mongol word to glyphs and add to output string
                        outputString.append(convertWord(parts[j]))
                        
                    } else { // these are the suffixes
                        // remove cursor holder character
                        let tempSuffix = parts[j].removingAllInstancesOfChar(CURSOR_HOLDER)
                        outputString.append(NNBS)
                        
                        if let renderedSuffix = suffixDictionary[tempSuffix] {
                            
                            outputString.append(renderedSuffix)
                            if parts[j].contains(CURSOR_HOLDER) {
                                outputString.append(CURSOR_HOLDER)
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
    
    
    func convertWord(mongolWord: ScalarString) -> ScalarString {
        
        // Error checking
        if mongolWord.length == 0 {
            return mongolWord
        }
        
        let MAXIMUM_SEARCH_LENGTH = 4 // max length in Dictionary is 4(?).
        var formattedMongolWord = ScalarString()
        var returnString = ScalarString()
        
        // Check if cursor holder is present
        let startsWithCursorHolder = mongolWord.startsWith() ==  CURSOR_HOLDER
        let endsWithCursorHolder = mongolWord.endsWith() ==  CURSOR_HOLDER
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
            if let value = isolateDictionary[formattedMongolWord] {
                
                returnString.append(value)
                
                if (startsWithCursorHolder) {
                    returnString.insert(CURSOR_HOLDER, atIndex: 0)
                } else if (endsWithCursorHolder) {
                    returnString.append(CURSOR_HOLDER)
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
            if let value = initialDictionary[subString] {
                match = value
                initialEndIndex = i
                break
            }
        }
        
        if startsWithCursorHolder {
            returnString.append(CURSOR_HOLDER)
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
            if let value = finalDictionary[subString] {
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
                if let value = medialDictionary[subString] {
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
            returnString.append(CURSOR_HOLDER)
        }
        return returnString
        
    }
    
    func preFormatter(mongolWord: ScalarString) -> ScalarString {
        
        // This method applies context based formatting rules by adding the appropriate FVS character
        // TODO This method is slow because every rule has to loop through the word. However, this was intentional in order to separate the rules for easier debugging
        
        
        var word = ScalarString()
        word.append(mongolWord)
        
        // MVS rule (only formats A/E after the MVS)
        // Consonant before is formatted by lookup table
        // If A/E is not final then ignore MVS (mingg-a -> minggan)
        for (var i = word.length - 2; i >= 0; i--) {
            if (word.charAt(i) == MVS) {
                // following char is a vowel
                if (i == word.length - 2
                    && (word.charAt(i + 1) == UNI_A || word.charAt(i + 1) == UNI_E)) {
                        // insert FVS2 (this is the lower form of FVS1)
                        word.insert(FVS2, atIndex: i + 2)
                } else if (i == word.length - 2 && (word.charAt(i + 1) == ZWJ)) {
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
            if (word.charAt(i) == UNI_ANG || word.charAt(i) == UNI_BA || word.charAt(i) == UNI_PA || word.charAt(i) == UNI_FA || word.charAt(i) == UNI_KA || word.charAt(i) == UNI_KHA) {
                // following char is Q/G
                if (word.charAt(i + 1) == UNI_QA || word.charAt(i + 1) == UNI_GA) {
                    // following char is not A/O/U or MVS (MVS allows NG+G/Q ligature)
                    if (!isMasculineVowel(word.charAt(i + 2)) && word.charAt(i + 2) != MVS) {
                        // insert ZWJ to prevent ligature between NG/B/P/F/K/KH and G/Q
                        word.insert(ZWJ, atIndex: i + 1)
                    }
                }
            }
        }
        
        // *** OE/UE long tooth in first syllable for non ligatures rule ***
        // (long tooth ligatures are handled by the hash tables)
        if (word.length > 2) {
            // second char is OE or UE
            if (word.charAt(1) == UNI_OE || word.charAt(1) == UNI_UE) {
                // first char not a vowel or ligature consonant (B/P/Q/G/F/K/KH)
                if (!isVowel(word.charAt(0)) && word.charAt(0) != UNI_BA && word.charAt(0) != UNI_PA && word.charAt(0) != UNI_QA && word.charAt(0) != UNI_GA && word.charAt(0) != UNI_FA && word.charAt(0) != UNI_KA && word.charAt(0) != UNI_KHA) {
                    if (!isFVS(word.charAt(2))) {
                        // insert FVS1 after OE/UE
                        word.insert(FVS1, atIndex: 2)
                    }
                }
                // second char is FVS and third char is OE or UE
            } else if (isFVS(word.charAt(1)) && word.length > 3 && (word.charAt(2) == UNI_OE || word.charAt(2) == UNI_UE)) {
                // first char not a vowel or ligature consonant (B/P/Q/G/F/K/KH)
                if (!isVowel(word.charAt(0)) && word.charAt(0) != UNI_BA && word.charAt(0) != UNI_PA && word.charAt(0) != UNI_QA && word.charAt(0) != UNI_GA && word.charAt(0) != UNI_FA && word.charAt(0) != UNI_KA && word.charAt(0) != UNI_KHA) {
                    if (!isFVS(word.charAt(3))) {
                        // insert FVS1 after OE/UE
                        word.insert(FVS1, atIndex: 3)
                    }
                }
            }
        }
        
        // *** medial N rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == UNI_NA) {
                // following char is a vowel
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1
                    word.insert(FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** medial D rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == UNI_DA) {
                // following char is a vowel
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1
                    word.insert(FVS1, atIndex: i + 1)
                }
            }
        }
        
        // GA rules
        if (word.charAt(0) == UNI_GA) {
            
            // Initial GA
            if (word.length > 1 && isConsonant(word.charAt(1))) {
                // *** Initial GA before consonant rule ***
                // make it a feminine initial GA
                word.insert(FVS2, atIndex: 1)
            }
        }
        for (var i = word.length - 1; i > 0; i--) {
            if (word.charAt(i) == UNI_GA) {
                
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
                        word.insert(FVS2, atIndex: i + 1)
                    }
                    
                } else { // medial GA
                    
                    // **** dotted medial masculine GA rule ****
                    if (isMasculineVowel(word.charAt(i + 1))) {
                        // add the dots
                        word.insert(FVS1, atIndex: i + 1)
                        
                        // **** feminine medial GA rule ****
                    } else if (isConsonant(word.charAt(i + 1))) {
                        var isFeminineWord = false
                        isMasculineWord = false
                        
                        
                        if (isConsonant(word.charAt(i - 1)) || word.charAt(i - 1) == ZWJ) {
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
                            word.insert(FVS3, atIndex: i + 1)
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
                                word.insert(FVS3, atIndex: i + 1)
                            }
                        }
                    }
                }
                
            }
        } // End of GA rules
        
        // *** medial Y rule ***
        // upturn the Y before any vowel except I (when YI follows vowel)
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == UNI_YA) {
                var nextChar = word.charAt(i + 1)
                var prevChar = word.charAt(i - 1)
                // following char is a vowel besides I (or previous char is consonant)
                if ((isVowel(nextChar) && nextChar != UNI_I) || (!isVowel(prevChar)) && !isFVS(nextChar) && nextChar != MVS) {
                    // insert FVS1 (hooked Y)
                    word.insert(FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** medial W rule ***
        // Use the hooked W before any vowel
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == UNI_WA) {
                if (isVowel(word.charAt(i + 1))) {
                    // insert FVS1 (hooked W)
                    word.insert(FVS1, atIndex: i + 1)
                }
            }
        }
        
        // *** AI, EI, OI, UI medial I diphthong rule ***
        for (var i = word.length - 2; i > 0; i--) {
            if (word.charAt(i) == UNI_I) {
                // previous char is a masculine vowel or E and next char is not FVS
                if ((isMasculineVowel(word.charAt(i - 1)) || word.charAt(i - 1) == UNI_E)
                    && !isFVS(word.charAt(i + 1))) {
                        // insert FVS3 (double tooth medial I)
                        word.insert(FVS3, atIndex: i + 1)
                }
            }
        }
        
        return word
    }
    
    func isVowel(character: UInt32) -> Bool {
        return character >= UNI_A && character <= UNI_EE
    }
    
    func isMasculineVowel(character: UInt32) -> Bool {
        return (character == UNI_A || character == UNI_O || character == UNI_U)
    }
    
    func isFeminineVowel(character: UInt32) -> Bool {
        return (character == UNI_E || character == UNI_EE || character == UNI_OE || character == UNI_UE)
    }
    
    func isConsonant(character: UInt32) -> Bool {
        return (character >= UNI_NA && character <= UNI_CHI)
    }
    
    func isFVS(character: UInt32) -> Bool {
        return (character >= FVS1 && character <= FVS3)
    }
    
    func isMongolian(character: UInt32) -> Bool {
        // Mongolian letters, MVS, FVS1-3, NIRUGU, ZWJ, (but not NNBS)
        return ((character >= UNI_A && character <= UNI_CHI) || (character >= MONGOLIAN_NIRUGU && character <= MVS) || character == ZWJ)
    }
    
    func isBGDRS(character: UInt32) -> Bool {
        // This method is not used internally, only for external use.
        return (character == UNI_BA || character == UNI_GA || character == UNI_DA
            || character == UNI_RA || character == UNI_SA)
    }
    
    func isMongolianAlphabet(character: UInt32) -> Bool {
        // This method is not used internally, only for external use.
        return (character >= UNI_A && character <= UNI_CHI)
    }
    
    func isMongolianGlyphAlphabet(character: UInt32) -> Bool {
        return (character >= GLYPH_ISOL_A && character <= GLYPH_INIT_KHA_MEDI_UE_FVS1)
    }
    
    func isMasculineWord(word: ScalarString) -> Bool {
        // This method is not used internally, only for external use.
        if (word.isEmpty) {
            return false
        }
        
        for (var i = word.length - 1; i >= 0; i--) {
            if (word.charAt(i) == UNI_A || word.charAt(i) == UNI_O || word.charAt(i) == UNI_U) {
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
            if (word.charAt(i) == UNI_E || word.charAt(i) == UNI_OE || word.charAt(i) == UNI_UE
                || word.charAt(i) == UNI_EE) {
                    return true
            }
        }
        return false
    }
    
    //    func getIsolate(lookup: ScalarString) -> String {
    //        if (mIsolateMap.containsKey(lookup)) {
    //            return mIsolateMap.get(lookup)
    //        } else {
    //            return "";
    //        }
    //    }
    //
    //    public String getInitial(String lookup) {
    //    if (initialDictionary.containsKey(lookup)) {
    //    return initialDictionary.get(lookup)
    //    } else {
    //    return "";
    //    }
    //    }
    //
    //    public String getMedial(String lookup) {
    //    if (mMedialMap.containsKey(lookup)) {
    //    return mMedialMap.get(lookup)
    //    } else {
    //    return "";
    //    }
    //    }
    //
    //    public String getFinal(String lookup) {
    //    if (mFinalMap.containsKey(lookup)) {
    //    return mFinalMap.get(lookup)
    //    } else {
    //    return "";
    //    }
    //    }
    
    
    func initIsolated() {
        
        // NOTE: assuming MAXIMUM_SEARCH_LENGTH = 4
        
        //mIsolateMap = new HashMap<String, String>()
        
        
        // Single letters
        isolateDictionary[ScalarString(UNI_A)] = ScalarString(GLYPH_ISOL_A)
        isolateDictionary[ScalarString([UNI_A, FVS1])] = ScalarString(GLYPH_ISOL_A_FVS1)
        isolateDictionary[ScalarString(UNI_E)] = ScalarString(GLYPH_ISOL_E)
        isolateDictionary[ScalarString([UNI_E, FVS1])] = ScalarString(GLYPH_ISOL_E_FVS1)
        isolateDictionary[ScalarString(UNI_I)] = ScalarString(GLYPH_ISOL_I)
        isolateDictionary[ScalarString([UNI_I, FVS1])] = ScalarString(GLYPH_ISOL_I_FVS1)
        isolateDictionary[ScalarString(UNI_O)] = ScalarString(GLYPH_ISOL_O)
        isolateDictionary[ScalarString([UNI_O, FVS1])] = ScalarString(GLYPH_ISOL_O_FVS1)
        isolateDictionary[ScalarString(UNI_U)] = ScalarString(GLYPH_ISOL_U)
        isolateDictionary[ScalarString([UNI_U, FVS1])] = ScalarString(GLYPH_ISOL_U_FVS1)
        isolateDictionary[ScalarString([UNI_U, FVS2])] = ScalarString(GLYPH_ISOL_U_FVS2)  // I am adding this myself
        isolateDictionary[ScalarString(UNI_OE)] = ScalarString(GLYPH_ISOL_OE)
        isolateDictionary[ScalarString([UNI_OE, FVS1])] = ScalarString(GLYPH_ISOL_OE_FVS1)
        isolateDictionary[ScalarString(UNI_UE)] = ScalarString(GLYPH_ISOL_UE)
        isolateDictionary[ScalarString([UNI_UE, FVS1])] = ScalarString(GLYPH_ISOL_UE_FVS1)
        isolateDictionary[ScalarString([UNI_UE, FVS2])] = ScalarString(GLYPH_ISOL_UE_FVS2)
        isolateDictionary[ScalarString([UNI_UE, FVS3])] = ScalarString(GLYPH_ISOL_UE_FVS3)  // I am adding this myself
        isolateDictionary[ScalarString(UNI_EE)] = ScalarString(GLYPH_ISOL_EE)
        isolateDictionary[ScalarString([UNI_EE, FVS1])] = ScalarString(GLYPH_ISOL_EE_FVS1)
        isolateDictionary[ScalarString(UNI_NA)] = ScalarString(GLYPH_ISOL_NA)
        isolateDictionary[ScalarString([UNI_NA, FVS1])] = ScalarString(GLYPH_ISOL_NA_FVS1)
        isolateDictionary[ScalarString(UNI_ANG)] = ScalarString(GLYPH_ISOL_ANG)
        isolateDictionary[ScalarString(UNI_BA)] = ScalarString(GLYPH_ISOL_BA)
        isolateDictionary[ScalarString(UNI_PA)] = ScalarString(GLYPH_ISOL_PA)
        isolateDictionary[ScalarString(UNI_QA)] = ScalarString(GLYPH_ISOL_QA)
        isolateDictionary[ScalarString([UNI_QA, FVS1])] = ScalarString(GLYPH_ISOL_QA_FVS1)
        isolateDictionary[ScalarString([UNI_QA, FVS2])] = ScalarString(GLYPH_ISOL_QA_FVS2)
        isolateDictionary[ScalarString([UNI_QA, FVS3])] = ScalarString(GLYPH_ISOL_QA_FVS3)
        isolateDictionary[ScalarString(UNI_GA)] = ScalarString(GLYPH_ISOL_GA)
        isolateDictionary[ScalarString([UNI_GA, FVS1])] = ScalarString(GLYPH_ISOL_GA_FVS1)
        isolateDictionary[ScalarString([UNI_GA, FVS2])] = ScalarString(GLYPH_ISOL_GA_FVS2)
        isolateDictionary[ScalarString([UNI_GA, FVS3])] = ScalarString(GLYPH_ISOL_GA_FVS3)
        isolateDictionary[ScalarString(UNI_MA)] = ScalarString(GLYPH_ISOL_MA)
        isolateDictionary[ScalarString(UNI_LA)] = ScalarString(GLYPH_ISOL_LA)
        isolateDictionary[ScalarString(UNI_SA)] = ScalarString(GLYPH_ISOL_SA)
        isolateDictionary[ScalarString(UNI_SHA)] = ScalarString(GLYPH_ISOL_SHA)
        isolateDictionary[ScalarString(UNI_TA)] = ScalarString(GLYPH_ISOL_TA)
        isolateDictionary[ScalarString([UNI_TA, FVS1])] = ScalarString(GLYPH_ISOL_TA_FVS1)
        isolateDictionary[ScalarString(UNI_DA)] = ScalarString(GLYPH_ISOL_DA)
        isolateDictionary[ScalarString(UNI_CHA)] = ScalarString(GLYPH_ISOL_CHA)
        isolateDictionary[ScalarString(UNI_JA)] = ScalarString(GLYPH_ISOL_JA)
        isolateDictionary[ScalarString([UNI_JA, FVS1])] = ScalarString(GLYPH_ISOL_JA_FVS1)
        isolateDictionary[ScalarString(UNI_YA)] = ScalarString(GLYPH_ISOL_YA)
        isolateDictionary[ScalarString(UNI_RA)] = ScalarString(GLYPH_ISOL_RA)
        isolateDictionary[ScalarString(UNI_WA)] = ScalarString(GLYPH_ISOL_WA)
        isolateDictionary[ScalarString(UNI_FA)] = ScalarString(GLYPH_ISOL_FA)
        isolateDictionary[ScalarString(UNI_KA)] = ScalarString(GLYPH_ISOL_KA)
        isolateDictionary[ScalarString(UNI_KHA)] = ScalarString(GLYPH_ISOL_KHA)
        isolateDictionary[ScalarString(UNI_TSA)] = ScalarString(GLYPH_ISOL_TSA)
        isolateDictionary[ScalarString(UNI_ZA)] = ScalarString(GLYPH_ISOL_ZA)
        isolateDictionary[ScalarString(UNI_HAA)] = ScalarString(GLYPH_ISOL_HAA)
        isolateDictionary[ScalarString(UNI_ZRA)] = ScalarString(GLYPH_ISOL_ZRA)
        isolateDictionary[ScalarString(UNI_LHA)] = ScalarString(GLYPH_ISOL_LHA)
        isolateDictionary[ScalarString(UNI_ZHI)] = ScalarString(GLYPH_ISOL_ZHI)
        isolateDictionary[ScalarString(UNI_CHI)] = ScalarString(GLYPH_ISOL_CHI)
        
        // Double letters
        isolateDictionary[ScalarString([UNI_BA, UNI_A])] = ScalarString(GLYPH_INIT_BA_FINA_A)
        isolateDictionary[ScalarString([UNI_BA, UNI_E])] = ScalarString(GLYPH_INIT_BA_FINA_E)
        isolateDictionary[ScalarString([UNI_BA, UNI_I])] = ScalarString(GLYPH_INIT_BA_FINA_I)
        isolateDictionary[ScalarString([UNI_BA, UNI_O])] = ScalarString(GLYPH_INIT_BA_FINA_O)
        isolateDictionary[ScalarString([UNI_BA, UNI_U])] = ScalarString(GLYPH_INIT_BA_FINA_U)
        isolateDictionary[ScalarString([UNI_BA, UNI_OE])] = ScalarString(GLYPH_INIT_BA_FINA_OE)
        isolateDictionary[ScalarString([UNI_BA, UNI_UE])] = ScalarString(GLYPH_INIT_BA_FINA_UE)
        isolateDictionary[ScalarString([UNI_BA, UNI_EE])] = ScalarString(GLYPH_INIT_BA_FINA_EE)
        isolateDictionary[ScalarString([UNI_PA, UNI_A])] = ScalarString(GLYPH_INIT_PA_FINA_A)
        isolateDictionary[ScalarString([UNI_PA, UNI_E])] = ScalarString(GLYPH_INIT_PA_FINA_E)
        isolateDictionary[ScalarString([UNI_PA, UNI_I])] = ScalarString(GLYPH_INIT_PA_FINA_I)
        isolateDictionary[ScalarString([UNI_PA, UNI_O])] = ScalarString(GLYPH_INIT_PA_FINA_O)
        isolateDictionary[ScalarString([UNI_PA, UNI_U])] = ScalarString(GLYPH_INIT_PA_FINA_U)
        isolateDictionary[ScalarString([UNI_PA, UNI_OE])] = ScalarString(GLYPH_INIT_PA_FINA_OE)
        isolateDictionary[ScalarString([UNI_PA, UNI_UE])] = ScalarString(GLYPH_INIT_PA_FINA_UE)
        isolateDictionary[ScalarString([UNI_PA, UNI_EE])] = ScalarString(GLYPH_INIT_PA_FINA_EE)
        isolateDictionary[ScalarString([UNI_QA, UNI_E])] = ScalarString(GLYPH_INIT_QA_FINA_E)
        isolateDictionary[ScalarString([UNI_QA, UNI_I])] = ScalarString(GLYPH_INIT_QA_FINA_I)
        isolateDictionary[ScalarString([UNI_QA, UNI_OE])] = ScalarString(GLYPH_INIT_QA_FINA_OE)
        isolateDictionary[ScalarString([UNI_QA, UNI_UE])] = ScalarString(GLYPH_INIT_QA_FINA_UE)
        isolateDictionary[ScalarString([UNI_QA, UNI_EE])] = ScalarString(GLYPH_INIT_QA_FINA_EE)
        isolateDictionary[ScalarString([UNI_GA, UNI_E])] = ScalarString(GLYPH_INIT_GA_FINA_E)
        isolateDictionary[ScalarString([UNI_GA, UNI_I])] = ScalarString(GLYPH_INIT_GA_FINA_I)
        isolateDictionary[ScalarString([UNI_GA, UNI_OE])] = ScalarString(GLYPH_INIT_GA_FINA_OE)
        isolateDictionary[ScalarString([UNI_GA, UNI_UE])] = ScalarString(GLYPH_INIT_GA_FINA_UE)
        isolateDictionary[ScalarString([UNI_GA, UNI_EE])] = ScalarString(GLYPH_INIT_GA_FINA_EE)
        isolateDictionary[ScalarString([UNI_FA, UNI_A])] = ScalarString(GLYPH_INIT_FA_FINA_A)
        isolateDictionary[ScalarString([UNI_FA, UNI_E])] = ScalarString(GLYPH_INIT_FA_FINA_E)
        isolateDictionary[ScalarString([UNI_FA, UNI_I])] = ScalarString(GLYPH_INIT_FA_FINA_I)
        isolateDictionary[ScalarString([UNI_FA, UNI_O])] = ScalarString(GLYPH_INIT_FA_FINA_O)
        isolateDictionary[ScalarString([UNI_FA, UNI_U])] = ScalarString(GLYPH_INIT_FA_FINA_U)
        isolateDictionary[ScalarString([UNI_FA, UNI_OE])] = ScalarString(GLYPH_INIT_FA_FINA_OE)
        isolateDictionary[ScalarString([UNI_FA, UNI_UE])] = ScalarString(GLYPH_INIT_FA_FINA_UE)
        isolateDictionary[ScalarString([UNI_FA, UNI_EE])] = ScalarString(GLYPH_INIT_FA_FINA_EE)
        isolateDictionary[ScalarString([UNI_KA, UNI_A])] = ScalarString(GLYPH_INIT_KA_FINA_A)
        isolateDictionary[ScalarString([UNI_KA, UNI_E])] = ScalarString(GLYPH_INIT_KA_FINA_E)
        isolateDictionary[ScalarString([UNI_KA, UNI_I])] = ScalarString(GLYPH_INIT_KA_FINA_I)
        isolateDictionary[ScalarString([UNI_KA, UNI_O])] = ScalarString(GLYPH_INIT_KA_FINA_O)
        isolateDictionary[ScalarString([UNI_KA, UNI_U])] = ScalarString(GLYPH_INIT_KA_FINA_U)
        isolateDictionary[ScalarString([UNI_KA, UNI_OE])] = ScalarString(GLYPH_INIT_KA_FINA_OE)
        isolateDictionary[ScalarString([UNI_KA, UNI_UE])] = ScalarString(GLYPH_INIT_KA_FINA_UE)
        isolateDictionary[ScalarString([UNI_KA, UNI_EE])] = ScalarString(GLYPH_INIT_KA_FINA_EE)
        isolateDictionary[ScalarString([UNI_KHA, UNI_A])] = ScalarString(GLYPH_INIT_KHA_FINA_A)
        isolateDictionary[ScalarString([UNI_KHA, UNI_E])] = ScalarString(GLYPH_INIT_KHA_FINA_E)
        isolateDictionary[ScalarString([UNI_KHA, UNI_I])] = ScalarString(GLYPH_INIT_KHA_FINA_I)
        isolateDictionary[ScalarString([UNI_KHA, UNI_O])] = ScalarString(GLYPH_INIT_KHA_FINA_O)
        isolateDictionary[ScalarString([UNI_KHA, UNI_U])] = ScalarString(GLYPH_INIT_KHA_FINA_U)
        isolateDictionary[ScalarString([UNI_KHA, UNI_OE])] = ScalarString(GLYPH_INIT_KHA_FINA_OE)
        isolateDictionary[ScalarString([UNI_KHA, UNI_UE])] = ScalarString(GLYPH_INIT_KHA_FINA_UE)
        isolateDictionary[ScalarString([UNI_KHA, UNI_EE])] = ScalarString(GLYPH_INIT_KHA_FINA_EE)
        isolateDictionary[ScalarString([UNI_QA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_QA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_QA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_QA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_GA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_GA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_GA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_GA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_E])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_E)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_I])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_I)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_OE])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_OE)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_UE])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_UE)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_EE])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_EE)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_E])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_E)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_I])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_I)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_OE])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_OE)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_UE])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_UE)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_EE])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_EE)
        isolateDictionary[ScalarString([UNI_BA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_BA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_BA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_BA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_PA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_PA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_PA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_PA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_QA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_QA_FVS1_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_GA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_GA_FVS1_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_FA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_FA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_FA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_FA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_KA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_KA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_KA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_KA_FINA_UE_FVS1)
        isolateDictionary[ScalarString([UNI_KHA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_KHA_FINA_OE_FVS1)
        isolateDictionary[ScalarString([UNI_KHA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_KHA_FINA_UE_FVS1)
        
        // BUU exception (no tooth on first UE)
        isolateDictionary[ScalarString([UNI_BA, UNI_UE, UNI_UE])] = ScalarString([GLYPH_INIT_BA_MEDI_U, GLYPH_FINA_UE])
        
        // Catch other chars
        isolateDictionary[ScalarString(CURSOR_HOLDER)] = ScalarString(CURSOR_HOLDER)
        isolateDictionary[ScalarString(MONGOLIAN_NIRUGU)] = ScalarString(GLYPH_NIRUGU)
        isolateDictionary[ScalarString(ZWJ)] = ScalarString("")
        isolateDictionary[ScalarString(NNBS)] = ScalarString(NNBS)
        isolateDictionary[ScalarString(MVS)] = ScalarString("")
        isolateDictionary[ScalarString(FVS1)] = ScalarString("")
        isolateDictionary[ScalarString(FVS2)] = ScalarString("")
        isolateDictionary[ScalarString(FVS3)] = ScalarString("")
        
    }
    
    func initInitial() {
        
        // NOTE: assuming MAXIMUM_SEARCH_LENGTH = 4
        
        //initialDictionary = new HashMap<String, String>()
        
        initialDictionary[ScalarString(UNI_A)] = ScalarString(GLYPH_INIT_A)
        initialDictionary[ScalarString([UNI_A, FVS1])] = ScalarString(GLYPH_INIT_A_FVS1)
        initialDictionary[ScalarString(UNI_E)] = ScalarString(GLYPH_INIT_E)
        initialDictionary[ScalarString([UNI_E, FVS1])] = ScalarString(GLYPH_INIT_E_FVS1)
        initialDictionary[ScalarString(UNI_I)] = ScalarString(GLYPH_INIT_I)
        initialDictionary[ScalarString([UNI_I, FVS1])] = ScalarString(GLYPH_INIT_I_FVS1)
        initialDictionary[ScalarString(UNI_O)] = ScalarString(GLYPH_INIT_O)
        initialDictionary[ScalarString([UNI_O, FVS1])] = ScalarString(GLYPH_INIT_O_FVS1)
        initialDictionary[ScalarString(UNI_U)] = ScalarString(GLYPH_INIT_U)
        initialDictionary[ScalarString([UNI_U, FVS1])] = ScalarString(GLYPH_INIT_U_FVS1)
        initialDictionary[ScalarString(UNI_OE)] = ScalarString(GLYPH_INIT_OE)
        initialDictionary[ScalarString(UNI_UE)] = ScalarString(GLYPH_INIT_UE)
        initialDictionary[ScalarString(UNI_EE)] = ScalarString(GLYPH_INIT_EE)
        initialDictionary[ScalarString([UNI_EE, FVS1])] = ScalarString(GLYPH_INIT_EE_FVS1)
        initialDictionary[ScalarString([UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_UE_FVS1)
        initialDictionary[ScalarString(UNI_NA)] = ScalarString(GLYPH_INIT_NA)
        // TODO when is UNI_NA, FVS1 ever used?
        initialDictionary[ScalarString([UNI_NA, FVS1])] = ScalarString(GLYPH_INIT_NA_FVS1)
        initialDictionary[ScalarString(UNI_ANG)] = ScalarString(GLYPH_INIT_ANG)
        initialDictionary[ScalarString(UNI_BA)] = ScalarString(GLYPH_INIT_BA)
        initialDictionary[ScalarString([UNI_BA, UNI_A])] = ScalarString(GLYPH_INIT_BA_MEDI_A)
        initialDictionary[ScalarString([UNI_BA, UNI_E])] = ScalarString(GLYPH_INIT_BA_MEDI_E)
        initialDictionary[ScalarString([UNI_BA, UNI_I])] = ScalarString(GLYPH_INIT_BA_MEDI_I)
        initialDictionary[ScalarString([UNI_BA, UNI_O])] = ScalarString(GLYPH_INIT_BA_MEDI_O)
        initialDictionary[ScalarString([UNI_BA, UNI_U])] = ScalarString(GLYPH_INIT_BA_MEDI_U)
        initialDictionary[ScalarString([UNI_BA, UNI_OE])] = ScalarString(GLYPH_INIT_BA_MEDI_OE)
        initialDictionary[ScalarString([UNI_BA, UNI_UE])] = ScalarString(GLYPH_INIT_BA_MEDI_UE)
        initialDictionary[ScalarString([UNI_BA, UNI_EE])] = ScalarString(GLYPH_INIT_BA_MEDI_EE)
        initialDictionary[ScalarString(UNI_PA)] = ScalarString(GLYPH_INIT_PA)
        initialDictionary[ScalarString([UNI_PA, UNI_A])] = ScalarString(GLYPH_INIT_PA_MEDI_A)
        initialDictionary[ScalarString([UNI_PA, UNI_E])] = ScalarString(GLYPH_INIT_PA_MEDI_E)
        initialDictionary[ScalarString([UNI_PA, UNI_I])] = ScalarString(GLYPH_INIT_PA_MEDI_I)
        initialDictionary[ScalarString([UNI_PA, UNI_O])] = ScalarString(GLYPH_INIT_PA_MEDI_O)
        initialDictionary[ScalarString([UNI_PA, UNI_U])] = ScalarString(GLYPH_INIT_PA_MEDI_U)
        initialDictionary[ScalarString([UNI_PA, UNI_OE])] = ScalarString(GLYPH_INIT_PA_MEDI_OE)
        initialDictionary[ScalarString([UNI_PA, UNI_UE])] = ScalarString(GLYPH_INIT_PA_MEDI_UE)
        initialDictionary[ScalarString([UNI_PA, UNI_EE])] = ScalarString(GLYPH_INIT_PA_MEDI_EE)
        initialDictionary[ScalarString(UNI_QA)] = ScalarString(GLYPH_INIT_QA)
        initialDictionary[ScalarString([UNI_QA, FVS1])] = ScalarString(GLYPH_INIT_QA_FVS1)
        initialDictionary[ScalarString([UNI_QA, UNI_E])] = ScalarString(GLYPH_INIT_QA_MEDI_E)
        initialDictionary[ScalarString([UNI_QA, UNI_I])] = ScalarString(GLYPH_INIT_QA_MEDI_I)
        initialDictionary[ScalarString([UNI_QA, UNI_OE])] = ScalarString(GLYPH_INIT_QA_MEDI_OE)
        initialDictionary[ScalarString([UNI_QA, UNI_UE])] = ScalarString(GLYPH_INIT_QA_MEDI_UE)
        initialDictionary[ScalarString([UNI_QA, UNI_EE])] = ScalarString(GLYPH_INIT_QA_MEDI_EE)
        initialDictionary[ScalarString(UNI_GA)] = ScalarString(GLYPH_INIT_GA)
        initialDictionary[ScalarString([UNI_GA, FVS1])] = ScalarString(GLYPH_INIT_GA_FVS1)
        initialDictionary[ScalarString([UNI_GA, UNI_E])] = ScalarString(GLYPH_INIT_GA_MEDI_E)
        initialDictionary[ScalarString([UNI_GA, UNI_I])] = ScalarString(GLYPH_INIT_GA_MEDI_I)
        initialDictionary[ScalarString([UNI_GA, UNI_OE])] = ScalarString(GLYPH_INIT_GA_MEDI_OE)
        initialDictionary[ScalarString([UNI_GA, UNI_UE])] = ScalarString(GLYPH_INIT_GA_MEDI_UE)
        initialDictionary[ScalarString([UNI_GA, UNI_EE])] = ScalarString(GLYPH_INIT_GA_MEDI_EE)
        initialDictionary[ScalarString(UNI_MA)] = ScalarString(GLYPH_INIT_MA)
        initialDictionary[ScalarString(UNI_LA)] = ScalarString(GLYPH_INIT_LA)
        initialDictionary[ScalarString(UNI_SA)] = ScalarString(GLYPH_INIT_SA)
        initialDictionary[ScalarString(UNI_SHA)] = ScalarString(GLYPH_INIT_SHA)
        initialDictionary[ScalarString(UNI_TA)] = ScalarString(GLYPH_INIT_TA)
        initialDictionary[ScalarString(UNI_DA)] = ScalarString(GLYPH_INIT_DA)
        initialDictionary[ScalarString([UNI_DA, FVS1])] = ScalarString(GLYPH_INIT_DA_FVS1)
        initialDictionary[ScalarString(UNI_CHA)] = ScalarString(GLYPH_INIT_CHA)
        initialDictionary[ScalarString(UNI_JA)] = ScalarString(GLYPH_INIT_JA)
        initialDictionary[ScalarString(UNI_YA)] = ScalarString(GLYPH_INIT_YA)
        initialDictionary[ScalarString([UNI_YA, FVS1])] = ScalarString(GLYPH_INIT_YA_FVS1)
        initialDictionary[ScalarString(UNI_RA)] = ScalarString(GLYPH_INIT_RA)
        initialDictionary[ScalarString(UNI_WA)] = ScalarString(GLYPH_INIT_WA)
        initialDictionary[ScalarString(UNI_FA)] = ScalarString(GLYPH_INIT_FA)
        initialDictionary[ScalarString([UNI_FA, UNI_A])] = ScalarString(GLYPH_INIT_FA_MEDI_A)
        initialDictionary[ScalarString([UNI_FA, UNI_E])] = ScalarString(GLYPH_INIT_FA_MEDI_E)
        initialDictionary[ScalarString([UNI_FA, UNI_I])] = ScalarString(GLYPH_INIT_FA_MEDI_I)
        initialDictionary[ScalarString([UNI_FA, UNI_O])] = ScalarString(GLYPH_INIT_FA_MEDI_O)
        initialDictionary[ScalarString([UNI_FA, UNI_U])] = ScalarString(GLYPH_INIT_FA_MEDI_U)
        initialDictionary[ScalarString([UNI_FA, UNI_OE])] = ScalarString(GLYPH_INIT_FA_MEDI_OE)
        initialDictionary[ScalarString([UNI_FA, UNI_UE])] = ScalarString(GLYPH_INIT_FA_MEDI_UE)
        initialDictionary[ScalarString([UNI_FA, UNI_EE])] = ScalarString(GLYPH_INIT_FA_MEDI_EE)
        initialDictionary[ScalarString(UNI_KA)] = ScalarString(GLYPH_INIT_KA)
        initialDictionary[ScalarString([UNI_KA, UNI_A])] = ScalarString(GLYPH_INIT_KA_MEDI_A)
        initialDictionary[ScalarString([UNI_KA, UNI_E])] = ScalarString(GLYPH_INIT_KA_MEDI_E)
        initialDictionary[ScalarString([UNI_KA, UNI_I])] = ScalarString(GLYPH_INIT_KA_MEDI_I)
        initialDictionary[ScalarString([UNI_KA, UNI_O])] = ScalarString(GLYPH_INIT_KA_MEDI_O)
        initialDictionary[ScalarString([UNI_KA, UNI_U])] = ScalarString(GLYPH_INIT_KA_MEDI_U)
        initialDictionary[ScalarString([UNI_KA, UNI_OE])] = ScalarString(GLYPH_INIT_KA_MEDI_OE)
        initialDictionary[ScalarString([UNI_KA, UNI_UE])] = ScalarString(GLYPH_INIT_KA_MEDI_UE)
        initialDictionary[ScalarString([UNI_KA, UNI_EE])] = ScalarString(GLYPH_INIT_KA_MEDI_EE)
        initialDictionary[ScalarString(UNI_KHA)] = ScalarString(GLYPH_INIT_KHA)
        initialDictionary[ScalarString([UNI_KHA, UNI_A])] = ScalarString(GLYPH_INIT_KHA_MEDI_A)
        initialDictionary[ScalarString([UNI_KHA, UNI_E])] = ScalarString(GLYPH_INIT_KHA_MEDI_E)
        initialDictionary[ScalarString([UNI_KHA, UNI_I])] = ScalarString(GLYPH_INIT_KHA_MEDI_I)
        initialDictionary[ScalarString([UNI_KHA, UNI_O])] = ScalarString(GLYPH_INIT_KHA_MEDI_O)
        initialDictionary[ScalarString([UNI_KHA, UNI_U])] = ScalarString(GLYPH_INIT_KHA_MEDI_U)
        initialDictionary[ScalarString([UNI_KHA, UNI_OE])] = ScalarString(GLYPH_INIT_KHA_MEDI_OE)
        initialDictionary[ScalarString([UNI_KHA, UNI_UE])] = ScalarString(GLYPH_INIT_KHA_MEDI_UE)
        initialDictionary[ScalarString([UNI_KHA, UNI_EE])] = ScalarString(GLYPH_INIT_KHA_MEDI_EE)
        initialDictionary[ScalarString(UNI_TSA)] = ScalarString(GLYPH_INIT_TSA)
        initialDictionary[ScalarString(UNI_ZA)] = ScalarString(GLYPH_INIT_ZA)
        initialDictionary[ScalarString(UNI_HAA)] = ScalarString(GLYPH_INIT_HAA)
        initialDictionary[ScalarString(UNI_ZRA)] = ScalarString(GLYPH_INIT_ZRA)
        initialDictionary[ScalarString(UNI_LHA)] = ScalarString(GLYPH_INIT_LHA)
        initialDictionary[ScalarString(UNI_ZHI)] = ScalarString(GLYPH_INIT_ZHI)
        initialDictionary[ScalarString(UNI_CHI)] = ScalarString(GLYPH_INIT_CHI)
        initialDictionary[ScalarString([UNI_QA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_QA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_QA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_QA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_GA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_GA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_GA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_GA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_QA, FVS2])] = ScalarString(GLYPH_INIT_QA_FVS2)
        initialDictionary[ScalarString([UNI_QA, FVS3])] = ScalarString(GLYPH_INIT_QA_FVS3)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_E])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_E)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_I])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_I)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_OE])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_OE)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_UE])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_UE)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_EE])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_EE)
        initialDictionary[ScalarString([UNI_GA, FVS2])] = ScalarString(GLYPH_INIT_GA_FVS2)
        initialDictionary[ScalarString([UNI_GA, FVS3])] = ScalarString(GLYPH_INIT_GA_FVS3)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_E])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_E)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_I])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_I)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_OE])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_OE)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_UE])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_UE)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_EE])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_EE)
        initialDictionary[ScalarString([UNI_BA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_BA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_BA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_BA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_PA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_PA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_PA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_PA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_QA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_QA_FVS1_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_GA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_GA_FVS1_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_FA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_FA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_FA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_FA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_KA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_KA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_KA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_KA_MEDI_UE_FVS1)
        initialDictionary[ScalarString([UNI_KHA, UNI_OE, FVS1])] = ScalarString(GLYPH_INIT_KHA_MEDI_OE_FVS1)
        initialDictionary[ScalarString([UNI_KHA, UNI_UE, FVS1])] = ScalarString(GLYPH_INIT_KHA_MEDI_UE_FVS1)
        
        // Catch other chars
        initialDictionary[ScalarString(CURSOR_HOLDER)] = ScalarString(CURSOR_HOLDER)
        initialDictionary[ScalarString(MONGOLIAN_NIRUGU)] = ScalarString(GLYPH_NIRUGU)
        initialDictionary[ScalarString(ZWJ)] = ScalarString("")
        initialDictionary[ScalarString(NNBS)] = ScalarString(NNBS)
        initialDictionary[ScalarString(MVS)] = ScalarString("")
        initialDictionary[ScalarString(FVS1)] = ScalarString("")
        initialDictionary[ScalarString(FVS2)] = ScalarString("")
        initialDictionary[ScalarString(FVS3)] = ScalarString("")
        
    }
    
    func initMedial() {
        
        // NOTE: assuming MAXIMUM_SEARCH_LENGTH = 4
        
        medialDictionary[ScalarString(UNI_A)] = ScalarString(GLYPH_MEDI_A)
        medialDictionary[ScalarString([UNI_A, FVS1])] = ScalarString(GLYPH_MEDI_A_FVS1)
        medialDictionary[ScalarString(UNI_E)] = ScalarString(GLYPH_MEDI_E)
        medialDictionary[ScalarString(UNI_I)] = ScalarString(GLYPH_MEDI_I)
        medialDictionary[ScalarString([UNI_I, FVS1])] = ScalarString(GLYPH_MEDI_I_FVS1)
        medialDictionary[ScalarString([UNI_I, FVS2])] = ScalarString(GLYPH_MEDI_I_FVS2)
        medialDictionary[ScalarString([UNI_I, FVS3])] = ScalarString(GLYPH_MEDI_I_FVS3)
        medialDictionary[ScalarString(UNI_O)] = ScalarString(GLYPH_MEDI_O)
        medialDictionary[ScalarString([UNI_O, FVS1])] = ScalarString(GLYPH_MEDI_O_FVS1)
        medialDictionary[ScalarString(UNI_U)] = ScalarString(GLYPH_MEDI_U)
        medialDictionary[ScalarString([UNI_U, FVS1])] = ScalarString(GLYPH_MEDI_U_FVS1)
        medialDictionary[ScalarString(UNI_OE)] = ScalarString(GLYPH_MEDI_OE)
        medialDictionary[ScalarString([UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_OE, FVS2])] = ScalarString(GLYPH_MEDI_OE_FVS2)
        medialDictionary[ScalarString(UNI_UE)] = ScalarString(GLYPH_MEDI_UE)
        medialDictionary[ScalarString([UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_UE, FVS2])] = ScalarString(GLYPH_MEDI_UE_FVS2)
        medialDictionary[ScalarString(UNI_EE)] = ScalarString(GLYPH_MEDI_EE)
        medialDictionary[ScalarString(UNI_NA)] = ScalarString(GLYPH_MEDI_NA)
        medialDictionary[ScalarString([UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_NA_FVS1)
        medialDictionary[ScalarString([UNI_NA, FVS2])] = ScalarString(GLYPH_MEDI_NA_FVS2)
        medialDictionary[ScalarString(UNI_ANG)] = ScalarString(GLYPH_MEDI_ANG)
        medialDictionary[ScalarString([UNI_ANG, UNI_QA])] = ScalarString(GLYPH_MEDI_ANG_MEDI_QA)
        medialDictionary[ScalarString([UNI_ANG, UNI_GA])] = ScalarString(GLYPH_MEDI_ANG_MEDI_GA)
        medialDictionary[ScalarString([UNI_ANG, UNI_QA, FVS1])] = ScalarString(GLYPH_MEDI_ANG_MEDI_QA)
        medialDictionary[ScalarString([UNI_ANG, UNI_GA, FVS1])] = ScalarString(GLYPH_MEDI_ANG_MEDI_GA)
        medialDictionary[ScalarString([UNI_ANG, UNI_MA])] = ScalarString(GLYPH_MEDI_ANG_MEDI_MA)
        medialDictionary[ScalarString([UNI_ANG, UNI_LA])] = ScalarString(GLYPH_MEDI_ANG_MEDI_LA)
        medialDictionary[ScalarString([UNI_ANG, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_ANG_MEDI_NA_FVS1)
        
        medialDictionary[ScalarString(UNI_BA)] = ScalarString(GLYPH_MEDI_BA)
        medialDictionary[ScalarString([UNI_BA, UNI_A])] = ScalarString(GLYPH_MEDI_BA_MEDI_A)
        medialDictionary[ScalarString([UNI_BA, UNI_E])] = ScalarString(GLYPH_MEDI_BA_MEDI_E)
        medialDictionary[ScalarString([UNI_BA, UNI_I])] = ScalarString(GLYPH_MEDI_BA_MEDI_I)
        medialDictionary[ScalarString([UNI_BA, UNI_O])] = ScalarString(GLYPH_MEDI_BA_MEDI_O)
        medialDictionary[ScalarString([UNI_BA, UNI_U])] = ScalarString(GLYPH_MEDI_BA_MEDI_U)
        medialDictionary[ScalarString([UNI_BA, UNI_OE])] = ScalarString(GLYPH_MEDI_BA_MEDI_OE)
        medialDictionary[ScalarString([UNI_BA, UNI_UE])] = ScalarString(GLYPH_MEDI_BA_MEDI_UE)
        medialDictionary[ScalarString([UNI_BA, UNI_EE])] = ScalarString(GLYPH_MEDI_BA_MEDI_EE)
        medialDictionary[ScalarString([UNI_BA, UNI_MA])] = ScalarString(GLYPH_MEDI_BA_MEDI_MA)
        medialDictionary[ScalarString([UNI_BA, UNI_LA])] = ScalarString(GLYPH_MEDI_BA_MEDI_LA)
        medialDictionary[ScalarString([UNI_BA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_BA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_BA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_BA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_BA, UNI_QA])] = ScalarString(GLYPH_MEDI_BA_MEDI_QA)
        medialDictionary[ScalarString([UNI_BA, UNI_GA])] = ScalarString(GLYPH_MEDI_BA_MEDI_GA)
        medialDictionary[ScalarString([UNI_BA, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_BA_MEDI_NA_FVS1)
        medialDictionary[ScalarString(UNI_PA)] = ScalarString(GLYPH_MEDI_PA)
        medialDictionary[ScalarString([UNI_PA, UNI_A])] = ScalarString(GLYPH_MEDI_PA_MEDI_A)
        medialDictionary[ScalarString([UNI_PA, UNI_E])] = ScalarString(GLYPH_MEDI_PA_MEDI_E)
        medialDictionary[ScalarString([UNI_PA, UNI_I])] = ScalarString(GLYPH_MEDI_PA_MEDI_I)
        medialDictionary[ScalarString([UNI_PA, UNI_O])] = ScalarString(GLYPH_MEDI_PA_MEDI_O)
        medialDictionary[ScalarString([UNI_PA, UNI_U])] = ScalarString(GLYPH_MEDI_PA_MEDI_U)
        medialDictionary[ScalarString([UNI_PA, UNI_OE])] = ScalarString(GLYPH_MEDI_PA_MEDI_OE)
        medialDictionary[ScalarString([UNI_PA, UNI_UE])] = ScalarString(GLYPH_MEDI_PA_MEDI_UE)
        medialDictionary[ScalarString([UNI_PA, UNI_EE])] = ScalarString(GLYPH_MEDI_PA_MEDI_EE)
        medialDictionary[ScalarString([UNI_PA, UNI_MA])] = ScalarString(GLYPH_MEDI_PA_MEDI_MA)
        medialDictionary[ScalarString([UNI_PA, UNI_LA])] = ScalarString(GLYPH_MEDI_PA_MEDI_LA)
        medialDictionary[ScalarString([UNI_PA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_PA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_PA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_PA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_PA, UNI_QA])] = ScalarString(GLYPH_MEDI_PA_MEDI_QA)
        medialDictionary[ScalarString([UNI_PA, UNI_GA])] = ScalarString(GLYPH_MEDI_PA_MEDI_GA)
        medialDictionary[ScalarString([UNI_PA, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_PA_MEDI_NA_FVS1)
        medialDictionary[ScalarString(UNI_QA)] = ScalarString(GLYPH_MEDI_QA)
        medialDictionary[ScalarString([UNI_QA, FVS1])] = ScalarString(GLYPH_MEDI_QA_FVS1)
        medialDictionary[ScalarString([UNI_QA, FVS2])] = ScalarString(GLYPH_MEDI_QA_FVS2)
        medialDictionary[ScalarString([UNI_QA, UNI_E])] = ScalarString(GLYPH_MEDI_QA_MEDI_E)
        medialDictionary[ScalarString([UNI_QA, UNI_I])] = ScalarString(GLYPH_MEDI_QA_MEDI_I)
        medialDictionary[ScalarString([UNI_QA, UNI_OE])] = ScalarString(GLYPH_MEDI_QA_MEDI_OE)
        medialDictionary[ScalarString([UNI_QA, UNI_UE])] = ScalarString(GLYPH_MEDI_QA_MEDI_UE)
        medialDictionary[ScalarString([UNI_QA, UNI_EE])] = ScalarString(GLYPH_MEDI_QA_MEDI_EE)
        medialDictionary[ScalarString([UNI_QA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_QA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_QA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_QA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_QA, FVS3])] = ScalarString(GLYPH_MEDI_QA_FVS3)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_E])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_E)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_I])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_I)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_OE])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_OE)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_UE])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_UE)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_EE])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_EE)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_QA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FVS1_MEDI_UE_FVS1)
        medialDictionary[ScalarString(UNI_GA)] = ScalarString(GLYPH_MEDI_GA)
        medialDictionary[ScalarString([UNI_GA, FVS1])] = ScalarString(GLYPH_MEDI_GA_FVS1)
        medialDictionary[ScalarString([UNI_GA, FVS2])] = ScalarString(GLYPH_MEDI_GA_FVS2)
        medialDictionary[ScalarString([UNI_GA, FVS3])] = ScalarString(GLYPH_MEDI_GA_FVS3)
        medialDictionary[ScalarString([UNI_GA, UNI_E])] = ScalarString(GLYPH_MEDI_GA_MEDI_E)
        medialDictionary[ScalarString([UNI_GA, UNI_I])] = ScalarString(GLYPH_MEDI_GA_MEDI_I)
        medialDictionary[ScalarString([UNI_GA, UNI_OE])] = ScalarString(GLYPH_MEDI_GA_MEDI_OE)
        medialDictionary[ScalarString([UNI_GA, UNI_UE])] = ScalarString(GLYPH_MEDI_GA_MEDI_UE)
        medialDictionary[ScalarString([UNI_GA, UNI_EE])] = ScalarString(GLYPH_MEDI_GA_MEDI_EE)
        medialDictionary[ScalarString([UNI_GA, FVS3, UNI_MA])] = ScalarString(GLYPH_MEDI_GA_MEDI_MA)
        medialDictionary[ScalarString([UNI_GA, FVS3, UNI_LA])] = ScalarString(GLYPH_MEDI_GA_MEDI_LA)
        medialDictionary[ScalarString([UNI_GA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_GA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_GA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_GA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_GA, FVS3, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_GA_MEDI_NA_FVS1)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_E])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_E)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_I])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_I)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_OE])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_OE)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_UE])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_UE)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_EE])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_EE)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_GA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FVS1_MEDI_UE_FVS1)
        medialDictionary[ScalarString(UNI_MA)] = ScalarString(GLYPH_MEDI_MA)
        medialDictionary[ScalarString([UNI_MA, UNI_MA])] = ScalarString(GLYPH_MEDI_MA_MEDI_MA)
        medialDictionary[ScalarString([UNI_MA, UNI_LA])] = ScalarString(GLYPH_MEDI_MA_MEDI_LA)
        medialDictionary[ScalarString(UNI_LA)] = ScalarString(GLYPH_MEDI_LA)
        medialDictionary[ScalarString([UNI_LA, UNI_LA])] = ScalarString(GLYPH_MEDI_LA_MEDI_LA)
        medialDictionary[ScalarString(UNI_SA)] = ScalarString(GLYPH_MEDI_SA)
        medialDictionary[ScalarString(UNI_SHA)] = ScalarString(GLYPH_MEDI_SHA)
        medialDictionary[ScalarString(UNI_TA)] = ScalarString(GLYPH_MEDI_TA)
        medialDictionary[ScalarString([UNI_TA, FVS1])] = ScalarString(GLYPH_MEDI_TA_FVS1)
        medialDictionary[ScalarString([UNI_TA, FVS2])] = ScalarString(GLYPH_MEDI_TA_FVS2)
        medialDictionary[ScalarString(UNI_DA)] = ScalarString(GLYPH_MEDI_DA)
        medialDictionary[ScalarString([UNI_DA, FVS1])] = ScalarString(GLYPH_MEDI_DA_FVS1)
        medialDictionary[ScalarString([UNI_CHA])] = ScalarString(GLYPH_MEDI_CHA)
        medialDictionary[ScalarString(UNI_JA)] = ScalarString(GLYPH_MEDI_JA)
        medialDictionary[ScalarString(UNI_YA)] = ScalarString(GLYPH_MEDI_YA)
        medialDictionary[ScalarString([UNI_YA, FVS1])] = ScalarString(GLYPH_MEDI_YA_FVS1)
        medialDictionary[ScalarString(UNI_RA)] = ScalarString(GLYPH_MEDI_RA)
        medialDictionary[ScalarString(UNI_WA)] = ScalarString(GLYPH_MEDI_WA)
        medialDictionary[ScalarString([UNI_WA, FVS1])] = ScalarString(GLYPH_MEDI_WA_FVS1)
        medialDictionary[ScalarString(UNI_FA)] = ScalarString(GLYPH_MEDI_FA)
        medialDictionary[ScalarString([UNI_FA, UNI_A])] = ScalarString(GLYPH_MEDI_FA_MEDI_A)
        medialDictionary[ScalarString([UNI_FA, UNI_E])] = ScalarString(GLYPH_MEDI_FA_MEDI_E)
        medialDictionary[ScalarString([UNI_FA, UNI_I])] = ScalarString(GLYPH_MEDI_FA_MEDI_I)
        medialDictionary[ScalarString([UNI_FA, UNI_O])] = ScalarString(GLYPH_MEDI_FA_MEDI_O)
        medialDictionary[ScalarString([UNI_FA, UNI_U])] = ScalarString(GLYPH_MEDI_FA_MEDI_U)
        medialDictionary[ScalarString([UNI_FA, UNI_OE])] = ScalarString(GLYPH_MEDI_FA_MEDI_OE)
        medialDictionary[ScalarString([UNI_FA, UNI_UE])] = ScalarString(GLYPH_MEDI_FA_MEDI_UE)
        medialDictionary[ScalarString([UNI_FA, UNI_EE])] = ScalarString(GLYPH_MEDI_FA_MEDI_EE)
        medialDictionary[ScalarString([UNI_FA, UNI_MA])] = ScalarString(GLYPH_MEDI_FA_MEDI_MA)
        medialDictionary[ScalarString([UNI_FA, UNI_LA])] = ScalarString(GLYPH_MEDI_FA_MEDI_LA)
        medialDictionary[ScalarString([UNI_FA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_FA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_FA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_FA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_FA, UNI_QA])] = ScalarString(GLYPH_MEDI_FA_MEDI_QA)
        medialDictionary[ScalarString([UNI_FA, UNI_GA])] = ScalarString(GLYPH_MEDI_FA_MEDI_GA)
        medialDictionary[ScalarString([UNI_FA, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_FA_MEDI_NA_FVS1)
        medialDictionary[ScalarString(UNI_KA)] = ScalarString(GLYPH_MEDI_KA)
        medialDictionary[ScalarString([UNI_KA, UNI_A])] = ScalarString(GLYPH_MEDI_KA_MEDI_A)
        medialDictionary[ScalarString([UNI_KA, UNI_E])] = ScalarString(GLYPH_MEDI_KA_MEDI_E)
        medialDictionary[ScalarString([UNI_KA, UNI_I])] = ScalarString(GLYPH_MEDI_KA_MEDI_I)
        medialDictionary[ScalarString([UNI_KA, UNI_O])] = ScalarString(GLYPH_MEDI_KA_MEDI_O)
        medialDictionary[ScalarString([UNI_KA, UNI_U])] = ScalarString(GLYPH_MEDI_KA_MEDI_U)
        medialDictionary[ScalarString([UNI_KA, UNI_OE])] = ScalarString(GLYPH_MEDI_KA_MEDI_OE)
        medialDictionary[ScalarString([UNI_KA, UNI_UE])] = ScalarString(GLYPH_MEDI_KA_MEDI_UE)
        medialDictionary[ScalarString([UNI_KA, UNI_EE])] = ScalarString(GLYPH_MEDI_KA_MEDI_EE)
        medialDictionary[ScalarString([UNI_KA, UNI_MA])] = ScalarString(GLYPH_MEDI_KA_MEDI_MA)
        medialDictionary[ScalarString([UNI_KA, UNI_LA])] = ScalarString(GLYPH_MEDI_KA_MEDI_LA)
        medialDictionary[ScalarString([UNI_KA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_KA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_KA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_KA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_KA, UNI_QA])] = ScalarString(GLYPH_MEDI_KA_MEDI_QA)
        medialDictionary[ScalarString([UNI_KA, UNI_GA])] = ScalarString(GLYPH_MEDI_KA_MEDI_GA)
        medialDictionary[ScalarString([UNI_KA, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_KA_MEDI_NA_FVS1)
        medialDictionary[ScalarString(UNI_KHA)] = ScalarString(GLYPH_MEDI_KHA)
        medialDictionary[ScalarString([UNI_KHA, UNI_A])] = ScalarString(GLYPH_MEDI_KHA_MEDI_A)
        medialDictionary[ScalarString([UNI_KHA, UNI_E])] = ScalarString(GLYPH_MEDI_KHA_MEDI_E)
        medialDictionary[ScalarString([UNI_KHA, UNI_I])] = ScalarString(GLYPH_MEDI_KHA_MEDI_I)
        medialDictionary[ScalarString([UNI_KHA, UNI_O])] = ScalarString(GLYPH_MEDI_KHA_MEDI_O)
        medialDictionary[ScalarString([UNI_KHA, UNI_U])] = ScalarString(GLYPH_MEDI_KHA_MEDI_U)
        medialDictionary[ScalarString([UNI_KHA, UNI_OE])] = ScalarString(GLYPH_MEDI_KHA_MEDI_OE)
        medialDictionary[ScalarString([UNI_KHA, UNI_UE])] = ScalarString(GLYPH_MEDI_KHA_MEDI_UE)
        medialDictionary[ScalarString([UNI_KHA, UNI_EE])] = ScalarString(GLYPH_MEDI_KHA_MEDI_EE)
        medialDictionary[ScalarString([UNI_KHA, UNI_MA])] = ScalarString(GLYPH_MEDI_KHA_MEDI_MA)
        medialDictionary[ScalarString([UNI_KHA, UNI_LA])] = ScalarString(GLYPH_MEDI_KHA_MEDI_LA)
        medialDictionary[ScalarString([UNI_KHA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_KHA_MEDI_OE_FVS1)
        medialDictionary[ScalarString([UNI_KHA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_KHA_MEDI_UE_FVS1)
        medialDictionary[ScalarString([UNI_KHA, UNI_QA])] = ScalarString(GLYPH_MEDI_KHA_MEDI_QA)
        medialDictionary[ScalarString([UNI_KHA, UNI_GA])] = ScalarString(GLYPH_MEDI_KHA_MEDI_GA)
        medialDictionary[ScalarString([UNI_KHA, UNI_NA, FVS1])] = ScalarString(GLYPH_MEDI_KHA_MEDI_NA_FVS1)
        medialDictionary[ScalarString(UNI_TSA)] = ScalarString(GLYPH_MEDI_TSA)
        medialDictionary[ScalarString(UNI_ZA)] = ScalarString(GLYPH_MEDI_ZA)
        medialDictionary[ScalarString(UNI_HAA)] = ScalarString(GLYPH_MEDI_HAA)
        medialDictionary[ScalarString(UNI_ZRA)] = ScalarString(GLYPH_MEDI_ZRA)
        medialDictionary[ScalarString(UNI_LHA)] = ScalarString(GLYPH_MEDI_LHA)
        medialDictionary[ScalarString(UNI_ZHI)] = ScalarString(GLYPH_MEDI_ZHI)
        medialDictionary[ScalarString(UNI_CHI)] = ScalarString(GLYPH_MEDI_CHI)
        
        // MVS
        medialDictionary[ScalarString([UNI_NA, MVS])] = ScalarString(GLYPH_FINA_NA_FVS1)
        medialDictionary[ScalarString([UNI_ANG, UNI_QA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_QA)
        medialDictionary[ScalarString([UNI_ANG, FVS1, UNI_QA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_QA)
        medialDictionary[ScalarString([UNI_ANG, FVS1, UNI_GA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_GA)
        medialDictionary[ScalarString([UNI_ANG, UNI_GA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_GA)
        medialDictionary[ScalarString([UNI_BA, MVS])] = ScalarString(GLYPH_FINA_BA)
        medialDictionary[ScalarString([UNI_PA, MVS])] = ScalarString(GLYPH_FINA_PA)
        medialDictionary[ScalarString([UNI_QA, MVS])] = ScalarString(GLYPH_FINA_QA)
        medialDictionary[ScalarString([UNI_GA, MVS])] = ScalarString(GLYPH_FINA_GA_FVS3)
        medialDictionary[ScalarString([UNI_MA, MVS])] = ScalarString(GLYPH_FINA_MA)
        medialDictionary[ScalarString([UNI_LA, MVS])] = ScalarString(GLYPH_FINA_LA)
        medialDictionary[ScalarString([UNI_SA, MVS])] = ScalarString(GLYPH_FINA_SA)
        medialDictionary[ScalarString([UNI_SA, FVS1, MVS])] = ScalarString(GLYPH_FINA_SA_FVS1)
        medialDictionary[ScalarString([UNI_SHA, MVS])] = ScalarString(GLYPH_FINA_SHA)
        medialDictionary[ScalarString([UNI_TA, MVS])] = ScalarString(GLYPH_FINA_TA)
        medialDictionary[ScalarString([UNI_DA, MVS])] = ScalarString(GLYPH_FINA_DA_FVS1)
        medialDictionary[ScalarString([UNI_CHA, MVS])] = ScalarString(GLYPH_FINA_CHA)
        medialDictionary[ScalarString([UNI_JA, MVS])] = ScalarString(GLYPH_FINA_JA_FVS1)
        medialDictionary[ScalarString([UNI_YA, MVS])] = ScalarString(GLYPH_FINA_YA)
        medialDictionary[ScalarString([UNI_I, MVS])] = ScalarString(GLYPH_FINA_YA) // I may be a substitute for YA
        medialDictionary[ScalarString([UNI_RA, MVS])] = ScalarString(GLYPH_FINA_RA)
        medialDictionary[ScalarString([UNI_WA, MVS])] = ScalarString(GLYPH_FINA_WA)
        medialDictionary[ScalarString([UNI_FA, MVS])] = ScalarString(GLYPH_FINA_FA)
        medialDictionary[ScalarString([UNI_KA, MVS])] = ScalarString(GLYPH_FINA_KA)
        medialDictionary[ScalarString([UNI_KHA, MVS])] = ScalarString(GLYPH_FINA_KHA)
        medialDictionary[ScalarString([UNI_TSA, MVS])] = ScalarString(GLYPH_FINA_TSA)
        medialDictionary[ScalarString([UNI_ZA, MVS])] = ScalarString(GLYPH_FINA_ZA)
        medialDictionary[ScalarString([UNI_HAA, MVS])] = ScalarString(GLYPH_FINA_HAA)
        medialDictionary[ScalarString([UNI_ZRA, MVS])] = ScalarString(GLYPH_FINA_ZRA)
        medialDictionary[ScalarString([UNI_LHA, MVS])] = ScalarString(GLYPH_FINA_LHA)
        medialDictionary[ScalarString([UNI_ZHI, MVS])] = ScalarString(GLYPH_FINA_ZHI)
        medialDictionary[ScalarString([UNI_CHI, MVS])] = ScalarString(GLYPH_FINA_CHI)
        
        // Catch other chars
        medialDictionary[ScalarString(CURSOR_HOLDER)] = ScalarString(CURSOR_HOLDER)
        medialDictionary[ScalarString(MONGOLIAN_NIRUGU)] = ScalarString(GLYPH_NIRUGU)
        medialDictionary[ScalarString(ZWJ)] = ScalarString("")
        medialDictionary[ScalarString(NNBS)] = ScalarString(NNBS)
        medialDictionary[ScalarString(MVS)] = ScalarString("")
        medialDictionary[ScalarString(FVS1)] = ScalarString("")
        medialDictionary[ScalarString(FVS2)] = ScalarString("")
        medialDictionary[ScalarString(FVS3)] = ScalarString("")
        
    }
    
    func initFinal() {
        
        // NOTE: assuming MAXIMUM_SEARCH_LENGTH = 4
        
        finalDictionary[ScalarString(UNI_A)] = ScalarString(GLYPH_FINA_A)
        finalDictionary[ScalarString([UNI_A, FVS1])] = ScalarString(GLYPH_FINA_A_FVS1)
        finalDictionary[ScalarString([UNI_A, FVS2])] = ScalarString(GLYPH_FINA_A_FVS2)
        finalDictionary[ScalarString(UNI_E)] = ScalarString(GLYPH_FINA_E)
        finalDictionary[ScalarString([UNI_E, FVS1])] = ScalarString(GLYPH_FINA_E_FVS1)
        finalDictionary[ScalarString([UNI_E, FVS2])] = ScalarString(GLYPH_FINA_E_FVS2)
        finalDictionary[ScalarString(UNI_I)] = ScalarString(GLYPH_FINA_I)
        finalDictionary[ScalarString(UNI_O)] = ScalarString(GLYPH_FINA_O)
        finalDictionary[ScalarString([UNI_O, FVS1])] = ScalarString(GLYPH_FINA_O_FVS1)
        finalDictionary[ScalarString(UNI_U)] = ScalarString(GLYPH_FINA_U)
        finalDictionary[ScalarString([UNI_U, FVS1])] = ScalarString(GLYPH_FINA_U_FVS1)
        finalDictionary[ScalarString(UNI_OE)] = ScalarString(GLYPH_FINA_OE)
        finalDictionary[ScalarString([UNI_OE, FVS1])] = ScalarString(GLYPH_FINA_OE_FVS1)
        finalDictionary[ScalarString(UNI_UE)] = ScalarString(GLYPH_FINA_UE)
        finalDictionary[ScalarString([UNI_UE, FVS1])] = ScalarString(GLYPH_FINA_UE_FVS1)
        finalDictionary[ScalarString(UNI_EE)] = ScalarString(GLYPH_FINA_EE)
        finalDictionary[ScalarString(UNI_NA)] = ScalarString(GLYPH_FINA_NA)
        finalDictionary[ScalarString([UNI_NA, FVS1])] = ScalarString(GLYPH_FINA_NA_FVS1)
        finalDictionary[ScalarString(UNI_ANG)] = ScalarString(GLYPH_FINA_ANG)
        finalDictionary[ScalarString(UNI_BA)] = ScalarString(GLYPH_FINA_BA)
        finalDictionary[ScalarString([UNI_BA, UNI_A])] = ScalarString(GLYPH_MEDI_BA_FINA_A)
        finalDictionary[ScalarString([UNI_BA, UNI_E])] = ScalarString(GLYPH_MEDI_BA_FINA_E)
        finalDictionary[ScalarString([UNI_BA, UNI_I])] = ScalarString(GLYPH_MEDI_BA_FINA_I)
        finalDictionary[ScalarString([UNI_BA, UNI_O])] = ScalarString(GLYPH_MEDI_BA_FINA_O)
        finalDictionary[ScalarString([UNI_BA, UNI_U])] = ScalarString(GLYPH_MEDI_BA_FINA_U)
        finalDictionary[ScalarString([UNI_BA, UNI_OE])] = ScalarString(GLYPH_MEDI_BA_FINA_OE)
        finalDictionary[ScalarString([UNI_BA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_BA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_BA, UNI_UE])] = ScalarString(GLYPH_MEDI_BA_FINA_UE)
        finalDictionary[ScalarString([UNI_BA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_BA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_BA, UNI_EE])] = ScalarString(GLYPH_MEDI_BA_FINA_EE)
        finalDictionary[ScalarString(UNI_PA)] = ScalarString(GLYPH_FINA_PA)
        finalDictionary[ScalarString([UNI_PA, UNI_A])] = ScalarString(GLYPH_MEDI_PA_FINA_A)
        finalDictionary[ScalarString([UNI_PA, UNI_E])] = ScalarString(GLYPH_MEDI_PA_FINA_E)
        finalDictionary[ScalarString([UNI_PA, UNI_I])] = ScalarString(GLYPH_MEDI_PA_FINA_I)
        finalDictionary[ScalarString([UNI_PA, UNI_O])] = ScalarString(GLYPH_MEDI_PA_FINA_O)
        finalDictionary[ScalarString([UNI_PA, UNI_U])] = ScalarString(GLYPH_MEDI_PA_FINA_U)
        finalDictionary[ScalarString([UNI_PA, UNI_OE])] = ScalarString(GLYPH_MEDI_PA_FINA_OE)
        finalDictionary[ScalarString([UNI_PA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_PA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_PA, UNI_UE])] = ScalarString(GLYPH_MEDI_PA_FINA_UE)
        finalDictionary[ScalarString([UNI_PA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_PA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_PA, UNI_EE])] = ScalarString(GLYPH_MEDI_PA_FINA_EE)
        finalDictionary[ScalarString(UNI_QA)] = ScalarString(GLYPH_FINA_QA)
        finalDictionary[ScalarString([UNI_QA, FVS1])] = ScalarString(GLYPH_FINA_QA_FVS1)
        finalDictionary[ScalarString([UNI_QA, FVS2])] = ScalarString(GLYPH_FINA_QA_FVS2)
        finalDictionary[ScalarString([UNI_QA, UNI_E])] = ScalarString(GLYPH_MEDI_QA_FINA_E)
        finalDictionary[ScalarString([UNI_QA, UNI_I])] = ScalarString(GLYPH_MEDI_QA_FINA_I)
        finalDictionary[ScalarString([UNI_QA, UNI_OE])] = ScalarString(GLYPH_MEDI_QA_FINA_OE)
        finalDictionary[ScalarString([UNI_QA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_QA, UNI_UE])] = ScalarString(GLYPH_MEDI_QA_FINA_UE)
        finalDictionary[ScalarString([UNI_QA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_QA, UNI_EE])] = ScalarString(GLYPH_MEDI_QA_FINA_EE)
        finalDictionary[ScalarString(UNI_GA)] = ScalarString(GLYPH_FINA_GA)
        finalDictionary[ScalarString([UNI_GA, FVS1])] = ScalarString(GLYPH_FINA_GA_FVS1)
        finalDictionary[ScalarString([UNI_GA, FVS2])] = ScalarString(GLYPH_FINA_GA_FVS2)
        // TODO The FSV3 is just to make it compatible with Baiti
        finalDictionary[ScalarString([UNI_GA, FVS3])] = ScalarString(GLYPH_FINA_GA_FVS3)
        finalDictionary[ScalarString([UNI_GA, UNI_E])] = ScalarString(GLYPH_MEDI_GA_FINA_E)
        finalDictionary[ScalarString([UNI_GA, UNI_I])] = ScalarString(GLYPH_MEDI_GA_FINA_I)
        finalDictionary[ScalarString([UNI_GA, UNI_OE])] = ScalarString(GLYPH_MEDI_GA_FINA_OE)
        finalDictionary[ScalarString([UNI_GA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_GA, UNI_UE])] = ScalarString(GLYPH_MEDI_GA_FINA_UE)
        finalDictionary[ScalarString([UNI_GA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_GA, UNI_EE])] = ScalarString(GLYPH_MEDI_GA_FINA_EE)
        finalDictionary[ScalarString(UNI_MA)] = ScalarString(GLYPH_FINA_MA)
        finalDictionary[ScalarString(UNI_LA)] = ScalarString(GLYPH_FINA_LA)
        finalDictionary[ScalarString(UNI_SA)] = ScalarString(GLYPH_FINA_SA)
        finalDictionary[ScalarString(UNI_SHA)] = ScalarString(GLYPH_FINA_SHA)
        finalDictionary[ScalarString(UNI_TA)] = ScalarString(GLYPH_FINA_TA)
        finalDictionary[ScalarString(UNI_DA)] = ScalarString(GLYPH_FINA_DA)
        finalDictionary[ScalarString([UNI_DA, FVS1])] = ScalarString(GLYPH_FINA_DA_FVS1)
        finalDictionary[ScalarString(UNI_CHA)] = ScalarString(GLYPH_FINA_CHA)
        finalDictionary[ScalarString(UNI_JA)] = ScalarString(GLYPH_FINA_JA)
        finalDictionary[ScalarString([UNI_JA, FVS1])] = ScalarString(GLYPH_FINA_JA_FVS1)
        finalDictionary[ScalarString(UNI_YA)] = ScalarString(GLYPH_FINA_YA)
        finalDictionary[ScalarString(UNI_RA)] = ScalarString(GLYPH_FINA_RA)
        finalDictionary[ScalarString(UNI_WA)] = ScalarString(GLYPH_FINA_WA)
        finalDictionary[ScalarString([UNI_WA, FVS1])] = ScalarString(GLYPH_FINA_WA_FVS1)
        finalDictionary[ScalarString(UNI_FA)] = ScalarString(GLYPH_FINA_FA)
        finalDictionary[ScalarString([UNI_FA, UNI_A])] = ScalarString(GLYPH_MEDI_FA_FINA_A)
        finalDictionary[ScalarString([UNI_FA, UNI_E])] = ScalarString(GLYPH_MEDI_FA_FINA_E)
        finalDictionary[ScalarString([UNI_FA, UNI_I])] = ScalarString(GLYPH_MEDI_FA_FINA_I)
        finalDictionary[ScalarString([UNI_FA, UNI_O])] = ScalarString(GLYPH_MEDI_FA_FINA_O)
        finalDictionary[ScalarString([UNI_FA, UNI_U])] = ScalarString(GLYPH_MEDI_FA_FINA_U)
        finalDictionary[ScalarString([UNI_FA, UNI_OE])] = ScalarString(GLYPH_MEDI_FA_FINA_OE)
        finalDictionary[ScalarString([UNI_FA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_FA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_FA, UNI_UE])] = ScalarString(GLYPH_MEDI_FA_FINA_UE)
        finalDictionary[ScalarString([UNI_FA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_FA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_FA, UNI_EE])] = ScalarString(GLYPH_MEDI_FA_FINA_EE)
        finalDictionary[ScalarString(UNI_KA)] = ScalarString(GLYPH_FINA_KA)
        finalDictionary[ScalarString([UNI_KA, UNI_A])] = ScalarString(GLYPH_MEDI_KA_FINA_A)
        finalDictionary[ScalarString([UNI_KA, UNI_E])] = ScalarString(GLYPH_MEDI_KA_FINA_E)
        finalDictionary[ScalarString([UNI_KA, UNI_I])] = ScalarString(GLYPH_MEDI_KA_FINA_I)
        finalDictionary[ScalarString([UNI_KA, UNI_O])] = ScalarString(GLYPH_MEDI_KA_FINA_O)
        finalDictionary[ScalarString([UNI_KA, UNI_U])] = ScalarString(GLYPH_MEDI_KA_FINA_U)
        finalDictionary[ScalarString([UNI_KA, UNI_OE])] = ScalarString(GLYPH_MEDI_KA_FINA_OE)
        finalDictionary[ScalarString([UNI_KA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_KA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_KA, UNI_UE])] = ScalarString(GLYPH_MEDI_KA_FINA_UE)
        finalDictionary[ScalarString([UNI_KA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_KA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_KA, UNI_EE])] = ScalarString(GLYPH_MEDI_KA_FINA_EE)
        finalDictionary[ScalarString(UNI_KHA)] = ScalarString(GLYPH_FINA_KHA)
        finalDictionary[ScalarString([UNI_KHA, UNI_A])] = ScalarString(GLYPH_MEDI_KHA_FINA_A)
        finalDictionary[ScalarString([UNI_KHA, UNI_E])] = ScalarString(GLYPH_MEDI_KHA_FINA_E)
        finalDictionary[ScalarString([UNI_KHA, UNI_I])] = ScalarString(GLYPH_MEDI_KHA_FINA_I)
        finalDictionary[ScalarString([UNI_KHA, UNI_O])] = ScalarString(GLYPH_MEDI_KHA_FINA_O)
        finalDictionary[ScalarString([UNI_KHA, UNI_U])] = ScalarString(GLYPH_MEDI_KHA_FINA_U)
        finalDictionary[ScalarString([UNI_KHA, UNI_OE])] = ScalarString(GLYPH_MEDI_KHA_FINA_OE)
        finalDictionary[ScalarString([UNI_KHA, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_KHA_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_KHA, UNI_UE])] = ScalarString(GLYPH_MEDI_KHA_FINA_UE)
        finalDictionary[ScalarString([UNI_KHA, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_KHA_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_KHA, UNI_EE])] = ScalarString(GLYPH_MEDI_KHA_FINA_EE)
        finalDictionary[ScalarString(UNI_TSA)] = ScalarString(GLYPH_FINA_TSA)
        finalDictionary[ScalarString(UNI_ZA)] = ScalarString(GLYPH_FINA_ZA)
        finalDictionary[ScalarString(UNI_HAA)] = ScalarString(GLYPH_FINA_HAA)
        finalDictionary[ScalarString(UNI_ZRA)] = ScalarString(GLYPH_FINA_ZRA)
        finalDictionary[ScalarString(UNI_LHA)] = ScalarString(GLYPH_FINA_LHA)
        finalDictionary[ScalarString(UNI_ZHI)] = ScalarString(GLYPH_FINA_ZHI)
        finalDictionary[ScalarString(UNI_CHI)] = ScalarString(GLYPH_FINA_CHI)
        finalDictionary[ScalarString([UNI_SA, FVS1])] = ScalarString(GLYPH_FINA_SA_FVS1)
        finalDictionary[ScalarString([UNI_SA, FVS2])] = ScalarString(GLYPH_FINA_SA_FVS2)
        finalDictionary[ScalarString([UNI_BA, FVS1])] = ScalarString(GLYPH_FINA_BA_FVS1)
        finalDictionary[ScalarString([UNI_ANG, UNI_QA])] = ScalarString(GLYPH_MEDI_ANG_FINA_QA)
        finalDictionary[ScalarString([UNI_ANG, UNI_GA])] = ScalarString(GLYPH_MEDI_ANG_FINA_GA)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_E])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_E)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_I])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_I)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_OE])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_OE)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_UE])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_UE)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_QA, FVS1, UNI_EE])] = ScalarString(GLYPH_MEDI_QA_FVS1_FINA_EE)
        finalDictionary[ScalarString([UNI_NA, FVS2])] = ScalarString(GLYPH_FINA_NA_FVS2)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_E])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_E)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_I])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_I)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_OE])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_OE)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_OE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_OE_FVS1)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_UE])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_UE)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_UE, FVS1])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_UE_FVS1)
        finalDictionary[ScalarString([UNI_GA, FVS1, UNI_EE])] = ScalarString(GLYPH_MEDI_GA_FVS1_FINA_EE)
        
        // Final Vowel+YI rule (drop the Y)
        // (preFormatter catches final Consonant+YI)
        finalDictionary[ScalarString([UNI_YA, UNI_I])] = ScalarString(GLYPH_FINA_I)
        
        // MVS
        // TODO handle MVS in preFormatter()?
        finalDictionary[ScalarString([UNI_NA, MVS])] = ScalarString(GLYPH_FINA_NA_FVS1)
        finalDictionary[ScalarString([UNI_ANG, UNI_QA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_QA)
        finalDictionary[ScalarString([UNI_ANG, FVS1, UNI_QA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_QA)
        finalDictionary[ScalarString([UNI_ANG, FVS1, UNI_GA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_GA)
        finalDictionary[ScalarString([UNI_ANG, UNI_GA, MVS])] = ScalarString(GLYPH_MEDI_ANG_FINA_GA)
        finalDictionary[ScalarString([UNI_QA, MVS])] = ScalarString(GLYPH_FINA_QA)
        finalDictionary[ScalarString([UNI_GA, MVS])] = ScalarString(GLYPH_FINA_GA_FVS3)
        finalDictionary[ScalarString([UNI_MA, MVS])] = ScalarString(GLYPH_FINA_MA)
        finalDictionary[ScalarString([UNI_LA, MVS])] = ScalarString(GLYPH_FINA_LA)
        finalDictionary[ScalarString([UNI_JA, MVS])] = ScalarString(GLYPH_FINA_JA_FVS1)
        finalDictionary[ScalarString([UNI_YA, MVS])] = ScalarString(GLYPH_FINA_YA)
        finalDictionary[ScalarString([UNI_I, MVS])] = ScalarString(GLYPH_FINA_YA) // I may be a substitute for YA
        finalDictionary[ScalarString([UNI_RA, MVS])] = ScalarString(GLYPH_FINA_RA)
        finalDictionary[ScalarString([UNI_WA, MVS])] = ScalarString(GLYPH_FINA_WA)
        
        // Catch other chars
        finalDictionary[ScalarString(CURSOR_HOLDER)] = ScalarString(CURSOR_HOLDER)
        finalDictionary[ScalarString(MONGOLIAN_NIRUGU)] = ScalarString(GLYPH_NIRUGU)
        finalDictionary[ScalarString(ZWJ)] = ScalarString("")
        finalDictionary[ScalarString(NNBS)] = ScalarString(NNBS)
        finalDictionary[ScalarString(MVS)] = ScalarString("")
        finalDictionary[ScalarString(FVS1)] = ScalarString("")
        finalDictionary[ScalarString(FVS2)] = ScalarString("")
        finalDictionary[ScalarString(FVS3)] = ScalarString("")
        
    }
    
    func initSuffixes() {
        
        //mSuffixMap = new HashMap<String, String>()
        
        // Vocative Case
        suffixDictionary[ScalarString(UNI_A)] = ScalarString(GLYPH_FINA_A_FVS1)
        suffixDictionary[ScalarString(UNI_E)] = ScalarString(GLYPH_FINA_E_FVS1)
        
        // Genetive Case
        // YIN
        suffixDictionary[ScalarString([UNI_YA, UNI_I, UNI_NA])] = ScalarString([GLYPH_INIT_YA_FVS1, GLYPH_MEDI_I, GLYPH_FINA_NA])
        // UN
        suffixDictionary[ScalarString([UNI_U, UNI_NA])] = ScalarString([GLYPH_INIT_U_FVS1, GLYPH_FINA_NA])
        // UEN
        suffixDictionary[ScalarString([UNI_UE, UNI_NA])] = ScalarString([GLYPH_INIT_UE_FVS1, GLYPH_FINA_NA])
        // U
        suffixDictionary[ScalarString(UNI_U)] = ScalarString(GLYPH_ISOL_U_FVS2)
        // UE
        suffixDictionary[ScalarString(UNI_UE)] = ScalarString(GLYPH_ISOL_UE_FVS3)
        
        // Accusative Case
        // I
        suffixDictionary[ScalarString(UNI_I)] = ScalarString(GLYPH_ISOL_I_FVS1)
        // YI
        suffixDictionary[ScalarString([UNI_YA, UNI_I])] = ScalarString([GLYPH_INIT_YA_FVS1, GLYPH_FINA_I])
        
        // Dative-Locative Case
        // DU
        suffixDictionary[ScalarString([UNI_DA, UNI_U])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_FINA_U])
        // DUE
        suffixDictionary[ScalarString([UNI_DA, UNI_UE])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_FINA_UE])
        // TU
        suffixDictionary[ScalarString([UNI_TA, UNI_U])] = ScalarString([GLYPH_INIT_TA, GLYPH_FINA_U])
        // TUE
        suffixDictionary[ScalarString([UNI_TA, UNI_UE])] = ScalarString([GLYPH_INIT_TA, GLYPH_FINA_UE])
        // DUR
        suffixDictionary[ScalarString([UNI_DA, UNI_U, UNI_RA])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_U, GLYPH_FINA_RA])
        // DUER
        suffixDictionary[ScalarString([UNI_DA, UNI_UE, UNI_RA])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_UE, GLYPH_FINA_RA])
        // TUR
        suffixDictionary[ScalarString([UNI_TA, UNI_U, UNI_RA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_U, GLYPH_FINA_RA])
        // TUER
        suffixDictionary[ScalarString([UNI_TA, UNI_UE, UNI_RA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_UE, GLYPH_FINA_RA])
        // DAQI
        suffixDictionary[ScalarString([UNI_DA, UNI_A, UNI_QA, UNI_I])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_A, GLYPH_MEDI_QA_FINA_I])
        // DEQI
        suffixDictionary[ScalarString([UNI_DA, UNI_E, UNI_QA, UNI_I])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_E, GLYPH_MEDI_QA_FINA_I])
        
        // Ablative Case
        // ACHA
        suffixDictionary[ScalarString([UNI_A, UNI_CHA, UNI_A])] = ScalarString([GLYPH_INIT_A_FVS1, GLYPH_MEDI_CHA, GLYPH_FINA_A])
        // ECHE
        suffixDictionary[ScalarString([UNI_E, UNI_CHA, UNI_E])] = ScalarString([GLYPH_INIT_E, GLYPH_MEDI_CHA, GLYPH_FINA_E])
        
        // Instrumental Case
        // BAR
        suffixDictionary[ScalarString([UNI_BA, UNI_A, UNI_RA])] = ScalarString([GLYPH_INIT_BA_MEDI_A, GLYPH_FINA_RA])
        // BER
        suffixDictionary[ScalarString([UNI_BA, UNI_E, UNI_RA])] = ScalarString([GLYPH_INIT_BA_MEDI_E, GLYPH_FINA_RA])
        // IYAR
        suffixDictionary[ScalarString([UNI_I, UNI_YA, UNI_A, UNI_RA])] = ScalarString([GLYPH_INIT_I_FVS1, GLYPH_MEDI_I, GLYPH_MEDI_A, GLYPH_FINA_RA])
        // IYER
        suffixDictionary[ScalarString([UNI_I, UNI_YA, UNI_E, UNI_RA])] = ScalarString([GLYPH_INIT_I_FVS1, GLYPH_MEDI_I, GLYPH_MEDI_E, GLYPH_FINA_RA])
        
        // Comitative Case
        // TAI
        suffixDictionary[ScalarString([UNI_TA, UNI_A, UNI_I])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_A, GLYPH_FINA_I])
        suffixDictionary[ScalarString([UNI_TA, UNI_A, UNI_YA, UNI_I])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_A, GLYPH_FINA_I])
        // TEI
        suffixDictionary[ScalarString([UNI_TA, UNI_E, UNI_I])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_E, GLYPH_FINA_I])
        suffixDictionary[ScalarString([UNI_TA, UNI_E, UNI_YA, UNI_I])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_E, GLYPH_FINA_I])
        // LUG-A
        suffixDictionary[ScalarString([UNI_LA, UNI_U, UNI_GA, MVS, UNI_A])] = ScalarString([GLYPH_INIT_LA, GLYPH_MEDI_U, GLYPH_FINA_GA_FVS3, GLYPH_FINA_A_FVS2])
        // LUEGE
        suffixDictionary[ScalarString([UNI_LA, UNI_UE, UNI_GA, UNI_E])] = ScalarString([GLYPH_INIT_LA, GLYPH_MEDI_UE, GLYPH_MEDI_GA_FINA_E])
        
        // Reflexive Case
        // BAN
        suffixDictionary[ScalarString([UNI_BA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_BA_MEDI_A, GLYPH_FINA_NA])
        // BEN
        suffixDictionary[ScalarString([UNI_BA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_BA_MEDI_E, GLYPH_FINA_NA])
        // IYAN
        suffixDictionary[ScalarString([UNI_I, UNI_YA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_I_FVS1, GLYPH_MEDI_I, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // IYEN
        suffixDictionary[ScalarString([UNI_I, UNI_YA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_I_FVS1, GLYPH_MEDI_I, GLYPH_MEDI_E, GLYPH_FINA_NA])
        
        // Reflexive+Accusative
        // YUGAN
        suffixDictionary[ScalarString([UNI_YA, UNI_U, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_YA, GLYPH_MEDI_U, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // YUEGEN
        suffixDictionary[ScalarString([UNI_YA, UNI_UE, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_YA, GLYPH_MEDI_UE, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        
        // Reflexive+Dative-Locative
        // DAGAN
        suffixDictionary[ScalarString([UNI_DA, UNI_A, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_A, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // DEGEN
        suffixDictionary[ScalarString([UNI_DA, UNI_E, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_DA_FVS1, GLYPH_MEDI_E, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        // TAGAN
        suffixDictionary[ScalarString([UNI_TA, UNI_A, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_A, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // TEGEN
        suffixDictionary[ScalarString([UNI_TA, UNI_E, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_E, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        
        // Reflexive+Ablative
        // ACHAGAN
        suffixDictionary[ScalarString([UNI_A, UNI_CHA, UNI_A, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_A_FVS1, GLYPH_MEDI_CHA, GLYPH_MEDI_A, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // ECHEGEN
        suffixDictionary[ScalarString([UNI_E, UNI_CHA, UNI_E, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_E, GLYPH_MEDI_CHA, GLYPH_MEDI_E, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        
        // Reflexive+Comitative
        // TAIGAN
        suffixDictionary[ScalarString([UNI_TA, UNI_A, UNI_I, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_A, GLYPH_MEDI_I_FVS3, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        suffixDictionary[ScalarString([UNI_TA, UNI_A, UNI_YA, UNI_I, UNI_GA, UNI_A, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_A, GLYPH_MEDI_I_FVS3, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_A, GLYPH_FINA_NA])
        // TEIGEN
        suffixDictionary[ScalarString([UNI_TA, UNI_E, UNI_I, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_E, GLYPH_MEDI_I_FVS3, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        suffixDictionary[ScalarString([UNI_TA, UNI_E, UNI_YA, UNI_I, UNI_GA, UNI_E, UNI_NA])] = ScalarString([GLYPH_INIT_TA, GLYPH_MEDI_E, GLYPH_MEDI_I_FVS3, GLYPH_MEDI_GA_MEDI_E, GLYPH_FINA_NA])
        
        // Plural
        // UD
        suffixDictionary[ScalarString([UNI_U, UNI_DA])] = ScalarString([GLYPH_INIT_U_FVS1, GLYPH_FINA_DA])
        // UED
        suffixDictionary[ScalarString([UNI_UE, UNI_DA])] = ScalarString([GLYPH_INIT_UE_FVS1, GLYPH_FINA_DA])
        // NUGUD
        suffixDictionary[ScalarString([UNI_NA, UNI_U, UNI_GA, UNI_U, UNI_DA])] = ScalarString([GLYPH_INIT_NA, GLYPH_MEDI_U, GLYPH_MEDI_GA_FVS1, GLYPH_MEDI_U, GLYPH_FINA_DA])
        // NUEGUED
        suffixDictionary[ScalarString([UNI_NA, UNI_UE, UNI_GA, UNI_UE, UNI_DA])] = ScalarString([GLYPH_INIT_NA, GLYPH_MEDI_UE, GLYPH_MEDI_GA_MEDI_UE, GLYPH_FINA_DA])
        // NAR
        suffixDictionary[ScalarString([UNI_NA, UNI_A, UNI_RA])] = ScalarString([GLYPH_INIT_NA, GLYPH_MEDI_A, GLYPH_FINA_RA])
        // NER
        suffixDictionary[ScalarString([UNI_NA, UNI_E, UNI_RA])] = ScalarString([GLYPH_INIT_NA, GLYPH_MEDI_E, GLYPH_FINA_RA])
        
        // Question partical
        // UU
        suffixDictionary[ScalarString([UNI_U, UNI_U])] = ScalarString([GLYPH_WORD_UU])
        // UEUE
        suffixDictionary[ScalarString([UNI_UE, UNI_UE])] = ScalarString([GLYPH_WORD_UU])
        
    }
    
    
}



