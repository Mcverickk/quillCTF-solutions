# Confidential Hash

The [challenge](https://quillctf.super.site/challenges/quillctf-challenges/ctf02) is to find the keccak256 hash of aliceHash and bobHash. 


## Vulnerability & Solution

`private` visibility in solidity means that we can only access the variable or function from the contract it is defined. `private` , `public` , `internal` & `external` are used to define the scope of the variables & functions. It does not mean we cannot access the `private` variable's value or that it is encrypted.

State variables in solidity are stored in slots of 256 bits in the order they are defined inside the contract. We will use this knowledge to read the value stored inside `aliceHash` and `bobHash`.

We can see from the Confidential Hash contract that all the variables defined take up 256 bits of space. So, each variable is stored in a separate slot. `aliceHash` & `bobHash` according to the sequence they are defined, are stored in slot numbers 4 & 9, respectively. We can go to the contract address in Etherscan and search for them in the state variables.

From there, the value of `aliceHash` is 0x448e5df1a6908f8d17fae934d9ae3f0c63545235f8ff393c6777194cae281478 and `bobHash` is 0x98290e06bee00d6b6f34095a54c4087297e3285d457b140128c1c2f3b62a41bd.

Now we can get the hash of the two hashed by using `hash(bytes32 key1, bytes32 key2)` inside the Confidential Hash contract. 

We can check if we got the correct hash using the function `checkthehash(bytes32 _hash)`. 
