Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CE28026B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgJAPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:19:09 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33484 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:19:09 -0400
Received: by mail-ej1-f65.google.com with SMTP id j11so8714306ejk.0;
        Thu, 01 Oct 2020 08:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ON2gB82ELmsBG6VggmUOlBmaT2J26CMtUjnZB7DZRdM=;
        b=rzAQh+JkCd2LKvQ0EIvBjLOO3n/gdL0ylglCNWxdSiHaQ4In9pdmNvnpTHNu2Wa1TX
         TVjsfiX6vyUlYaRjN1JcZWhM0xEjWZ7rG08u64ZXh/ClxgrFMcsxEzgyByi0AZPrbGM0
         7of6kFoDIohoYIYvfj8eYAxzqIcHwb7m4Q1MDU9NAvXObzZNKf8hv0PIkfWHxA3D3gzk
         JP9alcdNyI8LtkrV8z+Pb0kiwUu5Jd8xnQHuFY1RHPZulsln5KX5S742FBKOF2+7ZV7D
         TDZUHedo9otIhaEVtKf+URELnVVts3xBZMJy5xg0sDgbRy+LzMwGfJ3kW1Rdee87X1qs
         k3QQ==
X-Gm-Message-State: AOAM533K5yj4BczMSDAg1RBmpmL7fXu4z77gkhKCmye47HHbjUjUhx+l
        7Ii1G+eQ5rcE6wBke8n3ObU=
X-Google-Smtp-Source: ABdhPJyyFu0bL7OIwwDMyKrJ8+Qwi7ZGEdwdemPGRD5gziNd1/C14veHmbZxUtPcTGEOTqwOEjecDA==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr9020600ejc.100.1601565546454;
        Thu, 01 Oct 2020 08:19:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id i17sm4393418ejy.79.2020.10.01.08.19.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 08:19:05 -0700 (PDT)
Date:   Thu, 1 Oct 2020 17:19:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
Message-ID: <20201001151901.GB14276@kozik-lap>
References: <20201001151422.16028-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001151422.16028-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 05:13:37PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Kontron Electronics GmbH offers small and powerful SoMs based on the
> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
> 
> The matching baseboards have the same form factor and similar interfaces
> as the other boards from the Kontron "Board-Line" family, including
> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
> RS485, CAN, LVDS or HDMI, RTC and much more.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v5:
> * Add Makefile entry to build dtb
> 
> Changes for v4:
> * Remove one more needless status property
> * Use local-mac-address instead of mac-address
> * Add missing pinctrl-names in PMIC node
> * Fix interrupt flags in PMIC node
> * Use lowercase regulator names
> * Enable pullup for PMIC IRQ line
> * Fix pinctrl grp names to match schema
> 
> Changes for v3:
> * Remove needless status properties
> * Remove needless regulator properties for reg_vdd_5v
> * Use proper PHY reset properties in PHY node
> * Use phy-connection-type instead of phy-mode
> * Adjust PMIC node name and label
> * Add over-current-active-low to usbotg1 node
> * Remove redundant bus-width property from usdhc2 node
> * Remove needless regulator-compatible from reg_vdd_snvs
> * Set minimum voltage to 85mV for reg_vdd_snvs
> 
> Changes for v2:
> * Make the licensing less strict (GPL-2.0+ OR MIT)
> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>   they only differ in DDR and eMMC size.
> * Change compatibles and model strings to "n810x" and "N8010X".
> * Only use a common memory node that will be updated by the
>   bootloader reflecting the detected DDR size.
> * Improve naming for 16MHz CAN fixed oscillator and set
>   "clock-output-names".
> * Consistently use "reg_" prefix for regulators.
> * Remove "userspi" node.
> * Slightly improve commit message.
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 322 ++++++++++++++++++
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
>  3 files changed, 617 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
