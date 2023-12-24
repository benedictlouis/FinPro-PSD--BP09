# Final Project PSD BP9 - Morse Code Decoder & Encoder
## Background
Morse code is a method of encoding text characters using sequences of dots and dashes, which were originally devised by Samuel Morse and Alfred Vail in the early 1830s. It was initially developed for use with the electric telegraph, playing a crucial role in revolutionizing communication during the 19th century. The system assigns a unique combination of dots and dashes to each letter of the alphabet and numerals, allowing for the transmission of messages across telegraph wires using a simple on-off signaling mechanism.

The term Morse Code refers to either of two systems for representing letters of the alphabet, numerals, and punctuation marks by an arrangement of dots, dashes, and spaces. The codes are transmitted as electrical pulses of varied lengths or analogous mechanical or visual signals, such as flashing lights. The two systems are the original “American” Morse Code and the later International Morse Code, which became the global standard.


## How it works 
This program operates by providing a MorseTable containing a collection of arrays for both letters and numbers. To convert Morse code into binary, we represent a dot with 01 and a dash with 11. For example, Morse code A is represented in binary as 01110000, and Morse code 1 is represented in binary as 0111111111. In the MorseTable, there are a total of 4 arrays: 2 tables are used to match ASCII values with letters in Morse code, and the other 2 tables are used to match binary values with numbers in Morse code.

When the user inputs a letter or a number, the program undergoes the decoding process using the decode_morse_letter function for letter decoding and decode_morse_number for numbers. These functions contain loops that aim to match the input with Morse code values in the table. When a matching value is found, the program returns that value to be outputted.

![morse-poster_orig2](https://github.com/benedictlouis/FinPro-PSD--BP09/assets/142081888/5e78736f-45db-42db-ba04-1724f8cbb833)

## How to use 
During a program simulation, the user has two options: to decode a letter or a number. To decode a letter, the user must set d_enable to 0, and for a number, d_enable should be set to 1. When decoding a letter, the user can choose a letter from the ASCII table. After inputting the desired letter, the program will initiate the decoding process using a function containing a loop to match the ASCII values with their Morse code equivalents. If the user wants to encode and retrieve the input ASCII value, they need to set morse_letter to 1.

For decoding numbers, the user can select a number (0-9) from the binary_number table to be entered into decode_number_in. The decoding process for numbers is also carried out by a function with a loop to match the binary values equivalent to Morse code.

## Finite State Machine
Our program has 5 states: IDLE, DECODE_LETTER, ENCODE_LETTER, DECODE_NUMBER, and ENCODE_NUMBER

<img width="487" alt="statemachine_morse" src="https://github.com/benedictlouis/FinPro-PSD--BP09/assets/142081888/d2ae2334-1fd3-4236-ad41-0102c91293e3">

## Testing 
We tested our program by using a testbench for each file (LetterDecoder, LetterEncoder, NumberDecoder, and Number Encoder) to ensure that the output is accurate.

## Result
Our testing result shows that when the program is executed, the generated output is correct, both for decoding and encoding.

Decoding and Encoding a letter

![image](https://github.com/benedictlouis/FinPro-PSD--BP09/assets/142081888/164c5900-2b2a-40a9-8d71-47870a91da1b)

Decoding and Encoding a number

![image](https://github.com/benedictlouis/FinPro-PSD--BP09/assets/142081888/07d00ba5-5a0c-40f8-a52c-8ab50d7c7cba)
