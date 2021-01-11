Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580102F0E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbhAKImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:42:05 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55326 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbhAKImE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:42:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CC77AFB03;
        Mon, 11 Jan 2021 09:41:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IBpD8r-1kRtP; Mon, 11 Jan 2021 09:41:20 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 19E7040885; Mon, 11 Jan 2021 09:41:20 +0100 (CET)
Date:   Mon, 11 Jan 2021 09:41:20 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64: defconfig: Enable Librem 5 devkit
 components
Message-ID: <20210111084120.GA10280@bogon.m.sigxcpu.org>
References: <cover.1610110514.git.agx@sigxcpu.org>
 <5636a3d6e3217475e2a479248250d5c0e0a50e26.1610110514.git.agx@sigxcpu.org>
 <20210111002308.GP28365@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111002308.GP28365@dragon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Jan 11, 2021 at 08:23:09AM +0800, Shawn Guo wrote:
> On Fri, Jan 08, 2021 at 01:57:07PM +0100, Guido Günther wrote:
> > The Librem 5 devkit is based on NXP's i.MX8MQ. Schematics are at
> > https://source.puri.sm/Librem5/dvk-mx8m-bsb.
> > 
> > This enables drivers for the following hardware components that aren't
> > yet enabled in defconfig:
> > 
> > - Goodix GT5688 touchscreen
> > - iMX8MQ's PWM for the LCD backlight
> > - TI BQ25896 charge controller
> > - NXP SGTL5000 audio codec
> > - Microcrystal RV-4162-C7 RTC
> > - magnetometer: CONFIG_IIO_ST_MAGN_3AXIS
> > - the SIMCom SIM7100E/A modem
> > - NXP PTN5110HQZ usb-c controller
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Applied, thanks.

Thanks for applying this series!
 -- Guido
