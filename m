Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DDC274340
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIVNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:37:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3275C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:37:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so14168982ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBM0wDpz4gWqS8J0E28DVuLHcmz48nqEeS/I/Lgqig4=;
        b=K/XqzqAzo0bNKgUmXmj/26iPesYp4qC178KcnW/J6mEOL9FDgDG2QQXYxWN6+u/kji
         nMC33oyqITDgIhLDDsA3P4nxaG1PeaMhebQD7UeoAsCOJC14NPBEvawId0rszbv1ZdLN
         +jSNOxfLi+Z2CpDzSNwG1xCFTYW9K11iIdG8TypFy0jfYpPY8Fs1n05/Yij37fbjl7Xh
         MRE6ebkF2s/0+P9rCUqHlXHgxQIYQhWNEQ71By5HQ874206X4L71vF1iCRkyBKn7BC1S
         S19bSVfHO25TjnEBcyMBJAKkspKxkARjnz2W7B7IiLEELIJKvgCbXNydASm5g48MEMil
         ePzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBM0wDpz4gWqS8J0E28DVuLHcmz48nqEeS/I/Lgqig4=;
        b=OJhs9tImB+tSh8p0l1HkdAZUlE4JUVARnIHOPvP+zRHsE03X2az6LUq7P3dJU8w+Ms
         clIx+7iX7m/tp/4ELvs3HD7zlUoCOITaMTI9lmMQShClt5XpiWC+gsanoUfiadZ0RcIh
         M8QLYKgk3Hk0PGIgjhySx6Idyp5A+untkf+i3tFS7ZYXb7nmkVBetn7rIa1OMKF6IWaB
         Ay9filOPu5FH6AlFeOcr8aY5QwsEiW38xKYXpRy9rPbKSXsFzxdf6Q/4UcAbNqcdu9UB
         V7qu14st9VvXslbpNokugb37ItPslaXMn85C/8ztjbEq5lRroA3TL1KmTlTJ6SmreSmf
         dgkA==
X-Gm-Message-State: AOAM530PNIzxAijmH2NvS0P3o//Mpft0bAvTOgLGNL91U9BAAV4u35Kx
        0jD5wy57YWD+07l4wJUnMHtA+5gzfO5DUCpXbBqB7w==
X-Google-Smtp-Source: ABdhPJx5zNMjKsCRF+VPgehOttxLuFwA+urSURvTzIpMkTSR6PFJQxgRcpnikd9rZ6LIy9jvbsYLVFyEf4OI3+1eAK0=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr1438805ljc.192.1600781833796;
 Tue, 22 Sep 2020 06:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz>
In-Reply-To: <20200922111202.GY12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 06:37:02 -0700
Message-ID: <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
Subject: Re: Machine lockups on extreme memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 4:12 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-09-20 11:35:35, Shakeel Butt wrote:
> > Hi all,
> >
> > We are seeing machine lockups due extreme memory pressure where the
> > free pages on all the zones are way below the min watermarks. The stack
> > of the stuck CPU looks like the following (I had to crash the machine to
> > get the info).
>
> sysrq+l didn't report anything?
>

Sorry I misspoke earlier that I personally crash the machine. I get to
know the state of the machine from the crash dump. We have a crash
timer on our machines which need to be reset every couple of hours
from user space. If the user space daemon responsible to reset does
not get chance to reset it, the machine get crashed, so, these crashes
are where the user space timer resetter daemon could not run for
couple of hours.

> >  #0 [ ] crash_nmi_callback
> >  #1 [ ] nmi_handle
> >  #2 [ ] default_do_nmi
> >  #3 [ ] do_nmi
> >  #4 [ ] end_repeat_nmi
> > --- <NMI exception stack> ---
> >  #5 [ ] queued_spin_lock_slowpath
> >  #6 [ ] _raw_spin_lock
> >  #7 [ ] ____cache_alloc_node
> >  #8 [ ] fallback_alloc
> >  #9 [ ] __kmalloc_node_track_caller
> > #10 [ ] __alloc_skb
> > #11 [ ] tcp_send_ack
> > #12 [ ] tcp_delack_timer
> > #13 [ ] run_timer_softirq
> > #14 [ ] irq_exit
> > #15 [ ] smp_apic_timer_interrupt
> > #16 [ ] apic_timer_interrupt
> > --- <IRQ stack> ---
> > #17 [ ] apic_timer_interrupt
> > #18 [ ] _raw_spin_lock
> > #19 [ ] vmpressure
> > #20 [ ] shrink_node
> > #21 [ ] do_try_to_free_pages
> > #22 [ ] try_to_free_pages
> > #23 [ ] __alloc_pages_direct_reclaim
> > #24 [ ] __alloc_pages_nodemask
> > #25 [ ] cache_grow_begin
> > #26 [ ] fallback_alloc
> > #27 [ ] __kmalloc_node_track_caller
> > #28 [ ] __alloc_skb
> > #29 [ ] tcp_sendmsg_locked
> > #30 [ ] tcp_sendmsg
> > #31 [ ] inet6_sendmsg
> > #32 [ ] ___sys_sendmsg
> > #33 [ ] sys_sendmsg
> > #34 [ ] do_syscall_64
> >
> > These are high traffic machines. Almost all the CPUs are stuck on the
> > root memcg's vmpressure sr_lock and almost half of the CPUs are stuck
> > on kmem cache node's list_lock in the IRQ.
>
> Are you able to track down the lock holder?
>
> > Note that the vmpressure sr_lock is irq-unsafe.
>
> Which is ok because this is only triggered from the memory reclaim and
> that cannot ever happen from the interrrupt context for obvoius reasons.
>
> > Couple of months back, we observed a similar
> > situation with swap locks which forces us to disable swap on global
> > pressure. Since we do proactive reclaim disabling swap on global reclaim
> > was not an issue. However now we have started seeing the same situation
> > with other irq-unsafe locks like vmpressure sr_lock and almost all the
> > slab shrinkers have irq-unsafe spinlocks. One of way to mitigate this
> > is by converting all such locks (which can be taken in reclaim path)
> > to be irq-safe but it does not seem like a maintainable solution.
>
> This doesn't make much sense to be honest. We are not disabling IRQs
> unless it is absolutely necessary.
>
> > Please note that we are running user space oom-killer which is more
> > aggressive than oomd/PSI but even that got stuck under this much memory
> > pressure.
> >
> > I am wondering if anyone else has seen a similar situation in production
> > and if there is a recommended way to resolve this situation.
>
> I would recommend to focus on tracking down the who is blocking the
> further progress.

I was able to find the CPU next in line for the list_lock from the
dump. I don't think anyone is blocking the progress as such but more
like the spinlock in the irq context is starving the spinlock in the
process context. This is a high traffic machine and there are tens of
thousands of potential network ACKs on the queue.

I talked about this problem with Johannes at LPC 2019 and I think we
talked about two potential solutions. First was to somehow give memory
reserves to oomd and second was in-kernel PSI based oom-killer. I am
not sure the first one will work in this situation but the second one
might help.

Shakeel
