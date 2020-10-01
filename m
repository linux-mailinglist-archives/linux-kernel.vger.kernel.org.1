Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C705828013B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgJAOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbgJAOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:29 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D0C221EF;
        Thu,  1 Oct 2020 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601562328;
        bh=7IxxHuTn6pG3paS/ct7dqGz5Fv9KdwfGBK5Jk1r/w8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K7qsOdOr1AvHBIknPLe7P9uNa8vZdb3ICILpo7IrLtutUZMXm/VojZxn3vc5ZnEO9
         ZysWMD6wr+CFZ7b7mxxPAEO3Gvfrkm+b4nmvq6AxsyMF7eY8PrR1FlylJXMUdVQWyo
         DTrpL/a7GEh9GYSOdueeCQS5zOXOQe2RGZVaJKVg=
Received: by mail-ed1-f44.google.com with SMTP id t16so5842570edw.7;
        Thu, 01 Oct 2020 07:25:28 -0700 (PDT)
X-Gm-Message-State: AOAM530Dlw2tNLuAmmlSkl0E7e5S1u4KxH9h6EPCMCO723W7u++A5pHJ
        zatK1EKlEyLIs6PjeFIF+wCdJdw4UE+WmyV8B40=
X-Google-Smtp-Source: ABdhPJwFJiHNM6UYM/nYgKwEhMNgbW1nDaUjH+sNDZq39ixv5OMUnEeuvRkS3SNFBH2iNmZVxg3KVBWcrlT2IvhJqkU=
X-Received: by 2002:a50:cc8d:: with SMTP id q13mr8338596edi.298.1601562326977;
 Thu, 01 Oct 2020 07:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
 <20201001125722.GA6082@kozik-lap> <985c5eb3-3f8a-2b70-8831-b7b52671ee4f@kontron.de>
 <6f2b294f-9f28-fe1b-bd1a-d32cbdb86e00@kontron.de>
In-Reply-To: <6f2b294f-9f28-fe1b-bd1a-d32cbdb86e00@kontron.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 1 Oct 2020 16:25:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPePy2-CS1YuEWTksFjR5wP=HWtEixRR3wwsCSK59ckX2w@mail.gmail.com>
Message-ID: <CAJKOXPePy2-CS1YuEWTksFjR5wP=HWtEixRR3wwsCSK59ckX2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
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
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 at 16:24, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 01.10.20 15:30, Frieder Schrempf wrote:
> > On 01.10.20 14:57, Krzysztof Kozlowski wrote:
> >> On Thu, Oct 01, 2020 at 02:06:58PM +0200, Schrempf Frieder wrote:
> >>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>>
> >>> Kontron Electronics GmbH offers small and powerful SoMs based on the
> >>> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
> >>>
> >>> The matching baseboards have the same form factor and similar interfaces
> >>> as the other boards from the Kontron "Board-Line" family, including
> >>> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
> >>> RS485, CAN, LVDS or HDMI, RTC and much more.
> >>>
> >>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>> ---
> >>> Changes for v3:
> >>> * Remove needless status properties
> >>> * Remove needless regulator properties for reg_vdd_5v
> >>> * Use proper PHY reset properties in PHY node
> >>> * Use phy-connection-type instead of phy-mode
> >>> * Adjust PMIC node name and label
> >>> * Add over-current-active-low to usbotg1 node
> >>> * Remove redundant bus-width property from usdhc2 node
> >>> * Remove needless regulator-compatible from reg_vdd_snvs
> >>> * Set minimum voltage to 85mV for reg_vdd_snvs
> >>>
> >>> Changes for v2:
> >>> * Make the licensing less strict (GPL-2.0+ OR MIT)
> >>> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
> >>>    they only differ in DDR and eMMC size.
> >>> * Change compatibles and model strings to "n810x" and "N8010X".
> >>> * Only use a common memory node that will be updated by the
> >>>    bootloader reflecting the detected DDR size.
> >>> * Improve naming for 16MHz CAN fixed oscillator and set
> >>>    "clock-output-names".
> >>> * Consistently use "reg_" prefix for regulators.
> >>> * Remove "userspi" node.
> >>> * Slightly improve commit message.
> >>> ---
> >>>   .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 323 ++++++++++++++++++
> >>>   .../freescale/imx8mm-kontron-n801x-som.dtsi   | 293 ++++++++++++++++
> >>>   2 files changed, 616 insertions(+)
> >>>   create mode 100644
> [...]
> >>
> >>> +
> >>> +        regulators {
> >>> +            reg_vdd_soc: BUCK1 {
> >>> +                regulator-name = "BUCK1";
> >>
> >> All regulator names should be lowercase, as dtschema asks. Node names
> >> can stay uppercase, although I guess it would be better to have them
> >> lower as it is also naming convention for device tree.
> >
> > Ok, I will change the regulator and node names to lowercase.
>
> I just found out that the pca9450 driver actually uses the upper case
> node names for matching. So I will keep the upper case node names for
> now and only change the regulator names.
>
> Afterwards we can fix the node names in the driver and in the DTs in a
> separate patch if required.

Right, I forgot that it's important for the driver. Thanks for checking it.

Best regards,
Krzysztof
