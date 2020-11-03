Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3054C2A3AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKCDTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:19:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D6C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 19:19:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l28so20219155lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 19:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGFIq0N/0aUl+phcBiONvIjSg1NTDz3wTK7dzOr5chM=;
        b=Zg5KF+3KOopx63jJc4i6NewIlZ0HW1FuJAwYCvwxwmkGP6R8q4SUFjih25qIte59DZ
         bJiANDAXk+laUxVRGIgi2cH/wPQJ3ihaMjNTSJzkxtEdAdupNxRiAcJPNuip1HJpcI6V
         8265I/d1SUaeqfTqk98FHza+94z/lBcb6CeCFMM2ubGGUVSVspdJ4sCFGZrw5X8cLF0m
         qFmZt6JXZp/D0q6JTtKqw3rcrJQFgO0Z6Ysx5tBT/WtgoOa2OPn92iLVbGz7D8i0tE4o
         TMKY/c2Zoy31VdNF0nmNR1+SgOXgYHuBBjJtDbdKf8u0OTsbtFPyOkzFs1FradqtxbSQ
         pJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGFIq0N/0aUl+phcBiONvIjSg1NTDz3wTK7dzOr5chM=;
        b=tNzZqVgQibxpeTyR+Ag1UMhgIhNZvfaPuKAcR5QOVA2fiV/oIKZrpbA0oDu23X6SIP
         SsGgvDDGjt9B5t6lHiwwZWymQL1gU3pVRLOcqXQcYrUA7H2s5u0+lRSP9WyvfZaaL/V/
         kPo+oi85a9pUiCbNRjogQmijvp8rjUmB2Zv39jcd+MCu2CCcYHx2lGOgV/UbEZiRuIV5
         lq+2wjv+tMVEpmRUXPb8ERlUK0mIcuG89U/Qct9khM3Nwn1b+Kmv64aMum9AG/dd479V
         zvAnHHVcVRzcdGrHHotREB2oUf5eKdxK1pEK9NQW84EI1ZpxXKQkVyIM3SZQctVIuuOo
         PYgQ==
X-Gm-Message-State: AOAM533sAwOZzcasECe5WFjhwXalkQNO2wb0sbcWmAdqCySzOK3wmpQe
        1ZrgdepXMAWODFTRWyiFRCUEefImTsQ0FGjwZizNKSrpVv8=
X-Google-Smtp-Source: ABdhPJzNuPN3ncIlXeIbSCZd5HwS0ZvQW3/ySuZ1gUP48NdXYgGfUJfDR7iaawlJjbZRm2PM4i0rWqdTOM8d6PEzJ4Y=
X-Received: by 2002:a05:6512:51a:: with SMTP id o26mr6375560lfb.381.1604373577739;
 Mon, 02 Nov 2020 19:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20201016230915.1972840-1-jannh@google.com> <20201016230915.1972840-4-jannh@google.com>
 <20201016232153.GD37159@ziepe.ca> <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
 <CAG48ez0ChA80cjg4-=1k8PfXV_4u_YVQay9g_RdrLjbAzch4Gw@mail.gmail.com>
In-Reply-To: <CAG48ez0ChA80cjg4-=1k8PfXV_4u_YVQay9g_RdrLjbAzch4Gw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 04:19:11 +0100
Message-ID: <CAG48ez1ue84pXoQvdjqiXZSj5_3+2Wq7A9v9D_7=rzEFac2AFg@mail.gmail.com>
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

On Tue, Nov 3, 2020 at 3:11 AM Jann Horn <jannh@google.com> wrote:
> On Sat, Oct 17, 2020 at 2:30 AM Jann Horn <jannh@google.com> wrote:
> > On Sat, Oct 17, 2020 at 1:21 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
> > > > Currently, mm_struct has two refcounts:
> > > >
> > > >  - mm_users: preserves everything - the mm_struct, the page tables, the
> > > >    memory mappings, and so on
> > > >  - mm_count: preserves the mm_struct and pgd
> > > >
> > > > However, there are three types of users of mm_struct:
> > > >
> > > > 1. users that want page tables, memory mappings and so on
> > > > 2. users that want to preserve the pgd (for lazy TLB)
> > > > 3. users that just want to keep the mm_struct itself around (e.g. for
> > > >    mmget_not_zero() or __ptrace_may_access())
> > > >
> > > > Dropping mm_count references can be messy because dropping mm_count to
> > > > zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
> > > > work from RCU callbacks (which run in IRQ context). In those cases,
> > > > mmdrop_async() must be used to punt the invocation of __mmdrop() to
> > > > workqueue context.
> > > >
> > > > That's fine when mmdrop_async() is a rare case, but the preceding patch
> > > > "ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
> > > > the common case; we should probably avoid punting freeing to workqueue
> > > > context all the time if we can avoid it?
> > > >
> > > > To resolve this, add a third refcount that just protects the mm_struct and
> > > > the user_ns it points to, and which can be dropped with synchronous freeing
> > > > from (almost) any context.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > >  arch/x86/kernel/tboot.c    |  2 ++
> > > >  drivers/firmware/efi/efi.c |  2 ++
> > > >  include/linux/mm_types.h   | 13 +++++++++++--
> > > >  include/linux/sched/mm.h   | 13 +++++++++++++
> > > >  kernel/fork.c              | 14 ++++++++++----
> > > >  mm/init-mm.c               |  2 ++
> > > >  6 files changed, 40 insertions(+), 6 deletions(-)
> > >
> > > I think mmu notifiers and the stuff in drivers/infiniband/core/ can be
> > > converted to this as well..
> > >
> > > Actually I kind of wonder if you should go the reverse and find the
> > > few callers that care about the pgd and give them a new api with a
> > > better name (mmget_pgd?).
> >
> > Yeah, that might make more sense... as long as I'm really sure about
> > all the places I haven't changed. ^^
> >
> > I'll try to change it as you suggested for v2.
>
> Actually, no - I think it ends up being around 30 mentions of the
> "take reference without PGD" function and around 35 mentions of the
> "take reference with PGD" function (assuming that all the weird
> powerpc stuff I don't understand needs the mm_context to not yet be
> destroyed). (A decent chunk of which are all the per-arch functions
> for starting secondary processors.) So I don't think doing it the way
> you suggested would really make the patch(es) smaller.
>
> And I think that it is helpful for review purposes to have separate
> patches for every converted site, and leave things as-is by default.
> If the semantics change for every user that is *not* touched by the
> patch, that makes it really easy for mistakes to slip through.
>
> I could try to convert more callers though?

But really, I would be happiest if I could just leave all the callers
where both refcounts work as-is, and let people more familiar with the
subsystems switch them over when that actually becomes necessary. Is
that not acceptable?
