Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A62980C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768259AbgJYI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:28:58 -0400
Received: from mailoutvs9.siol.net ([185.57.226.200]:54241 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1765994AbgJYI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:28:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 811C852A64E;
        Sun, 25 Oct 2020 09:28:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zjUPgiDvtWlK; Sun, 25 Oct 2020 09:28:55 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 3227952A6BF;
        Sun, 25 Oct 2020 09:28:55 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id DFAA752A6BE;
        Sun, 25 Oct 2020 09:28:54 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [linux-sunxi] [PATCH 10/10] arm64: dts: allwinner: a64: bananapi-m64: Enable RGMII RX/TX delay on PHY
Date:   Sun, 25 Oct 2020 09:34:24 +0100
Message-ID: <10346945.z8tZaDcLle@kista>
In-Reply-To: <20201024195803.GA30672@Red>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-10-wens@kernel.org> <20201024195803.GA30672@Red>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 21:58:03 CET je Corentin Labbe napisal(a):
> On Sun, Oct 25, 2020 at 12:25:15AM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> > 
> > The Ethernet PHY on the Bananapi M64 has the RX and TX delays
> > enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> > 
> > Fix the phy-mode description to correct reflect this so that the
> > implementation doesn't reconfigure the delays incorrectly. This
> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> > rx/tx delay config").
> > 
> > Fixes: e7295499903d ("arm64: allwinner: bananapi-m64: Enable dwmac-sun8i")
> > Fixes: 94f442886711 ("arm64: dts: allwinner: A64: Restore EMAC changes")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/
arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > index 3ea5182ca489..e5e840b9fbb4 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > @@ -105,7 +105,7 @@ &ehci1 {
> >  &emac {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&rgmii_pins>;
> > -	phy-mode = "rgmii";
> > +	phy-mode = "rgmii-id";
> >  	phy-handle = <&ext_rgmii_phy>;
> >  	phy-supply = <&reg_dc1sw>;
> >  	status = "okay";
> > -- 
> > 2.28.0
> 
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


