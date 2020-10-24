Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA1297E02
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763909AbgJXSak convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Oct 2020 14:30:40 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:38779 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1763901AbgJXSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:30:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 77C8952A035;
        Sat, 24 Oct 2020 20:30:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WRsKgVeLa2dz; Sat, 24 Oct 2020 20:30:36 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 2643252A034;
        Sat, 24 Oct 2020 20:30:36 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 6BA9152A038;
        Sat, 24 Oct 2020 20:30:35 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     wens@kernel.org, Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sat, 24 Oct 2020 20:30:35 +0200
Message-ID: <2859076.BEgH6Mo0Pn@jernej-laptop>
In-Reply-To: <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-2-wens@kernel.org> <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 19:51:06 CEST je Icenowy Zheng napisal(a):
> 在 2020-10-25星期日的 00:25 +0800，Chen-Yu Tsai写道：
> 
> > From: Chen-Yu Tsai <wens@csie.org>
> > 
> > The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
> > enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> > 
> > Fix the phy-mode description to correct reflect this so that the
> > implementation doesn't reconfigure the delays incorrectly. This
> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> > rx/tx delay config").
> 
> Personally I think they should revert this commit, and consider other
> solution.
> 
> This commit breaks everything.
> 

Previously broken driver allowed inproper DT to work, so you have to fix 
everything eventually.

Plus side, there is no need to have hack for Pine64 Plus ethernet anymore.

Best regards,
Jernej

> (Although the patch on individual DT patches are technically correct)
> 
> > Fixes: c220aec2bb79 ("ARM: dts: sun6i: Add Merrii A31 Hummingbird
> > support")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > 
> >  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> > b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> > index 049e6ab3cf56..73de34ae37fd 100644
> > --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> > +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> > @@ -154,7 +154,7 @@ &gmac {
> > 
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&gmac_rgmii_pins>;
> >  	phy-handle = <&phy1>;
> > 
> > -	phy-mode = "rgmii";
> > +	phy-mode = "rgmii-id";
> > 
> >  	status = "okay";
> >  
> >  };




