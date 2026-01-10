import Testing
@testable import Sertifikasi_ISB

struct AuthViewModelTests {

    @MainActor
    @Test func loginFailsWhenPasswordIsEmpty() async throws {
        let vm = AuthViewModel()
        
        vm.email = "juan@example.com"
        vm.password = ""
        
        await vm.login()
        
        #expect(vm.isLoggedIn == false)
    }
    
    @MainActor
    @Test func loginSuccess() async throws {
        let vm = AuthViewModel()
        
        vm.email = "member5@library.com"
        vm.password = "password12345"
        
        await vm.login()
        
        #expect(vm.isLoggedIn == true)
    }
}
