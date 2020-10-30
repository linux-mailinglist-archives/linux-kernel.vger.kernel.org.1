Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827FC29FE41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJ3HLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgJ3HLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:11:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:11:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p7so6485198ioo.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lCDu4YJEI+q9a2OpMirtjxhLxtnBQw3CAKzIexy7ftU=;
        b=OfSrZcIv5CT9u8kr0FCatES7KaXo/rTKyMvTz+Y3S4cIOJmgbNJucV4PGs9M0Bw4dT
         /newLtGLA8z0DkuLbX2k/rTDUQn8wqYmmL/FsQzH504jzpyUqKede0nCJPXw7uHNjsaz
         FiBmSXyVGtw+jGK48DgxRfO77/6WcVycNI2a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lCDu4YJEI+q9a2OpMirtjxhLxtnBQw3CAKzIexy7ftU=;
        b=nRrf7sv8RY6o5/b1qmNTuBW2L9Mxhk3Uu6EzhPJ+adHYLtIeaYtAjxGkJpa4p+PXG1
         8/6+GNFAcPc9g5acSJO4gAKHmTDVTPgUFzhE6ilsCYG5hS/CvOpCXa87BmSRElRxBdBs
         HcvZ6wU6EccXdxbeTrdPdQVwfrPriYLp7lsCpcq5eRcNfbQCODBVooits1UUoTFJYipK
         hQY/n4viDPE7h+AQAB0b9tX0KDt0iJ3iNwhOgQLtuy9KEPpRaFmhdcPWOgSIlgfP5zoA
         rhY5lUESz+bnoB3oK3iYXLUJ39nYFHFBMut0GuW0lKT995yR6LgX52b4qt9pOtDtB99+
         QkZw==
X-Gm-Message-State: AOAM530F9VFlXOArVYzIK9kltDr6MdpO4ym1syAcP8LSzi6stf9I9ZWU
        gYHaE100GCqs3OeMPsXo1dJuW0PlUZU14Ev2LaPF
X-Google-Smtp-Source: ABdhPJzhV12emgquuh/faM9LcKz6FglfK3ez3AVbqeCjH53Oo6frLWUWXoN0iCa9+pL863stDszhf6WpMYrMoIo1LNc=
X-Received: by 2002:a05:6638:2b3:: with SMTP id d19mr882266jaq.141.1604041875672;
 Fri, 30 Oct 2020 00:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
In-Reply-To: <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 30 Oct 2020 00:11:04 -0700
Message-ID: <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <padmarao.begari@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 3:24 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote=
:
>
> On 28/10/2020 23:27, Atish Patra wrote:
> > Add initial DTS for Microchip ICICLE board having only
> > essential devcies (clocks, sdhci, ethernet, serial, etc).
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >   arch/riscv/boot/dts/Makefile                  |   1 +
> >   arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >   .../microchip/microchip-icicle-kit-a000.dts   | 313 +++++++++++++++++=
+
> >   3 files changed, 316 insertions(+)
> >   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >   create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit=
-a000.dts
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefil=
e
> > index ca1f8cbd78c0..3ea94ea0a18a 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -1,5 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   subdir-y +=3D sifive
> >   subdir-y +=3D kendryte
> > +subdir-y +=3D microchip
> >
> >   obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> > diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/d=
ts/microchip/Makefile
> > new file mode 100644
> > index 000000000000..55ad77521304
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/microchip/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) +=3D microchip-icicle-kit-a000.d=
tb
> > diff --git a/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dt=
s b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> > new file mode 100644
> > index 000000000000..5848920af55c
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> > @@ -0,0 +1,313 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (c) 2020 Microchip Technology Inc */
> > +
> > +/dts-v1/;
> > +
> > +/* Clock frequency (in Hz) of the rtcclk */
> > +#define RTCCLK_FREQ          1000000
> > +
> > +/ {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +     model =3D "Microchip PolarFire-SoC";
> > +     compatible =3D "microchip,polarfire-soc";
> > +
> > +     chosen {
> > +             stdout-path =3D &serial0;
> > +     };
> > +
> > +     cpus {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             timebase-frequency =3D <RTCCLK_FREQ>;
> > +
> > +             cpu@0 {
> > +                     clock-frequency =3D <0>;
> > +                     compatible =3D "sifive,rocket0", "riscv";
> > +                     device_type =3D "cpu";
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-sets =3D <128>;
> > +                     i-cache-size =3D <16384>;
> > +                     reg =3D <0>;
> > +                     riscv,isa =3D "rv64imac";
> > +                     status =3D "disabled";
> > +
> > +                     cpu0_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu@1 {
> > +                     clock-frequency =3D <0>;
> > +                     compatible =3D "sifive,rocket0", "riscv";
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-sets =3D <64>;
> > +                     d-cache-size =3D <32768>;
> > +                     d-tlb-sets =3D <1>;
> > +                     d-tlb-size =3D <32>;
> > +                     device_type =3D "cpu";
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-sets =3D <64>;
> > +                     i-cache-size =3D <32768>;
> > +                     i-tlb-sets =3D <1>;
> > +                     i-tlb-size =3D <32>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     reg =3D <1>;
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     tlb-split;
> > +                     status =3D "okay";
> > +
> > +                     cpu1_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu@2 {
> > +                     clock-frequency =3D <0>;
> > +                     compatible =3D "sifive,rocket0", "riscv";
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-sets =3D <64>;
> > +                     d-cache-size =3D <32768>;
> > +                     d-tlb-sets =3D <1>;
> > +                     d-tlb-size =3D <32>;
> > +                     device_type =3D "cpu";
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-sets =3D <64>;
> > +                     i-cache-size =3D <32768>;
> > +                     i-tlb-sets =3D <1>;
> > +                     i-tlb-size =3D <32>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     reg =3D <2>;
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     tlb-split;
> > +                     status =3D "okay";
> > +
> > +                     cpu2_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu@3 {
> > +                     clock-frequency =3D <0>;
> > +                     compatible =3D "sifive,rocket0", "riscv";
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-sets =3D <64>;
> > +                     d-cache-size =3D <32768>;
> > +                     d-tlb-sets =3D <1>;
> > +                     d-tlb-size =3D <32>;
> > +                     device_type =3D "cpu";
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-sets =3D <64>;
> > +                     i-cache-size =3D <32768>;
> > +                     i-tlb-sets =3D <1>;
> > +                     i-tlb-size =3D <32>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     reg =3D <3>;
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     tlb-split;
> > +                     status =3D "okay";
> > +
> > +                     cpu3_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu@4 {
> > +                     clock-frequency =3D <0>;
> > +                     compatible =3D "sifive,rocket0", "riscv";
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-sets =3D <64>;
> > +                     d-cache-size =3D <32768>;
> > +                     d-tlb-sets =3D <1>;
> > +                     d-tlb-size =3D <32>;
> > +                     device_type =3D "cpu";
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-sets =3D <64>;
> > +                     i-cache-size =3D <32768>;
> > +                     i-tlb-sets =3D <1>;
> > +                     i-tlb-size =3D <32>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     reg =3D <4>;
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     tlb-split;
> > +                     status =3D "okay";
> > +                     cpu4_intc: interrupt-controller {
> > +                             #interrupt-cells =3D <1>;
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x0 0x80000000 0x0 0x40000000>;
> > +             clocks =3D <&clkcfg 26>;
> > +     };
>
> U-boot doesn't seem to be updating this properly.
>
> The board should have 2GiB, confirmed by looking at the device's
> chip markings. We only see 1GiB memory. The 0x80000000 bus window
> is only capable of dealing with 1GiB memory. The higher 64-bit one
> can have 16GiB mapped.
>
> Do we need a second node for the second GiB of memory?
>
We could just modify the reg size but to allow more memory. I tried
that for Linux but it didn't boot.
Probably, DDR init code in HSS only initialized 1GB of memory.

> > +
> > +     soc {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             compatible =3D "simple-bus";
> > +             ranges;
> > +
> > +             cache-controller@2010000 {
> > +                     compatible =3D "sifive,fu540-c000-ccache", "cache=
";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-size =3D <2097152>;
> > +                     cache-unified;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <1 2 3>;
> > +                     reg =3D <0x0 0x2010000 0x0 0x1000>;
> > +             };
> > +
> > +             clint@2000000 {
> > +                     compatible =3D "riscv,clint0";
> > +                     reg =3D <0x0 0x2000000 0x0 0xC000>;
> > +                     interrupts-extended =3D <&cpu0_intc 3 &cpu0_intc =
7
> > +                                             &cpu1_intc 3 &cpu1_intc 7
> > +                                             &cpu2_intc 3 &cpu2_intc 7
> > +                                             &cpu3_intc 3 &cpu3_intc 7
> > +                                             &cpu4_intc 3 &cpu4_intc 7=
>;
> > +             };
> > +
> > +             plic: interrupt-controller@c000000 {
> > +                     #interrupt-cells =3D <1>;
> > +                     compatible =3D "sifive,plic-1.0.0";
> > +                     reg =3D <0x0 0xc000000 0x0 0x4000000>;
> > +                     riscv,ndev =3D <53>;
> > +                     interrupt-controller;
> > +                     interrupts-extended =3D <&cpu0_intc 11
> > +                                     &cpu1_intc 11 &cpu1_intc 9
> > +                                     &cpu2_intc 11 &cpu2_intc 9
> > +                                     &cpu3_intc 11 &cpu3_intc 9
> > +                                     &cpu4_intc 11 &cpu4_intc 9>;
> > +             };
> > +
> > +             dma@3000000 {
> > +                     compatible =3D "sifive,fu540-c000-pdma";
> > +                     reg =3D <0x0 0x3000000 0x0 0x8000>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <23 24 25 26 27 28 29 30>;
> > +                     #dma-cells =3D <1>;
> > +             };
> > +
> > +             refclk: refclk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <600000000>;
> > +                     clock-output-names =3D "msspllclk";
> > +             };
> > +
> > +             clkcfg: clkcfg@20002000 {
> > +                     compatible =3D "microchip,pfsoc-clkcfg";
> > +                     reg =3D <0x0 0x20002000 0x0 0x1000>;
> > +                     reg-names =3D "mss_sysreg";
> > +                     clocks =3D <&refclk>;
> > +                     #clock-cells =3D <1>;
> > +                     clock-output-names =3D "cpuclk", "axiclk", "ahbcl=
k", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", "M=
MUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk",=
 "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCclk"=
, "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "FIC=
1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
>
> Any chance of making this list multi-line, it is difficult to read as-is.
>

Yes. We can also get rid of a few names that are not used. I will fix it in=
 v2.

> > +             };
> > +
> > +             serial0: serial@20000000 {
> > +                     compatible =3D "ns16550a";
> > +                     reg =3D <0x0 0x20000000 0x0 0x400>;
> > +                     reg-io-width =3D <4>;
> > +                     reg-shift =3D <2>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <90>;
> > +                     current-speed =3D <115200>;
> > +                     clocks =3D <&clkcfg 8>;
> > +                     status =3D "okay";
> > +             };
> > +
> > +             serial1: serial@20100000 {
> > +                     compatible =3D "ns16550a";
> > +                     reg =3D <0x0 0x20100000 0x0 0x400>;
> > +                     reg-io-width =3D <4>;
> > +                     reg-shift =3D <2>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <91>;
> > +                     current-speed =3D <115200>;
> > +                     clocks =3D <&clkcfg 9>;
> > +                     status =3D "okay";
> > +             };
> > +
> > +             serial2: serial@20102000 {
> > +                     compatible =3D "ns16550a";
> > +                     reg =3D <0x0 0x20102000 0x0 0x400>;
> > +                     reg-io-width =3D <4>;
> > +                     reg-shift =3D <2>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <92>;
> > +                     current-speed =3D <115200>;
> > +                     clocks =3D <&clkcfg 10>;
> > +                     status =3D "okay";
> > +             };
> > +
> > +             serial3: serial@20104000 {
> > +                     compatible =3D "ns16550a";
> > +                     reg =3D <0x0 0x20104000 0x0 0x400>;
> > +                     reg-io-width =3D <4>;
> > +                     reg-shift =3D <2>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <93>;
> > +                     current-speed =3D <115200>;
> > +                     clocks =3D <&clkcfg 11>;
> > +                     status =3D "okay";
> > +             };
> > +
> > +             sdcard: sdhc@20008000 {
> > +                     compatible =3D "cdns,sd4hc";
> > +                     reg =3D <0x0 0x20008000 0x0 0x1000>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <88>;
> > +                     pinctrl-names =3D "default";
> > +                     clocks =3D <&clkcfg 6>;
> > +                     bus-width =3D <4>;
> > +                     disable-wp;
> > +                     no-1-8-v;
> > +                     cap-mmc-highspeed;
> > +                     cap-sd-highspeed;
> > +                     card-detect-delay =3D <200>;
> > +                     sd-uhs-sdr12;
> > +                     sd-uhs-sdr25;
> > +                     sd-uhs-sdr50;
> > +                     sd-uhs-sdr104;
> > +                     max-frequency =3D <200000000>;
> > +                     status =3D "okay";
> > +             };
>
> Given eMMC is the default device, shouldn't that be default for the
> device tree too? Even if not, having the emmc node here would be a
> good thing as it is different to the SD node.
>

I tested this device tree with sdcard. That's why, I just picked the
sdcard node.
I am not sure if both eMMC & sdcard node can co-exist. The polar fire
soc github repo
seems to point that both of them have the same address and only 1 can be en=
abled
at that time. That may not be true now as the github repo has not been
updated in
couple of months.

@Cyril : Can we enable both eMMC & sdcard at the same time ?

> > +
> > +             emac1: ethernet@20112000 {
> > +                     compatible =3D "cdns,macb";
> > +                     reg =3D <0x0 0x20112000 0x0 0x2000>;
> > +                     interrupt-parent =3D <&plic>;
> > +                     interrupts =3D <70 71 72 73>;
> > +                     mac-address =3D [56 34 12 00 FC 00];
> > +                     phy-mode =3D "sgmii";
> > +                     clocks =3D <&clkcfg 5>, <&clkcfg 2>;
> > +                     clock-names =3D "pclk", "hclk";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     phy1: ethernet-phy@9 {
> > +                             reg =3D <9>;
> > +                             ti,fifo-depth =3D <0x01>;
> > +                     };
> > +             };
>
> Aren't there two ethernet ports on the board?
>

Yes. I hadn't tested that out. I will test it and add the 2nd one as well.

> Also, at the moment u-boot is not filling the MAC address parameter
> in so we've got at two boards on the network with the same MAC until
> we override it in the device tree for the second.
>

Looking at latest U-Boot patches, it seems it updates the mac address
from the serial number.

> > +
> > +             uio_axi_lsram@2030000000 {
> > +                     compatible =3D "generic-uio";
> > +                     reg =3D <0x20 0x30000000 0 0x80000000 >;
> > +                     status =3D "okay";
> > +             };
> > +     };
> > +};
> >
>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
