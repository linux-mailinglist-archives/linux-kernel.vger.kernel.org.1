Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E7F2F0680
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAJKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbhAJKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 05:46:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wwQOTzeTLvZ8Q6Stq9mYikRBLji4EDzHoDTBNEOIcYs=; b=b+PcWe0hknOfNb4WfwZLN+mbs
        O50RfU9Eua3kGGRhrKrKOUYVCv5QNCgKR676+TQnjASkR5kWkZQf3TSARy5CNs8AV1L3VDlDvq+Km
        fv19LLjM2ty0WGT71OCOdWCDJdzpSOfJ8BP9oxeR+VoklbYiflRldfL8uK81OgC/qnq8Ez/nGKmp0
        6UVPOfRYWW6Hj9ya30+AQCALYJPCjm7yWN0OGp+g/LRpldujCfsfU2kJwZ7HL1PKqQzdFJ8qtjERH
        c2JmDYZ1ZL1cPPfGzDi7s0c2PlBeggs9hCKlLdIWvlueUzShyqIbjumMhrgdSEKBcCCDjwJRM9klY
        kCJIYCs7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46116)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kyYD8-0005lE-9H; Sun, 10 Jan 2021 10:44:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kyYD0-00048h-FQ; Sun, 10 Jan 2021 10:44:30 +0000
Date:   Sun, 10 Jan 2021 10:44:30 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Arnd Bergmann <arnd@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yoshinori Sato <ysato@users.osdn.me>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210110104430.GE1551@shell.armlinux.org.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <20210110062113.GA2912@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110062113.GA2912@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 07:21:13AM +0100, Willy Tarreau wrote:
> On Sat, Jan 09, 2021 at 10:52:53PM +0100, Arnd Bergmann wrote:
> (... i486 ...)
> > As with the other older platforms, the main question to ask is:
> > Are there users that are better off running a future LTS kernel on this
> > hardware than the v5.10.y version or something older?
> 
> I think this is the most important part of the question. Because the
> possible use case I've described actually doesn't correspond to a
> "prod" machine but to a machine that's powered on every 5 years for
> some old data recovery. In such a case users just start with an old
> system (possibly the one that's still on them if present), and this
> doesn't warrant an up-to-date OS.
> 
> Moreover, just as I experienced when maintaining 2.4, there's a point
> where support for old stuff starts to break again by lack of testing.
> And just because of this, users shouldn't always expect to see their
> old machines boot fine on a recent kernel. Sometimes there may even be
> difficulties setting up a compatible toolchain.
> 
> So actually the question shouldn't be "does anyone want such old
> machines to still be supported" but "does anyone *need* them to be
> supported". And I suspect that for most of them the response is "no",
> it's just a convenience.

What about feature obsolescence?

Consider that old ssh (supporting only the v1 protocol) will no longer
connect to new sshd (supporting only the v2 protocol) or older NFS
supporting UDP only trying to connect to new NFS supporting only TCP.
Or older NFS that does buggily support TCP and won't talk to newer
machines.

At one time, the suggestion would've been to use a DOS formatted
floppy to transfer the data... but modern machines tend not to have
floppy drives. USB pendrive? Maybe the older machine doesn't have USB.

I suppose you'd have to resort to FTP at that point to move data off
the old machine, or via email if you have email setup on it.

Having a machine that's able to boot an old installation just means
it can run, but it doesn't guarantee that it will be useful once
booted to move old data onto newer machines.

Over Christmas, I booted my Acorn A5000 (the very first machine to run
Linux on ARM) to retrieve some old data off it - thankfully I still
have an Acorn Ether1 card with an AUI interface and a 10baseT MAU to
connect to my network.  Sadly, support for running Linux on it has
long since passed - with only 8MB and 32KiB pages, modern Linux would
struggle with it, which is really the reason why support was dropped.
Linux outgrew the hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
