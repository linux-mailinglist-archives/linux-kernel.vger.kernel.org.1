Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8152F0268
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAIRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbhAIRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:45:00 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F4C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GpaoU3cw27IRYx/c768yG/+71BxBlR/KEHcDMD0IvXU=; b=13rNe03tyS23Yg4i8s20zWr63
        ItKKkysjtblwYeJtMIHO1yBrREUOCUmme4YI9HbHL9ht64RqdF8BbArMNvgi36Whz82SoOdNsVopd
        qJBD0DhSD4npSBXZ6s1frUD0sb78yWXz+bV29SL4mJ1cRGpgXcHMZUtxhkRobUE81Zl7MCXsDHizP
        tSBSKMIohV+UOw0VhAFGIlR8UqYIdO0xqCsC/1gj7ppVjRSLbHq+uvdoVzLQ4hGPaBbi+rZIkQyYU
        EjGEjfhlFplVTrR3fNSKLKiVDOOel+VX34BXNreg7Pfd5P5eIV+3xHx9GesQ0AsukAgw8fl3/1pEa
        /tpssDDPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45810)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kyIHY-0005Fh-Bv; Sat, 09 Jan 2021 17:44:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kyIHN-0003Nf-Ob; Sat, 09 Jan 2021 17:43:57 +0000
Date:   Sat, 9 Jan 2021 17:43:57 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Wei Xu <xuwei5@hisilicon.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alex Elder <elder@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210109174357.GB1551@shell.armlinux.org.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> * dove -- added in 2009, obsoleted by mach-mvebu in 2015

May be obsoleted, but I still use this for my dove cubox with
additional patches.

> * footbridge -- added in prehistory, stable since ~2013, rmk and LinusW
>   have one

Yes, and still running:
Linux flint 5.6.12+ #94 Sat Oct 17 23:44:28 BST 2020 armv4l armv4l armv4l GNU/Linux

> * iop32x -- added in 2006, no notable changes other than my cleanup, but
>   I think there are still users

I have two TheCUS N2100s here, one still powered up and running and
one is currently available if anyone wants the machine. Both may
become available if anyone wants them later in 2021. I notice
Heiner Kallweit has been patching some of this code recently.

> * rpc -- prehistoric, but I think Russell still uses his machine

Yes, and I have sent some patches in the 5.x timeframe, and I do
have some further ones I could send, mostly around SCSI stuff.
It is my only machine that gives me access to some old tape backups
and syquest cartridges (not that any of that contains "modern" data.)

> * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it

I also have some further patches that have been hanging around for
some time to modernise sa1100 a bit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
