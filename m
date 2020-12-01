Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CE2CAA90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404163AbgLASNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbgLASNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:13:31 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E65021741
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606846369;
        bh=E2CKcTo1Blq+axp7WlL6UklE/acfYFuyZ7lpoupxS18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SSF5/HFZte04ybpegAbK9BA3K0ZsiL+A5o5hs2TE2Bx1NkbtXW+JXpIdCFdHvzgyh
         ccXOujAIzOZepWyLdSfI/B5S7zOO/AtNdNe7NKzCuEhglooI7eBYZIdp+PnUQPNuo5
         oKhkhwqjyDXyxBcMQYBlGusUsRTuAJtgsub+pe4c=
Received: by mail-wr1-f49.google.com with SMTP id u12so4152313wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:12:49 -0800 (PST)
X-Gm-Message-State: AOAM530WXsEovUBRSNIqz9m+pf0+TSEvnHvJfz18/abZ+SavYbXGpNu7
        gqA87anDDxMLknJTqL0oZCuloNdoNzNJdFpr4DXDRA==
X-Google-Smtp-Source: ABdhPJzfQSvMvtPeNRQUyXKET3QHJ0g1V4BgEp0hnU/pmlRvK9z7RRqmPxpodPPKtcP2EJhHsqLs6orujq/lgMrOJRk=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr5723748wru.70.1606846367963;
 Tue, 01 Dec 2020 10:12:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
 <20201201101637.GU2414@hirez.programming.kicks-ass.net> <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com>
In-Reply-To: <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 10:12:34 -0800
X-Gmail-Original-Message-ID: <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com>
Message-ID: <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Dec 1, 2020, at 5:16 AM, Peter Zijlstra peterz@infradead.org wro=
te:
>
> > On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
> >> membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
> >> other CPUs, but there are two issues.
> >>
> >>  - membarrier() does not sync_core() or rseq_preempt() the calling
> >>    CPU.  Aside from the logic being mind-bending, this also means
> >>    that it may not be safe to modify user code through an alias,
> >>    call membarrier(), and then jump to a different executable alias
> >>    of the same code.
> >
> > I always understood this to be on purpose. The calling CPU can fix up
> > itself just fine. The pain point is fixing up the other CPUs, and that'=
s
> > where membarrier() helps.
>
> Indeed, as documented in the man page:
>
>        MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE (since Linux 4.16)
>               In  addition  to  providing  the  memory ordering guarantee=
s de=E2=80=90
>               scribed in MEMBARRIER_CMD_PRIVATE_EXPEDITED,  upon  return =
 from
>               system call the calling thread has a guarantee that all its=
 run=E2=80=90
>               ning thread siblings have executed a core  serializing  ins=
truc=E2=80=90
>               tion.   This  guarantee is provided only for threads in the=
 same
>               process as the calling thread.
>
> membarrier sync core guarantees a core serializing instruction on the sib=
lings,
> not on the caller thread. This has been done on purpose given that the ca=
ller
> thread can always issue its core serializing instruction from user-space =
on
> its own.
>
> >
> > That said, I don't mind including self, these aren't fast calls by any
> > means.
>
> I don't mind including self either, but this would require documentation
> updates, including man pages, to state that starting from kernel Y this
> is the guaranteed behavior. It's then tricky for user-space to query what
> the behavior is unless we introduce a new membarrier command for it. So t=
his
> could introduce issues if software written for the newer kernels runs on =
older
> kernels.

For rseq at least, if we do this now we don't have this issue -- I
don't think any released kernel has the rseq mode.

>
> >
> >>  - membarrier() does not explicitly sync_core() remote CPUs either;
> >>    instead, it relies on the assumption that an IPI will result in a
> >>    core sync.  On x86, I think this may be true in practice, but
> >>    it's not architecturally reliable.  In particular, the SDM and
> >>    APM do not appear to guarantee that interrupt delivery is
> >>    serializing.
> >
> > Right, I don't think we rely on that, we do rely on interrupt delivery
> > providing order though -- as per the previous email.
> >
> >>    On a preemptible kernel, IPI return can schedule,
> >>    thereby switching to another task in the same mm that was
> >>    sleeping in a syscall.  The new task could then SYSRET back to
> >>    usermode without ever executing IRET.
> >
> > This; I think we all overlooked this scenario.
>
> Indeed, this is an issue which needs to be fixed.
>
> >
> >> This patch simplifies the code to treat the calling CPU just like
> >> all other CPUs, and explicitly sync_core() on all target CPUs.  This
> >> eliminates the need for the smp_mb() at the end of the function
> >> except in the special case of a targeted remote membarrier().  This
> >> patch updates that code and the comments accordingly.
>
> I am not confident that removing the smp_mb at the end of membarrier is
> an appropriate change, nor that it simplifies the model.

Ah, but I didn't remove it.  I carefully made sure that every possible
path through the function does an smp_mb() or stronger after all the
cpu_rq reads.  ipi_func(), on_each_cpu(), and the explicit smp_mb()
cover the three cases.

That being said, if you prefer, I can make the change to skip the
calling CPU, in which case I'll leave the smp_mb() at the end alone.
