Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBB2CAA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgLASKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgLASKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:10:19 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2632151B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606846178;
        bh=EhrZkmA9Szocp4hMa9ZLKDMOcJbzH5Tz9JqGL69MrcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sjlcWhdxLfWSE1JO3nRaRUwqRhe0D3u/nDyu0MvUWeRNg/FIr2kzSE09VfQKwybc1
         U9Hq1jYuDkrGbTEj4qqIScU/FCGwUBrgo7gTqZ+d5pF2fh7iBQxYFsUcGIzW9+Wj2J
         vmib/i5M8Q1BvSN39QytQEjOPrlahvgo0Xev6Y1k=
Received: by mail-wr1-f50.google.com with SMTP id l1so4095413wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:09:37 -0800 (PST)
X-Gm-Message-State: AOAM53356WzjG6mwv133TsYGrCgn0jH9cA1IJ31RYlqytPS3Hzv6NO19
        HIyboPByYmJ9lDmVR1XxN0g7D2BKyCNjqoDWFBM5iA==
X-Google-Smtp-Source: ABdhPJwL1A7ldTocM+lmFFcHnFAXIjQ15HhJ15nbX0vXG6dSoRM+SNnNTimVNikAgX9B2yoVi/V+7Kclr4Tqn+ZVNDs=
X-Received: by 2002:adf:e449:: with SMTP id t9mr5420621wrm.257.1606846176406;
 Tue, 01 Dec 2020 10:09:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
 <20201201101637.GU2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201201101637.GU2414@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 10:09:22 -0800
X-Gmail-Original-Message-ID: <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
Message-ID: <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
> > membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
> > other CPUs, but there are two issues.
> >
> >  - membarrier() does not sync_core() or rseq_preempt() the calling
> >    CPU.  Aside from the logic being mind-bending, this also means
> >    that it may not be safe to modify user code through an alias,
> >    call membarrier(), and then jump to a different executable alias
> >    of the same code.
>
> I always understood this to be on purpose. The calling CPU can fix up
> itself just fine. The pain point is fixing up the other CPUs, and that's
> where membarrier() helps.
>
> That said, I don't mind including self, these aren't fast calls by any
> means.

Honestly, I mostly did this because IMO it's a nice cleanup.  It took
quite some reading of the code and the comments that try not to target
the calling CPU to decide that it was correct, and I think the new
code is considerably more clear.  If we want to skip the calling CPU,
then I think we should still use the new code but use
smp_call_function instead, which will itself skip the caller.
Thoughts?

>
> >  - membarrier() does not explicitly sync_core() remote CPUs either;
> >    instead, it relies on the assumption that an IPI will result in a
> >    core sync.  On x86, I think this may be true in practice, but
> >    it's not architecturally reliable.  In particular, the SDM and
> >    APM do not appear to guarantee that interrupt delivery is
> >    serializing.
>
> Right, I don't think we rely on that, we do rely on interrupt delivery
> providing order though -- as per the previous email.

I looked for a bit, and I couldn't find anything in the SDM or APM to
support this, and I would be rather surprised if other architectures
synchronize their instruction streams on interrupt delivery.  On
architectures without hardware I$ coherency and with actual fast
interrupts, I would be surprised if interrupts ensured I$ coherency
with prior writes from other cores.

On x86, interrupt *return* via IRET is definitely serializing but, as
mentioned in patch 1, we don't actually guarantee that we'll execute
IRET on the way out of an IPI before running user code.

So I stand by this part of my patch.

>
> >    On a preemptible kernel, IPI return can schedule,
> >    thereby switching to another task in the same mm that was
> >    sleeping in a syscall.  The new task could then SYSRET back to
> >    usermode without ever executing IRET.
>
> This; I think we all overlooked this scenario.
>
> > This patch simplifies the code to treat the calling CPU just like
> > all other CPUs, and explicitly sync_core() on all target CPUs.  This
> > eliminates the need for the smp_mb() at the end of the function
> > except in the special case of a targeted remote membarrier().  This
> > patch updates that code and the comments accordingly.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> > @@ -228,25 +258,33 @@ static int membarrier_private_expedited(int flags, int cpu_id)
> >               rcu_read_unlock();
> >       }
> >
> > -     preempt_disable();
> > -     if (cpu_id >= 0)
> > -             smp_call_function_single(cpu_id, ipi_func, NULL, 1);
> > -     else
> > -             smp_call_function_many(tmpmask, ipi_func, NULL, 1);
> > -     preempt_enable();
> > +     if (cpu_id >= 0) {
> > +             int cpu = get_cpu();
> > +
> > +             if (cpu_id == cpu) {
> > +                     ipi_func(NULL);
> > +             } else {
> > +                     smp_call_function_single(cpu_id, ipi_func, NULL, 1);
> > +                     /*
> > +                      * This is analogous to the smp_mb() at the beginning
> > +                      * of the function -- exit from a system call is not a
> > +                      * barrier.  We only need this if we're targeting a
> > +                      * specific remote CPU, though -- otherwise ipi_func()
> > +                      * would serves the same purpose.
> > +                      */
> > +                     smp_mb();
>
> smp_call_function_single(.wait=1) already orders against completion of
> the IPI. Do we really need more?

What kind of order does it provide?  A quick skim of the code suggests
that it's an acquire barrier, but I think we need a full sequential
consistency barrier, at least on sufficiently weakly ordered
architectures.  On x86, loads are ordered and this is probably
irrelevant.  Also, this barrier was already there (it's the one I
deleted below), and I think that removing it should be its own patch
if we want to go that route.
