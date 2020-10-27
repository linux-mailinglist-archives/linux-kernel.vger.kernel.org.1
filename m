Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8729BE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813065AbgJ0Qru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1812028AbgJ0QpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:45:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACC020727;
        Tue, 27 Oct 2020 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603817120;
        bh=it6+5eIhjAOmLpKS1T5u/uQqAOw4eN9xqiUyXoVjz7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLYSywKRXWs03RnAIzJlcc1AgTmlsc2n3apExFuB12H55A4vJEO3kpIM6R4Y1VFfh
         9Ye+Tf6hbQ9a+MMiPrit7KhXXJFdbJh2tMrXiqktJHCUu7DKK5xcE4CsNYetBaMJWy
         cGYHHWMoGm6d2XyjrWnoLoDfDhkPB1QQjRdJXuz0=
Date:   Tue, 27 Oct 2020 17:43:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: memory leak in u_audio_start_playback
Message-ID: <20201027164343.GA1523116@kroah.com>
References: <CAEAjamthOsn9JfL1K-sGUmTUJ-1GV6eCnn3baLNnG_MnUk12ow@mail.gmail.com>
 <CAEAjams+ztDnt80M37ivQtGSUS1y6_zs-o0BoLDrTfBGAt+8ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjams+ztDnt80M37ivQtGSUS1y6_zs-o0BoLDrTfBGAt+8ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:50:25AM -0400, Kyungtae Kim wrote:
> On Sun, Oct 25, 2020 at 3:32 PM Kyungtae Kim <kt0755@gmail.com> wrote:
> >
> > We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
> > of syzkaller).
> >
> > An instance of struct usb_request allocated in f_audio_set_alt() leaked.
> >
> > ==================================================================
> > BUG: memory leak
> > unreferenced object 0xffff888053df0e00 (size 128):
> >   comm "softirq", pid 0, jiffies 4294940573 (age 17.540s)
> >   hex dump (first 32 bytes):
> >     00 0e df 53 80 88 ff ff 00 0e df 53 80 88 ff ff  ...S.......S....
> >     00 82 df 53 80 88 ff ff c0 00 00 00 00 00 00 00  ...S............
> >   backtrace:
> >     [<000000000694647e>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
> >     [<000000000694647e>] slab_post_alloc_hook mm/slab.h:588 [inline]
> >     [<000000000694647e>] slab_alloc_node mm/slub.c:2824 [inline]
> >     [<000000000694647e>] slab_alloc mm/slub.c:2832 [inline]
> >     [<000000000694647e>] kmem_cache_alloc_trace+0x15c/0x310 mm/slub.c:2849
> >     [<00000000d7d91433>] kmalloc include/linux/slab.h:555 [inline]
> >     [<00000000d7d91433>] kzalloc include/linux/slab.h:669 [inline]
> >     [<00000000d7d91433>] dummy_alloc_request+0x83/0x120 drivers/usb/gadget/udc/dummy_hcd.c:663
> >     [<000000006e043557>] usb_ep_alloc_request+0x23/0x170 drivers/usb/gadget/udc/core.c:178
> >     [<00000000fb13871b>] u_audio_start_playback+0x224/0x3c0 drivers/usb/gadget/function/u_audio.c:449
> >     [<0000000017cb1f54>] f_audio_set_alt+0x8e/0x170 drivers/usb/gadget/function/f_uac1.c:463
> >     [<0000000063ba610c>] composite_setup+0x62e/0x2690 drivers/usb/gadget/composite.c:1793
> >     [<00000000e86333ed>] configfs_composite_setup+0xa5/0xd0 drivers/usb/gadget/configfs.c:1457
> >     [<00000000f9a524ea>] dummy_timer+0x5a7/0x1460 drivers/usb/gadget/udc/dummy_hcd.c:1899
> >     [<00000000182f2904>] call_timer_fn+0xdd/0x3a0 kernel/time/timer.c:1416
> >     [<000000000d926b91>] expire_timers kernel/time/timer.c:1461 [inline]
> >     [<000000000d926b91>] __run_timers kernel/time/timer.c:1792 [inline]
> >     [<000000000d926b91>] run_timer_softirq+0x286/0x670 kernel/time/timer.c:1805
> >     [<000000008902fa26>] __do_softirq+0xfa/0x684 kernel/softirq.c:292
> >     [<000000003597f960>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
> >     [<000000005c5a9a83>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
> >     [<000000005c5a9a83>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
> >     [<000000005c5a9a83>] do_softirq_own_stack+0x8b/0xb0 arch/x86/kernel/irq_64.c:77
> >     [<00000000590d59e5>] invoke_softirq kernel/softirq.c:387 [inline]
> >     [<00000000590d59e5>] __irq_exit_rcu kernel/softirq.c:417 [inline]
> >     [<00000000590d59e5>] irq_exit_rcu+0xb5/0xf0 kernel/softirq.c:429
> >     [<00000000689d4053>] sysvec_apic_timer_interrupt+0x83/0xf0 arch/x86/kernel/apic/apic.c:1091
> >     [<00000000f2e90960>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
> > ==================================================================
> >
> > Regards,
> > Kyungtae Kim

Nice, care to submit a patch to fix this?

We are drowning in syzbot-found issues, almost none will get resolved
unless people start providing resources to fix them.  I would strongly
recommend the people that find them also send a fix at the same time
where ever possible.

thanks,

greg k-h
