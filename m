Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18052C8DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbgK3THV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbgK3THU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:07:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mdWSD+1qCx9Ml65+hGn0IHNvQjAC2TF2iTY3oj4yxVk=; b=wR1+J7QmI9WZnC8kywHggy+Es
        CCTeKBgC1N2bHWhrkOmq1nU7SJds4gsnKnfNb+bxEv1Uw2YNlIbJxspgRniYOM7Q48Tc5SZ69b1k3
        1E/wulnROKRozX5Kms9EiFEkqXYTD43EiMQ6TSb8TOt3+FM7OYd7lDxaGpzyWQNSagWaItan4XMdF
        lc6pMkDYkBFpD5um0bLVhXCZQx/WZnj4j+9nWA4Bkthor07NY0M4p1D7VpGGnct0Wu42qibiyRT2i
        LBmeMABu2MbdnSKB73/ywRm9KHR3M9qpcm79G2HFZYDKZ3OXJCqv+GrXjBzFkfraAQZQ8SzD6A6Im
        GU6wa9+9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38106)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kjoVO-0007S1-Vw; Mon, 30 Nov 2020 19:06:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kjoVO-0005FN-Bf; Mon, 30 Nov 2020 19:06:34 +0000
Date:   Mon, 30 Nov 2020 19:06:34 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
Message-ID: <20201130190634.GA1551@shell.armlinux.org.uk>
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
 <20201130180523.GZ1551@shell.armlinux.org.uk>
 <CAHk-=wgZhkMu5UFgmD2Yt96S_nrhMzTTXfqOwgBe4nsg0R_M6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZhkMu5UFgmD2Yt96S_nrhMzTTXfqOwgBe4nsg0R_M6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:15:29AM -0800, Linus Torvalds wrote:
> On Mon, Nov 30, 2020 at 10:05 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > If you think that /dev/sda for example is always the machine's internal
> > HDD, that is wrong.
> 
> Yes. See the whole part about
> 
>  "Note that it really is only the internal devices that matter. Once you
>   start plugging in an external USB hug and random devices, ordering
>   clearly won't be reliable.
> 
>   So this is not a "everything must be ordered". But people who think
>   that that then means "everythinbg can be random" are wrong"
> 
> in my email.
> 
> And the key word here is:
> 
> > I have a HP Pavilion laptop with its internal HDD with a Windows
> > installation. Because I didn't want to destroy that in any way, I
> > bought an external USB3 SATA enclosure and SSD, and installed Debian
> > Stable on there.
> 
> .. but it will still generally be stable with the same hardware
> configuration, and not fluctuate randomly from boot to boot when the
> hardware is the same.
> 
> Is it a guarantee? No. External plugged in hardware can change things.
> In fact, when you have things like Thunderbolt involved, since it just
> looks like PCI, even the PCI probing order won't be the same with or
> without the plugged-in device.
> 
> But again: avoid randomness. The difference between non-random and
> random is that one is predictable and one is not.
> 
> Predictability is good. It's not necessariyl always achievable, but
> it's very much something we should strive for VERY HARD.
> 
> Predictability and reproducibility help debugging enormously. It means
> that things like "git bisect" work a lot better. It makes user reports
> much more understandable when two users with identical hardware see
> identical issues.
> 
> Seriously. Anybody who argues against reproducibility is so far out to
> lunch that it's not even funny.
> 
> You seem to argue on a complete technicality.

Yes, I fully agree - but the problem is that how people read your
"avoid randomness".

Randomness as in "doesn't change if I change kernel configuration"
or "doesn't change order on reboot to a similar kernel".

People who have complained about mmc in the past have done so from
the point of view of "I changed something, now my mmc block devices
are different".

It is my understanding that mmc behaves in the same way as exactly
what I see on my HP laptop. The device numbering is stable provided
the hardware (and indeed software) configuration is stable.

If I decide to rebuild the Debian kernel for my HP laptop, and build
in the drivers necessary for all its hardware, the internal HDD will
switch to being /dev/sda instead of /dev/sdb as it is now... which
doesn't seem to be any different from complaints like "I've changed
some code in the kernel now my MMC devices have changed order."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
