Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87C927FFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgJANAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:00:37 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38806 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJANAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:00:37 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so1865077ejc.5;
        Thu, 01 Oct 2020 06:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DHqv6lgH4uxioUbGBwndGX/EiJJgsVBJJkqWTUPkzJY=;
        b=HzO9dl5exixBxyjY/7XLwIiokrvuzzRWW2R1IO5p38mNGfbX7QPi01cei4NgO7ZO31
         ojys0glc5qsRbLouXoN0Zvf9p6clTcTXmTQkTK6on3vA8zGWSObJbW4d6aC+Xjt7tM4o
         VWz6AaVU/oUf7/p6x9DKD3a4zl+0cTJFBQRzKM2iHnX60h2h0xu3VIS3ZMEMg/wFiTUr
         h/Jt4VUEFOV2M+BzoA+rytb26sDOQqScCp1C518j/yfWdUGQ0YOBiniWH+LnMPZTnChM
         +WMBd02Toq6iD/1bwyc+xZCVpF6VXR0HI5WQxAEMCY7MGGgKN/oYcM6gDpIXcv0sJmxk
         QUqw==
X-Gm-Message-State: AOAM531aEY1CrFsez/eLEx6PqKdxuFI9KBZRG4Q9N8oOT2NQVRcHLtaO
        F/alUSZadYt8hkadZp0LiAc=
X-Google-Smtp-Source: ABdhPJx28A7G0WIAnz/htz95tJcCC/bQ+sHiClLUmJz1coCykbAcd8719ftgLthw2LzTXJJclUtz+w==
X-Received: by 2002:a17:906:2e83:: with SMTP id o3mr8277737eji.47.1601557234810;
        Thu, 01 Oct 2020 06:00:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id i14sm4098920ejp.2.2020.10.01.06.00.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 06:00:33 -0700 (PDT)
Date:   Thu, 1 Oct 2020 15:00:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
Message-ID: <20201001130031.GC6082@kozik-lap>
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001120717.13027-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 02:06:58PM +0200, Schrempf Frieder wrote:
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
>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 323 ++++++++++++++++++
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 293 ++++++++++++++++
>  2 files changed, 616 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

Ah, and one more issue - missing Makefile entry? This won't build.

Best regards,
Krzysztof
