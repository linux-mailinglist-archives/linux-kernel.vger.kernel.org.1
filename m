Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17910294CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408288AbgJUMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391392AbgJUMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:45:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D0C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=erzJ45tZHdKCSwUlwbFLZ5SMRuQ10sfHSD1kkcO8798=; b=ji/Ur4W6kHAQmPf9pVvtEVVOt
        7qTVDx1mFFg2hqbRgRZ1vWccUK//PT2Z62JXuJrBfNC+UEjpw5PmaY7uBxmvnCTtp5aDRPH9GpqyE
        HoozeZXGqq7dsYN/tkXI+po+S+r8fho6K5FNOLkloKFtFFUIvy5iUP9Kal5OwsfOKa6cCKuKF0UBD
        4MSmdamUvEFKZTvYsexkmH9rMYeWZvGCLzyfiR0RBG6Folq4zAG0WWqgUFVl9Jv70ol+lomhp5+qt
        h9SWfQoUeTPD/r+zON2nCjMW5g4LmwocAf+MwWPKJlPT467yRg/+j5WpJiLOv7SeESBDDV5NBerx3
        BQUsNDwdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49094)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVDUu-0000YA-5g; Wed, 21 Oct 2020 13:45:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVDUs-0006Oi-G8; Wed, 21 Oct 2020 13:45:42 +0100
Date:   Wed, 21 Oct 2020 13:45:42 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>, v.narang@samsung.com,
        a.sahrawat@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
Message-ID: <20201021124542.GL1551@shell.armlinux.org.uk>
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:42:48PM +0200, Arnd Bergmann wrote:
> (also resending this reply from @kernel.org)
> 
> On Fri, Oct 16, 2020 at 12:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Oct 8, 2020 at 9:20 AM Maninder Singh <maninder1.s@samsung.com> wrote:
> > >
> > > This patch adds code for switching to IRQ stack.
> > > IRQ stack and Kernel SVC stack have below design.
> > >
> > > IRQ STACK:-
> > >                     ------------ IRQ stack top
> > >                     |          |
> > >                     ------------
> > >                     .          .
> > >                     .          .
> > >                     .          .
> > >                     ------------
> > >                     |    sp    | <- irq_stack_base + 0x8
> > >                     ------------
> > >                     |    fp    | <- irq_stack_base + 0x4
> > >                     ------------
> > >                     |tinfo_ptr | /* pointer to thread info */
> > > irq_stack_ptr -->   ------------ IRQ stack base
> > >
> > > Kernel SVC stack:-
> > >                     ------------  Kernel stack top
> > >                     |          |
> > >                     ------------
> > >                     .          .
> > >                     .          .
> > >                     .          .
> > >                     ------------
> > >                     |          |
> > >                     |          |
> > >                     ------------
> > >                     |tinfo_ptr |  /* pointer to thread info */
> > >                     ------------ Kernel stack base
> >
> > The extra indirection doesn't look great, and I don't see any of the
> > other architectures need that. Since we can access percpu data
> > without going through thread_info, maybe doing the same as
> > x86 would work here:
> >
> > - define 'current' as 'this_cpu_read_stable(current_task);'
> > - convert to CONFIG_THREAD_INFO_IN_TASK

That means we need to also code that up in assembly - remember, we
need to access thread_info from assembly code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
