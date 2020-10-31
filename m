Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDA2A1560
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgJaLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJaLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:03:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304AC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qm/dQY1APPXhjSPvUnH3gO6xHjupja3A54rMyQhlKYk=; b=t410NVk9eDFxFp96VJFBgdK3o
        5ECw1YSrWf2wveE+xJ0W2cfO+Fnjk/qYXCfQI/WjVZkUs49XnhNgHzZUIWutNvObWQ/Z7/Bx2ZRPW
        bN3PxBjqtKEMLvbLgI+PtMGiXDkl7DrBDs1yxOZytmk8E4ml3Xtb1kK/SgwkUb7lsgKX66ftc9Nnq
        qJVlziCdqUSuDYHYYkWYMQ/WtG5dvbc2ZhSRm08l79MS5ZXUWYuhiT2sIsHnxmr5Ce6WqdfD6CquS
        JbEKKh/hBX115/fOL6Z9uVittAg3p75EVGe94Tnv4mC4xNLhwow8LYEa6LPQmfA/8qk+xGAL9F9W5
        CbzqwRJ6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53284)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kYofo-00075q-FC; Sat, 31 Oct 2020 11:03:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kYofn-00088r-4v; Sat, 31 Oct 2020 11:03:51 +0000
Date:   Sat, 31 Oct 2020 11:03:51 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-xtensa@linux-xtensa.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
Message-ID: <20201031110350.GJ1551@shell.armlinux.org.uk>
References: <20201031094345.6984-1-rppt@kernel.org>
 <20201031103312.GI1551@shell.armlinux.org.uk>
 <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:47:42AM +0100, Ard Biesheuvel wrote:
> On Sat, 31 Oct 2020 at 11:33, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Sat, Oct 31, 2020 at 11:43:45AM +0200, Mike Rapoport wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > free_highpages() iterates over the free memblock regions in high
> > > memory, and marks each page as available for the memory management
> > > system.
> > >
> > > Until commit cddb5ddf2b76 ("arm, xtensa: simplify initialization of
> > > high memory pages") it rounded beginning of each region upwards and end of
> > > each region downwards.
> > >
> > > However, after that commit free_highmem() rounds the beginning and end of
> > > each region downwards, and we may end up freeing a page that is
> > > memblock_reserve()d, resulting in memory corruption.
> > >
> > > Restore the original rounding of the region boundaries to avoid freeing
> > > reserved pages.
> > >
> > > Fixes: cddb5ddf2b76 ("arm, xtensa: simplify initialization of high memory pages")
> > > Link: https://lore.kernel.org/r/20201029110334.4118-1-ardb@kernel.org/
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Co-developed-by:  Mike Rapoport <rppt@linux.ibm.com>
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >
> > > Max, Russell,
> > >
> > > Please let me know how do you prefer to take it upstream.
> > > If needed this can go via memblock tree.
> > >
> > > v2: fix words order in the commit message
> >
> > I really don't understand what is going on here; there seems to be a
> > total disconnect of communication between yourself and Ard. Ard has
> > already submitted a different patch for this to the patch system
> > already, sent yesterday.
> >
> > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9021/1
> >
> > Please discuss between yourselves how you want to solve the problem,
> > and then submit an agreed and tested patch to those of us upstream;
> > please don't make it for those upstream to pick one of your patches
> > as you are at present.
> >
> 
> Apologies for creating this confusion. I posted a patch and dropped it
> into the patch system when I found the bug.
> 
> However, only when Florian asked about a 'fixes' tag, I went back to
> the history, and realized that the issue was introduced by Mike during
> the most recent merge window, and affects xtensa as well.

So why does Mike's patch have:

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

in it? It seems you haven't been directly involved in Mike's patch.

There's something /really/ not right with the process behind this
patch.

> I don't have a preference which patch gets applied, though, so please
> indicate your preference, and we will adapt accordingly.

I asked for you both to come to a concensus about how you want to
proceed, and now you're throwing it back on to me to solve your(pl)
mis-communication issue. We haven't heard from Mike yet.

Clearly, I wasn't blunt and stroppy enough to be properly understood.
Sort it out between yourselves and tell me which patch you want me to
apply.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
