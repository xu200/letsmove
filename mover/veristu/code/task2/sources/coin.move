module task2::veristu_coin {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url::{Self,Url};

    public struct VERISTU_COIN has drop {}

    fun init(witness: VERISTU_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<VERISTU_COIN>(
            witness,
            9,
            b"VERISTU_COIN",
            b"VERISTU_COIN",
            b"coin create by veristu",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317650")),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<VERISTU_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }
    public fun burn(
        treasury_cap: &mut TreasuryCap<VERISTU_COIN>, 
        coin: Coin<VERISTU_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}