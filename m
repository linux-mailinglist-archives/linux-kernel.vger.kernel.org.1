Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44CD2F0A95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 01:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbhAKAX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 19:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAKAX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:23:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C8F22AAF;
        Mon, 11 Jan 2021 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610324596;
        bh=00AbescVqxNe0rvjXCxOXK5E9xt1nbaW0F5ybaKYVNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uh8rs/5Fdk0yJXZHK+zdbcRDvzqN1Na09XRCdCh7S/g7kiHzU2GxZlgUdm6Ep7Yui
         2JurVYg9XWMqk6tjhcCmjp+tSUFSw2/Bd2IR6SFholeczd8CfSjALAlNB11uKevQuI
         Ei/pNyVgBHDnt9Tvapi7hoTgvCbOQVxSAPJlFz8PZ4Owz4n8IsN8QwDhCGNsEk0VR0
         QQhLFfKWij2eY/ZPobCq1TnbInXqaxwVNp66+fEwfu7hP3d00m4jZcgi2NgDEXBz+v
         PJT2csiOiYiiNcV3dILf7BkHGeQiMSHh4tTK973vNqziWNXfstNSxiPeJnvyPzH2t3
         +C6ifWlRqhf8A==
Date:   Mon, 11 Jan 2021 08:23:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
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
Message-ID: <20210111002308.GP28365@dragon>
References: <cover.1610110514.git.agx@sigxcpu.org>
 <5636a3d6e3217475e2a479248250d5c0e0a50e26.1610110514.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5636a3d6e3217475e2a479248250d5c0e0a50e26.1610110514.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:57:07PM +0100, Guido Günther wrote:
> The Librem 5 devkit is based on NXP's i.MX8MQ. Schematics are at
> https://source.puri.sm/Librem5/dvk-mx8m-bsb.
> 
> This enables drivers for the following hardware components that aren't
> yet enabled in defconfig:
> 
> - Goodix GT5688 touchscreen
> - iMX8MQ's PWM for the LCD backlight
> - TI BQ25896 charge controller
> - NXP SGTL5000 audio codec
> - Microcrystal RV-4162-C7 RTC
> - magnetometer: CONFIG_IIO_ST_MAGN_3AXIS
> - the SIMCom SIM7100E/A modem
> - NXP PTN5110HQZ usb-c controller
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
