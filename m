Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBE29FE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgJ3HCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3HCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:02:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418BC206F4;
        Fri, 30 Oct 2020 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604041347;
        bh=Wmc3L5Wiq/M77QegDxYJZj1oQ864yk7N4t7n7A5IQQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmyoXnemyg04KBwP5zgV3fuLLmyBzukWw7VARnlKTbjVrcjTRt5y4J54E+O05661h
         9VmP4zl9C9/mVRDzXmBnf2b7JVtYtKi7pIV1EHmpG58WK6ErAPZbOrIjmyg955TYYr
         Yeidt5arJvTTLVTL+s/Ek1ZkkEisoT8v1YyipeSE=
Date:   Fri, 30 Oct 2020 15:02:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
Message-ID: <20201030070218.GE28755@dragon>
References: <20201001151422.16028-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Applied both, thanks.
