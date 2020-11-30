Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64A2C91B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbgK3Wzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgK3Wzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:55:46 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA745C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FEehqEG1a1gUdHMKaEzZ631DuoSmxOdN1LmfoAyBjQc=; b=qBSfxuEsqEYHROB6wvqwA4hgO
        EH2hU26Pr7z9GnAYVIIn9mZLTPMgCr80jon+Fr0Wc9uwnXJezF0D7E086/eiUchvt5UY7NycIpwWC
        Untb1/3t8bDJt8i89ETNPxwwpmPOSSePmCN8OS6styfdvVLvio7JDgg3rXmO4R3X/O0i/tdSpSFUP
        FiRgdUeiGh61K1S5OEcBXo9DNtwZclHGar/+lEZHvMdGrofmgdkt369aTppCIGFU88/2aFW1oQwT2
        1kaFMSCn04TZahWY79POLyVmeGthGE6VQIZ2MDyX9X/7NgUS2VKKavDhVNKqO8PGnTDvrSqIkZO3o
        yW14xwt6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38174)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kjs4S-0007hl-FI; Mon, 30 Nov 2020 22:55:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kjs4R-0005Ol-Ns; Mon, 30 Nov 2020 22:54:59 +0000
Date:   Mon, 30 Nov 2020 22:54:59 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
Message-ID: <20201130225459.GB1551@shell.armlinux.org.uk>
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
 <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
 <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:22:58AM -0800, Linus Torvalds wrote:
> > I guess the question is: why is static assignment of numbers not an
> > acceptable solution to the problem?  It gives us the desired fixed
> > numbers and automatically avoids all weird probe ordering / dependency
> > problems.
> 
> I think that if this had been done originally, it would probably be fine.

It was not done originally, because the original structure of the MMC
bus was:

host controller ---+--- card 1
                   +--- card 2
		   +--- card 3
		   ...

So one host controller could be connected to multiple different cards,
and the bus has a way to detect each card individually. This means we
had no idea how many cards would be connected to any one controller,
and it was entirely sensible to allocate MMC block devices in the order
we discovered the cards.

The SD specification, this became limited to just one card per
controller to allow for faster speeds.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
