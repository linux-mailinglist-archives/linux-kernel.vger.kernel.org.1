Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B502B1F62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKMP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKMP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:58:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82819C0613D1;
        Fri, 13 Nov 2020 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f7t3S1jdVSfRsXfQqlo0fUjZRYtsQhFitY7Hjvr6/jM=; b=ceZJidw5MO1m8hdi/JCiZTulG
        ZV4AdjOWhCHBfKk3vlSov0mmpQ1jGwIg9LcKJK5TR60X1KBZLNSYPXMMTzDH/usbj8l1Yr32uD7rC
        COfG4i5bBIHHOzfuW9LNphokoTQPlcqQ073HymwCP21TTG4jPNZLB9TqQIwRa1U794m756cM22N6n
        pAo2vBr2Kk/Xwmzax3vgOAcVm0DH5fNFFKO+qnp+8CbiilWTb3mE9Vwa2SinrWIt+JBdR5lOPOyfD
        pX+M4khlODgfJ4E8BaAy/XUBG/7DYA4xxtH1hTzscnnMSCfBvPxBxVpIlTGWdTI9mMoosKBsFv1PW
        8nKLw5f6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59226)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kdbT3-0004yp-BB; Fri, 13 Nov 2020 15:58:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kdbSz-0004Yy-J5; Fri, 13 Nov 2020 15:58:25 +0000
Date:   Fri, 13 Nov 2020 15:58:25 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernelci-results@groups.io,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: rmk/for-next bisection: baseline.login on bcm2836-rpi-2-b
Message-ID: <20201113155825.GD1551@shell.armlinux.org.uk>
References: <5fadef1f.1c69fb81.9166e.093c@mx.google.com>
 <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
 <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
 <ce91a878-5ce3-614d-d10c-569b891b12d0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce91a878-5ce3-614d-d10c-569b891b12d0@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 03:43:27PM +0000, Guillaume Tucker wrote:
> On 13/11/2020 10:35, Ard Biesheuvel wrote:
> > On Fri, 13 Nov 2020 at 11:31, Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> Please see the bisection report below about a boot failure on
> >> RPi-2b.
> >>
> >> Reports aren't automatically sent to the public while we're
> >> trialing new bisection features on kernelci.org but this one
> >> looks valid.
> >>
> >> There's nothing in the serial console log, probably because it's
> >> crashing too early during boot.  I'm not sure if other platforms
> >> on kernelci.org were hit by this in the same way, but there
> >> doesn't seem to be any.
> >>
> >> The same regression can be see on rmk's for-next branch as well
> >> as in linux-next.  It happens with both bcm2835_defconfig and
> >> multi_v7_defconfig.
> >>
> >> Some more details can be found here:
> >>
> >>   https://kernelci.org/test/case/id/5fae44823818ee918adb8864/
> >>
> >> If this looks like a real issue but you don't have a platform at
> >> hand to reproduce it, please let us know if you would like the
> >> KernelCI test to be re-run with earlyprintk or some debug config
> >> turned on, or if you have a fix to try.
> >>
> >> Best wishes,
> >> Guillaume
> >>
> > 
> > Hello Guillaume,
> > 
> > That patch did have an issue, but it was already fixed by
> > 
> > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9020/1
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fc2933c133744305236793025b00c2f7d258b687
> > 
> > Could you please double check whether cherry-picking that on top of
> > the first bad commit fixes the problem?
> 
> Sadly this doesn't appear to be fixing the issue.  I've
> cherry-picked your patch on top of the commit found by the
> bisection but it still didn't boot, here's the git log
> 
> cbb9656e83ca ARM: 9020/1: mm: use correct section size macro to describe the FDT virtual address
> 7a1be318f579 ARM: 9012/1: move device tree mapping out of linear region
> e9a2f8b599d0 ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
> 3650b228f83a Linux 5.10-rc1
> 
> Test log: https://people.collabora.com/~gtucker/lava/boot/rpi-2-b/v5.10-rc1-3-gcbb9656e83ca/
> 
> There's no output so it's hard to tell what is going on, but
> reverting the bad commmit does make the board to boot (that's
> what "revert: PASS" means in the bisect report).  So it's
> unlikely that there is another issue causing the boot failure.

These silent boot failures are precisely what the DEBUG_LL stuff (and
early_printk) is supposed to help with - getting the kernel messages
out when there is an oops before the serial console is initialised.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
