Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C62A00AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgJ3JFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3JFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:05:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A5C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:05:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 126so6902247lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wuS5u1doYgwJMrQ1HQaz2hiwPQ/dACD5OsCQyigRClI=;
        b=h7pf6DdOD7RmWd3oL0OMKqO3VA+HHBjIglyYGHiJrbDITIQrZ+7BxOU3+eFBXamPCG
         myV/ZOuma7t7c/O3TiEZYHI26M+uyiDZloylZcBu7sMYX3498wCBhv9AE63XwPIC40Qm
         F3NBmr1gO71vYwXqHA33XaBtWYHC2ca1ct14MQpYJ15itobbxe9A6Luz4h1W3KT9+JcO
         goBGIl3MSLgCfqcuxfxn45h1m2zd1vVdfMnRpIM8No2h+mycIVHWkMX9Rp6SegRjLIqP
         QlBbddpowxyvdrsjNlCtanZALX9uOMjawC3F430supnuLtBeptC0gUQbu247TCGiRrde
         JNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wuS5u1doYgwJMrQ1HQaz2hiwPQ/dACD5OsCQyigRClI=;
        b=K1x/plqI502LzzOxKfuu1Z0m7W2V2N0tzIm+r2Y4JP8auLkM0VnV3Pzy7JtxTAqxC6
         NX3eWZx6JvvLRjtOSmdmHmv3448uT8kqCP8OmCvwG65XV9brVchX0X651uBNHa9mQsDn
         3psYnRi4Ip1GxB1REMwMsEBOXs3LDcw8zaUOqtCD0gYVNvwFA+kqGJ4Iu6vqT4IJFtqs
         YdITgPpea6kgFxPQmSAXQE3DvBhoJWXmzVPCrXy5/nuYaUQGK1gXhPk7cVnYYH8ZPry0
         qOd+0SfnElDRF+cT1pYHanuwWz1yQWWeXmdDUYdzfwikUFjFTpzFGgqZjWiIvfr1ZU8E
         1LgA==
X-Gm-Message-State: AOAM533pF+iRpWeb6HfpeOH5kQQblxWKlO2b+yyKzAHuPB/EqX2zOCH4
        9H165xMCYxwQNH22UcRhqs8qGqk1xuq/lDJzyoCvAQ==
X-Google-Smtp-Source: ABdhPJyy29DKvlmhSGLrkaffIQCfwSejXh+C1NwBmK26auf6nYDHNgTcUdxbrM+XOi2UCmABu6cU0zzmKdonhvYu018=
X-Received: by 2002:a19:6a04:: with SMTP id u4mr543814lfu.493.1604048742501;
 Fri, 30 Oct 2020 02:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
In-Reply-To: <20201028232759.1928479-3-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 30 Oct 2020 14:35:30 +0530
Message-ID: <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Padmarao Begari <padmarao.begari@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Add initial DTS for Microchip ICICLE board having only
> essential devcies (clocks, sdhci, ethernet, serial, etc).
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++

I suggest we split this DTS into two parts:
1. SOC (microchip-polarfire.dtsi)
2. Board (microchip-icicle-kit-a000.dts)

This will be much cleaner and aligned with what is done
on other architectures.

>  3 files changed, 316 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a0=
00.dts
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ca1f8cbd78c0..3ea94ea0a18a 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  subdir-y +=3D sifive
>  subdir-y +=3D kendryte
> +subdir-y +=3D microchip
>
>  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts=
/microchip/Makefile
> new file mode 100644
> index 000000000000..55ad77521304
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) +=3D microchip-icicle-kit-a000.dtb
> diff --git a/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts =
b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> new file mode 100644
> index 000000000000..5848920af55c
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ            1000000
> +
> +/ {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +       model =3D "Microchip PolarFire-SoC";
> +       compatible =3D "microchip,polarfire-soc";
> +
> +       chosen {
> +               stdout-path =3D &serial0;
> +       };
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               timebase-frequency =3D <RTCCLK_FREQ>;
> +
> +               cpu@0 {
> +                       clock-frequency =3D <0>;
> +                       compatible =3D "sifive,rocket0", "riscv";
> +                       device_type =3D "cpu";
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <128>;
> +                       i-cache-size =3D <16384>;
> +                       reg =3D <0>;
> +                       riscv,isa =3D "rv64imac";
> +                       status =3D "disabled";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               #interrupt-cells =3D <1>;
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@1 {
> +                       clock-frequency =3D <0>;
> +                       compatible =3D "sifive,rocket0", "riscv";
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-tlb-sets =3D <1>;
> +                       d-tlb-size =3D <32>;
> +                       device_type =3D "cpu";
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-tlb-sets =3D <1>;
> +                       i-tlb-size =3D <32>;
> +                       mmu-type =3D "riscv,sv39";
> +                       reg =3D <1>;
> +                       riscv,isa =3D "rv64imafdc";
> +                       tlb-split;
> +                       status =3D "okay";
> +
> +                       cpu1_intc: interrupt-controller {
> +                               #interrupt-cells =3D <1>;
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@2 {
> +                       clock-frequency =3D <0>;
> +                       compatible =3D "sifive,rocket0", "riscv";
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-tlb-sets =3D <1>;
> +                       d-tlb-size =3D <32>;
> +                       device_type =3D "cpu";
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-tlb-sets =3D <1>;
> +                       i-tlb-size =3D <32>;
> +                       mmu-type =3D "riscv,sv39";
> +                       reg =3D <2>;
> +                       riscv,isa =3D "rv64imafdc";
> +                       tlb-split;
> +                       status =3D "okay";
> +
> +                       cpu2_intc: interrupt-controller {
> +                               #interrupt-cells =3D <1>;
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@3 {
> +                       clock-frequency =3D <0>;
> +                       compatible =3D "sifive,rocket0", "riscv";
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-tlb-sets =3D <1>;
> +                       d-tlb-size =3D <32>;
> +                       device_type =3D "cpu";
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-tlb-sets =3D <1>;
> +                       i-tlb-size =3D <32>;
> +                       mmu-type =3D "riscv,sv39";
> +                       reg =3D <3>;
> +                       riscv,isa =3D "rv64imafdc";
> +                       tlb-split;
> +                       status =3D "okay";
> +
> +                       cpu3_intc: interrupt-controller {
> +                               #interrupt-cells =3D <1>;
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               cpu@4 {
> +                       clock-frequency =3D <0>;
> +                       compatible =3D "sifive,rocket0", "riscv";
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-tlb-sets =3D <1>;
> +                       d-tlb-size =3D <32>;
> +                       device_type =3D "cpu";
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-tlb-sets =3D <1>;
> +                       i-tlb-size =3D <32>;
> +                       mmu-type =3D "riscv,sv39";
> +                       reg =3D <4>;
> +                       riscv,isa =3D "rv64imafdc";
> +                       tlb-split;
> +                       status =3D "okay";
> +                       cpu4_intc: interrupt-controller {
> +                               #interrupt-cells =3D <1>;
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +       };
> +
> +       memory@80000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x80000000 0x0 0x40000000>;
> +               clocks =3D <&clkcfg 26>;
> +       };
> +
> +       soc {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               compatible =3D "simple-bus";
> +               ranges;
> +
> +               cache-controller@2010000 {
> +                       compatible =3D "sifive,fu540-c000-ccache", "cache=
";
> +                       cache-block-size =3D <64>;
> +                       cache-level =3D <2>;
> +                       cache-sets =3D <1024>;
> +                       cache-size =3D <2097152>;
> +                       cache-unified;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <1 2 3>;
> +                       reg =3D <0x0 0x2010000 0x0 0x1000>;
> +               };
> +
> +               clint@2000000 {
> +                       compatible =3D "riscv,clint0";
> +                       reg =3D <0x0 0x2000000 0x0 0xC000>;
> +                       interrupts-extended =3D <&cpu0_intc 3 &cpu0_intc =
7
> +                                               &cpu1_intc 3 &cpu1_intc 7
> +                                               &cpu2_intc 3 &cpu2_intc 7
> +                                               &cpu3_intc 3 &cpu3_intc 7
> +                                               &cpu4_intc 3 &cpu4_intc 7=
>;
> +               };
> +
> +               plic: interrupt-controller@c000000 {
> +                       #interrupt-cells =3D <1>;
> +                       compatible =3D "sifive,plic-1.0.0";
> +                       reg =3D <0x0 0xc000000 0x0 0x4000000>;
> +                       riscv,ndev =3D <53>;
> +                       interrupt-controller;
> +                       interrupts-extended =3D <&cpu0_intc 11
> +                                       &cpu1_intc 11 &cpu1_intc 9
> +                                       &cpu2_intc 11 &cpu2_intc 9
> +                                       &cpu3_intc 11 &cpu3_intc 9
> +                                       &cpu4_intc 11 &cpu4_intc 9>;
> +               };
> +
> +               dma@3000000 {
> +                       compatible =3D "sifive,fu540-c000-pdma";
> +                       reg =3D <0x0 0x3000000 0x0 0x8000>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <23 24 25 26 27 28 29 30>;
> +                       #dma-cells =3D <1>;
> +               };
> +
> +               refclk: refclk {
> +                       compatible =3D "fixed-clock";
> +                       #clock-cells =3D <0>;
> +                       clock-frequency =3D <600000000>;
> +                       clock-output-names =3D "msspllclk";
> +               };
> +
> +               clkcfg: clkcfg@20002000 {
> +                       compatible =3D "microchip,pfsoc-clkcfg";
> +                       reg =3D <0x0 0x20002000 0x0 0x1000>;
> +                       reg-names =3D "mss_sysreg";
> +                       clocks =3D <&refclk>;
> +                       #clock-cells =3D <1>;
> +                       clock-output-names =3D "cpuclk", "axiclk", "ahbcl=
k", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", "M=
MUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk",=
 "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCclk"=
, "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "FIC=
1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
> +               };
> +
> +               serial0: serial@20000000 {
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0x0 0x20000000 0x0 0x400>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <90>;
> +                       current-speed =3D <115200>;
> +                       clocks =3D <&clkcfg 8>;
> +                       status =3D "okay";
> +               };
> +
> +               serial1: serial@20100000 {
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0x0 0x20100000 0x0 0x400>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <91>;
> +                       current-speed =3D <115200>;
> +                       clocks =3D <&clkcfg 9>;
> +                       status =3D "okay";
> +               };
> +
> +               serial2: serial@20102000 {
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0x0 0x20102000 0x0 0x400>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <92>;
> +                       current-speed =3D <115200>;
> +                       clocks =3D <&clkcfg 10>;
> +                       status =3D "okay";
> +               };
> +
> +               serial3: serial@20104000 {
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0x0 0x20104000 0x0 0x400>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <93>;
> +                       current-speed =3D <115200>;
> +                       clocks =3D <&clkcfg 11>;
> +                       status =3D "okay";
> +               };
> +
> +               sdcard: sdhc@20008000 {
> +                       compatible =3D "cdns,sd4hc";
> +                       reg =3D <0x0 0x20008000 0x0 0x1000>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <88>;
> +                       pinctrl-names =3D "default";
> +                       clocks =3D <&clkcfg 6>;
> +                       bus-width =3D <4>;
> +                       disable-wp;
> +                       no-1-8-v;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
> +                       card-detect-delay =3D <200>;
> +                       sd-uhs-sdr12;
> +                       sd-uhs-sdr25;
> +                       sd-uhs-sdr50;
> +                       sd-uhs-sdr104;
> +                       max-frequency =3D <200000000>;
> +                       status =3D "okay";
> +               };
> +
> +               emac1: ethernet@20112000 {
> +                       compatible =3D "cdns,macb";
> +                       reg =3D <0x0 0x20112000 0x0 0x2000>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupts =3D <70 71 72 73>;
> +                       mac-address =3D [56 34 12 00 FC 00];
> +                       phy-mode =3D "sgmii";
> +                       clocks =3D <&clkcfg 5>, <&clkcfg 2>;
> +                       clock-names =3D "pclk", "hclk";
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       phy1: ethernet-phy@9 {
> +                               reg =3D <9>;
> +                               ti,fifo-depth =3D <0x01>;
> +                       };
> +               };
> +
> +               uio_axi_lsram@2030000000 {
> +                       compatible =3D "generic-uio";
> +                       reg =3D <0x20 0x30000000 0 0x80000000 >;
> +                       status =3D "okay";
> +               };
> +       };
> +};
> --
> 2.25.1
>

Regards,
Anup
