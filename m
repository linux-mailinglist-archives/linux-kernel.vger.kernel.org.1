Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC52B598B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 07:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKQGIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:08:03 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3661C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 22:08:03 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id k1so17559071ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 22:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXj1kMps1/BK6Uch4Qccm9xtXkpubngO/RTHap1t+GY=;
        b=CoOfCo8kLOw8/Y/mqhjtUquRGoicSNh0QmNNf8vaiUT2AIlNCH8ulBSZx1QIFCqWYh
         MlFMOKBMvoEGmalteNU258do7/fcT3tCz7VU+Guc6RTfHTF/j7e0ogy21DAc6RHzzHKp
         9TH4Q2F5x8TiMdhJphoVd883IR+k/E1KzkKb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXj1kMps1/BK6Uch4Qccm9xtXkpubngO/RTHap1t+GY=;
        b=pc6+Hjxl3K0w/+NJDOqyFSyg4MJ8fk5yymg4ShnpiFl3m9tT85lJIOwA9X7pPjsP+c
         DZqQfXyk0vKn8eZtU8jAQNzEis52fhaMwDqNx8BSXYcWjF11AeB9f7S6NftAIIHrYe9n
         i9ZTNpOsA5VbigmCF32ZLoHC2Nm7ppJhikK4vo3IYLe8rurFlgbXltVClFchhBhtD7PE
         8DCpRZ+U+IqY7kVlZYqrjlOYQi3XlvzKaSArKE2zMdDNj+vtfMYNbEV4ypOWYej812XY
         wZRd/tNIm7ezuKLnbTYOD6iy2e3eXH918xQDGcV03gmj+jVq5IoJUAFn08pbAO3Txqds
         Y+Kg==
X-Gm-Message-State: AOAM533YbIrRZtV55HOuZw7DCBfnIUVRmY1jbgbpxRsgCewcNXQVIsiL
        ubsI2e9iFDKkDb382ZS1vRUBvlcek5iAeINWULll
X-Google-Smtp-Source: ABdhPJzGWiK/KC2t4nyuDIr7OpOzHmY6EUEtoQhrkmKv2suUIRXrzoYR6q28k/oA9fjmpRn1+PT/DbmZVkao+0SkPPM=
X-Received: by 2002:a92:1f8d:: with SMTP id f13mr11538671ilf.77.1605593282829;
 Mon, 16 Nov 2020 22:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20201113202550.3693323-1-atish.patra@wdc.com> <20201113202550.3693323-4-atish.patra@wdc.com>
 <CAEUhbmVq=O29MLGraHD_1AvV+UH0q0gh0JAu1ZJ5n7qk4Gb-tQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVq=O29MLGraHD_1AvV+UH0q0gh0JAu1ZJ5n7qk4Gb-tQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 16 Nov 2020 22:07:51 -0800
Message-ID: <CAOnJCUKq9xP+yYGU0OLYPqBGqph7oD4pihZzfOLyXFoBPs2uTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] RISC-V: Initial DTS for Microchip ICICLE board
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Conor.Dooley@microchip.com, Albert Ou <aou@eecs.berkeley.edu>,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ivan.Griffin@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Nov 14, 2020 at 4:29 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > Add initial DTS for Microchip ICICLE board having only
> > essential devcies (clocks, sdhci, ethernet, serial, etc).
>
> typo: devices
>

Thanks. Will fix it.

> > The device tree is based on the U-Boot patch.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/boot/dts/Makefile                  |   1 +
> >  arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >  .../microchip/microchip-mpfs-icicle-kit.dts   |  54 +++
> >  .../boot/dts/microchip/microchip-mpfs.dtsi    | 342 ++++++++++++++++++
> >  4 files changed, 399 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> >  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index ca1f8cbd78c0..3ea94ea0a18a 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  subdir-y += sifive
> >  subdir-y += kendryte
> > +subdir-y += microchip
> >
> >  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> > diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> > new file mode 100644
> > index 000000000000..622b12771fd3
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/microchip/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
> > diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > new file mode 100644
> > index 000000000000..9a382ab0a799
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>
> Please make this dual-licensed, GPL or MIT.
> See https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp/blob/master/recipes-kernel/linux/files/icicle-kit-es/icicle-kit-es-a000-microchip.dts
>

I had that originally. Checkpatch did not like that. I will revert it
and investigate the real cause for the checkpatch complaint.

> > +/* Copyright (c) 2020 Microchip Technology Inc */
> > +
> > +/dts-v1/;
> > +
> > +#include "microchip-mpfs.dtsi"
> > +
> > +/* Clock frequency (in Hz) of the rtcclk */
> > +#define RTCCLK_FREQ            1000000
> > +
> > +/ {
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +       model = "Microchip PolarFire-SoC Icicle Kit";
> > +       compatible = "microchip,mpfs-icicle-kit", "microchip,polarfire-soc";
> > +
> > +       chosen {
> > +               stdout-path = &serial0;
> > +       };
> > +
> > +       cpus {
> > +               timebase-frequency = <RTCCLK_FREQ>;
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0x0 0x40000000>;
> > +               clocks = <&clkcfg 26>;
> > +       };
> > +
> > +       soc {
> > +       };
> > +};
> > +
> > +&serial0 {
> > +       status = "okay";
> > +};
> > +
> > +&serial1 {
> > +       status = "okay";
> > +};
> > +
> > +&serial2 {
> > +       status = "okay";
> > +};
> > +
> > +&serial3 {
> > +       status = "okay";
> > +};
> > +
> > +&sdcard {
> > +       status = "okay";
> > +};
> > +
> > diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > new file mode 100644
> > index 000000000000..63ac60f345d8
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > @@ -0,0 +1,342 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (c) 2020 Microchip Technology Inc */
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +       model = "Microchip PolarFire-SoC";
> > +       compatible = "microchip,polarfire-soc";
> > +
> > +       chosen {
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0 {
> > +                       clock-frequency = <0>;
> > +                       compatible = "sifive,rocket0", "riscv";
> > +                       device_type = "cpu";
> > +                       i-cache-block-size = <64>;
> > +                       i-cache-sets = <128>;
> > +                       i-cache-size = <16384>;
> > +                       reg = <0>;
> > +                       riscv,isa = "rv64imac";
> > +                       status = "disabled";
> > +
> > +                       cpu0_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@1 {
> > +                       clock-frequency = <0>;
> > +                       compatible = "sifive,rocket0", "riscv";
> > +                       d-cache-block-size = <64>;
> > +                       d-cache-sets = <64>;
> > +                       d-cache-size = <32768>;
> > +                       d-tlb-sets = <1>;
> > +                       d-tlb-size = <32>;
> > +                       device_type = "cpu";
> > +                       i-cache-block-size = <64>;
> > +                       i-cache-sets = <64>;
> > +                       i-cache-size = <32768>;
> > +                       i-tlb-sets = <1>;
> > +                       i-tlb-size = <32>;
> > +                       mmu-type = "riscv,sv39";
> > +                       reg = <1>;
> > +                       riscv,isa = "rv64imafdc";
> > +                       tlb-split;
> > +                       status = "okay";
> > +
> > +                       cpu1_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@2 {
> > +                       clock-frequency = <0>;
> > +                       compatible = "sifive,rocket0", "riscv";
> > +                       d-cache-block-size = <64>;
> > +                       d-cache-sets = <64>;
> > +                       d-cache-size = <32768>;
> > +                       d-tlb-sets = <1>;
> > +                       d-tlb-size = <32>;
> > +                       device_type = "cpu";
> > +                       i-cache-block-size = <64>;
> > +                       i-cache-sets = <64>;
> > +                       i-cache-size = <32768>;
> > +                       i-tlb-sets = <1>;
> > +                       i-tlb-size = <32>;
> > +                       mmu-type = "riscv,sv39";
> > +                       reg = <2>;
> > +                       riscv,isa = "rv64imafdc";
> > +                       tlb-split;
> > +                       status = "okay";
> > +
> > +                       cpu2_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@3 {
> > +                       clock-frequency = <0>;
> > +                       compatible = "sifive,rocket0", "riscv";
> > +                       d-cache-block-size = <64>;
> > +                       d-cache-sets = <64>;
> > +                       d-cache-size = <32768>;
> > +                       d-tlb-sets = <1>;
> > +                       d-tlb-size = <32>;
> > +                       device_type = "cpu";
> > +                       i-cache-block-size = <64>;
> > +                       i-cache-sets = <64>;
> > +                       i-cache-size = <32768>;
> > +                       i-tlb-sets = <1>;
> > +                       i-tlb-size = <32>;
> > +                       mmu-type = "riscv,sv39";
> > +                       reg = <3>;
> > +                       riscv,isa = "rv64imafdc";
> > +                       tlb-split;
> > +                       status = "okay";
> > +
> > +                       cpu3_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +
> > +               cpu@4 {
> > +                       clock-frequency = <0>;
> > +                       compatible = "sifive,rocket0", "riscv";
> > +                       d-cache-block-size = <64>;
> > +                       d-cache-sets = <64>;
> > +                       d-cache-size = <32768>;
> > +                       d-tlb-sets = <1>;
> > +                       d-tlb-size = <32>;
> > +                       device_type = "cpu";
> > +                       i-cache-block-size = <64>;
> > +                       i-cache-sets = <64>;
> > +                       i-cache-size = <32768>;
> > +                       i-tlb-sets = <1>;
> > +                       i-tlb-size = <32>;
> > +                       mmu-type = "riscv,sv39";
> > +                       reg = <4>;
> > +                       riscv,isa = "rv64imafdc";
> > +                       tlb-split;
> > +                       status = "okay";
> > +                       cpu4_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +       };
> > +
> > +       soc {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               compatible = "simple-bus";
> > +               ranges;
> > +
> > +               cache-controller@2010000 {
> > +                       compatible = "sifive,fu540-c000-ccache", "cache";
> > +                       cache-block-size = <64>;
> > +                       cache-level = <2>;
> > +                       cache-sets = <1024>;
> > +                       cache-size = <2097152>;
> > +                       cache-unified;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <1 2 3>;
> > +                       reg = <0x0 0x2010000 0x0 0x1000>;
> > +               };
> > +
> > +               clint@2000000 {
> > +                       compatible = "riscv,clint0";
> > +                       reg = <0x0 0x2000000 0x0 0xC000>;
> > +                       interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
> > +                                               &cpu1_intc 3 &cpu1_intc 7
> > +                                               &cpu2_intc 3 &cpu2_intc 7
> > +                                               &cpu3_intc 3 &cpu3_intc 7
> > +                                               &cpu4_intc 3 &cpu4_intc 7>;
> > +               };
> > +
> > +               plic: interrupt-controller@c000000 {
> > +                       #interrupt-cells = <1>;
> > +                       compatible = "sifive,plic-1.0.0";
> > +                       reg = <0x0 0xc000000 0x0 0x4000000>;
> > +                       riscv,ndev = <53>;
> > +                       interrupt-controller;
> > +                       interrupts-extended = <&cpu0_intc 11
> > +                                       &cpu1_intc 11 &cpu1_intc 9
> > +                                       &cpu2_intc 11 &cpu2_intc 9
> > +                                       &cpu3_intc 11 &cpu3_intc 9
> > +                                       &cpu4_intc 11 &cpu4_intc 9>;
> > +               };
> > +
> > +               dma@3000000 {
> > +                       compatible = "sifive,fu540-c000-pdma";
> > +                       reg = <0x0 0x3000000 0x0 0x8000>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <23 24 25 26 27 28 29 30>;
> > +                       #dma-cells = <1>;
> > +               };
> > +
> > +               refclk: refclk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <600000000>;
> > +                       clock-output-names = "msspllclk";
> > +               };
> > +
> > +               clkcfg: clkcfg@20002000 {
> > +                       compatible = "microchip,pfsoc-clkcfg";
> > +                       reg = <0x0 0x20002000 0x0 0x1000>;
> > +                       reg-names = "mss_sysreg";
> > +                       clocks = <&refclk>;
> > +                       #clock-cells = <1>;
> > +                       clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk",   /* 0-3   */
> > +                                "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk",            /* 4-7   */
> > +                               "MMUART0clk", "MMUART1clk", "MMUART2clk", "MMUART3clk", /* 8-11  */
> > +                               "MMUART4clk", "SPI0clk", "SPI1clk", "I2C0clk",          /* 12-15 */
> > +                               "I2C1clk", "CAN0clk", "CAN1clk", "USBclk",              /* 16-19 */
> > +                               "RESERVED", "RTCclk", "QSPIclk", "GPIO0clk",            /* 20-23 */
> > +                               "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk",           /* 24-27 */
> > +                               "FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk"; /* 28-32 */
>
> Should all these names be lower case?
>

Probably yes. The DT binding document did not specify any case.
However, I just checked the linux kernel source. Most of the DT
actually use lowercase.
I will change it lower case in the next version.

> > +               };
> > +
> > +               serial0: serial@20000000 {
> > +                       compatible = "ns16550a";
> > +                       reg = <0x0 0x20000000 0x0 0x400>;
> > +                       reg-io-width = <4>;
> > +                       reg-shift = <2>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <90>;
> > +                       current-speed = <115200>;
> > +                       clocks = <&clkcfg 8>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               serial1: serial@20100000 {
> > +                       compatible = "ns16550a";
> > +                       reg = <0x0 0x20100000 0x0 0x400>;
> > +                       reg-io-width = <4>;
> > +                       reg-shift = <2>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <91>;
> > +                       current-speed = <115200>;
> > +                       clocks = <&clkcfg 9>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               serial2: serial@20102000 {
> > +                       compatible = "ns16550a";
> > +                       reg = <0x0 0x20102000 0x0 0x400>;
> > +                       reg-io-width = <4>;
> > +                       reg-shift = <2>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <92>;
> > +                       current-speed = <115200>;
> > +                       clocks = <&clkcfg 10>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               serial3: serial@20104000 {
> > +                       compatible = "ns16550a";
> > +                       reg = <0x0 0x20104000 0x0 0x400>;
> > +                       reg-io-width = <4>;
> > +                       reg-shift = <2>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <93>;
> > +                       current-speed = <115200>;
> > +                       clocks = <&clkcfg 11>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               emmc: mmc@20008000 {
> > +                       compatible = "cdns,sd4hc";
> > +                       reg = <0x0 0x20008000 0x0 0x1000>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <88 89>;
> > +                       pinctrl-names = "default";
> > +                       clocks = <&clkcfg 6>;
> > +                       bus-width = <4>;
> > +                       cap-mmc-highspeed;
> > +                       mmc-ddr-3_3v;
> > +                       max-frequency = <200000000>;
> > +                       non-removable;
> > +                       no-sd;
> > +                       no-sdio;
> > +                       voltage-ranges = <3300 3300>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               sdcard: sdhc@20008000 {
> > +                       compatible = "cdns,sd4hc";
> > +                       reg = <0x0 0x20008000 0x0 0x1000>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <88>;
> > +                       pinctrl-names = "default";
> > +                       clocks = <&clkcfg 6>;
> > +                       bus-width = <4>;
> > +                       disable-wp;
> > +                       no-1-8-v;
> > +                       cap-mmc-highspeed;
> > +                       cap-sd-highspeed;
> > +                       card-detect-delay = <200>;
> > +                       sd-uhs-sdr12;
> > +                       sd-uhs-sdr25;
> > +                       sd-uhs-sdr50;
> > +                       sd-uhs-sdr104;
> > +                       max-frequency = <200000000>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               emac0: ethernet@20110000 {
> > +                       compatible = "cdns,macb";
> > +                       reg = <0x0 0x20110000 0x0 0x2000>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <64 65 66 67>;
> > +                       local-mac-address = [00 00 00 00 00 00];
> > +                       phy-mode = "sgmii";
> > +                       clocks = <&clkcfg 5>, <&clkcfg 2>;
> > +                       clock-names = "pclk", "hclk";
> > +                       status = "disabled";
> > +
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       phy-handle = <&phy0>;
> > +                       phy0: ethernet-phy@8 {
> > +                               reg = <8>;
> > +                               ti,fifo-depth = <0x01>;
> > +                       };
> > +               };
> > +
> > +               emac1: ethernet@20112000 {
> > +                       compatible = "cdns,macb";
> > +                       reg = <0x0 0x20112000 0x0 0x2000>;
> > +                       interrupt-parent = <&plic>;
> > +                       interrupts = <70 71 72 73>;
> > +                       mac-address = [00 00 00 00 00 00];
> > +                       phy-mode = "sgmii";
> > +                       clocks = <&clkcfg 5>, <&clkcfg 2>;
> > +                       clock-names = "pclk", "hclk";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       phy1: ethernet-phy@9 {
> > +                               reg = <9>;
> > +                               ti,fifo-depth = <0x01>;
> > +                       };
> > +               };
> > +
> > +       };
> > +};
>
> Regards,
> Bin
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
