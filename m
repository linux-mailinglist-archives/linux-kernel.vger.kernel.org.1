Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA885294CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440400AbgJUMeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440367AbgJUMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:34:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KjDZj7jv/QmeVv/HyadGtxH0b8QpjjCHYbS7ZTPmBWE=; b=0MSJvLoarof91KiLDHrbNudem
        nNnus0fI426ZesZDBv96ZksSlXAwGCKZtZBDlAl1dywPBwTK36wSJ8RYOFBv+kEK5GyyNDfUTnixg
        Jw0hd6H4JHE0+rfFGZkEZCroz4bncPTVKk7epp/ewjYrX+gIqc+sOO8c2wAiZJT6YMxCB6dqlyGZj
        QvC03krJ7bDzDPoGDzv8UrT993jHzISm4B+Mdg2LQ17A1+EgW3H+H4Va7Y+nvmPPyUH9OMXz6JBdW
        nnNix9L1WSJbwfCryjP6JOowtx9AK9WOU0epyikDdMLbMrPm5mYvg/++vz9P5X1k/v8y+CWm4bwgP
        oc0PPSzIw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49092)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVDJc-0000W6-Ji; Wed, 21 Oct 2020 13:34:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVDJY-0006Ng-MV; Wed, 21 Oct 2020 13:34:00 +0100
Date:   Wed, 21 Oct 2020 13:34:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>, v.narang@samsung.com,
        a.sahrawat@samsung.com, Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
Message-ID: <20201021123400.GK1551@shell.armlinux.org.uk>
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <20201008083015.GK1551@shell.armlinux.org.uk>
 <CAK8P3a0h=D8_Kn_fpHbsik_jf4to2jayxj7K7B7=HaNFzKqNnw@mail.gmail.com>
 <CAK8P3a2tmRo0voZJLqYbNQGG9FZCGuKzMj8Zo8f+WL+dvOourw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2tmRo0voZJLqYbNQGG9FZCGuKzMj8Zo8f+WL+dvOourw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 01:58:21PM +0200, Arnd Bergmann wrote:
> (replying to my own mail, apparently my normal outgoing email server is
> blacklisted, so resending from @kernel.org)
> 
> On Fri, Oct 16, 2020 at 12:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Oct 8, 2020 at 10:32 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Thu, Oct 08, 2020 at 12:45:30PM +0530, Maninder Singh wrote:
> > > > Observed Stack Overflow on 8KB kernel stack on ARM specially
> > > > incase on network interrupts, which results in undeterministic behaviour.
> > > > So there is need for per cpu dedicated IRQ stack for ARM.
> > > >
> > > > As ARm does not have extra co-processor register
> > > > to save thread info pointer, IRQ stack will be at some
> > > > performance cost, so code is under CONFIG_IRQ_STACK.
> > > >
> > > > and we don't have much knowledge and set up for CLANG
> > > > and ARM_UNWIND, so dependency added for both cases.
> > > >
> > > > Tested patch set with QEMU for latest kernel
> > > > and 4.1 kernel for ARM target with same patch set.
> > >
> > > You need to investigate and show where and why this is happening. My
> > > guess is you have a network driver that uses a lot of kernel stack
> > > space, which itself would be a bug.
> >
> > Agreed.
> >
> > > Note that there are compiler versions out there that mis-optimise and
> > > eat stack space - the kernel build should be warning if a function
> > > uses a large amount of stack.
> >
> > Some more ideas for figuring it out:
> >
> > CONFIG_DEBUG_STACK_USAGE may also be helpful in identifying
> > code paths that are deeply nested with multiple functions taking a
> > lot of stack space, but each one staying under the limit.
> >
> > CONFIG_DEBUG_STACKOVERFLOW would also help here but
> > is not supported on Arm at the moment. There was a patch[1] from
> > Uwe Kleine-König to add this, and I suppose we should still add
> > that, in particular if it helps debug this problem.
> >
> > CONFIG_VMAP_STACK is probably the best way to debug
> > random runtime stack overflows because using a guard page
> > turns random memory corruption into an immediate oops,
> > but I don't think there is an implementation for Arm yet and
> > using a lot of vmalloc space means we might not be able to
> > default to this.
> >
> > Regardless of identifying and fixing the bug Maninder found, I
> > also think that supporting separate async stacks on Arm is useful
> > for determinism. Most of the popular architectures use irqstack
> > for this reason, and I was actually surprised that we don't do it
> > on arch/arm/.
> >
> >      Arnd
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/

We don't do it because we don't have a separate register to be able
to store the thread_info pointer, and copying that lump between the
SVC and IRQ stack will add massively to IRQ latency, especially for
older machines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
