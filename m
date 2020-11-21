Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB15A2BBE22
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 10:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKUIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 03:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKUIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 03:53:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118BC061A49
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 00:53:04 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so725336lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cceQRmZEgjB9fx3i/wk5DdJOjTvr1pgKhs4f6j6i9LY=;
        b=i1uxd4qQg92tKfPLqPef+CiOf8ixdWMhQK6jPYXdsBlYDLFdMpNDw7/UFxukr6BMP4
         UN60/qmpxEaQ/opjC8ovR/EQcLypGuxfQeJ2ni7fKkHOQ63HTuerIR+HWC7WQh5uT9ax
         3kyVJUPc6Vm+AelTq6MnUGO1wezMQQwIOxMwq4XqY4g0BTgsvDWIxeRcXZZBEsrqsmYd
         wouk93y4c8rBvL6kUkWirZwRLOPefqgQtFK9hja2j0LNFiuQMY5NUPs6DDkla8j+9kJo
         CFWup8jk/Ipzo3ti0Ub3FVFTevSDbSgOazWzaSOXN2pnoezcgEp2F15+D6dZvVH/PeYF
         ff7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cceQRmZEgjB9fx3i/wk5DdJOjTvr1pgKhs4f6j6i9LY=;
        b=K8RHOak+KnkZ3gv+S1BMK7FlSfp0NnZFnUJkF4v633myDLVB2BTznfvO2opDguJzN7
         /QzJS5P/ZD/5uaBe049KzRg8Y55/m4eOh+PnMu6O+N4HN7y1ATzTDswCIEzm6TPwBP1h
         d6Q+LD4jP3mxDuWclkd0Yvi74nOaOFH99Hsux2YQwq4xIedQPwNVxTqnw4xSzelyuPGl
         1wZJq5bfL9EHFnAgGqtuj93P/EuGq7xz4jm8f5FxNCA0Yo9xkTUI0dLgVaJxRk1YnQet
         DA4fG5qxAHt8ggrwoWEztMUVbviqGL5dAI4qzGwJRihXo9EXnc2gImpUrlvlurpF/14T
         OxCA==
X-Gm-Message-State: AOAM5305vB1EmCFeRgD+olX50vUZrKOeaIi/3NTY/liRTxd+OlXZJF5O
        Z0OoWg0WETtCIGR6PM71rAQJR+BoEf+X5ZW4VrBk3w==
X-Google-Smtp-Source: ABdhPJz/zJTaVxXF9/YBjuyutYaxGa0Xtsj4FU46ZkgGV4y4/g3qais1Etq65IUucdhd7hXSu2B8WgnFhQl32yX8dac=
X-Received: by 2002:a19:2389:: with SMTP id j131mr10068188lfj.324.1605948782994;
 Sat, 21 Nov 2020 00:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20201113202550.3693323-1-atish.patra@wdc.com> <20201113202550.3693323-4-atish.patra@wdc.com>
In-Reply-To: <20201113202550.3693323-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 21 Nov 2020 14:22:51 +0530
Message-ID: <CAAhSdy1vgfnxgnqa50OmxzNsa47r03e=41fxwX7kkwtL4N1FAA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Conor.Dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 1:56 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Add initial DTS for Microchip ICICLE board having only
> essential devcies (clocks, sdhci, ethernet, serial, etc).
> The device tree is based on the U-Boot patch.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../microchip/microchip-mpfs-icicle-kit.dts   |  54 +++
>  .../boot/dts/microchip/microchip-mpfs.dtsi    | 342 ++++++++++++++++++
>  4 files changed, 399 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ca1f8cbd78c0..3ea94ea0a18a 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  subdir-y += sifive
>  subdir-y += kendryte
> +subdir-y += microchip
>
>  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> new file mode 100644
> index 000000000000..622b12771fd3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> new file mode 100644
> index 000000000000..9a382ab0a799
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "microchip-mpfs.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ            1000000
> +
> +/ {
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       model = "Microchip PolarFire-SoC Icicle Kit";
> +       compatible = "microchip,mpfs-icicle-kit", "microchip,polarfire-soc";
> +
> +       chosen {
> +               stdout-path = &serial0;
> +       };
> +
> +       cpus {
> +               timebase-frequency = <RTCCLK_FREQ>;
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x0 0x40000000>;
> +               clocks = <&clkcfg 26>;
> +       };
> +
> +       soc {
> +       };
> +};
> +
> +&serial0 {
> +       status = "okay";
> +};
> +
> +&serial1 {
> +       status = "okay";
> +};
> +
> +&serial2 {
> +       status = "okay";
> +};
> +
> +&serial3 {
> +       status = "okay";
> +};
> +
> +&sdcard {
> +       status = "okay";
> +};
> +
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> new file mode 100644
> index 000000000000..63ac60f345d8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       model = "Microchip PolarFire-SoC";
> +       compatible = "microchip,polarfire-soc";
> +
> +       chosen {
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,rocket0", "riscv";
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <128>;
> +                       i-cache-size = <16384>;
> +                       reg = <0>;
> +                       riscv,isa = "rv64imac";
> +                       status = "disabled";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@1 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <1>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +                       status = "okay";
> +
> +                       cpu1_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@2 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <2>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +                       status = "okay";
> +
> +                       cpu2_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@3 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <3>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +                       status = "okay";
> +
> +                       cpu3_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@4 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <4>;
> +                       riscv,isa = "rv64imafdc";
> +                       tlb-split;
> +                       status = "okay";
> +                       cpu4_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +       };
> +
> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               cache-controller@2010000 {
> +                       compatible = "sifive,fu540-c000-ccache", "cache";
> +                       cache-block-size = <64>;
> +                       cache-level = <2>;
> +                       cache-sets = <1024>;
> +                       cache-size = <2097152>;
> +                       cache-unified;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <1 2 3>;
> +                       reg = <0x0 0x2010000 0x0 0x1000>;
> +               };
> +
> +               clint@2000000 {
> +                       compatible = "riscv,clint0";
> +                       reg = <0x0 0x2000000 0x0 0xC000>;
> +                       interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
> +                                               &cpu1_intc 3 &cpu1_intc 7
> +                                               &cpu2_intc 3 &cpu2_intc 7
> +                                               &cpu3_intc 3 &cpu3_intc 7
> +                                               &cpu4_intc 3 &cpu4_intc 7>;
> +               };
> +
> +               plic: interrupt-controller@c000000 {
> +                       #interrupt-cells = <1>;
> +                       compatible = "sifive,plic-1.0.0";
> +                       reg = <0x0 0xc000000 0x0 0x4000000>;
> +                       riscv,ndev = <53>;
> +                       interrupt-controller;
> +                       interrupts-extended = <&cpu0_intc 11
> +                                       &cpu1_intc 11 &cpu1_intc 9
> +                                       &cpu2_intc 11 &cpu2_intc 9
> +                                       &cpu3_intc 11 &cpu3_intc 9
> +                                       &cpu4_intc 11 &cpu4_intc 9>;
> +               };
> +
> +               dma@3000000 {
> +                       compatible = "sifive,fu540-c000-pdma";
> +                       reg = <0x0 0x3000000 0x0 0x8000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <23 24 25 26 27 28 29 30>;
> +                       #dma-cells = <1>;
> +               };
> +
> +               refclk: refclk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <600000000>;
> +                       clock-output-names = "msspllclk";
> +               };
> +
> +               clkcfg: clkcfg@20002000 {
> +                       compatible = "microchip,pfsoc-clkcfg";
> +                       reg = <0x0 0x20002000 0x0 0x1000>;
> +                       reg-names = "mss_sysreg";
> +                       clocks = <&refclk>;
> +                       #clock-cells = <1>;
> +                       clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk",   /* 0-3   */
> +                                "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk",            /* 4-7   */
> +                               "MMUART0clk", "MMUART1clk", "MMUART2clk", "MMUART3clk", /* 8-11  */
> +                               "MMUART4clk", "SPI0clk", "SPI1clk", "I2C0clk",          /* 12-15 */
> +                               "I2C1clk", "CAN0clk", "CAN1clk", "USBclk",              /* 16-19 */
> +                               "RESERVED", "RTCclk", "QSPIclk", "GPIO0clk",            /* 20-23 */
> +                               "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk",           /* 24-27 */
> +                               "FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk"; /* 28-32 */
> +               };
> +
> +               serial0: serial@20000000 {
> +                       compatible = "ns16550a";
> +                       reg = <0x0 0x20000000 0x0 0x400>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <90>;
> +                       current-speed = <115200>;
> +                       clocks = <&clkcfg 8>;
> +                       status = "disabled";
> +               };
> +
> +               serial1: serial@20100000 {
> +                       compatible = "ns16550a";
> +                       reg = <0x0 0x20100000 0x0 0x400>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <91>;
> +                       current-speed = <115200>;
> +                       clocks = <&clkcfg 9>;
> +                       status = "disabled";
> +               };
> +
> +               serial2: serial@20102000 {
> +                       compatible = "ns16550a";
> +                       reg = <0x0 0x20102000 0x0 0x400>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <92>;
> +                       current-speed = <115200>;
> +                       clocks = <&clkcfg 10>;
> +                       status = "disabled";
> +               };
> +
> +               serial3: serial@20104000 {
> +                       compatible = "ns16550a";
> +                       reg = <0x0 0x20104000 0x0 0x400>;
> +                       reg-io-width = <4>;
> +                       reg-shift = <2>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <93>;
> +                       current-speed = <115200>;
> +                       clocks = <&clkcfg 11>;
> +                       status = "disabled";
> +               };
> +
> +               emmc: mmc@20008000 {
> +                       compatible = "cdns,sd4hc";
> +                       reg = <0x0 0x20008000 0x0 0x1000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <88 89>;
> +                       pinctrl-names = "default";
> +                       clocks = <&clkcfg 6>;
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       mmc-ddr-3_3v;
> +                       max-frequency = <200000000>;
> +                       non-removable;
> +                       no-sd;
> +                       no-sdio;
> +                       voltage-ranges = <3300 3300>;
> +                       status = "disabled";
> +               };
> +
> +               sdcard: sdhc@20008000 {
> +                       compatible = "cdns,sd4hc";
> +                       reg = <0x0 0x20008000 0x0 0x1000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <88>;
> +                       pinctrl-names = "default";
> +                       clocks = <&clkcfg 6>;
> +                       bus-width = <4>;
> +                       disable-wp;
> +                       no-1-8-v;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
> +                       card-detect-delay = <200>;
> +                       sd-uhs-sdr12;
> +                       sd-uhs-sdr25;
> +                       sd-uhs-sdr50;
> +                       sd-uhs-sdr104;
> +                       max-frequency = <200000000>;
> +                       status = "disabled";
> +               };
> +
> +               emac0: ethernet@20110000 {
> +                       compatible = "cdns,macb";
> +                       reg = <0x0 0x20110000 0x0 0x2000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <64 65 66 67>;
> +                       local-mac-address = [00 00 00 00 00 00];
> +                       phy-mode = "sgmii";
> +                       clocks = <&clkcfg 5>, <&clkcfg 2>;
> +                       clock-names = "pclk", "hclk";
> +                       status = "disabled";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       phy-handle = <&phy0>;
> +                       phy0: ethernet-phy@8 {
> +                               reg = <8>;
> +                               ti,fifo-depth = <0x01>;
> +                       };

Ethernet PHYs are generally on-board devices.

Keep the "#address-cells" and "#size-cells" here but
move the PHY related details to board DTS files.

> +               };
> +
> +               emac1: ethernet@20112000 {
> +                       compatible = "cdns,macb";
> +                       reg = <0x0 0x20112000 0x0 0x2000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <70 71 72 73>;
> +                       mac-address = [00 00 00 00 00 00];
> +                       phy-mode = "sgmii";
> +                       clocks = <&clkcfg 5>, <&clkcfg 2>;
> +                       clock-names = "pclk", "hclk";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       phy1: ethernet-phy@9 {
> +                               reg = <9>;
> +                               ti,fifo-depth = <0x01>;
> +                       };
> +               };

Same comments as emac0.

In addition, disable emac1 by default in the SOC DTS file
and enable it in the board DTS file.

> +
> +       };
> +};
> --
> 2.25.1
>

Regards,
Anup
