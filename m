Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D122A4907
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKCPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgKCPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:08:46 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE30BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:08:46 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id p7so18786281ioo.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XrYo9O0i05esQNevxBJRekZg/PnpDyjXAgTjbtO6ZbQ=;
        b=GtodWBZgnt/01Qr4mekcBNERbrUasrZM+mr1F5Oj4I84rSfafAepqUPCe69+3zNHWL
         6OMmQS4yS7pmCZPqfhwLc4h/PwNCYu9kKXlij8tyXfcRNeHPuHeUZTzJB5+9InIe/jAh
         Q3MCWiRdtcU/MRKPI1InMspF8gb4SHb2QjHrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XrYo9O0i05esQNevxBJRekZg/PnpDyjXAgTjbtO6ZbQ=;
        b=XXeFYjK/v7VqJr1NUuLn1VUdbRsjXNYV+GM85W4aCVd2CIr7DEmU+gFGYrm7opoyZb
         gvURYNeTqF5b4wm8MvltYqHivDvhr97aqx2nH7MlMJDSWs+jH3SmbGKe5wSgRbMopoVH
         aT8BEZ7GceC5jKCm0t51OvaUIS/kBmGNXanjNebk6yjCDon7ZNlrZ8rerPr7Abri948x
         tUIEVrRWcAmwapOudNy7l5aghy8mS0pjYu+MaAisnxqbdo6Dptw5BXzxhUEMPGuWh4o1
         zY9SDn6lmtEKtMdbHJqXgvwjPs2YCUu1GVPqt4fn83L8v7FvSlLOwgF//vhGWad2/vLD
         /f6g==
X-Gm-Message-State: AOAM532Xa1F7vWarwaH3uh0hiVGOR9n6HckdpVQjSsrTfyFWjrBtDgcp
        C5AQcMiKss4he37GV3FCsO6tI8+KtY1FdSjXvDsP
X-Google-Smtp-Source: ABdhPJzqzs/NB1K8HBkkw07rlFBru3y1mQ/Kj5vQRDvo9rz/SNNFqYuUqOQrko55mRHImrw86ttj+W7Cth3Cy/mXo2E=
X-Received: by 2002:a02:65cf:: with SMTP id u198mr15912776jab.24.1604416126101;
 Tue, 03 Nov 2020 07:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
 <CAOnJCUKCbkZVGX5Rjputs9QQAHCvH6Fikt7kVGsyCkNjbdMv=Q@mail.gmail.com> <734904fe-975a-5908-d08c-266a5049deac@codethink.co.uk>
In-Reply-To: <734904fe-975a-5908-d08c-266a5049deac@codethink.co.uk>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 Nov 2020 07:08:33 -0800
Message-ID: <CAOnJCU+Zj7JCHssg_+Vj3E1NhK_etXauDDbKK08v=C6o4gDv2g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Cyril.Jean@microchip.com,
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

On Tue, Nov 3, 2020 at 2:59 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 30/10/2020 20:27, Atish Patra wrote:
> > On Fri, Oct 30, 2020 at 2:05 AM Anup Patel <anup@brainfault.org> wrote:
> >>
> >> On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrot=
e:
> >>>
> >>> Add initial DTS for Microchip ICICLE board having only
> >>> essential devcies (clocks, sdhci, ethernet, serial, etc).
> >>>
> >>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >>> ---
> >>>   arch/riscv/boot/dts/Makefile                  |   1 +
> >>>   arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >>>   .../microchip/microchip-icicle-kit-a000.dts   | 313 +++++++++++++++=
+++
> >>
> >> I suggest we split this DTS into two parts:
> >> 1. SOC (microchip-polarfire.dtsi)
> >> 2. Board (microchip-icicle-kit-a000.dts)
> >>
> >> This will be much cleaner and aligned with what is done
> >> on other architectures.
> >>
> >
> > Sure. I will do that in v2.
> >
> >>>   3 files changed, 316 insertions(+)
> >>>   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >>>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-k=
it-a000.dts
> >>>
> >>> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makef=
ile
> >>> index ca1f8cbd78c0..3ea94ea0a18a 100644
> >>> --- a/arch/riscv/boot/dts/Makefile
> >>> +++ b/arch/riscv/boot/dts/Makefile
> >>> @@ -1,5 +1,6 @@
> >>>   # SPDX-License-Identifier: GPL-2.0
> >>>   subdir-y +=3D sifive
> >>>   subdir-y +=3D kendryte
> >>> +subdir-y +=3D microchip
> >>>
> >>>   obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
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
> >>> +#define RTCCLK_FREQ            1000000
> >>> +
> >>> +/ {
> >>> +       #address-cells =3D <2>;
> >>> +       #size-cells =3D <2>;
> >>> +       model =3D "Microchip PolarFire-SoC";
> >>> +       compatible =3D "microchip,polarfire-soc";
> >>> +
> >>> +       chosen {
> >>> +               stdout-path =3D &serial0;
> >>> +       };
> >>> +
> >>> +       cpus {
> >>> +               #address-cells =3D <1>;
> >>> +               #size-cells =3D <0>;
> >>> +               timebase-frequency =3D <RTCCLK_FREQ>;
> >>> +
> >>> +               cpu@0 {
> >>> +                       clock-frequency =3D <0>;
> >>> +                       compatible =3D "sifive,rocket0", "riscv";
> >>> +                       device_type =3D "cpu";
> >>> +                       i-cache-block-size =3D <64>;
> >>> +                       i-cache-sets =3D <128>;
> >>> +                       i-cache-size =3D <16384>;
> >>> +                       reg =3D <0>;
> >>> +                       riscv,isa =3D "rv64imac";
> >>> +                       status =3D "disabled";
> >>> +
> >>> +                       cpu0_intc: interrupt-controller {
> >>> +                               #interrupt-cells =3D <1>;
> >>> +                               compatible =3D "riscv,cpu-intc";
> >>> +                               interrupt-controller;
> >>> +                       };
> >>> +               };
> >>> +
> >>> +               cpu@1 {
> >>> +                       clock-frequency =3D <0>;
> >>> +                       compatible =3D "sifive,rocket0", "riscv";
> >>> +                       d-cache-block-size =3D <64>;
> >>> +                       d-cache-sets =3D <64>;
> >>> +                       d-cache-size =3D <32768>;
> >>> +                       d-tlb-sets =3D <1>;
> >>> +                       d-tlb-size =3D <32>;
> >>> +                       device_type =3D "cpu";
> >>> +                       i-cache-block-size =3D <64>;
> >>> +                       i-cache-sets =3D <64>;
> >>> +                       i-cache-size =3D <32768>;
> >>> +                       i-tlb-sets =3D <1>;
> >>> +                       i-tlb-size =3D <32>;
> >>> +                       mmu-type =3D "riscv,sv39";
> >>> +                       reg =3D <1>;
> >>> +                       riscv,isa =3D "rv64imafdc";
> >>> +                       tlb-split;
> >>> +                       status =3D "okay";
> >>> +
> >>> +                       cpu1_intc: interrupt-controller {
> >>> +                               #interrupt-cells =3D <1>;
> >>> +                               compatible =3D "riscv,cpu-intc";
> >>> +                               interrupt-controller;
> >>> +                       };
> >>> +               };
> >>> +
> >>> +               cpu@2 {
> >>> +                       clock-frequency =3D <0>;
> >>> +                       compatible =3D "sifive,rocket0", "riscv";
> >>> +                       d-cache-block-size =3D <64>;
> >>> +                       d-cache-sets =3D <64>;
> >>> +                       d-cache-size =3D <32768>;
> >>> +                       d-tlb-sets =3D <1>;
> >>> +                       d-tlb-size =3D <32>;
> >>> +                       device_type =3D "cpu";
> >>> +                       i-cache-block-size =3D <64>;
> >>> +                       i-cache-sets =3D <64>;
> >>> +                       i-cache-size =3D <32768>;
> >>> +                       i-tlb-sets =3D <1>;
> >>> +                       i-tlb-size =3D <32>;
> >>> +                       mmu-type =3D "riscv,sv39";
> >>> +                       reg =3D <2>;
> >>> +                       riscv,isa =3D "rv64imafdc";
> >>> +                       tlb-split;
> >>> +                       status =3D "okay";
> >>> +
> >>> +                       cpu2_intc: interrupt-controller {
> >>> +                               #interrupt-cells =3D <1>;
> >>> +                               compatible =3D "riscv,cpu-intc";
> >>> +                               interrupt-controller;
> >>> +                       };
> >>> +               };
> >>> +
> >>> +               cpu@3 {
> >>> +                       clock-frequency =3D <0>;
> >>> +                       compatible =3D "sifive,rocket0", "riscv";
> >>> +                       d-cache-block-size =3D <64>;
> >>> +                       d-cache-sets =3D <64>;
> >>> +                       d-cache-size =3D <32768>;
> >>> +                       d-tlb-sets =3D <1>;
> >>> +                       d-tlb-size =3D <32>;
> >>> +                       device_type =3D "cpu";
> >>> +                       i-cache-block-size =3D <64>;
> >>> +                       i-cache-sets =3D <64>;
> >>> +                       i-cache-size =3D <32768>;
> >>> +                       i-tlb-sets =3D <1>;
> >>> +                       i-tlb-size =3D <32>;
> >>> +                       mmu-type =3D "riscv,sv39";
> >>> +                       reg =3D <3>;
> >>> +                       riscv,isa =3D "rv64imafdc";
> >>> +                       tlb-split;
> >>> +                       status =3D "okay";
> >>> +
> >>> +                       cpu3_intc: interrupt-controller {
> >>> +                               #interrupt-cells =3D <1>;
> >>> +                               compatible =3D "riscv,cpu-intc";
> >>> +                               interrupt-controller;
> >>> +                       };
> >>> +               };
> >>> +
> >>> +               cpu@4 {
> >>> +                       clock-frequency =3D <0>;
> >>> +                       compatible =3D "sifive,rocket0", "riscv";
> >>> +                       d-cache-block-size =3D <64>;
> >>> +                       d-cache-sets =3D <64>;
> >>> +                       d-cache-size =3D <32768>;
> >>> +                       d-tlb-sets =3D <1>;
> >>> +                       d-tlb-size =3D <32>;
> >>> +                       device_type =3D "cpu";
> >>> +                       i-cache-block-size =3D <64>;
> >>> +                       i-cache-sets =3D <64>;
> >>> +                       i-cache-size =3D <32768>;
> >>> +                       i-tlb-sets =3D <1>;
> >>> +                       i-tlb-size =3D <32>;
> >>> +                       mmu-type =3D "riscv,sv39";
> >>> +                       reg =3D <4>;
> >>> +                       riscv,isa =3D "rv64imafdc";
> >>> +                       tlb-split;
> >>> +                       status =3D "okay";
> >>> +                       cpu4_intc: interrupt-controller {
> >>> +                               #interrupt-cells =3D <1>;
> >>> +                               compatible =3D "riscv,cpu-intc";
> >>> +                               interrupt-controller;
> >>> +                       };
> >>> +               };
> >>> +       };
> >>> +
> >>> +       memory@80000000 {
> >>> +               device_type =3D "memory";
> >>> +               reg =3D <0x0 0x80000000 0x0 0x40000000>;
> >>> +               clocks =3D <&clkcfg 26>;
> >>> +       };
> >>> +
> >>> +       soc {
> >>> +               #address-cells =3D <2>;
> >>> +               #size-cells =3D <2>;
> >>> +               compatible =3D "simple-bus";
> >>> +               ranges;
> >>> +
> >>> +               cache-controller@2010000 {
> >>> +                       compatible =3D "sifive,fu540-c000-ccache", "c=
ache";
> >>> +                       cache-block-size =3D <64>;
> >>> +                       cache-level =3D <2>;
> >>> +                       cache-sets =3D <1024>;
> >>> +                       cache-size =3D <2097152>;
> >>> +                       cache-unified;
> >>> +                       interrupt-parent =3D <&plic>;
> >>> +                       interrupts =3D <1 2 3>;
> >>> +                       reg =3D <0x0 0x2010000 0x0 0x1000>;
> >>> +               };
> >>> +
> >>> +               clint@2000000 {
> >>> +                       compatible =3D "riscv,clint0";
> >>> +                       reg =3D <0x0 0x2000000 0x0 0xC000>;
> >>> +                       interrupts-extended =3D <&cpu0_intc 3 &cpu0_i=
ntc 7
> >>> +                                               &cpu1_intc 3 &cpu1_in=
tc 7
> >>> +                                               &cpu2_intc 3 &cpu2_in=
tc 7
> >>> +                                               &cpu3_intc 3 &cpu3_in=
tc 7
> >>> +                                               &cpu4_intc 3 &cpu4_in=
tc 7>;
> >>> +               };
> >>> +
> >>> +               plic: interrupt-controller@c000000 {
> >>> +                       #interrupt-cells =3D <1>;
> >>> +                       compatible =3D "sifive,plic-1.0.0";
> >>> +                       reg =3D <0x0 0xc000000 0x0 0x4000000>;
> >>> +                       riscv,ndev =3D <53>;
> >>> +                       interrupt-controller;
> >>> +                       interrupts-extended =3D <&cpu0_intc 11
> >>> +                                       &cpu1_intc 11 &cpu1_intc 9
> >>> +                                       &cpu2_intc 11 &cpu2_intc 9
> >>> +                                       &cpu3_intc 11 &cpu3_intc 9
> >>> +                                       &cpu4_intc 11 &cpu4_intc 9>;
> >>> +               };
> >>> +
> >>> +               dma@3000000 {
> >>> +                       compatible =3D "sifive,fu540-c000-pdma";
> >>> +                       reg =3D <0x0 0x3000000 0x0 0x8000>;
> >>> +                       interrupt-parent =3D <&plic>;
> >>> +                       interrupts =3D <23 24 25 26 27 28 29 30>;
> >>> +                       #dma-cells =3D <1>;
> >>> +               };
> >>> +
> >>> +               refclk: refclk {
> >>> +                       compatible =3D "fixed-clock";
> >>> +                       #clock-cells =3D <0>;
> >>> +                       clock-frequency =3D <600000000>;
> >>> +                       clock-output-names =3D "msspllclk";
> >>> +               };
> >>> +
> >>> +               clkcfg: clkcfg@20002000 {
> >>> +                       compatible =3D "microchip,pfsoc-clkcfg";
> >>> +                       reg =3D <0x0 0x20002000 0x0 0x1000>;
> >>> +                       reg-names =3D "mss_sysreg";
> >>> +                       clocks =3D <&refclk>;
> >>> +                       #clock-cells =3D <1>;
> >>> +                       clock-output-names =3D "cpuclk", "axiclk", "a=
hbclk", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk"=
, "MMUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1c=
lk", "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTC=
clk", "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", =
"FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
> >>> +               };
> >>> +
>
> H ow about doing something like
> >               clock-output-names =3D "cpuclk", "axiclk", "ahbclk", "ENV=
Mclk", "MAC0clk",        /* 0 -4 */
> >                               "MAC1clk", "MMCclk", "TIMERclk", "MMUART0=
clk", "MMUART1clk", /* 5-9 */
>
> this means we can easily work out what clocks are in which index
>
> As per the previos email, I'd leave these all populated as coming back
> and adding ones later is just going to be a pain with merge conflicts.
>

Sounds good to me.

>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html



--=20
Regards,
Atish
