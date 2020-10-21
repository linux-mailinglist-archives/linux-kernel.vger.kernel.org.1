Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5F294D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442743AbgJUM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441113AbgJUM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:57:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4BCC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2guoGSLtHOa0nTM7D1+lgjYVtsEuXac+T3GLacIF1mg=; b=y78jstFCx8mCbIM5K6v+eQ+mu
        AhGm2FxHNI+92IzJArQE5oZS+WltS4w9ASWH5GSlSdMtfuuxObcpTXgWNZ1Or89k/RHL9YvGv0qlN
        weODQgpXxgNWGzdaeU43FB0iVlCtBm8bZKLkycy6z5VXekcjqR0zRpOsfgL4y8CrEDn2u25mOBZGS
        kTaJMrIVOnUHTCAuBPPhIcwwrhDgiCyrGur1DKPSCpQUqib6544KM37/LQkQ8Nkog2PPruNfNZU9K
        kxVbl3nn8hCXN88zG27ISaAH6rG7tKRCKWhLvVbs30duo5SKv+Xd8NFWlK8yigyeDd80D/FLZretT
        8e3o6JR4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49106)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVDgT-0000ZV-OY; Wed, 21 Oct 2020 13:57:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVDgS-0006P1-7u; Wed, 21 Oct 2020 13:57:40 +0100
Date:   Wed, 21 Oct 2020 13:57:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     v.narang@samsung.com, a.sahrawat@samsung.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
Message-ID: <20201021125740.GM1551@shell.armlinux.org.uk>
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021124542.GL1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 01:45:42PM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Oct 21, 2020 at 02:42:48PM +0200, Arnd Bergmann wrote:
> > (also resending this reply from @kernel.org)
> > 
> > On Fri, Oct 16, 2020 at 12:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Oct 8, 2020 at 9:20 AM Maninder Singh <maninder1.s@samsung.com> wrote:
> > > >
> > > > This patch adds code for switching to IRQ stack.
> > > > IRQ stack and Kernel SVC stack have below design.
> > > >
> > > > IRQ STACK:-
> > > >                     ------------ IRQ stack top
> > > >                     |          |
> > > >                     ------------
> > > >                     .          .
> > > >                     .          .
> > > >                     .          .
> > > >                     ------------
> > > >                     |    sp    | <- irq_stack_base + 0x8
> > > >                     ------------
> > > >                     |    fp    | <- irq_stack_base + 0x4
> > > >                     ------------
> > > >                     |tinfo_ptr | /* pointer to thread info */
> > > > irq_stack_ptr -->   ------------ IRQ stack base
> > > >
> > > > Kernel SVC stack:-
> > > >                     ------------  Kernel stack top
> > > >                     |          |
> > > >                     ------------
> > > >                     .          .
> > > >                     .          .
> > > >                     .          .
> > > >                     ------------
> > > >                     |          |
> > > >                     |          |
> > > >                     ------------
> > > >                     |tinfo_ptr |  /* pointer to thread info */
> > > >                     ------------ Kernel stack base
> > >
> > > The extra indirection doesn't look great, and I don't see any of the
> > > other architectures need that. Since we can access percpu data
> > > without going through thread_info, maybe doing the same as
> > > x86 would work here:
> > >
> > > - define 'current' as 'this_cpu_read_stable(current_task);'
> > > - convert to CONFIG_THREAD_INFO_IN_TASK
> 
> That means we need to also code that up in assembly - remember, we
> need to access thread_info from assembly code.

Note also that there is a circular dependency involved. If you make
thread_info accessible via per-cpu, then:

#ifndef __my_cpu_offset
#define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
#endif
#ifdef CONFIG_DEBUG_PREEMPT
#define my_cpu_offset per_cpu_offset(smp_processor_id())
#else
#define my_cpu_offset __my_cpu_offset
#endif

smp_processor_id() ultimately ends up as raw_smp_processor_id() which
is:

#define raw_smp_processor_id() (current_thread_info()->cpu)

and if current_thread_info() itself involves reading from per-cpu data,
we end up recursing... infinitely.

This is why I said in the other thread:

"We don't do it because we don't have a separate register to be able
to store the thread_info pointer, and copying that lump between the
SVC and IRQ stack will add massively to IRQ latency, especially for
older machines."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
