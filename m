Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29E32A5CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgKDClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgKDCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:41:41 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A2BC061A4D;
        Tue,  3 Nov 2020 18:41:41 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s89so16693290ybi.12;
        Tue, 03 Nov 2020 18:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cDwu8w0Ft1ZAZ8iiy474iPvNGaBgMcTsKWWIzgtdonw=;
        b=tP2SPRV6r6Z6P1aAgoIFHSHqTdEKrW+Zyy1aM8B9azV83aQ6dTfLyBI+AYZXwFPK0Y
         cx/jnW2Gx/FOjzYedTSb5f/NVEvBpYU58Uc1qO2mo0uLVESHT0pcGZbMfTXnqC0jvKf6
         MzqDPH6dvrH3Yxi6oKgdV8S8bB77ByRpmkLtumtzqV/MRDVwZQdywVsYnetTMkyc97ND
         /VI5Si/JxcGqVBEb7pppqk/cfMMw08OAdnjKj6Ol+EUlRfppThrJkkTRePpluEF1EPoa
         b2xWfYR4xseFCC+zZRxBFztqLFJSJVPtDTJEkwSwFoZOh/Hav+qCYk/0qqFb7L4x/D5P
         8mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cDwu8w0Ft1ZAZ8iiy474iPvNGaBgMcTsKWWIzgtdonw=;
        b=QVEsPxo7X8u9EDqeenzlAoPNj1loq8OO56X2wS/qaqhAz4Fj++jKXYTxFRjtfjwey2
         nfkqo8bCcVfc9aoFp9vAdiV1JF/54+61fUt21ddyKa4nvS2A9q+iPEjIKpnCer4RrGmF
         CMLow+L+k2lZP4x3/V2RQEsdrWHVgWcm0SboRlH+g5HHn0bM6CWvyeCcxSaZ5qOxJP/t
         38j7lH7dzChRWonomGossZVY2C+R/HsQUTJzA6RmbgprafadYlnh8O1kV5+Y2AjtOFx7
         yWRioOFJbwLNf1Q1w0J1lt5VIiu/XURx1Xncizaw1ILQHDfyXMwL5sXMAxOvxrsiu2PJ
         5qcg==
X-Gm-Message-State: AOAM532WqMPyyEB/y0dhv6IigFCIwH2wWRhCWqw8odftjkUOGzp8vrsn
        9LqrYoAEOybDor1YX+YwOayViHTOYsSEHDXcMYg=
X-Google-Smtp-Source: ABdhPJwVBSx33QM9yJLdfpQ/A7R2S4nNepUlDZUIfL/f1jPjtfJWoCDYg1JChaPwN6Ou8Lm/bl0c054U8he7+MXyD4k=
X-Received: by 2002:a25:f81e:: with SMTP id u30mr33350036ybd.332.1604457700557;
 Tue, 03 Nov 2020 18:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
In-Reply-To: <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 4 Nov 2020 10:41:28 +0800
Message-ID: <CAEUhbmV8b5p3wYEH9xcP1UC8GFmtb6SYnHJgGJMRNOeSUuwF2g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Atish Patra <atish.patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Cyril.Jean@microchip.com,
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

On Thu, Oct 29, 2020 at 6:42 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote=
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

Besides the multi-line issue, I believe the clock-output-names should
all have lower case names.

>
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
> Also, at the moment u-boot is not filling the MAC address parameter
> in so we've got at two boards on the network with the same MAC until
> we override it in the device tree for the second.
>
> > +
> > +             uio_axi_lsram@2030000000 {
> > +                     compatible =3D "generic-uio";
> > +                     reg =3D <0x20 0x30000000 0 0x80000000 >;
> > +                     status =3D "okay";
> > +             };
> > +     };
> > +};

Regards,
Bin
