Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C127274083
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIVLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:12:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:51552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgIVLMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600773123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElFV5jeETsr+xnp+5r8vzg/2KidT8i/0vYbVSw0KM8k=;
        b=F+azv4OPoZYxtmiKVZOBa1af22kp+hkqBCmz6AkJZh3POCLt5S+CQvXDTHLY3/osdOw4De
        d2WKAhP5ArskGDK1gzGJlN8v+NEmGliuUErjK+OwCZlheH1LhQlZAmApEOx9GRl1I5WVuN
        RYfGXrEjsII2y+Aal7VsMG2v0OieI50=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23074B263;
        Tue, 22 Sep 2020 11:12:40 +0000 (UTC)
Date:   Tue, 22 Sep 2020 13:12:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: Machine lockups on extreme memory pressure
Message-ID: <20200922111202.GY12990@dhcp22.suse.cz>
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 11:35:35, Shakeel Butt wrote:
> Hi all,
> 
> We are seeing machine lockups due extreme memory pressure where the
> free pages on all the zones are way below the min watermarks. The stack
> of the stuck CPU looks like the following (I had to crash the machine to
> get the info).

sysrq+l didn't report anything?
 
>  #0 [ ] crash_nmi_callback
>  #1 [ ] nmi_handle
>  #2 [ ] default_do_nmi
>  #3 [ ] do_nmi
>  #4 [ ] end_repeat_nmi
> --- <NMI exception stack> ---
>  #5 [ ] queued_spin_lock_slowpath
>  #6 [ ] _raw_spin_lock
>  #7 [ ] ____cache_alloc_node
>  #8 [ ] fallback_alloc
>  #9 [ ] __kmalloc_node_track_caller
> #10 [ ] __alloc_skb
> #11 [ ] tcp_send_ack
> #12 [ ] tcp_delack_timer
> #13 [ ] run_timer_softirq
> #14 [ ] irq_exit
> #15 [ ] smp_apic_timer_interrupt
> #16 [ ] apic_timer_interrupt
> --- <IRQ stack> ---
> #17 [ ] apic_timer_interrupt
> #18 [ ] _raw_spin_lock
> #19 [ ] vmpressure
> #20 [ ] shrink_node
> #21 [ ] do_try_to_free_pages
> #22 [ ] try_to_free_pages
> #23 [ ] __alloc_pages_direct_reclaim
> #24 [ ] __alloc_pages_nodemask
> #25 [ ] cache_grow_begin
> #26 [ ] fallback_alloc
> #27 [ ] __kmalloc_node_track_caller
> #28 [ ] __alloc_skb
> #29 [ ] tcp_sendmsg_locked
> #30 [ ] tcp_sendmsg
> #31 [ ] inet6_sendmsg
> #32 [ ] ___sys_sendmsg
> #33 [ ] sys_sendmsg
> #34 [ ] do_syscall_64
> 
> These are high traffic machines. Almost all the CPUs are stuck on the
> root memcg's vmpressure sr_lock and almost half of the CPUs are stuck
> on kmem cache node's list_lock in the IRQ.

Are you able to track down the lock holder?

> Note that the vmpressure sr_lock is irq-unsafe.

Which is ok because this is only triggered from the memory reclaim and
that cannot ever happen from the interrrupt context for obvoius reasons.

> Couple of months back, we observed a similar
> situation with swap locks which forces us to disable swap on global
> pressure. Since we do proactive reclaim disabling swap on global reclaim
> was not an issue. However now we have started seeing the same situation
> with other irq-unsafe locks like vmpressure sr_lock and almost all the
> slab shrinkers have irq-unsafe spinlocks. One of way to mitigate this
> is by converting all such locks (which can be taken in reclaim path)
> to be irq-safe but it does not seem like a maintainable solution.

This doesn't make much sense to be honest. We are not disabling IRQs
unless it is absolutely necessary.

> Please note that we are running user space oom-killer which is more
> aggressive than oomd/PSI but even that got stuck under this much memory
> pressure.
> 
> I am wondering if anyone else has seen a similar situation in production
> and if there is a recommended way to resolve this situation.

I would recommend to focus on tracking down the who is blocking the
further progress.
-- 
Michal Hocko
SUSE Labs
