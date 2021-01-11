Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE732F206C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbhAKUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404092AbhAKUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:10:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC4C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7mVHYFSOD6PIstBzq8DpUaHpjmOPYloyxHKSoY+lXIM=; b=Ic8i/251qLlOukDGpoCiKBnTI
        0eJKrMYnc1U31xjUfRzMK30w9AabAKO+eFLi+64pKMZ9MJ8Mgca45hGFr55CQ+RRu0UCMO81z8g4d
        5EQ5erlJp9yZNWSCjfO+erRc1mn5IgVmitbooxY4xQT7MagxeONC9vVkbvT1EjihgSMS2wIc9g4eT
        Vd9VWcolHM2wVAdwVHg6Rt4LthYH5MII8ug2QS7hNQqzbCPEF2tdx3Bkuio1XQt7gB3dhh/JgOrYU
        wPU75AWkZt/ZZReeiQBMS7w4GFPX304URussZ03TOUzbvPcRD6J/+0Rjx3WWsB5e0R3vixsCzeQOW
        caSW3EO9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46732)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kz3V4-0007Qx-Oo; Mon, 11 Jan 2021 20:09:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kz3Uv-0005XO-St; Mon, 11 Jan 2021 20:09:05 +0000
Date:   Mon, 11 Jan 2021 20:09:05 +0000
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
Message-ID: <20210111200905.GZ1551@shell.armlinux.org.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109174357.GB1551@shell.armlinux.org.uk>
 <CAK8P3a03+C6aoR-f0nr4Gf_O6e=ppPoEMPMPya59cT826a0=Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a03+C6aoR-f0nr4Gf_O6e=ppPoEMPMPya59cT826a0=Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 10:34:57PM +0100, Arnd Bergmann wrote:
> On Sat, Jan 9, 2021 at 6:43 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> > > * dove -- added in 2009, obsoleted by mach-mvebu in 2015
> >
> > May be obsoleted, but I still use this for my dove cubox with
> > additional patches.
> 
> What is the status of these patches? I also still have a set of patches
> to integrate it with the other ARMv7 machines into multiplatform,
> and a series to change some of the PCI handling in all plat-orion
> platforms, that I was hoping to either upstream or drop once the
> platform itself gets removed.

I really couldn't say - I have over 200 patches in my kernel tree for
the Dove Cubox that give me a fully featured kernel - and I mean
everything, including the vMeta video decoder. I haven't updated the
tree since last Summer, partly because other things have taken
precedence. I couldn't say what the status is right now without
going through an update to 5.10.

However, some bits can't go into mainline - I was totally shafted over
the audio support. There is no way to add flexible support to the
kirkwood audio driver without breaking the DT descriptions for every
board using that - and by flexible, I mean the ability to output DTS
via the SPDIF connector or HDMI on the Dove Cubox. I wasn't listened
to at the time, and it _still_ hurts to this day that there is no way
back from the crippling bad choices that mainline kernel developers
and others made. There was no need for this, other than a desire to
merge something that worked for everyone else but was totally
unsuitable to be able to provide the full features.

> Did you give up on moving the Cubox to DT, or is this something you
> still want to get back?

Yes, because it is the only fully featured platform I have.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
