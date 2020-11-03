Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF62A439F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKCK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:59:56 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:34446 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgKCK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:59:56 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kZu2J-00035F-Ll; Tue, 03 Nov 2020 10:59:35 +0000
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <padmarao.begari@microchip.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
 <CAOnJCUKCbkZVGX5Rjputs9QQAHCvH6Fikt7kVGsyCkNjbdMv=Q@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <734904fe-975a-5908-d08c-266a5049deac@codethink.co.uk>
Date:   Tue, 3 Nov 2020 10:59:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUKCbkZVGX5Rjputs9QQAHCvH6Fikt7kVGsyCkNjbdMv=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2020 20:27, Atish Patra wrote:
> On Fri, Oct 30, 2020 at 2:05 AM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> Add initial DTS for Microchip ICICLE board having only
>>> essential devcies (clocks, sdhci, ethernet, serial, etc).
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>   arch/riscv/boot/dts/Makefile                  |   1 +
>>>   arch/riscv/boot/dts/microchip/Makefile        |   2 +
>>>   .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
>>
>> I suggest we split this DTS into two parts:
>> 1. SOC (microchip-polarfire.dtsi)
>> 2. Board (microchip-icicle-kit-a000.dts)
>>
>> This will be much cleaner and aligned with what is done
>> on other architectures.
>>
> 
> Sure. I will do that in v2.
> 
>>>   3 files changed, 316 insertions(+)
>>>   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>>>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>>>
>>> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
>>> index ca1f8cbd78c0..3ea94ea0a18a 100644
>>> --- a/arch/riscv/boot/dts/Makefile
>>> +++ b/arch/riscv/boot/dts/Makefile
>>> @@ -1,5 +1,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   subdir-y += sifive
>>>   subdir-y += kendryte
>>> +subdir-y += microchip
>>>
>>>   obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
>>> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
>>> new file mode 100644
>>> index 000000000000..55ad77521304
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/microchip/Makefile
>>> @@ -0,0 +1,2 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-icicle-kit-a000.dtb
>>> diff --git a/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>>> new file mode 100644
>>> index 000000000000..5848920af55c
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>>> @@ -0,0 +1,313 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/* Copyright (c) 2020 Microchip Technology Inc */
>>> +
>>> +/dts-v1/;
>>> +
>>> +/* Clock frequency (in Hz) of the rtcclk */
>>> +#define RTCCLK_FREQ            1000000
>>> +
>>> +/ {
>>> +       #address-cells = <2>;
>>> +       #size-cells = <2>;
>>> +       model = "Microchip PolarFire-SoC";
>>> +       compatible = "microchip,polarfire-soc";
>>> +
>>> +       chosen {
>>> +               stdout-path = &serial0;
>>> +       };
>>> +
>>> +       cpus {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +               timebase-frequency = <RTCCLK_FREQ>;
>>> +
>>> +               cpu@0 {
>>> +                       clock-frequency = <0>;
>>> +                       compatible = "sifive,rocket0", "riscv";
>>> +                       device_type = "cpu";
>>> +                       i-cache-block-size = <64>;
>>> +                       i-cache-sets = <128>;
>>> +                       i-cache-size = <16384>;
>>> +                       reg = <0>;
>>> +                       riscv,isa = "rv64imac";
>>> +                       status = "disabled";
>>> +
>>> +                       cpu0_intc: interrupt-controller {
>>> +                               #interrupt-cells = <1>;
>>> +                               compatible = "riscv,cpu-intc";
>>> +                               interrupt-controller;
>>> +                       };
>>> +               };
>>> +
>>> +               cpu@1 {
>>> +                       clock-frequency = <0>;
>>> +                       compatible = "sifive,rocket0", "riscv";
>>> +                       d-cache-block-size = <64>;
>>> +                       d-cache-sets = <64>;
>>> +                       d-cache-size = <32768>;
>>> +                       d-tlb-sets = <1>;
>>> +                       d-tlb-size = <32>;
>>> +                       device_type = "cpu";
>>> +                       i-cache-block-size = <64>;
>>> +                       i-cache-sets = <64>;
>>> +                       i-cache-size = <32768>;
>>> +                       i-tlb-sets = <1>;
>>> +                       i-tlb-size = <32>;
>>> +                       mmu-type = "riscv,sv39";
>>> +                       reg = <1>;
>>> +                       riscv,isa = "rv64imafdc";
>>> +                       tlb-split;
>>> +                       status = "okay";
>>> +
>>> +                       cpu1_intc: interrupt-controller {
>>> +                               #interrupt-cells = <1>;
>>> +                               compatible = "riscv,cpu-intc";
>>> +                               interrupt-controller;
>>> +                       };
>>> +               };
>>> +
>>> +               cpu@2 {
>>> +                       clock-frequency = <0>;
>>> +                       compatible = "sifive,rocket0", "riscv";
>>> +                       d-cache-block-size = <64>;
>>> +                       d-cache-sets = <64>;
>>> +                       d-cache-size = <32768>;
>>> +                       d-tlb-sets = <1>;
>>> +                       d-tlb-size = <32>;
>>> +                       device_type = "cpu";
>>> +                       i-cache-block-size = <64>;
>>> +                       i-cache-sets = <64>;
>>> +                       i-cache-size = <32768>;
>>> +                       i-tlb-sets = <1>;
>>> +                       i-tlb-size = <32>;
>>> +                       mmu-type = "riscv,sv39";
>>> +                       reg = <2>;
>>> +                       riscv,isa = "rv64imafdc";
>>> +                       tlb-split;
>>> +                       status = "okay";
>>> +
>>> +                       cpu2_intc: interrupt-controller {
>>> +                               #interrupt-cells = <1>;
>>> +                               compatible = "riscv,cpu-intc";
>>> +                               interrupt-controller;
>>> +                       };
>>> +               };
>>> +
>>> +               cpu@3 {
>>> +                       clock-frequency = <0>;
>>> +                       compatible = "sifive,rocket0", "riscv";
>>> +                       d-cache-block-size = <64>;
>>> +                       d-cache-sets = <64>;
>>> +                       d-cache-size = <32768>;
>>> +                       d-tlb-sets = <1>;
>>> +                       d-tlb-size = <32>;
>>> +                       device_type = "cpu";
>>> +                       i-cache-block-size = <64>;
>>> +                       i-cache-sets = <64>;
>>> +                       i-cache-size = <32768>;
>>> +                       i-tlb-sets = <1>;
>>> +                       i-tlb-size = <32>;
>>> +                       mmu-type = "riscv,sv39";
>>> +                       reg = <3>;
>>> +                       riscv,isa = "rv64imafdc";
>>> +                       tlb-split;
>>> +                       status = "okay";
>>> +
>>> +                       cpu3_intc: interrupt-controller {
>>> +                               #interrupt-cells = <1>;
>>> +                               compatible = "riscv,cpu-intc";
>>> +                               interrupt-controller;
>>> +                       };
>>> +               };
>>> +
>>> +               cpu@4 {
>>> +                       clock-frequency = <0>;
>>> +                       compatible = "sifive,rocket0", "riscv";
>>> +                       d-cache-block-size = <64>;
>>> +                       d-cache-sets = <64>;
>>> +                       d-cache-size = <32768>;
>>> +                       d-tlb-sets = <1>;
>>> +                       d-tlb-size = <32>;
>>> +                       device_type = "cpu";
>>> +                       i-cache-block-size = <64>;
>>> +                       i-cache-sets = <64>;
>>> +                       i-cache-size = <32768>;
>>> +                       i-tlb-sets = <1>;
>>> +                       i-tlb-size = <32>;
>>> +                       mmu-type = "riscv,sv39";
>>> +                       reg = <4>;
>>> +                       riscv,isa = "rv64imafdc";
>>> +                       tlb-split;
>>> +                       status = "okay";
>>> +                       cpu4_intc: interrupt-controller {
>>> +                               #interrupt-cells = <1>;
>>> +                               compatible = "riscv,cpu-intc";
>>> +                               interrupt-controller;
>>> +                       };
>>> +               };
>>> +       };
>>> +
>>> +       memory@80000000 {
>>> +               device_type = "memory";
>>> +               reg = <0x0 0x80000000 0x0 0x40000000>;
>>> +               clocks = <&clkcfg 26>;
>>> +       };
>>> +
>>> +       soc {
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               compatible = "simple-bus";
>>> +               ranges;
>>> +
>>> +               cache-controller@2010000 {
>>> +                       compatible = "sifive,fu540-c000-ccache", "cache";
>>> +                       cache-block-size = <64>;
>>> +                       cache-level = <2>;
>>> +                       cache-sets = <1024>;
>>> +                       cache-size = <2097152>;
>>> +                       cache-unified;
>>> +                       interrupt-parent = <&plic>;
>>> +                       interrupts = <1 2 3>;
>>> +                       reg = <0x0 0x2010000 0x0 0x1000>;
>>> +               };
>>> +
>>> +               clint@2000000 {
>>> +                       compatible = "riscv,clint0";
>>> +                       reg = <0x0 0x2000000 0x0 0xC000>;
>>> +                       interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
>>> +                                               &cpu1_intc 3 &cpu1_intc 7
>>> +                                               &cpu2_intc 3 &cpu2_intc 7
>>> +                                               &cpu3_intc 3 &cpu3_intc 7
>>> +                                               &cpu4_intc 3 &cpu4_intc 7>;
>>> +               };
>>> +
>>> +               plic: interrupt-controller@c000000 {
>>> +                       #interrupt-cells = <1>;
>>> +                       compatible = "sifive,plic-1.0.0";
>>> +                       reg = <0x0 0xc000000 0x0 0x4000000>;
>>> +                       riscv,ndev = <53>;
>>> +                       interrupt-controller;
>>> +                       interrupts-extended = <&cpu0_intc 11
>>> +                                       &cpu1_intc 11 &cpu1_intc 9
>>> +                                       &cpu2_intc 11 &cpu2_intc 9
>>> +                                       &cpu3_intc 11 &cpu3_intc 9
>>> +                                       &cpu4_intc 11 &cpu4_intc 9>;
>>> +               };
>>> +
>>> +               dma@3000000 {
>>> +                       compatible = "sifive,fu540-c000-pdma";
>>> +                       reg = <0x0 0x3000000 0x0 0x8000>;
>>> +                       interrupt-parent = <&plic>;
>>> +                       interrupts = <23 24 25 26 27 28 29 30>;
>>> +                       #dma-cells = <1>;
>>> +               };
>>> +
>>> +               refclk: refclk {
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +                       clock-frequency = <600000000>;
>>> +                       clock-output-names = "msspllclk";
>>> +               };
>>> +
>>> +               clkcfg: clkcfg@20002000 {
>>> +                       compatible = "microchip,pfsoc-clkcfg";
>>> +                       reg = <0x0 0x20002000 0x0 0x1000>;
>>> +                       reg-names = "mss_sysreg";
>>> +                       clocks = <&refclk>;
>>> +                       #clock-cells = <1>;
>>> +                       clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", "MMUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk", "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCclk", "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
>>> +               };
>>> +

H ow about doing something like
> 		clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk", "MAC0clk", 	/* 0 -4 */
> 				"MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", "MMUART1clk", /* 5-9 */

this means we can easily work out what clocks are in which index

As per the previos email, I'd leave these all populated as coming back 
and adding ones later is just going to be a pain with merge conflicts.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
