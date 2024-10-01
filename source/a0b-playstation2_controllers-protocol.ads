--
--  Copyright (C) 2024, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  PlayStation2 Controller support.
--
--  This package provides exchange buffer definition, and utilities to build
--  "command" packets.

pragma Restrictions (No_Elaboration_Code);

with A0B.Types;

package A0B.PlayStation2_Controllers.Protocol
  with Preelaborate
is

   type Communication_Buffer is
     array (A0B.Types.Unsigned_32 range 0 .. 31) of aliased A0B.Types.Unsigned_8
       with Alignment => 4, Size => 256;

   package Packet_Builder is

      procedure Poll (Buffer : out Communication_Buffer);
      --  0x42 command to poll controller's state.

      procedure Enter_Configuration_Mode (Buffer : out Communication_Buffer);
      --  0x43 command to enter configuration (escape) mode.

      procedure Leave_Configuration_Mode (Buffer : out Communication_Buffer);
      --  0x43 command to leave configuration (escape) mode.

      procedure Controller_Identification (Buffer : out Communication_Buffer);
      --  0x45 command to get identifier and status of analog mode.

      procedure Enable_Digital_Mode
        (Buffer : out Communication_Buffer; Lock : Boolean);
      --  0x44 command to enable digital mode, and lock mode when requested.

      procedure Enable_Analog_Mode
        (Buffer : out Communication_Buffer; Lock : Boolean);
      --  0x44 command to enable analog mode, and lock mode when requested.
      --  Note, it enables joysticks only, analog mode for buttons need to
      --  be enabled and configured separately with 0x4F and 0x40 commands.

      procedure Set_Analog_Polling_Mask (Buffer : out Communication_Buffer);
      --  0x4F command to set polling mask of analog buttons (enable for all
      --  buttons now). Note, each button need to be configured additionaly
      --  with 0x41 command.

      procedure Get_Analog_Polling_Mask (Buffer : out Communication_Buffer);
      --  0x41 command to get polling mask of analog buttons.

      procedure Enable_Analog_Button
        (Buffer : out Communication_Buffer;
         Button : A0B.Types.Unsigned_8);
      --  0x40 command to enables analog mode for the given button.

   end Packet_Builder;

end A0B.PlayStation2_Controllers.Protocol;