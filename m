Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6B290FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436616AbgJQGBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408610AbgJQGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA22C0613E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:31:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a4so4491608lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/sWR0p47UgoK2TmBJzUx19LTEORlnSt46iQ0/xyDHM=;
        b=Wms7rawWGB5oFn62QEGz5lHNH5vau7bERBTG0DfIGC0CQiOOnA1nF6JZv024zY8YAk
         gp7mdJKaO1C+fL6yC/VGAuS73YRv9qfMhYIS8Bl7RGo3NalqQo6hTvQ1DnPx3Slkc78T
         GPDX6K2cIoGP7/Gkg1+AyTqS0ou52X3L0o0IiJLbtaixvXuGePl3iVouOtsi1Fujg6Kt
         dXbpYbknvZdKWy/zC0Vbcz6fHYFLkINOR7Ar+6C9TeWDQs2449ANdjebMmVtT3svG/FH
         IrlE/asC9rLGL3QReOuPYHe7aeNDyqFEycMjVHLXpwr+uvgXI8+PJqq5di50eUe8c2WJ
         A8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/sWR0p47UgoK2TmBJzUx19LTEORlnSt46iQ0/xyDHM=;
        b=DmkPkYJ3aJhCqKPjY2KJdrf4t3AMEon2ZeaOl2bIjHNamnZSff5P/MssbTRKOlg2le
         Kd6aHv2e7fA2PWDt2D0Twwfw6uCvgdBvk65uvz7c7flU+CxjxevIVHrypEUFzk/PFZB6
         ++gXbxnj3oHoy2g/tNavyFyLfdWpK1ogPhBgGq78wWWKGcfUQ5TEi6Lz6Vf8Gbe5VV7C
         x+8lCDLTWSfHlJeKDZUDGHbmTu7R5fUARHIESNLP8LOfEvOMUX0aqWwlACq2VAUoMGVo
         wKPBcPu3rilzcOnmtpvHyWEhlB4wlebKaJRgceMBlHxh3ig3TLYjL1MhtDDWdU08pZvV
         Ya2g==
X-Gm-Message-State: AOAM5318aCxr6fUs7+Dot7b8Ti9oaUFQTqLGcBVsA+diW8DDsQYvba6u
        ZsW+ZiBCJ5D+WE4sI2NQeHnFgauFOdY/7fbs+rrCww==
X-Google-Smtp-Source: ABdhPJxvWObDbaGlbNeOfB1Hq3JUfCEnfa4GhlzqTJ1PqHavxyEGEYGzTXmQhgo+T/BNlQzDMc+mwaR6D9Tlj15eXIE=
X-Received: by 2002:a2e:504b:: with SMTP id v11mr2406934ljd.138.1602894659512;
 Fri, 16 Oct 2020 17:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201016230915.1972840-1-jannh@google.com> <20201016230915.1972840-4-jannh@google.com>
 <20201016232153.GD37159@ziepe.ca>
In-Reply-To: <20201016232153.GD37159@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 02:30:31 +0200
Message-ID: <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
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

On Sat, Oct 17, 2020 at 1:21 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
> > Currently, mm_struct has two refcounts:
> >
> >  - mm_users: preserves everything - the mm_struct, the page tables, the
> >    memory mappings, and so on
> >  - mm_count: preserves the mm_struct and pgd
> >
> > However, there are three types of users of mm_struct:
> >
> > 1. users that want page tables, memory mappings and so on
> > 2. users that want to preserve the pgd (for lazy TLB)
> > 3. users that just want to keep the mm_struct itself around (e.g. for
> >    mmget_not_zero() or __ptrace_may_access())
> >
> > Dropping mm_count references can be messy because dropping mm_count to
> > zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
> > work from RCU callbacks (which run in IRQ context). In those cases,
> > mmdrop_async() must be used to punt the invocation of __mmdrop() to
> > workqueue context.
> >
> > That's fine when mmdrop_async() is a rare case, but the preceding patch
> > "ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
> > the common case; we should probably avoid punting freeing to workqueue
> > context all the time if we can avoid it?
> >
> > To resolve this, add a third refcount that just protects the mm_struct and
> > the user_ns it points to, and which can be dropped with synchronous freeing
> > from (almost) any context.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/kernel/tboot.c    |  2 ++
> >  drivers/firmware/efi/efi.c |  2 ++
> >  include/linux/mm_types.h   | 13 +++++++++++--
> >  include/linux/sched/mm.h   | 13 +++++++++++++
> >  kernel/fork.c              | 14 ++++++++++----
> >  mm/init-mm.c               |  2 ++
> >  6 files changed, 40 insertions(+), 6 deletions(-)
>
> I think mmu notifiers and the stuff in drivers/infiniband/core/ can be
> converted to this as well..
>
> Actually I kind of wonder if you should go the reverse and find the
> few callers that care about the pgd and give them a new api with a
> better name (mmget_pgd?).

Yeah, that might make more sense... as long as I'm really sure about
all the places I haven't changed. ^^

I'll try to change it as you suggested for v2.
