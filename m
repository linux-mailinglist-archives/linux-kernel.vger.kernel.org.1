Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FD2CAB05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgLASte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgLAStd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:49:33 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB35C2151B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606848532;
        bh=Q9w+YPjel2Xxs51s0kfnyiZQ3nHDzUY8ksdc+3t3bUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QtfZxvWlv3TJysMe3cH3d7vSFS1DBM9RI8tz6193Gb5rA/BJ4vt9P0ZF58aeDx25G
         Vv5punQ8bisAutcjhZJfJlj2EVdNvU1DdIb2gRN0OI4RRALVKwW3o8D2JrUhTPVSpI
         OXMnZwBV8Pp5n9+OpcnzV8EwnkgwzddDH9giXuEE=
Received: by mail-wm1-f53.google.com with SMTP id v14so5719390wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:48:51 -0800 (PST)
X-Gm-Message-State: AOAM5307I2D4ykfFPlcqKzScY+aQpdxkrfpQDzcMmHRYjjlH9ya3s/WT
        ukNWhGfTIbiTGCFZmXE9JQ4TjwDTayI2tI7Vknpy9Q==
X-Google-Smtp-Source: ABdhPJyBspeR30SiFoncl4Y/BgxGKfgVP1leXS/WTh5c9hig7YCfah/Mkwa1PqRHlRmrWqknE4JvOMGu9MI09YaaMq0=
X-Received: by 2002:a1c:630b:: with SMTP id x11mr4227854wmb.138.1606848530187;
 Tue, 01 Dec 2020 10:48:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
 <20201201101637.GU2414@hirez.programming.kicks-ass.net> <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com>
 <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com> <763536813.69859.1606847380892.JavaMail.zimbra@efficios.com>
In-Reply-To: <763536813.69859.1606847380892.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 10:48:36 -0800
X-Gmail-Original-Message-ID: <CALCETrUPiBOUEwJsLb8n0DJkHpTAYkFXJQuJ7swuRankvCzrRg@mail.gmail.com>
Message-ID: <CALCETrUPiBOUEwJsLb8n0DJkHpTAYkFXJQuJ7swuRankvCzrRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 10:29 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Dec 1, 2020, at 1:12 PM, Andy Lutomirski luto@kernel.org wrote:
>
> > On Tue, Dec 1, 2020 at 6:28 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Dec 1, 2020, at 5:16 AM, Peter Zijlstra peterz@infradead.org =
wrote:
> >>
> >> > On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
> >> >> membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
> >> >> other CPUs, but there are two issues.
> >> >>
> >> >>  - membarrier() does not sync_core() or rseq_preempt() the calling
> >> >>    CPU.  Aside from the logic being mind-bending, this also means
> >> >>    that it may not be safe to modify user code through an alias,
> >> >>    call membarrier(), and then jump to a different executable alias
> >> >>    of the same code.
> >> >
> >> > I always understood this to be on purpose. The calling CPU can fix u=
p
> >> > itself just fine. The pain point is fixing up the other CPUs, and th=
at's
> >> > where membarrier() helps.
> >>
> >> Indeed, as documented in the man page:
> >>
> >>        MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE (since Linux 4.16)
> >>               In  addition  to  providing  the  memory ordering guaran=
tees de=E2=80=90
> >>               scribed in MEMBARRIER_CMD_PRIVATE_EXPEDITED,  upon  retu=
rn  from
> >>               system call the calling thread has a guarantee that all =
its run=E2=80=90
> >>               ning thread siblings have executed a core  serializing  =
instruc=E2=80=90
> >>               tion.   This  guarantee is provided only for threads in =
the same
> >>               process as the calling thread.
> >>
> >> membarrier sync core guarantees a core serializing instruction on the =
siblings,
> >> not on the caller thread. This has been done on purpose given that the=
 caller
> >> thread can always issue its core serializing instruction from user-spa=
ce on
> >> its own.
> >>
> >> >
> >> > That said, I don't mind including self, these aren't fast calls by a=
ny
> >> > means.
> >>
> >> I don't mind including self either, but this would require documentati=
on
> >> updates, including man pages, to state that starting from kernel Y thi=
s
> >> is the guaranteed behavior. It's then tricky for user-space to query w=
hat
> >> the behavior is unless we introduce a new membarrier command for it. S=
o this
> >> could introduce issues if software written for the newer kernels runs =
on older
> >> kernels.
> >
> > For rseq at least, if we do this now we don't have this issue -- I
> > don't think any released kernel has the rseq mode.
>
> But for rseq, there is no core-sync. And considering that it is invalid
> to issue a system call within an rseq critical section (including membarr=
ier),
> I don't see what we gain by doing a rseq barrier on self ?
>
> The only case where it really changes the semantic is for core-sync I thi=
nk.
> And in this case, it would be adding an additional core-sync on self. I
> am OK with doing that considering that it will simplify use of the system
> call. I'm just wondering how we should document this change in the man pa=
ge.
>
> >
> >>
> >> >
> >> >>  - membarrier() does not explicitly sync_core() remote CPUs either;
> >> >>    instead, it relies on the assumption that an IPI will result in =
a
> >> >>    core sync.  On x86, I think this may be true in practice, but
> >> >>    it's not architecturally reliable.  In particular, the SDM and
> >> >>    APM do not appear to guarantee that interrupt delivery is
> >> >>    serializing.
> >> >
> >> > Right, I don't think we rely on that, we do rely on interrupt delive=
ry
> >> > providing order though -- as per the previous email.
> >> >
> >> >>    On a preemptible kernel, IPI return can schedule,
> >> >>    thereby switching to another task in the same mm that was
> >> >>    sleeping in a syscall.  The new task could then SYSRET back to
> >> >>    usermode without ever executing IRET.
> >> >
> >> > This; I think we all overlooked this scenario.
> >>
> >> Indeed, this is an issue which needs to be fixed.
> >>
> >> >
> >> >> This patch simplifies the code to treat the calling CPU just like
> >> >> all other CPUs, and explicitly sync_core() on all target CPUs.  Thi=
s
> >> >> eliminates the need for the smp_mb() at the end of the function
> >> >> except in the special case of a targeted remote membarrier().  This
> >> >> patch updates that code and the comments accordingly.
> >>
> >> I am not confident that removing the smp_mb at the end of membarrier i=
s
> >> an appropriate change, nor that it simplifies the model.
> >
> > Ah, but I didn't remove it.  I carefully made sure that every possible
> > path through the function does an smp_mb() or stronger after all the
> > cpu_rq reads.  ipi_func(), on_each_cpu(), and the explicit smp_mb()
> > cover the three cases.
> >
> > That being said, if you prefer, I can make the change to skip the
> > calling CPU, in which case I'll leave the smp_mb() at the end alone.
>
> For the memory barrier commands, I prefer skipping self and leaving the
> smp_mb at the very beginning/end of the system call. Those are the key
> before/after points we are synchronizing against, and those are simple
> to document.
>

Is there a reason that doing the barrier at the very end could make an
observable difference?  The two models are:

membarrier() {
 smp_mb();
 read a bunch of cpu_rq memory and make decisions;
 execute smp_mb() on relevant cpus including self;
}

versus

membarrier() {
 smp_mb();
 read a bunch of cpu_rq memory and make decisions;
 execute smp_mb() on relevant non-self cpus;
 wait for that to finish (acquire-style on the local cpu);
 smp_mb();
}

Is the idea that, on a sufficiently weakly ordered architecture, some
remote CPU could do a store before the IPI and a local load after the
membarrier() syscall might not observe the load unless the local
smp_mb() is after the remote smp_mb()?  If so, I'm not entirely
convinced that this is observably different from the store simply
occurring after the IPI, but maybe there are some gnarly situations in
which this could happen.

If your concern is something along these lines, I could try to write
up an appropriate comment, and I'll rework the patch.
