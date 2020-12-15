Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FC2DB510
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgLOU2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbgLOU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:28:03 -0500
X-Gm-Message-State: AOAM530B5Bw3dLZ0zs9BfiEyXZ572LOlTOR8JJk1g2jdVrpPWLX8aoZY
        WyR1yg9B8dI1gMmU4CIdiK3d2BidK4E9sYEM7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608064043;
        bh=MBGH1+TBwDVBKnTVwZJ+Y6Pz95/9T53Uh0u3LBjab2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0sl4ujDoF7sN+cuW0tYJTVqPsvEyxCTu2cLaIX4uXp2m4V/1PMv0u+Gs/poAeKWy
         wGE2+ntAvSrr5/Wmn8XnXPLrr4klCO3QCPWDj2KNiLjuEms/XchH96pb7SsmsjotIB
         x5aOJY6R8N+z2DF1j+pAy9RYl4ag0DhvY+SNpeeWFnQ/xOvps8tpJfvnTR1OhMOso9
         v0MIR4o2xRAT68eZRTYwCWiqJp9EOWjCPC61U4+QrWDD+2AcNtpgQYOFlSz2p3DDo7
         w5rkvnCCTBrRXsezL0r33s2rHKsWX3uJ15VW5uZkchDBw+LDppqbq2mm/S3NuNHVwf
         yb74d6Fy3rUaQ==
X-Google-Smtp-Source: ABdhPJyPP+RNnfjJT1wTon443g6dC9GOHv+GGIORiF0PyyZm2aga+kv6r74UhqjV+rSblF9RFvh1K2ETFxdMNCEiZ1U=
X-Received: by 2002:aa7:cc86:: with SMTP id p6mr8286989edt.289.1608064041463;
 Tue, 15 Dec 2020 12:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20201215155627.2513-1-nsaenzjulienne@suse.de> <20201215155627.2513-4-nsaenzjulienne@suse.de>
In-Reply-To: <20201215155627.2513-4-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Dec 2020 14:27:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSnGzJgEtJBVQqR7jY2bvxCfC-84u-GR-V8htw_O60JQ@mail.gmail.com>
Message-ID: <CAL_JsqLSnGzJgEtJBVQqR7jY2bvxCfC-84u-GR-V8htw_O60JQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: bcm2711: Add reserved memory template to
 hold firmware configuration
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 9:56 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> RPi4's co-processor will copy the board's bootloader configuration into
> memory for the OS to consume. Introduce a reserved-memory area template
> for the co-processor to edit before booting the system so as for Linux
> not to overwrite that memory.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 403bacf986eb..c58e58e8ce39 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -25,6 +25,7 @@ aliases {
>                 emmc2bus = &emmc2bus;
>                 ethernet0 = &genet;
>                 pcie0 = &pcie0;
> +               eeprom = &eeprom;

I don't see the need for this...

>         };
>
>         leds {
> @@ -218,6 +219,19 @@ &pwm1 {
>         status = "okay";
>  };
>
> +&rmem {
> +       /*
> +        * RPi4's co-processor will copy the board's bootloader configuration
> +        * into memory for the OS to consume. It'll also update this node with
> +        * its placement information.
> +        */
> +       eeprom: eeprom@0 {

But it's not an eeprom. It's just memory with some format to the contents.

> +               reg = <0x0 0x0 0x0>;
> +               no-map;
> +               status = "disabled";
> +       };
> +};
> +
>  /* SDHCI is used to control the SDIO for wireless */
>  &sdhci {
>         #address-cells = <1>;
> --
> 2.29.2
>
