module DecentralizedNotetTakingApp::Notes {
    use aptos_framework::signer;
    use aptos_framework::account;

    struct Note<phantom T> has key, store {
        owner: address,
        content: vector<u8>
    }

    public fun create_note<T>(owner: &signer, content: vector<u8>) {
        let note = Note<T> {
            owner: signer::address_of(owner),
            content
        };
        move_to(owner, note);
    }

    public fun update_note<T>(owner: &signer, new_content: vector<u8>) acquires Note<T> {
        let note = borrow_global_mut<Note<T>>(signer::address_of(owner));
        note.content = new_content;
    }

    public fun delete_note<T>(owner: &signer) acquires Note<T> {
        let note = move_from<Note<T>>(signer::address_of(owner));
        let Note<T> { owner: _, content: _ } = note;
    }
}