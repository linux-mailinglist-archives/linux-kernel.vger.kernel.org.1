Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C22F0A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 01:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbhAKAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAKAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:35:26 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA47C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 16:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0cyTYomTYRleb2ivxdiXv+EK4ye6kzvnUXElS+kgyYE=; b=aAxpuPMBpQ12U+b3ThpHyBFhF
        brySmDrHOp+5m+dNTxnmQWi+xvlxOzOGO+H3a0wSzJmIOVCnV+pcaEURbNyqAySga1sM5nkYJ9QRP
        bnPf3mXhcNkYqeBBbSMYYPtBCIk2iRqBdb7SWfipk/8AF35L0Vgrly12XFDYTyTshhyQJd0lqPQsu
        tnkY9DClbDaldQXjFxFfZKntj1Fu+T40J+i6lDbuXx5+3LEBL5aLaRqj/kLznLkp5f8CtC2BhXwZK
        ROyU/e/VSevHpy3cZnMYV4+pNdGUtP6Stww3G/E4USElKPzook1Jv+CYqFi4hdlSgcKTZt0y/wAkz
        rFACq5Fkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46376)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kyl9G-0006OC-7b; Mon, 11 Jan 2021 00:33:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kyl96-0004g6-RB; Mon, 11 Jan 2021 00:33:20 +0000
Date:   Mon, 11 Jan 2021 00:33:20 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Fabian Vogt <fabian@ritter-vogt.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210111003320.GQ1551@shell.armlinux.org.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com>
 <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
 <1702853.1557dWfJA4@linux-e202.suse.de>
 <CACRpkdYaMASWWDTX7hTt+xQnVPA=WTWNFk2eDnTjKoJF=LA7LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYaMASWWDTX7hTt+xQnVPA=WTWNFk2eDnTjKoJF=LA7LQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:33:56PM +0100, Linus Walleij wrote:
> On Sun, Jan 10, 2021 at 7:16 PM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> > Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> > > On Sat, Jan 9, 2021 at 1:06 AM Daniel Tang <dt.tangr@gmail.com> wrote:
> 
> > > > * nspire -- added in 2013, no notable changes after 2015
> >
> > Most of the platform is just the DT sources and some small drivers around it,
> > so it's actually fairly low maintenance. So far the migration away from
> > panel-simple in 2019
> > (https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
> > was the biggest required change so far.
> 
> What we're seeing here is actually a port that is:
> - Finished
> - Has a complete set of working drivers
> - Supported
> - Just works
> 
> I.e. it doesn't see much patches because it is pretty much perfect.
> 
> We are so unused to this situation that it can be mistaken for
> the device being abandoned.
> 
> I think it was Russell who first pointed out that this is actually
> the case for a few machines.

Yes indeed. I find it utterly rediculous that there is a perception
that you constantly need to be patching a bit of software for it to
not be seen as abandoned. If a piece of software works and does what
it needs to do, why does it need to be continually patched? It makes
no sense to me.

I have my xf86-video-armada which I use on the Dove Cubox and iMX6
platforms. It does what I need it to, and I haven't updated the
userspace on these platforms for a while. Therefore, I've no reason
to patch that code, and no one has sent me patches. Does that mean
it's abandoned? Absolutely not.

Some people are just weird and think that unless stuff is constantly
worked on, no one cares about it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
