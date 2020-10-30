Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638A02A0F73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgJ3U3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3U1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:27:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D83C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:27:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q25so8842410ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l6L8J7TQpQGj95Z9RtLis5s5Qg/ko8Slww2VXzzAiqE=;
        b=I0o9pEVfno/qU6ovogWT0mVU0HoCIwOih+sYM6Jj7FK+yqZaGtD5SLDnLBth1ZlIPB
         QYaWgqrjJYNveW7gsAFUHOL4d9tTqHSp4uRleK4pNihBNQkwJJ2YxvRUplT2YZVJI0Bw
         J5TSaGFKo5l4ynbDoEFiSmZflisB4Ju9ieX34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l6L8J7TQpQGj95Z9RtLis5s5Qg/ko8Slww2VXzzAiqE=;
        b=mCGwCFls5r4C2z0xsJxK0vUFu6CVMfgxSCZsu8R78OquCpFxRZg54gnGkLToomDjXF
         FABzYuOWqNVYCDnBTzdldWmEdkS5YNm/XOyQ3aPuyTuNl3YnN5PlVM9ID6o0KBwzhYmo
         VU91Qu8RB/8cJQAbtOOT/iTchgLgV+kf13GMX6+K3ugtstugr6Z0B5ZW3sLxh2EaQqVZ
         6FRrsJSZNddzZITc3WZqChbj9Zd4uxcEHao+YiRigKFRM0Y2VmLFKx+aLaYVixkv31Yy
         YpxYBcc8w02JlafjozlizLPTzWfHGobaWoqUF0FqoPF3eO9ym8jN0Pxg/X/yok4jvU9c
         zMVQ==
X-Gm-Message-State: AOAM531i0jeALvfCn+dlbMWrA3vDPCrzkrmkgHM2ocM3feXwL3tX/fRl
        IONbtR9433eLJLWqCp65lMnHJ82ugFVVE14WZJ9Z
X-Google-Smtp-Source: ABdhPJww/GufaQPAUwS+RKiwGlDwkQ00YiyMdyxjD9vGebY3gk/dJGLRmNoQiWo9NSuozqUjnhYhSaoZg+iVzuaV96k=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr3166678ios.113.1604089656337;
 Fri, 30 Oct 2020 13:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 30 Oct 2020 13:27:25 -0700
Message-ID: <CAOnJCUKCbkZVGX5Rjputs9QQAHCvH6Fikt7kVGsyCkNjbdMv=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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

On Fri, Oct 30, 2020 at 2:05 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > Add initial DTS for Microchip ICICLE board having only
> > essential devcies (clocks, sdhci, ethernet, serial, etc).
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/boot/dts/Makefile                  |   1 +
> >  arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >  .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
>
> I suggest we split this DTS into two parts:
> 1. SOC (microchip-polarfire.dtsi)
> 2. Board (microchip-icicle-kit-a000.dts)
>
> This will be much cleaner and aligned with what is done
> on other architectures.
>

Sure. I will do that in v2.

> >  3 files changed, 316 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >  create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-=
a000.dts
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefil=
e
> > index ca1f8cbd78c0..3ea94ea0a18a 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  subdir-y +=3D sifive
> >  subdir-y +=3D kendryte
> > +subdir-y +=3D microchip
> >
> >  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
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
> > +#define RTCCLK_FREQ            1000000
> > +
> > +/ {
> > +       #address-cells =3D <2>;
> > +       #size-cells =3D <2>;
> > +       model =3D "Microchip PolarFire-SoC";
> > +       compatible =3D "microchip,polarfire-soc";
> > +
> > +       chosen {
> > +               stdout-path =3D &serial0;
> > +       };
> > +
> > +       cpus {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +               timebase-frequency =3D <RTCCLK_FREQ>;
> > +
> > +               cpu@0 {
> > +                       clock-frequency =3D <0>;
> > +                       compatible =3D "sifive,rocket0", "riscv";
> > +                       device_type =3D "cpu";
> > +                       i-cache-block-size =3D <64>;
> > +                       i-cache-sets =3D <128>;
> > +                       i-cache-size =3D <16384>;
> > +                       reg =3D <0>;
> > +                       riscv,isa =3D "rv64imac";
> > +                       status =3D "disabled";
> > +
> > +                       cpu0_intc: interrupt-controller {
> > +                               #interrupt-cells =3D <1>;
> > +                               compatible =3D "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@1 {
> > +                       clock-frequency =3D <0>;
> > +                       compatible =3D "sifive,rocket0", "riscv";
> > +                       d-cache-block-size =3D <64>;
> > +                       d-cache-sets =3D <64>;
> > +                       d-cache-size =3D <32768>;
> > +                       d-tlb-sets =3D <1>;
> > +                       d-tlb-size =3D <32>;
> > +                       device_type =3D "cpu";
> > +                       i-cache-block-size =3D <64>;
> > +                       i-cache-sets =3D <64>;
> > +                       i-cache-size =3D <32768>;
> > +                       i-tlb-sets =3D <1>;
> > +                       i-tlb-size =3D <32>;
> > +                       mmu-type =3D "riscv,sv39";
> > +                       reg =3D <1>;
> > +                       riscv,isa =3D "rv64imafdc";
> > +                       tlb-split;
> > +                       status =3D "okay";
> > +
> > +                       cpu1_intc: interrupt-controller {
> > +                               #interrupt-cells =3D <1>;
> > +                               compatible =3D "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@2 {
> > +                       clock-frequency =3D <0>;
> > +                       compatible =3D "sifive,rocket0", "riscv";
> > +                       d-cache-block-size =3D <64>;
> > +                       d-cache-sets =3D <64>;
> > +                       d-cache-size =3D <32768>;
> > +                       d-tlb-sets =3D <1>;
> > +                       d-tlb-size =3D <32>;
> > +                       device_type =3D "cpu";
> > +                       i-cache-block-size =3D <64>;
> > +                       i-cache-sets =3D <64>;
> > +                       i-cache-size =3D <32768>;
> > +                       i-tlb-sets =3D <1>;
> > +                       i-tlb-size =3D <32>;
> > +                       mmu-type =3D "riscv,sv39";
> > +                       reg =3D <2>;
> > +                       riscv,isa =3D "rv64imafdc";
> > +                       tlb-split;
> > +                       status =3D "okay";
> > +
> > +                       cpu2_intc: interrupt-controller {
> > +                               #interrupt-cells =3D <1>;
> > +                               compatible =3D "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@3 {
> > +                       clock-frequency =3D <0>;
> > +                       compatible =3D "sifive,rocket0", "riscv";
> > +                       d-cache-block-size =3D <64>;
> > +                       d-cache-sets =3D <64>;
> > +                       d-cache-size =3D <32768>;
> > +                       d-tlb-sets =3D <1>;
> > +                       d-tlb-size =3D <32>;
> > +                       device_type =3D "cpu";
> > +                       i-cache-block-size =3D <64>;
> > +                       i-cache-sets =3D <64>;
> > +                       i-cache-size =3D <32768>;
> > +                       i-tlb-sets =3D <1>;
> > +                       i-tlb-size =3D <32>;
> > +                       mmu-type =3D "riscv,sv39";
> > +                       reg =3D <3>;
> > +                       riscv,isa =3D "rv64imafdc";
> > +                       tlb-split;
> > +                       status =3D "okay";
> > +
> > +                       cpu3_intc: interrupt-controller {
> > +                               #interrupt-cells =3D <1>;
> > +                               compatible =3D "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@4 {
> > +                       clock-frequency =3D <0>;
> > +                       compatible =3D "sifive,rocket0", "riscv";
> > +                       d-cache-block-size =3D <64>;
> > +                       d-cache-sets =3D <64>;
> > +                       d-cache-size =3D <32768>;
> > +                       d-tlb-sets =3D <1>;
> > +                       d-tlb-size =3D <32>;
> > +                       device_type =3D "cpu";
> > +                       i-cache-block-size =3D <64>;
> > +                       i-cache-sets =3D <64>;
> > +                       i-cache-size =3D <32768>;
> > +                       i-tlb-sets =3D <1>;
> > +                       i-tlb-size =3D <32>;
> > +                       mmu-type =3D "riscv,sv39";
> > +                       reg =3D <4>;
> > +                       riscv,isa =3D "rv64imafdc";
> > +                       tlb-split;
> > +                       status =3D "okay";
> > +                       cpu4_intc: interrupt-controller {
> > +                               #interrupt-cells =3D <1>;
> > +                               compatible =3D "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x0 0x80000000 0x0 0x40000000>;
> > +               clocks =3D <&clkcfg 26>;
> > +       };
> > +
> > +       soc {
> > +               #address-cells =3D <2>;
> > +               #size-cells =3D <2>;
> > +               compatible =3D "simple-bus";
> > +               ranges;
> > +
> > +               cache-controller@2010000 {
> > +                       compatible =3D "sifive,fu540-c000-ccache", "cac=
he";
> > +                       cache-block-size =3D <64>;
> > +                       cache-level =3D <2>;
> > +                       cache-sets =3D <1024>;
> > +                       cache-size =3D <2097152>;
> > +                       cache-unified;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <1 2 3>;
> > +                       reg =3D <0x0 0x2010000 0x0 0x1000>;
> > +               };
> > +
> > +               clint@2000000 {
> > +                       compatible =3D "riscv,clint0";
> > +                       reg =3D <0x0 0x2000000 0x0 0xC000>;
> > +                       interrupts-extended =3D <&cpu0_intc 3 &cpu0_int=
c 7
> > +                                               &cpu1_intc 3 &cpu1_intc=
 7
> > +                                               &cpu2_intc 3 &cpu2_intc=
 7
> > +                                               &cpu3_intc 3 &cpu3_intc=
 7
> > +                                               &cpu4_intc 3 &cpu4_intc=
 7>;
> > +               };
> > +
> > +               plic: interrupt-controller@c000000 {
> > +                       #interrupt-cells =3D <1>;
> > +                       compatible =3D "sifive,plic-1.0.0";
> > +                       reg =3D <0x0 0xc000000 0x0 0x4000000>;
> > +                       riscv,ndev =3D <53>;
> > +                       interrupt-controller;
> > +                       interrupts-extended =3D <&cpu0_intc 11
> > +                                       &cpu1_intc 11 &cpu1_intc 9
> > +                                       &cpu2_intc 11 &cpu2_intc 9
> > +                                       &cpu3_intc 11 &cpu3_intc 9
> > +                                       &cpu4_intc 11 &cpu4_intc 9>;
> > +               };
> > +
> > +               dma@3000000 {
> > +                       compatible =3D "sifive,fu540-c000-pdma";
> > +                       reg =3D <0x0 0x3000000 0x0 0x8000>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <23 24 25 26 27 28 29 30>;
> > +                       #dma-cells =3D <1>;
> > +               };
> > +
> > +               refclk: refclk {
> > +                       compatible =3D "fixed-clock";
> > +                       #clock-cells =3D <0>;
> > +                       clock-frequency =3D <600000000>;
> > +                       clock-output-names =3D "msspllclk";
> > +               };
> > +
> > +               clkcfg: clkcfg@20002000 {
> > +                       compatible =3D "microchip,pfsoc-clkcfg";
> > +                       reg =3D <0x0 0x20002000 0x0 0x1000>;
> > +                       reg-names =3D "mss_sysreg";
> > +                       clocks =3D <&refclk>;
> > +                       #clock-cells =3D <1>;
> > +                       clock-output-names =3D "cpuclk", "axiclk", "ahb=
clk", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", =
"MMUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk=
", "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCcl=
k", "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "F=
IC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
> > +               };
> > +
> > +               serial0: serial@20000000 {
> > +                       compatible =3D "ns16550a";
> > +                       reg =3D <0x0 0x20000000 0x0 0x400>;
> > +                       reg-io-width =3D <4>;
> > +                       reg-shift =3D <2>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <90>;
> > +                       current-speed =3D <115200>;
> > +                       clocks =3D <&clkcfg 8>;
> > +                       status =3D "okay";
> > +               };
> > +
> > +               serial1: serial@20100000 {
> > +                       compatible =3D "ns16550a";
> > +                       reg =3D <0x0 0x20100000 0x0 0x400>;
> > +                       reg-io-width =3D <4>;
> > +                       reg-shift =3D <2>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <91>;
> > +                       current-speed =3D <115200>;
> > +                       clocks =3D <&clkcfg 9>;
> > +                       status =3D "okay";
> > +               };
> > +
> > +               serial2: serial@20102000 {
> > +                       compatible =3D "ns16550a";
> > +                       reg =3D <0x0 0x20102000 0x0 0x400>;
> > +                       reg-io-width =3D <4>;
> > +                       reg-shift =3D <2>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <92>;
> > +                       current-speed =3D <115200>;
> > +                       clocks =3D <&clkcfg 10>;
> > +                       status =3D "okay";
> > +               };
> > +
> > +               serial3: serial@20104000 {
> > +                       compatible =3D "ns16550a";
> > +                       reg =3D <0x0 0x20104000 0x0 0x400>;
> > +                       reg-io-width =3D <4>;
> > +                       reg-shift =3D <2>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <93>;
> > +                       current-speed =3D <115200>;
> > +                       clocks =3D <&clkcfg 11>;
> > +                       status =3D "okay";
> > +               };
> > +
> > +               sdcard: sdhc@20008000 {
> > +                       compatible =3D "cdns,sd4hc";
> > +                       reg =3D <0x0 0x20008000 0x0 0x1000>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <88>;
> > +                       pinctrl-names =3D "default";
> > +                       clocks =3D <&clkcfg 6>;
> > +                       bus-width =3D <4>;
> > +                       disable-wp;
> > +                       no-1-8-v;
> > +                       cap-mmc-highspeed;
> > +                       cap-sd-highspeed;
> > +                       card-detect-delay =3D <200>;
> > +                       sd-uhs-sdr12;
> > +                       sd-uhs-sdr25;
> > +                       sd-uhs-sdr50;
> > +                       sd-uhs-sdr104;
> > +                       max-frequency =3D <200000000>;
> > +                       status =3D "okay";
> > +               };
> > +
> > +               emac1: ethernet@20112000 {
> > +                       compatible =3D "cdns,macb";
> > +                       reg =3D <0x0 0x20112000 0x0 0x2000>;
> > +                       interrupt-parent =3D <&plic>;
> > +                       interrupts =3D <70 71 72 73>;
> > +                       mac-address =3D [56 34 12 00 FC 00];
> > +                       phy-mode =3D "sgmii";
> > +                       clocks =3D <&clkcfg 5>, <&clkcfg 2>;
> > +                       clock-names =3D "pclk", "hclk";
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
> > +                       phy1: ethernet-phy@9 {
> > +                               reg =3D <9>;
> > +                               ti,fifo-depth =3D <0x01>;
> > +                       };
> > +               };
> > +
> > +               uio_axi_lsram@2030000000 {
> > +                       compatible =3D "generic-uio";
> > +                       reg =3D <0x20 0x30000000 0 0x80000000 >;
> > +                       status =3D "okay";
> > +               };
> > +       };
> > +};
> > --
> > 2.25.1
> >
>
> Regards,
> Anup
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
