Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F326C7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIPSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgIPS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF1C014DA0;
        Wed, 16 Sep 2020 06:15:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so10327840eja.2;
        Wed, 16 Sep 2020 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRMx2QCwn5J/0i/9dBFngMRBPtGNscayn9tnZ8FVVFA=;
        b=aOjRMHCWqaqetdVLoUYuPlq5bRuzANX9B9dYMATnSb6zxf1X2ynUB/pM+Jcu/wIGFJ
         CETwdhBeykYZYFurNTuKFqKoPiTebzRARzBs3zLDY0Mywtjd8ftxHEo34U+GLb/I4Uhk
         f9bYiM6j36GU/kbtBa9PYsxJpCM+Q4uVZOB4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRMx2QCwn5J/0i/9dBFngMRBPtGNscayn9tnZ8FVVFA=;
        b=XXviVE0NnuwOsd4+noUSe6CEI1+pYbQfe7Y/PjjFnTzwPnGDkfKNdNWaKWZIyN4Q7F
         oiz8UQ02PBuxfFG2HfPsWHG6j/GmXZLCeznf9w7PVBAXelMeZ6G5Po06+uxz68kyKIvS
         O93QSTSmobaZGwAvbi5sp/hhCuWqx5OVwOJMiIGtzoVFMakmIz0hh/G2ulBRvxv7qLrw
         vNgVp4bkP9fC5Ts0nxiktsimnDxOmpGVnbW4UtJOSbGOHBnF+ZgMMVKimFZy/3E+u9QZ
         CG98SeQYrUvgh/L47nuRUqf1miFrAs0drsMnt2XHLidXboLFEMNNh0TVysw8AAtyRPbz
         K/Hw==
X-Gm-Message-State: AOAM533Tfx87pJKgRBEPQy72DojABrpR4iASQZDZgilhkrJDXyoYuFHy
        gvRLjSKx4ucSbq9tM0nJAPaeKa62kucNw2bSzpA=
X-Google-Smtp-Source: ABdhPJwi2H60iamWSa4O+4BL2u/KxUFqRG+Fw+HbvWBjnoKrJkZiredljzBkenv3Dmr1y6tI6FfmOewXLd5CP/Y2Nks=
X-Received: by 2002:a17:906:e918:: with SMTP id ju24mr24683358ejb.442.1600262124914;
 Wed, 16 Sep 2020 06:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200916125554.195749-1-tmaimon77@gmail.com> <20200916125554.195749-2-tmaimon77@gmail.com>
In-Reply-To: <20200916125554.195749-2-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Sep 2020 13:15:12 +0000
Message-ID: <CACPK8Xfr8KQkKAtxC4FaWk-HKkSvgBnkrpF6yMBT0qxY16zmWQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm: dts: modify NPCM7xx device tree clock parameter
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 12:56, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Modify NPCM7xx device tree clock parameter to clock constants that
> define at include/dt-bindings/clock/nuvoton,npcm7xx-clock.h file.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 ++++++++++---------
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  6 +++---
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index d2d0761295a4..16a28c5c4131 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -3,6 +3,7 @@
>  // Copyright 2018 Google, Inc.
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
>
>  / {
>         #address-cells = <1>;
> @@ -80,7 +81,7 @@
>                         interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>                         cache-unified;
>                         cache-level = <2>;
> -                       clocks = <&clk 10>;
> +                       clocks = <&clk NPCM7XX_CLK_AXI>;
>                         arm,shared-override;
>                 };
>
> @@ -120,7 +121,7 @@
>                                 compatible = "nuvoton,npcm750-timer";
>                                 interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg = <0x8000 0x50>;
> -                               clocks = <&clk 5>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
>                         };
>
>                         watchdog0: watchdog@801C {
> @@ -128,7 +129,7 @@
>                                 interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg = <0x801C 0x4>;
>                                 status = "disabled";
> -                               clocks = <&clk 5>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
>                         };
>
>                         watchdog1: watchdog@901C {
> @@ -136,7 +137,7 @@
>                                 interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg = <0x901C 0x4>;
>                                 status = "disabled";
> -                               clocks = <&clk 5>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
>                         };
>
>                         watchdog2: watchdog@a01C {
> @@ -144,13 +145,13 @@
>                                 interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg = <0xa01C 0x4>;
>                                 status = "disabled";
> -                               clocks = <&clk 5>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
>                         };
>
>                         serial0: serial@1000 {
>                                 compatible = "nuvoton,npcm750-uart";
>                                 reg = <0x1000 0x1000>;
> -                               clocks = <&clk 6>;
> +                               clocks = <&clk NPCM7XX_CLK_UART>;
>                                 interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg-shift = <2>;
>                                 status = "disabled";
> @@ -159,7 +160,7 @@
>                         serial1: serial@2000 {
>                                 compatible = "nuvoton,npcm750-uart";
>                                 reg = <0x2000 0x1000>;
> -                               clocks = <&clk 6>;
> +                               clocks = <&clk NPCM7XX_CLK_UART>;
>                                 interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg-shift = <2>;
>                                 status = "disabled";
> @@ -168,7 +169,7 @@
>                         serial2: serial@3000 {
>                                 compatible = "nuvoton,npcm750-uart";
>                                 reg = <0x3000 0x1000>;
> -                               clocks = <&clk 6>;
> +                               clocks = <&clk NPCM7XX_CLK_UART>;
>                                 interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg-shift = <2>;
>                                 status = "disabled";
> @@ -177,7 +178,7 @@
>                         serial3: serial@4000 {
>                                 compatible = "nuvoton,npcm750-uart";
>                                 reg = <0x4000 0x1000>;
> -                               clocks = <&clk 6>;
> +                               clocks = <&clk NPCM7XX_CLK_UART>;
>                                 interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>                                 reg-shift = <2>;
>                                 status = "disabled";
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> index 6ac340533587..a37bb2294b8f 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> @@ -17,7 +17,7 @@
>                 cpu@0 {
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a9";
> -                       clocks = <&clk 0>;
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
>                         clock-names = "clk_cpu";
>                         reg = <0>;
>                         next-level-cache = <&l2>;
> @@ -26,7 +26,7 @@
>                 cpu@1 {
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a9";
> -                       clocks = <&clk 0>;
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
>                         clock-names = "clk_cpu";
>                         reg = <1>;
>                         next-level-cache = <&l2>;
> @@ -38,7 +38,7 @@
>                         reg = <0x3fe600 0x20>;
>                         interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
>                                                   IRQ_TYPE_LEVEL_HIGH)>;
> -                       clocks = <&clk 5>;
> +                       clocks = <&clk NPCM7XX_CLK_AHB>;
>                 };
>         };
>  };
> --
> 2.22.0
>
