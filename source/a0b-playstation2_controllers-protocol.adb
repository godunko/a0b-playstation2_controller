--
--  Copyright (C) 2024, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

pragma Ada_2022;

package body A0B.PlayStation2_Controllers.Protocol is

   --------------------
   -- Packet_Builder --
   --------------------

   package body Packet_Builder is

      -------------------------------
      -- Controller_Identification --
      -------------------------------

      procedure Controller_Identification (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 16#5A#];

         Buffer (0) := 16#45#;
         Buffer (1) := 16#00#;
      end Controller_Identification;

      --------------------------
      -- Enable_Analog_Button --
      --------------------------

      procedure Enable_Analog_Button
        (Buffer : out Communication_Buffer;
         Button : A0B.Types.Unsigned_8) is
      begin
         Buffer := [others => 16#00#];

         Buffer (0) := 16#40#;
         Buffer (1) := 16#00#;

         Buffer (2) := Button;
         Buffer (3) := 16#02#;
      end Enable_Analog_Button;

      ------------------------
      -- Enable_Analog_Mode --
      ------------------------

      procedure Enable_Analog_Mode
        (Buffer : out Communication_Buffer; Lock : Boolean) is
      begin
         Buffer := [others => 16#00#];

         Buffer (0) := 16#44#;
         Buffer (1) := 16#00#;

         Buffer (2) := 16#01#;
         Buffer (3) := (if Lock then 16#03# else 16#00#);
         --  XXX It is unclear what this byte do actually.
      end Enable_Analog_Mode;

      -------------------------
      -- Enable_Digital_Mode --
      -------------------------

      procedure Enable_Digital_Mode
        (Buffer : out Communication_Buffer; Lock : Boolean) is
      begin
         Buffer := [others => 16#00#];

         Buffer (0) := 16#44#;
         Buffer (1) := 16#00#;

         Buffer (2) := 16#00#;
         Buffer (3) := (if Lock then 16#03# else 16#00#);
         --  XXX It is unclear what this byte do actually.
      end Enable_Digital_Mode;

      ------------------------------
      -- Enter_Configuration_Mode --
      ------------------------------

      procedure Enter_Configuration_Mode (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 16#00#];

         Buffer (0) := 16#43#;
         Buffer (1) := 16#00#;

         Buffer (2) := 16#01#;
      end Enter_Configuration_Mode;

      -----------------------------
      -- Get_Analog_Polling_Mask --
      -----------------------------

      procedure Get_Analog_Polling_Mask (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 16#5A#];

         Buffer (0) := 16#41#;
         Buffer (1) := 16#00#;
      end Get_Analog_Polling_Mask;

      ------------------------------
      -- Leave_Configuration_Mode --
      ------------------------------

      procedure Leave_Configuration_Mode (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 16#5A#];

         Buffer (0) := 16#43#;
         Buffer (1) := 16#00#;

         Buffer (2) := 16#00#;
      end Leave_Configuration_Mode;

      ----------
      -- Poll --
      ----------

      procedure Poll (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 0];

         Buffer (0) := 16#42#;
         Buffer (1) := 16#00#;

         --  Buffer (2) := WW;
         --  Buffer (3) := YY;
         --  XXX motor control is not implemented.
      end Poll;

      -----------------------------
      -- Set_Analog_Polling_Mask --
      -----------------------------

      procedure Set_Analog_Polling_Mask (Buffer : out Communication_Buffer) is
      begin
         Buffer := [others => 0];

         Buffer (0) := 16#4F#;
         Buffer (1) := 16#00#;

         Buffer (2) := 16#FF#;
         Buffer (3) := 16#FF#;
         Buffer (4) := 16#03#;
      end Set_Analog_Polling_Mask;

   end Packet_Builder;

end A0B.PlayStation2_Controllers.Protocol;