Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396D52F1262
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbhAKMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbhAKMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:38:19 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E64C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pEfuol2oSvc4BFd2osX8PmaI99BGWh8iJ3Fh+S78otQ=; b=TRdZBCUKPlSDBB97brNisTclB
        C8fccf6TwmkSWVzyJZR3/f4vqKv8ob2LIlXTnYf6wtnJPuF3XXYZDcY8UdSW7YO7Gma8I48JZaQc4
        9oRbVNzntXsuME+ZVF82HxfnJcRj969zZFOy819cnZpQ1gdIo0fqG4OIVrZjcxKd4q9ffH58ipXqT
        crXBIjqG3MKIAGiZqgOi82NbtPJV0EYUo9BcnTBbVTukIE8q+Qz/jGIAYGdqi3CPme+k9oZ7fhtU3
        8Lo198rfziGZNy0QzgGgfYoQPWPkKfc1qUKucjHF07CIVrrGQcJ5XJaM+Fd5z52a+Y6Vzionpc54w
        4vdN/S05Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46584)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kywRJ-00070a-R5; Mon, 11 Jan 2021 12:36:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kywRC-0005EK-Lb; Mon, 11 Jan 2021 12:36:46 +0000
Date:   Mon, 11 Jan 2021 12:36:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Fabian Vogt <fabian@ritter-vogt.de>,
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210111123646.GS1551@shell.armlinux.org.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com>
 <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
 <1702853.1557dWfJA4@linux-e202.suse.de>
 <CACRpkdYaMASWWDTX7hTt+xQnVPA=WTWNFk2eDnTjKoJF=LA7LQ@mail.gmail.com>
 <20210111003320.GQ1551@shell.armlinux.org.uk>
 <CAK8P3a3C0mWHm+7GvtK92Nw0unZ8NTViXUVd_QysYgot8tuM7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3C0mWHm+7GvtK92Nw0unZ8NTViXUVd_QysYgot8tuM7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:32:57PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 11, 2021 at 1:33 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Sun, Jan 10, 2021 at 10:33:56PM +0100, Linus Walleij wrote:
> > > On Sun, Jan 10, 2021 at 7:16 PM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> > > > Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> > > > (https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
> > > > was the biggest required change so far.
> > >
> > > What we're seeing here is actually a port that is:
> > > - Finished
> > > - Has a complete set of working drivers
> > > - Supported
> > > - Just works
> > >
> > > I.e. it doesn't see much patches because it is pretty much perfect.
> > >
> > > We are so unused to this situation that it can be mistaken for
> > > the device being abandoned.
> > >
> > > I think it was Russell who first pointed out that this is actually
> > > the case for a few machines.
> >
> > Yes indeed. I find it utterly rediculous that there is a perception
> > that you constantly need to be patching a bit of software for it to
> > not be seen as abandoned. If a piece of software works and does what
> > it needs to do, why does it need to be continually patched? It makes
> > no sense to me.
> 
> I don't know where you got the impression that this is what I
> want to do. I used this as a first approximation because it reduced
> the number of platforms to look at from 71 to under 20, just by
> looking at what patches went into the kernel. I could further get the
> number down to the 14 platforms listed in this email by knowing
> some of the users of platforms that did not see a lot of updates but
> are well supported, like highbank or dove.
> 
> We have already confirmed axxia, digicolor, kona and nspire
> as platforms that we want to keep for now, and a new volunteer
> to maintain axxia, and I did not get the impression that any of
> the maintainers were overly stressed out by being sent an
> email inquiry five years after the last contact. I would prefer
> an occasional Tested-by tag for the cleanup patches that did make
> it in (yes, I counted those as activity), but I understand that
> everyone is busy and these are low-maintenance platforms.
> 
> > I have my xf86-video-armada which I use on the Dove Cubox and iMX6
> > platforms. It does what I need it to, and I haven't updated the
> > userspace on these platforms for a while. Therefore, I've no reason
> > to patch that code, and no one has sent me patches. Does that mean
> > it's abandoned? Absolutely not.
> 
> I listed the dove platform in the first table specifically because the
> plan back in 2014 was to completely remove the platform once that
> hardware is working with the modern mach-mvebu platform, and
> I hoped that the transition had finished by now.

I was talking in general terms about the whole idea that any piece of
software needs to be constantly changed in order not to be seen as
abandoned, and not specific to the kernel either.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
