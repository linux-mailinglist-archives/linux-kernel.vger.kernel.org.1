Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE202A461F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgKCNVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgKCNVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:21:30 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:21:30 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 140so14554264qko.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ze9TPY5BXRPK/D7NXpXYkdnFpW0fDfd9X/m3jAh/VQ=;
        b=HG1cjddf1rcvMeTgjvxFt6R6JfKgllaUe3ZY3G+5jcSzzNIMClWOPltZM8Rt4XwxGr
         25MpcieeohNae8JbBO6ujzWrULAxs5VCuDg3+uUfUU7bUnwX6WHpTIea+DN0/RMg4boJ
         +zwGbeptdlzWi/H36tWHlNmF9E07e9/VSDnmdDCJlYGjENOkYTXiw7oX8KiUKTJQwk4G
         UKWfwVnBXNobUSxLhLGsj0U5RfmYNf5e6OsUWjF83ddBY2wY5pH/dxPwACurMjZZ0tNa
         7LJY+hy5kIG67nRz1Z+ifz5qNrO8MYRQiVoFFETzHSByup6l+RZDD+GmDu9JbUTGt/jd
         vX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ze9TPY5BXRPK/D7NXpXYkdnFpW0fDfd9X/m3jAh/VQ=;
        b=hFz1An6MTLI14FHGb7xnkb9pF9EQqseyk8r+55uXVD9ZS9Jewj7vDBmBDw7bWMAhJB
         ONtx9h3q2rXpZlJjUUsH4CU5InFMdcBQYXTf6/tL2b2rVEHi03bZd6rYMmEh9FNVOYNU
         63TU7QXmgQCz/IhXomtrgiYgfguvtHr3F2mlbztvTWRDdl8+EZrF5g08P4zEq7n0cgXO
         egASEqDxRA8nMBlzs+Q4FvAXhVWvsH7BwyRCJ+M3Ybxd6JxrZNYS4r72F/11fORKgfrA
         tdDacoW+f8kQtuoMEnnV97vy/clpr0A26tVuqnUE1QhyFHrEOsmiEregqS8xXYdJI26I
         7m9A==
X-Gm-Message-State: AOAM5312Y/1Tg9avre+V9HoeZ7O1eduvGgMpcmu4UL1S/FdTfNgsutTj
        msJPI1FA/ESz8qcDgG1PyPh6bulJ2+DgfLvh
X-Google-Smtp-Source: ABdhPJz3K3so/OBx/Xg2VUEqf5re0lFXwtKXGw7ITpwwnVmI+zb83DZy+G2bNx+hD7jCqlGQTK7OHg==
X-Received: by 2002:a37:8c41:: with SMTP id o62mr18290126qkd.240.1604409689345;
        Tue, 03 Nov 2020 05:21:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 67sm10087871qkd.14.2020.11.03.05.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:21:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZwFb-00Fu0w-8m; Tue, 03 Nov 2020 09:21:27 -0400
Date:   Tue, 3 Nov 2020 09:21:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH resend 3/6] mm: Add refcount for preserving mm_struct
 without pgd
Message-ID: <20201103132127.GK36674@ziepe.ca>
References: <20201016230915.1972840-1-jannh@google.com>
 <20201016230915.1972840-4-jannh@google.com>
 <20201016232153.GD37159@ziepe.ca>
 <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
 <CAG48ez0ChA80cjg4-=1k8PfXV_4u_YVQay9g_RdrLjbAzch4Gw@mail.gmail.com>
 <CAG48ez1ue84pXoQvdjqiXZSj5_3+2Wq7A9v9D_7=rzEFac2AFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1ue84pXoQvdjqiXZSj5_3+2Wq7A9v9D_7=rzEFac2AFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 04:19:11AM +0100, Jann Horn wrote:
> On Tue, Nov 3, 2020 at 3:11 AM Jann Horn <jannh@google.com> wrote:
> > On Sat, Oct 17, 2020 at 2:30 AM Jann Horn <jannh@google.com> wrote:
> > > On Sat, Oct 17, 2020 at 1:21 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
> > > > > Currently, mm_struct has two refcounts:
> > > > >
> > > > >  - mm_users: preserves everything - the mm_struct, the page tables, the
> > > > >    memory mappings, and so on
> > > > >  - mm_count: preserves the mm_struct and pgd
> > > > >
> > > > > However, there are three types of users of mm_struct:
> > > > >
> > > > > 1. users that want page tables, memory mappings and so on
> > > > > 2. users that want to preserve the pgd (for lazy TLB)
> > > > > 3. users that just want to keep the mm_struct itself around (e.g. for
> > > > >    mmget_not_zero() or __ptrace_may_access())
> > > > >
> > > > > Dropping mm_count references can be messy because dropping mm_count to
> > > > > zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
> > > > > work from RCU callbacks (which run in IRQ context). In those cases,
> > > > > mmdrop_async() must be used to punt the invocation of __mmdrop() to
> > > > > workqueue context.
> > > > >
> > > > > That's fine when mmdrop_async() is a rare case, but the preceding patch
> > > > > "ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
> > > > > the common case; we should probably avoid punting freeing to workqueue
> > > > > context all the time if we can avoid it?
> > > > >
> > > > > To resolve this, add a third refcount that just protects the mm_struct and
> > > > > the user_ns it points to, and which can be dropped with synchronous freeing
> > > > > from (almost) any context.
> > > > >
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > >  arch/x86/kernel/tboot.c    |  2 ++
> > > > >  drivers/firmware/efi/efi.c |  2 ++
> > > > >  include/linux/mm_types.h   | 13 +++++++++++--
> > > > >  include/linux/sched/mm.h   | 13 +++++++++++++
> > > > >  kernel/fork.c              | 14 ++++++++++----
> > > > >  mm/init-mm.c               |  2 ++
> > > > >  6 files changed, 40 insertions(+), 6 deletions(-)
> > > >
> > > > I think mmu notifiers and the stuff in drivers/infiniband/core/ can be
> > > > converted to this as well..
> > > >
> > > > Actually I kind of wonder if you should go the reverse and find the
> > > > few callers that care about the pgd and give them a new api with a
> > > > better name (mmget_pgd?).
> > >
> > > Yeah, that might make more sense... as long as I'm really sure about
> > > all the places I haven't changed. ^^
> > >
> > > I'll try to change it as you suggested for v2.
> >
> > Actually, no - I think it ends up being around 30 mentions of the
> > "take reference without PGD" function and around 35 mentions of the
> > "take reference with PGD" function (assuming that all the weird
> > powerpc stuff I don't understand needs the mm_context to not yet be
> > destroyed). (A decent chunk of which are all the per-arch functions
> > for starting secondary processors.) So I don't think doing it the way
> > you suggested would really make the patch(es) smaller.
> >
> > And I think that it is helpful for review purposes to have separate
> > patches for every converted site, and leave things as-is by default.
> > If the semantics change for every user that is *not* touched by the
> > patch, that makes it really easy for mistakes to slip through.
> >
> > I could try to convert more callers though?
> 
> But really, I would be happiest if I could just leave all the callers
> where both refcounts work as-is, and let people more familiar with the
> subsystems switch them over when that actually becomes necessary. Is
> that not acceptable?

Either way can work, I liked the suggestion because it suggests an
good name for the ref: 'mmget_pgd' or somesuch

What I don't like is how nonsensical the names here are becoming:
mmget/mmgrab/mm_ref

Gives no impression at the callsite what is right/wrong

Names like this:
 mmget_struct
 mmget_pgd
 mmget_tables

Make alot more sense to me..

I think this patch needs to do something about the naming..

Jason
