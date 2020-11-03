Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA82A4902
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKCPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgKCPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:07:50 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FBC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:07:49 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id k1so16373792ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xNyKmWJoRtvhr3nBgnKdbKyr6U7m7nlOdcOfsuPpMQ=;
        b=PqeGC7P1v40wbHUtY2aJiCcl8od54qwCRI9yOaV6g4T8e7ONb9o4MvVbCWDTZ83Xfm
         RZmBJoDqNry26qSxbRSQFLAXSHWx7a/pW9KU9TESOz6+e8ODvxVJJvnMNglPAnMogzF5
         TGoPngBC2yJ1Qnprs5DfbwBU9yjMuiJHwNUV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xNyKmWJoRtvhr3nBgnKdbKyr6U7m7nlOdcOfsuPpMQ=;
        b=W1sLk0BLH18F0DKnYS0xkdS6VYJtDj93WEg5k3ugjZp2mETvid3AhLb2zx4RQRZDXg
         gCMAx9zIk6A1k4uBj9FEf75m5dowFePAUGVzcvxmCliCRaTKJiND2QfDqvjpq6qRVrN4
         fwx3NsF/8S8kWNlrL+hnzvld4N1qDMu9KulpR9i4YyPyPqZZf441WO0J+NL6Nlc0zuBV
         f+f5pMRhXbpiW7/XVS6EXfM9BDoRzHCjQtwdYwa4IIGGbfgfj5OF49qvG5hVJhkg+TPq
         Y+DWRGV6FEoqpcUiOkWOSgUK4TBNrs+l8+AnvyqxCRFV8KIilB8wDEtjtlpCf3xO3HuP
         +1WQ==
X-Gm-Message-State: AOAM532V8d2ipQUTTOxvxyaO5k8QR0enYWKTMaZR+BpoGtm1RG1nfTTT
        GX2AkXRiIHKGSlGo9t0/QyKs9uGlJ6Ew2cQRBi9O
X-Google-Smtp-Source: ABdhPJzBoXbifoV79nUrJqApfRTrWry4Q1R6vp+AudUsYkMDpTqPRTVLybsgfB9FapUJ/VJktoWYr1YF/Xgfjv7fPcQ=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr15775742ilm.79.1604416068801;
 Tue, 03 Nov 2020 07:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk> <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
 <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk>
In-Reply-To: <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 Nov 2020 07:07:36 -0800
Message-ID: <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Ben Dooks <ben.dooks@codethink.co.uk>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 2:20 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote=
:
>
> On 30/10/2020 07:11, Atish Patra wrote:
> > On Thu, Oct 29, 2020 at 3:24 AM Ben Dooks <ben.dooks@codethink.co.uk> w=
rote:
> >>
> >> On 28/10/2020 23:27, Atish Patra wrote:
> >>> Add initial DTS for Microchip ICICLE board having only
> >>> essential devcies (clocks, sdhci, ethernet, serial, etc).
> >>>
> >>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >>> ---
> >>>    arch/riscv/boot/dts/Makefile                  |   1 +
> >>>    arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >>>    .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++=
++++
> >>>    3 files changed, 316 insertions(+)
> >>>    create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >>>    create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-=
kit-a000.dts
> >>>
> >>> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makef=
ile
> >>> index ca1f8cbd78c0..3ea94ea0a18a 100644
> >>> --- a/arch/riscv/boot/dts/Makefile
> >>> +++ b/arch/riscv/boot/dts/Makefile
> >>> @@ -1,5 +1,6 @@
> >>>    # SPDX-License-Identifier: GPL-2.0
> >>>    subdir-y +=3D sifive
> >>>    subdir-y +=3D kendryte
> >>> +subdir-y +=3D microchip
> >>>
> >>>    obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> >>> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot=
/dts/microchip/Makefile
> >>> new file mode 100644
> >>> index 000000000000..55ad77521304
> >>> --- /dev/null
> >>> +++ b/arch/riscv/boot/dts/microchip/Makefile
> >>> @@ -0,0 +1,2 @@
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) +=3D microchip-icicle-kit-a000=
.dtb
> >>> diff --git a/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.=
dts b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> >>> new file mode 100644
> >>> index 000000000000..5848920af55c
> >>> --- /dev/null
> >>> +++ b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> >>> @@ -0,0 +1,313 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/* Copyright (c) 2020 Microchip Technology Inc */
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +/* Clock frequency (in Hz) of the rtcclk */
> >>> +#define RTCCLK_FREQ          1000000
> >>> +
> >>> +/ {
> >>> +     #address-cells =3D <2>;
> >>> +     #size-cells =3D <2>;
> >>> +     model =3D "Microchip PolarFire-SoC";
> >>> +     compatible =3D "microchip,polarfire-soc";
> >>> +
> >>> +     chosen {
> >>> +             stdout-path =3D &serial0;
> >>> +     };
> >>> +
> >>> +     cpus {
> >>> +             #address-cells =3D <1>;
> >>> +             #size-cells =3D <0>;
> >>> +             timebase-frequency =3D <RTCCLK_FREQ>;
> >>> +
> >>> +             cpu@0 {
> >>> +                     clock-frequency =3D <0>;
> >>> +                     compatible =3D "sifive,rocket0", "riscv";
> >>> +                     device_type =3D "cpu";
> >>> +                     i-cache-block-size =3D <64>;
> >>> +                     i-cache-sets =3D <128>;
> >>> +                     i-cache-size =3D <16384>;
> >>> +                     reg =3D <0>;
> >>> +                     riscv,isa =3D "rv64imac";
> >>> +                     status =3D "disabled";
> >>> +
> >>> +                     cpu0_intc: interrupt-controller {
> >>> +                             #interrupt-cells =3D <1>;
> >>> +                             compatible =3D "riscv,cpu-intc";
> >>> +                             interrupt-controller;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             cpu@1 {
> >>> +                     clock-frequency =3D <0>;
> >>> +                     compatible =3D "sifive,rocket0", "riscv";
> >>> +                     d-cache-block-size =3D <64>;
> >>> +                     d-cache-sets =3D <64>;
> >>> +                     d-cache-size =3D <32768>;
> >>> +                     d-tlb-sets =3D <1>;
> >>> +                     d-tlb-size =3D <32>;
> >>> +                     device_type =3D "cpu";
> >>> +                     i-cache-block-size =3D <64>;
> >>> +                     i-cache-sets =3D <64>;
> >>> +                     i-cache-size =3D <32768>;
> >>> +                     i-tlb-sets =3D <1>;
> >>> +                     i-tlb-size =3D <32>;
> >>> +                     mmu-type =3D "riscv,sv39";
> >>> +                     reg =3D <1>;
> >>> +                     riscv,isa =3D "rv64imafdc";
> >>> +                     tlb-split;
> >>> +                     status =3D "okay";
> >>> +
> >>> +                     cpu1_intc: interrupt-controller {
> >>> +                             #interrupt-cells =3D <1>;
> >>> +                             compatible =3D "riscv,cpu-intc";
> >>> +                             interrupt-controller;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             cpu@2 {
> >>> +                     clock-frequency =3D <0>;
> >>> +                     compatible =3D "sifive,rocket0", "riscv";
> >>> +                     d-cache-block-size =3D <64>;
> >>> +                     d-cache-sets =3D <64>;
> >>> +                     d-cache-size =3D <32768>;
> >>> +                     d-tlb-sets =3D <1>;
> >>> +                     d-tlb-size =3D <32>;
> >>> +                     device_type =3D "cpu";
> >>> +                     i-cache-block-size =3D <64>;
> >>> +                     i-cache-sets =3D <64>;
> >>> +                     i-cache-size =3D <32768>;
> >>> +                     i-tlb-sets =3D <1>;
> >>> +                     i-tlb-size =3D <32>;
> >>> +                     mmu-type =3D "riscv,sv39";
> >>> +                     reg =3D <2>;
> >>> +                     riscv,isa =3D "rv64imafdc";
> >>> +                     tlb-split;
> >>> +                     status =3D "okay";
> >>> +
> >>> +                     cpu2_intc: interrupt-controller {
> >>> +                             #interrupt-cells =3D <1>;
> >>> +                             compatible =3D "riscv,cpu-intc";
> >>> +                             interrupt-controller;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             cpu@3 {
> >>> +                     clock-frequency =3D <0>;
> >>> +                     compatible =3D "sifive,rocket0", "riscv";
> >>> +                     d-cache-block-size =3D <64>;
> >>> +                     d-cache-sets =3D <64>;
> >>> +                     d-cache-size =3D <32768>;
> >>> +                     d-tlb-sets =3D <1>;
> >>> +                     d-tlb-size =3D <32>;
> >>> +                     device_type =3D "cpu";
> >>> +                     i-cache-block-size =3D <64>;
> >>> +                     i-cache-sets =3D <64>;
> >>> +                     i-cache-size =3D <32768>;
> >>> +                     i-tlb-sets =3D <1>;
> >>> +                     i-tlb-size =3D <32>;
> >>> +                     mmu-type =3D "riscv,sv39";
> >>> +                     reg =3D <3>;
> >>> +                     riscv,isa =3D "rv64imafdc";
> >>> +                     tlb-split;
> >>> +                     status =3D "okay";
> >>> +
> >>> +                     cpu3_intc: interrupt-controller {
> >>> +                             #interrupt-cells =3D <1>;
> >>> +                             compatible =3D "riscv,cpu-intc";
> >>> +                             interrupt-controller;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             cpu@4 {
> >>> +                     clock-frequency =3D <0>;
> >>> +                     compatible =3D "sifive,rocket0", "riscv";
> >>> +                     d-cache-block-size =3D <64>;
> >>> +                     d-cache-sets =3D <64>;
> >>> +                     d-cache-size =3D <32768>;
> >>> +                     d-tlb-sets =3D <1>;
> >>> +                     d-tlb-size =3D <32>;
> >>> +                     device_type =3D "cpu";
> >>> +                     i-cache-block-size =3D <64>;
> >>> +                     i-cache-sets =3D <64>;
> >>> +                     i-cache-size =3D <32768>;
> >>> +                     i-tlb-sets =3D <1>;
> >>> +                     i-tlb-size =3D <32>;
> >>> +                     mmu-type =3D "riscv,sv39";
> >>> +                     reg =3D <4>;
> >>> +                     riscv,isa =3D "rv64imafdc";
> >>> +                     tlb-split;
> >>> +                     status =3D "okay";
> >>> +                     cpu4_intc: interrupt-controller {
> >>> +                             #interrupt-cells =3D <1>;
> >>> +                             compatible =3D "riscv,cpu-intc";
> >>> +                             interrupt-controller;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +
> >>> +     memory@80000000 {
> >>> +             device_type =3D "memory";
> >>> +             reg =3D <0x0 0x80000000 0x0 0x40000000>;
> >>> +             clocks =3D <&clkcfg 26>;
> >>> +     };
> >>
> >> U-boot doesn't seem to be updating this properly.
> >>
> >> The board should have 2GiB, confirmed by looking at the device's
> >> chip markings. We only see 1GiB memory. The 0x80000000 bus window
> >> is only capable of dealing with 1GiB memory. The higher 64-bit one
> >> can have 16GiB mapped.
> >>
> >> Do we need a second node for the second GiB of memory?
> >>
> > We could just modify the reg size but to allow more memory. I tried
> > that for Linux but it didn't boot.
> > Probably, DDR init code in HSS only initialized 1GB of memory.
>
> Yes, it is only looking at the low window which is 1GiB max.
> If it used the upper window it would get the 16GiB.
>
> I don't know how no-one noticed this issue before shipping a board
> out with this. I have updated the firmware on my second board but
> this only seems to currently fix a reboot issue with the eMMC.
>

We can't update the DT for Linux until there is a public release of
the updated firmware
with 2GB enabled.

> >>> +
> >>> +     soc {
> >>> +             #address-cells =3D <2>;
> >>> +             #size-cells =3D <2>;
> >>> +             compatible =3D "simple-bus";
> >>> +             ranges;
> >>> +
> >>> +             cache-controller@2010000 {
> >>> +                     compatible =3D "sifive,fu540-c000-ccache", "cac=
he";
> >>> +                     cache-block-size =3D <64>;
> >>> +                     cache-level =3D <2>;
> >>> +                     cache-sets =3D <1024>;
> >>> +                     cache-size =3D <2097152>;
> >>> +                     cache-unified;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <1 2 3>;
> >>> +                     reg =3D <0x0 0x2010000 0x0 0x1000>;
> >>> +             };
> >>> +
> >>> +             clint@2000000 {
> >>> +                     compatible =3D "riscv,clint0";
> >>> +                     reg =3D <0x0 0x2000000 0x0 0xC000>;
> >>> +                     interrupts-extended =3D <&cpu0_intc 3 &cpu0_int=
c 7
> >>> +                                             &cpu1_intc 3 &cpu1_intc=
 7
> >>> +                                             &cpu2_intc 3 &cpu2_intc=
 7
> >>> +                                             &cpu3_intc 3 &cpu3_intc=
 7
> >>> +                                             &cpu4_intc 3 &cpu4_intc=
 7>;
> >>> +             };
> >>> +
> >>> +             plic: interrupt-controller@c000000 {
> >>> +                     #interrupt-cells =3D <1>;
> >>> +                     compatible =3D "sifive,plic-1.0.0";
> >>> +                     reg =3D <0x0 0xc000000 0x0 0x4000000>;
> >>> +                     riscv,ndev =3D <53>;
> >>> +                     interrupt-controller;
> >>> +                     interrupts-extended =3D <&cpu0_intc 11
> >>> +                                     &cpu1_intc 11 &cpu1_intc 9
> >>> +                                     &cpu2_intc 11 &cpu2_intc 9
> >>> +                                     &cpu3_intc 11 &cpu3_intc 9
> >>> +                                     &cpu4_intc 11 &cpu4_intc 9>;
> >>> +             };
> >>> +
> >>> +             dma@3000000 {
> >>> +                     compatible =3D "sifive,fu540-c000-pdma";
> >>> +                     reg =3D <0x0 0x3000000 0x0 0x8000>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <23 24 25 26 27 28 29 30>;
> >>> +                     #dma-cells =3D <1>;
> >>> +             };
> >>> +
> >>> +             refclk: refclk {
> >>> +                     compatible =3D "fixed-clock";
> >>> +                     #clock-cells =3D <0>;
> >>> +                     clock-frequency =3D <600000000>;
> >>> +                     clock-output-names =3D "msspllclk";
> >>> +             };
> >>> +
> >>> +             clkcfg: clkcfg@20002000 {
> >>> +                     compatible =3D "microchip,pfsoc-clkcfg";
> >>> +                     reg =3D <0x0 0x20002000 0x0 0x1000>;
> >>> +                     reg-names =3D "mss_sysreg";
> >>> +                     clocks =3D <&refclk>;
> >>> +                     #clock-cells =3D <1>;
> >>> +                     clock-output-names =3D "cpuclk", "axiclk", "ahb=
clk", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", =
"MMUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk=
", "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCcl=
k", "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "F=
IC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
> >>
> >> Any chance of making this list multi-line, it is difficult to read as-=
is.
> >>
> >
> > Yes. We can also get rid of a few names that are not used. I will fix i=
t in v2.
> >
> >>> +             };
> >>> +
> >>> +             serial0: serial@20000000 {
> >>> +                     compatible =3D "ns16550a";
> >>> +                     reg =3D <0x0 0x20000000 0x0 0x400>;
> >>> +                     reg-io-width =3D <4>;
> >>> +                     reg-shift =3D <2>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <90>;
> >>> +                     current-speed =3D <115200>;
> >>> +                     clocks =3D <&clkcfg 8>;
> >>> +                     status =3D "okay";
> >>> +             };
> >>> +
> >>> +             serial1: serial@20100000 {
> >>> +                     compatible =3D "ns16550a";
> >>> +                     reg =3D <0x0 0x20100000 0x0 0x400>;
> >>> +                     reg-io-width =3D <4>;
> >>> +                     reg-shift =3D <2>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <91>;
> >>> +                     current-speed =3D <115200>;
> >>> +                     clocks =3D <&clkcfg 9>;
> >>> +                     status =3D "okay";
> >>> +             };
> >>> +
> >>> +             serial2: serial@20102000 {
> >>> +                     compatible =3D "ns16550a";
> >>> +                     reg =3D <0x0 0x20102000 0x0 0x400>;
> >>> +                     reg-io-width =3D <4>;
> >>> +                     reg-shift =3D <2>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <92>;
> >>> +                     current-speed =3D <115200>;
> >>> +                     clocks =3D <&clkcfg 10>;
> >>> +                     status =3D "okay";
> >>> +             };
> >>> +
> >>> +             serial3: serial@20104000 {
> >>> +                     compatible =3D "ns16550a";
> >>> +                     reg =3D <0x0 0x20104000 0x0 0x400>;
> >>> +                     reg-io-width =3D <4>;
> >>> +                     reg-shift =3D <2>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <93>;
> >>> +                     current-speed =3D <115200>;
> >>> +                     clocks =3D <&clkcfg 11>;
> >>> +                     status =3D "okay";
> >>> +             };
> >>> +
> >>> +             sdcard: sdhc@20008000 {
> >>> +                     compatible =3D "cdns,sd4hc";
> >>> +                     reg =3D <0x0 0x20008000 0x0 0x1000>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <88>;
> >>> +                     pinctrl-names =3D "default";
> >>> +                     clocks =3D <&clkcfg 6>;
> >>> +                     bus-width =3D <4>;
> >>> +                     disable-wp;
> >>> +                     no-1-8-v;
> >>> +                     cap-mmc-highspeed;
> >>> +                     cap-sd-highspeed;
> >>> +                     card-detect-delay =3D <200>;
> >>> +                     sd-uhs-sdr12;
> >>> +                     sd-uhs-sdr25;
> >>> +                     sd-uhs-sdr50;
> >>> +                     sd-uhs-sdr104;
> >>> +                     max-frequency =3D <200000000>;
> >>> +                     status =3D "okay";
> >>> +             };
> >>
> >> Given eMMC is the default device, shouldn't that be default for the
> >> device tree too? Even if not, having the emmc node here would be a
> >> good thing as it is different to the SD node.
> >>
> >
> > I tested this device tree with sdcard. That's why, I just picked the
> > sdcard node.
> > I am not sure if both eMMC & sdcard node can co-exist. The polar fire
> > soc github repo
> > seems to point that both of them have the same address and only 1 can b=
e enabled
> > at that time. That may not be true now as the github repo has not been
> > updated in
> > couple of months.
> >
> > @Cyril : Can we enable both eMMC & sdcard at the same time ?
>
> I would put /both/ in but only enable the one in use for the moment.
> Our boards are booting of eMMC as supplied, so this isn't going to work
> as well. The eMMC is 8bit wide, and thus is only delivering 11MB/sec
> instead of 22MB/sec. This performance is still not great, but losing
> half the data-rate is just not good.
>

I am not sure what should be enabled by default. Updating sdcard is much
easier than eMMC card and we use that approach.

@Cyril: Is there a way that we can enable both ?

> >>> +
> >>> +             emac1: ethernet@20112000 {
> >>> +                     compatible =3D "cdns,macb";
> >>> +                     reg =3D <0x0 0x20112000 0x0 0x2000>;
> >>> +                     interrupt-parent =3D <&plic>;
> >>> +                     interrupts =3D <70 71 72 73>;
> >>> +                     mac-address =3D [56 34 12 00 FC 00];
> >>> +                     phy-mode =3D "sgmii";
> >>> +                     clocks =3D <&clkcfg 5>, <&clkcfg 2>;
> >>> +                     clock-names =3D "pclk", "hclk";
> >>> +                     #address-cells =3D <1>;
> >>> +                     #size-cells =3D <0>;
> >>> +                     phy1: ethernet-phy@9 {
> >>> +                             reg =3D <9>;
> >>> +                             ti,fifo-depth =3D <0x01>;
> >>> +                     };
> >>> +             };
> >>
> >> Aren't there two ethernet ports on the board?
> >>
> >
> > Yes. I hadn't tested that out. I will test it and add the 2nd one as we=
ll.
> >
> >> Also, at the moment u-boot is not filling the MAC address parameter
> >> in so we've got at two boards on the network with the same MAC until
> >> we override it in the device tree for the second.
> >>
> >
> > Looking at latest U-Boot patches, it seems it updates the mac address
> > from the serial number.
>
> Ok, the one supplied on the boards does not. And the boards /both/ have
> the same MAC address!
>
Yeah. That one is hard coded. I think that will be fixed with U-Boot patche=
s.
We can just leave them all 0s in Linux DT.

> >>> +
> >>> +             uio_axi_lsram@2030000000 {
> >>> +                     compatible =3D "generic-uio";
> >>> +                     reg =3D <0x20 0x30000000 0 0x80000000 >;
> >>> +                     status =3D "okay";
> >>> +             };
> >>> +     };
> >>> +};
> >>>
> >>
> >>
> >> --
> >> Ben Dooks                               http://www.codethink.co.uk/
> >> Senior Engineer                         Codethink - Providing Genius
> >>
> >> https://www.codethink.co.uk/privacy.html
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
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
