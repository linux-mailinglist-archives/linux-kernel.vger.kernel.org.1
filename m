Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D52A3A41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKCCLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:11:31 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC8C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:11:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t13so17229985ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDptHzkTNo5v1VaGKz+DKFNTC+BV6fyCCdPZtdwjYHY=;
        b=CbTjX+TWC+ontKMRBBul5/niS/C7ZttvuYhDGOd5WKw7O0CGjzyetTuGzJESk1PhH5
         k9wgMUXwRg5ymIKV1shjWDoTC5NJZlQSWUkYD2koPSvK1MGj3mg7i92udafmALkJqTwV
         jvjJ64OaeMMAgZvjMKbSCjU+yiotjRl40JN/O3zFwmFe46OdhEMHqLU+SIM0rAJDs6ni
         ke2aVbWz1ZzTRg3/cRspBdJ6QtAd2Z9aBjyYcygR2aGIFLWdUYLjR8XLkTxjabJ02Lmd
         pUzW8RANdMxH97FDB6ZX6/DZp5K/9hHbK2DanZEGSWgTpR+F2iUJkYsiMJ1Q0GloeZlu
         6Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDptHzkTNo5v1VaGKz+DKFNTC+BV6fyCCdPZtdwjYHY=;
        b=oe/+6RBL8nMzVDKdBB3ICrUGQ9J8X0WKpfeFkmYZ5L8XRNtxqQhx5P2z2ROhHwS8dw
         GQNQnai+Hwky/PYmdZJSTvEcbJqecuzRVJg3Xv2MybYWS+3MzN4HjJSuDB42FaaU9yff
         E16OfHZ052Wz/DiN66ELCeLBnECgf9mD4r1wdmfNWhxb0t6vQYFmPWiOMFgBorn3pl9w
         yaqlffkE+a3Ob316+5Tzyn7JD1ENbJbJzAVxSsGZBUWpLgFr1jHAYvDWws3NNhLxSHb4
         /JitjxXLepmiHAn87YXkQCazwvhNi53bPqCtU6LliqMAmb7tyyTVaIS73QxuIB6tQxEh
         QTzg==
X-Gm-Message-State: AOAM530G5LwxaHdMpnADE9QEukvUT2epovf+XgZ8AxPq1Z3QyJdpUIHN
        g09vuVRMb8RPBSV5QVNVIgSMppSGmhTfApjx4Mp8Bw==
X-Google-Smtp-Source: ABdhPJzkf3oJ+YnmdBbEIiwKjgwvrLp0kI0wsfDkNRKZmuZVbm0hldGNOheyzR1IbcUCyLaag8+as7p2s4Jbf2reh1w=
X-Received: by 2002:a2e:a175:: with SMTP id u21mr6748044ljl.160.1604369489215;
 Mon, 02 Nov 2020 18:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20201016230915.1972840-1-jannh@google.com> <20201016230915.1972840-4-jannh@google.com>
 <20201016232153.GD37159@ziepe.ca> <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
In-Reply-To: <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 03:11:02 +0100
Message-ID: <CAG48ez0ChA80cjg4-=1k8PfXV_4u_YVQay9g_RdrLjbAzch4Gw@mail.gmail.com>
Subject: Re: [RFC PATCH resend 3/6] mm: Add refcount for preserving mm_struct
 without pgd
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 2:30 AM Jann Horn <jannh@google.com> wrote:
> On Sat, Oct 17, 2020 at 1:21 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
> > > Currently, mm_struct has two refcounts:
> > >
> > >  - mm_users: preserves everything - the mm_struct, the page tables, the
> > >    memory mappings, and so on
> > >  - mm_count: preserves the mm_struct and pgd
> > >
> > > However, there are three types of users of mm_struct:
> > >
> > > 1. users that want page tables, memory mappings and so on
> > > 2. users that want to preserve the pgd (for lazy TLB)
> > > 3. users that just want to keep the mm_struct itself around (e.g. for
> > >    mmget_not_zero() or __ptrace_may_access())
> > >
> > > Dropping mm_count references can be messy because dropping mm_count to
> > > zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
> > > work from RCU callbacks (which run in IRQ context). In those cases,
> > > mmdrop_async() must be used to punt the invocation of __mmdrop() to
> > > workqueue context.
> > >
> > > That's fine when mmdrop_async() is a rare case, but the preceding patch
> > > "ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
> > > the common case; we should probably avoid punting freeing to workqueue
> > > context all the time if we can avoid it?
> > >
> > > To resolve this, add a third refcount that just protects the mm_struct and
> > > the user_ns it points to, and which can be dropped with synchronous freeing
> > > from (almost) any context.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > >  arch/x86/kernel/tboot.c    |  2 ++
> > >  drivers/firmware/efi/efi.c |  2 ++
> > >  include/linux/mm_types.h   | 13 +++++++++++--
> > >  include/linux/sched/mm.h   | 13 +++++++++++++
> > >  kernel/fork.c              | 14 ++++++++++----
> > >  mm/init-mm.c               |  2 ++
> > >  6 files changed, 40 insertions(+), 6 deletions(-)
> >
> > I think mmu notifiers and the stuff in drivers/infiniband/core/ can be
> > converted to this as well..
> >
> > Actually I kind of wonder if you should go the reverse and find the
> > few callers that care about the pgd and give them a new api with a
> > better name (mmget_pgd?).
>
> Yeah, that might make more sense... as long as I'm really sure about
> all the places I haven't changed. ^^
>
> I'll try to change it as you suggested for v2.

Actually, no - I think it ends up being around 30 mentions of the
"take reference without PGD" function and around 35 mentions of the
"take reference with PGD" function (assuming that all the weird
powerpc stuff I don't understand needs the mm_context to not yet be
destroyed). (A decent chunk of which are all the per-arch functions
for starting secondary processors.) So I don't think doing it the way
you suggested would really make the patch(es) smaller.

And I think that it is helpful for review purposes to have separate
patches for every converted site, and leave things as-is by default.
If the semantics change for every user that is *not* touched by the
patch, that makes it really easy for mistakes to slip through.

I could try to convert more callers though?
