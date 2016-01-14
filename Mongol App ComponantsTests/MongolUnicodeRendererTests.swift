
import XCTest
@testable import Mongol_App_Componants

class MongolUnicodeRendererTests: XCTestCase {
    
    func testUnicodeToGlyphs_emptyString_returnEmptyString() {
        
        // Arrange
        let unicode = ""
        let expected = ""
        let renderer = MongolUnicodeRenderer()
        
        // Act
        let result = renderer.unicodeToGlyphs(unicode)
        
        // Assert
        XCTAssertEqual(result, expected)
    }

    func testUnicodeToGlyphs_nonMongolString_returnSame() {
        
        // Arrange
        let unicode = "abc"
        let expected = unicode
        let renderer = MongolUnicodeRenderer()
        
        // Act
        let result = renderer.unicodeToGlyphs(unicode)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testUnicodeToGlyphs_IsolateI_returnGlyph() {
        
        // Arrange
        let unicode = "ᠢ"
        let expected = ""
        let renderer = MongolUnicodeRenderer()
        
        // Act
        let result = renderer.unicodeToGlyphs(unicode)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testUnicodeToGlyphs_InitialMedialFinalNom_returnGlyph() {
        
        // Arrange
        let unicode = "ᠨᠣᠮ"
        let expected = ""
        let renderer = MongolUnicodeRenderer()
        
        // Act
        let result = renderer.unicodeToGlyphs(unicode)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testUnicodeToGlyphs_MVS_returnGlyphs() {
                
        // Arrange
        let baina = "ᠪᠠᠢᠨ᠎ᠠ"
        let minggan = "ᠮᠢᠩᠭ᠎ᠡᠨ"
        let na = "‍ᠨ᠎ᠡ"
        let ngqa = "‍ᠩᠬ᠎ᠡ"
        let ngga = "‍ᠩᠭ᠎ᠡ"
        let qa = "‍ᠬ᠎ᠡ"
        let ga = "‍ᠭ᠎ᠡ"
        let ma = "‍ᠮ᠎ᠡ"
        let la = "‍ᠯ᠎ᠡ"
        let ya = "‍ᠶ᠎ᠡ" // y
        let wa = "‍ᠸ᠎ᠡ"
        let ia = "‍ᠢ᠎ᠡ" // i
        let ra = "‍ᠷ᠎ᠡ"
        
        let bainaExpected = ""
        let mingganExpected = ""
        let naExpected = ""
        let ngqaExpected = ""
        let nggaExpected = ""
        let qaExpected = ""
        let gaExpected = ""
        let maExpected = ""
        let laExpected = ""
        let yaExpected = "" // y
        let waExpected = ""
        let iaExpected = "" // i
        let raExpected = ""

        let renderer = MongolUnicodeRenderer()
        
        // Assert
        XCTAssertEqual(renderer.unicodeToGlyphs(baina), bainaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(minggan), mingganExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(na), naExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ngqa), ngqaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ngga), nggaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(qa), qaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ga), gaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ma), maExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(la), laExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ya), yaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(wa), waExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ia), iaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ra), raExpected)
    }
    
    // TODO: make more tests

    func testUnicodeToGlyphs_YiRuleNamayi_returnGlyphs() {
        
        // Arrange
        let unicode = "ᠨᠠᠮᠠᠶᠢ"
        let expected = ""
        let renderer = MongolUnicodeRenderer()
        
        // Act
        let result = renderer.unicodeToGlyphs(unicode)
        
        // Assert
        XCTAssertEqual(result, expected)
        
        // show
        print("Unicode: \(unicode), Rendered: \(result)")
    }
    
    // Words from "A Study of Traditional Mongolian Script Encodings and Rendering"
    func testUnicodeToGlyphs_wordList1_returnGlyphs() {
        
        // Arrange
        let biqig = "ᠪᠢᠴᠢᠭ"
        let egshig_inu = "ᠡᠭᠡᠰᠢᠭ ᠢᠨᠦ"
        let bujig_i_ben_yugen = "ᠪᠦᠵᠢᠭ ᠢ ᠪᠡᠨ ᠶᠦᠭᠡᠨ"
        let chirig_mini = "ᠴᠢᠷᠢᠭ ᠮᠠᠨᠢ"
        let egche = "ᠡᠭᠴᠡ"
        let hugjim_dur_iyen_degen = "ᠬᠦᠭᠵᠢᠮ ᠳᠦᠷ ᠢᠶᠡᠨ ᠳᠡᠭᠡᠨ"
        let buridgel_iyen = "ᠪᠦᠷᠢᠳᠭᠡᠯ ᠢᠶᠡᠨ"
        let sedgil_mini = "ᠰᠡᠳᠬᠢᠯ ᠮᠢᠨᠢ"
        let uiledburi_du = "ᠦᠢᠯᠠᠳᠪᠦᠷᠢ ᠳᠦ"
        let jeligudgen_u = "ᠵᠡᠯᠢᠭᠦᠳᠭᠡᠨ ᠦ"
        let manggal_dur_iyen_dagan = "ᠮᠠᠩᠭᠠᠯ ᠳᠤᠷ ᠢᠶᠠᠨ ᠳᠠᠭᠠᠨ"
        let dung_i = "ᠳ᠋ᠦᠩ ᠢ"
        let sodnam_acha_ban_achagan = "ᠰᠣᠳᠨᠠᠮ ᠠᠴᠠ ᠪᠠᠨ ᠠᠴᠠᠭᠠᠨ"
        let lhagba_luga = "ᡀᠠᠭᠪᠠ ᠯᠤᠭ᠎ᠠ"
        let cement_tayigan = "ᠼᠧᠮᠧᠨ᠋ᠲ ᠲᠠᠶᠢᠭᠠᠨ" // should't have FVS1 according to Unicode 8.0 draft
        let chebegmed_luge = "ᠴᠡᠪᠡᠭᠮᠡᠳ ᠯᠦᠭᠡ"
        let uniye_teyigen = "ᠦᠨᠢᠶ᠎ᠡ ᠲᠡᠶᠢᠭᠡᠨ"
        let hoyina = "ᠬᠣᠶᠢᠨ᠎ᠠ"
        let angna = "ᠠᠩᠨ᠎ᠠ" // missing gliph in font
        
        let biqigExpected = ""
        let egshig_inuExpected = " "
        let bujig_i_ben_yugenExpected = "   "
        let chirig_miniExpected = " "
        let egcheExpected = ""
        let hugjim_dur_iyen_degenExpected = "   "
        let buridgel_iyenExpected = " "
        let sedgil_miniExpected = " "
        let uiledburi_duExpected = " "
        let jeligudgen_uExpected = " "
        let manggal_dur_iyen_daganExpected = "   "
        let dung_iExpected = " "
        let sodnam_acha_ban_achaganExpected = "   "
        let lhagba_lugaExpected = " "
        let cement_tayiganExpected = " "
        let chebegmed_lugeExpected = " "
        let uniye_teyigenExpected = " "
        let hoyinaExpected = ""
        let angnaExpected = ""
        
        let renderer = MongolUnicodeRenderer()
        
        // Assert
        XCTAssertEqual(renderer.unicodeToGlyphs(biqig), biqigExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(egshig_inu), egshig_inuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(bujig_i_ben_yugen), bujig_i_ben_yugenExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(chirig_mini), chirig_miniExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(egche), egcheExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(hugjim_dur_iyen_degen), hugjim_dur_iyen_degenExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(buridgel_iyen), buridgel_iyenExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sedgil_mini), sedgil_miniExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(uiledburi_du), uiledburi_duExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(jeligudgen_u), jeligudgen_uExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(manggal_dur_iyen_dagan), manggal_dur_iyen_daganExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(dung_i), dung_iExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sodnam_acha_ban_achagan), sodnam_acha_ban_achaganExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(lhagba_luga), lhagba_lugaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(cement_tayigan), cement_tayiganExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(chebegmed_luge), chebegmed_lugeExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(uniye_teyigen), uniye_teyigenExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(hoyina), hoyinaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(angna), angnaExpected)
        
        // show
        print("Unicode: \(biqig), Rendered: \(renderer.unicodeToGlyphs(biqig))")
        print("Unicode: \(egshig_inu), Rendered: \(renderer.unicodeToGlyphs(egshig_inu))")
        print("Unicode: \(bujig_i_ben_yugen), Rendered: \(renderer.unicodeToGlyphs(bujig_i_ben_yugen))")
        print("Unicode: \(chirig_mini), Rendered: \(renderer.unicodeToGlyphs(chirig_mini))")
        print("Unicode: \(egche), Rendered: \(renderer.unicodeToGlyphs(egche))")
        print("Unicode: \(hugjim_dur_iyen_degen), Rendered: \(renderer.unicodeToGlyphs(hugjim_dur_iyen_degen))")
        print("Unicode: \(buridgel_iyen), Rendered: \(renderer.unicodeToGlyphs(buridgel_iyen))")
        print("Unicode: \(sedgil_mini), Rendered: \(renderer.unicodeToGlyphs(sedgil_mini))")
        print("Unicode: \(uiledburi_du), Rendered: \(renderer.unicodeToGlyphs(uiledburi_du))")
        print("Unicode: \(jeligudgen_u), Rendered: \(renderer.unicodeToGlyphs(jeligudgen_u))")
        print("Unicode: \(manggal_dur_iyen_dagan), Rendered: \(renderer.unicodeToGlyphs(manggal_dur_iyen_dagan))")
        print("Unicode: \(dung_i), Rendered: \(renderer.unicodeToGlyphs(dung_i))")
        print("Unicode: \(sodnam_acha_ban_achagan), Rendered: \(renderer.unicodeToGlyphs(sodnam_acha_ban_achagan))")
        print("Unicode: \(lhagba_luga), Rendered: \(renderer.unicodeToGlyphs(lhagba_luga))")
        print("Unicode: \(cement_tayigan), Rendered: \(renderer.unicodeToGlyphs(cement_tayigan))")
        print("Unicode: \(chebegmed_luge), Rendered: \(renderer.unicodeToGlyphs(chebegmed_luge))")
        print("Unicode: \(uniye_teyigen), Rendered: \(renderer.unicodeToGlyphs(uniye_teyigen))")
        print("Unicode: \(hoyina), Rendered: \(renderer.unicodeToGlyphs(hoyina))")
        print("Unicode: \(angna), Rendered: \(renderer.unicodeToGlyphs(angna))")

    }
    
    // Additional words
    func testUnicodeToGlyphs_wordList2_returnGlyphs() {
        
        // TODO: sort these out into different tests based on rules
        
        // Arrange
        let chingalahu = "ᠴᠢᠩᠭᠠᠯᠠᠬᠤ"
        let taljiyagsan = "ᠳᠠᠯᠵᠢᠶᠭᠰᠠᠨ"
        let ilbigchi = "ᠢᠯᠪᠢᠭᠴᠢ"
        let bichigchi = "ᠪᠢᠴᠢᠭᠴᠢ"
        let shigshiglehu = "ᠰᠢᠭᠰᠢᠭᠯᠡᠬᠦ"
        let tiglimsigsen = "ᠳᠢᠭᠯᠢᠮᠰᠢᠭᠰᠡᠨ"
        let chigiglig = "ᠴᠢᠭᠢᠭᠯᠢᠭ"
        let gram = "ᠭᠷᠠᠮ" // g+non-vowel words
        let mingga = "ᠮᠢᠩᠭ᠎ᠠ"
        let minggan = "ᠮᠢᠩᠭ᠎ᠠᠨ"
        let naima = "ᠨᠠᠢ᠌ᠮᠠ"
        let baina = "ᠪᠠᠢᠨ᠎ᠠ"
        let bayina = "ᠪᠠᠶᠢᠨ᠎ᠠ"
        let buu = "ᠪᠦᠦ"
        let huu = "ᠬᠦᠦ"
        let heuhed = "ᠬᠡᠦᠬᠡᠳ"
        let angli = "ᠠᠩᠭᠯᠢ"
        let soyol = "ᠰᠤᠶᠤᠯ"
        let saihan = "ᠰᠠᠢᠬᠠᠨ" // beautiful
        let sayihan = "ᠰᠠᠶ᠋ᠢᠬᠠᠨ" // recently
        let sayi = "ᠰᠠᠶᠢ" // old form - straight Y
        let sayiHooked = "ᠰᠠᠶ᠋ᠢ" // hooked y
        let naranGerel = "ᠨᠠᠷᠠᠨᠭᠡᠷᠡᠯ"
        let cholmonOdo = "ᠴᠣᠯᠮᠣᠨ᠍ᠣ᠋ᠳᠣ"
        //let sodoBilig = "ᠰᠣᠳᠣᠪᠢᠯᠢᠭ" // TODO: final g unspecified
        let sodoBilig2 = "ᠰᠣᠳᠣᠪᠢᠯᠢᠭ᠌" // final g is specified
        let erdeniTana = "ᠡᠷᠳᠡᠨᠢᠲ᠋ᠠᠨ᠎ᠠ" // two-part name, with second medial TA form
        let engheBold = "ᠡᠩᠬᠡᠪᠣᠯᠣᠳ"
        let bayanUnder = "ᠪᠠᠶᠠᠨ᠍ᠦ᠌ᠨᠳᠦᠷ"
        let biburie = "ᠪᠢᠪᠦᠷᠢ᠎ᠡ" // i-e as an alternate to y-e
        let asiglaju = "ᠠᠰᠢᠭᠯᠠᠵᠤ" // ig
        let eimu = "ᠡᠢᠮᠣ"
        let namayi = "ᠨᠠᠮᠠᠶᠢ"
        let heduin = "ᠬᠡᠳᠦᠢᠨ"
        
        let chingalahuExpected = ""
        let taljiyagsanExpected = ""
        let ilbigchiExpected = ""
        let bichigchiExpected = ""
        let shigshiglehuExpected = ""
        let tiglimsigsenExpected = ""
        let chigigligExpected = ""
        let gramExpected = ""
        let minggaExpected = ""
        let mingganExpected = ""
        let naimaExpected = ""
        let bainaExpected = ""
        let bayinaExpected = ""
        let buuExpected = ""
        let huuExpected = ""
        let heuhedExpected = ""
        let angliExpected = ""
        let soyolExpected = ""
        let saihanExpected = ""
        let sayihanExpected = ""
        let sayiExpected = ""
        let sayiHookedExpected = ""
        let naranGerelExpected = ""
        let cholmonOdoExpected = ""
        //let sodoBiligExpected = ""
        let sodoBilig2Expected = ""
        let erdeniTanaExpected = ""
        let engheBoldExpected = ""
        let bayanUnderExpected = ""
        let biburieExpected = ""
        let asiglajuExpected = ""
        let eimuExpected = ""
        let namayiExpected = ""
        let heduinExpected = ""
        
        let renderer = MongolUnicodeRenderer()
        
        // Assert
        XCTAssertEqual(renderer.unicodeToGlyphs(chingalahu), chingalahuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(taljiyagsan), taljiyagsanExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(ilbigchi), ilbigchiExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(bichigchi), bichigchiExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(shigshiglehu), shigshiglehuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(tiglimsigsen), tiglimsigsenExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(chigiglig), chigigligExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(gram), gramExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(mingga), minggaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(minggan), mingganExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(naima), naimaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(baina), bainaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(bayina), bayinaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(buu), buuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(huu), huuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(heuhed), heuhedExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(angli), angliExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(soyol), soyolExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(saihan), saihanExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sayihan), sayihanExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sayi), sayiExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sayiHooked), sayiHookedExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(naranGerel), naranGerelExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(cholmonOdo), cholmonOdoExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(sodoBilig2), sodoBilig2Expected)
        XCTAssertEqual(renderer.unicodeToGlyphs(erdeniTana), erdeniTanaExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(engheBold), engheBoldExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(bayanUnder), bayanUnderExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(biburie), biburieExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(asiglaju), asiglajuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(eimu), eimuExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(namayi), namayiExpected)
        XCTAssertEqual(renderer.unicodeToGlyphs(heduin), heduinExpected)
        
        // show
        print("Unicode: \(chingalahu), Rendered: \(renderer.unicodeToGlyphs(chingalahu))")
        print("Unicode: \(taljiyagsan), Rendered: \(renderer.unicodeToGlyphs(taljiyagsan))")
        print("Unicode: \(ilbigchi), Rendered: \(renderer.unicodeToGlyphs(ilbigchi))")
        print("Unicode: \(bichigchi), Rendered: \(renderer.unicodeToGlyphs(bichigchi))")
        print("Unicode: \(shigshiglehu), Rendered: \(renderer.unicodeToGlyphs(shigshiglehu))")
        print("Unicode: \(tiglimsigsen), Rendered: \(renderer.unicodeToGlyphs(tiglimsigsen))")
        print("Unicode: \(chigiglig), Rendered: \(renderer.unicodeToGlyphs(chigiglig))")
        print("Unicode: \(gram), Rendered: \(renderer.unicodeToGlyphs(gram))")
        print("Unicode: \(mingga), Rendered: \(renderer.unicodeToGlyphs(mingga))")
        print("Unicode: \(minggan), Rendered: \(renderer.unicodeToGlyphs(minggan))")
        print("Unicode: \(naima), Rendered: \(renderer.unicodeToGlyphs(naima))")
        print("Unicode: \(baina), Rendered: \(renderer.unicodeToGlyphs(baina))")
        print("Unicode: \(bayina), Rendered: \(renderer.unicodeToGlyphs(bayina))")
        print("Unicode: \(buu), Rendered: \(renderer.unicodeToGlyphs(buu))")
        print("Unicode: \(huu), Rendered: \(renderer.unicodeToGlyphs(huu))")
        
        print("Unicode: \(heuhed), Rendered: \(renderer.unicodeToGlyphs(heuhed))")
        print("Unicode: \(angli), Rendered: \(renderer.unicodeToGlyphs(angli))")
        print("Unicode: \(soyol), Rendered: \(renderer.unicodeToGlyphs(soyol))")
        print("Unicode: \(saihan), Rendered: \(renderer.unicodeToGlyphs(saihan))")
        print("Unicode: \(sayihan), Rendered: \(renderer.unicodeToGlyphs(sayihan))")
        print("Unicode: \(sayi), Rendered: \(renderer.unicodeToGlyphs(sayi))")
        print("Unicode: \(sayiHooked), Rendered: \(renderer.unicodeToGlyphs(sayiHooked))")
        print("Unicode: \(naranGerel), Rendered: \(renderer.unicodeToGlyphs(naranGerel))")
        print("Unicode: \(cholmonOdo), Rendered: \(renderer.unicodeToGlyphs(cholmonOdo))")
        //print("Unicode: \(sodoBilig), Rendered: \(renderer.unicodeToGlyphs(sodoBilig))")
        print("Unicode: \(sodoBilig2), Rendered: \(renderer.unicodeToGlyphs(sodoBilig2))")
        print("Unicode: \(erdeniTana), Rendered: \(renderer.unicodeToGlyphs(erdeniTana))")
        print("Unicode: \(engheBold), Rendered: \(renderer.unicodeToGlyphs(engheBold))")
        print("Unicode: \(bayanUnder), Rendered: \(renderer.unicodeToGlyphs(bayanUnder))")
        print("Unicode: \(biburie), Rendered: \(renderer.unicodeToGlyphs(biburie))")
        print("Unicode: \(asiglaju), Rendered: \(renderer.unicodeToGlyphs(asiglaju))")
        print("Unicode: \(eimu), Rendered: \(renderer.unicodeToGlyphs(eimu))")
        print("Unicode: \(namayi), Rendered: \(renderer.unicodeToGlyphs(namayi))")
        print("Unicode: \(heduin), Rendered: \(renderer.unicodeToGlyphs(heduin))")
        
    }
}
