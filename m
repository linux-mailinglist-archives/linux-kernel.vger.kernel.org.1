Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053182EE80F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbhAGWBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:01:35 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414FC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:00:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so18274473lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yW+3vajLGH+6lau4Q23t7xOzJcMOieZX8ybzR0BAfk=;
        b=Ier3MNYKecyOt6NN3c4HC+zbSyJNg5S/LMzTJRu9UzjfRfd4yCgJJajS1vHgj/pDZM
         duBpzqUn+N0s2xULB/3TJqG0SEFi4UIGolIVBAEOY5Uu5Yvl8eZwCESToBDTsyCUBfok
         eXLpLnkORwHroIjZ/lNheQln8l8l4nBN2sj8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yW+3vajLGH+6lau4Q23t7xOzJcMOieZX8ybzR0BAfk=;
        b=fYhgZdzF+4q7UhB+pkArKI0+hngxuwhOC6R22dVprXh9ESMJHEqEJuCohobu54hGus
         MccH+AiFiKi82fZJmymfA8vtqlACLbeaItwCQkkr1n9O2lnSJ3zv0Wz0kGcNoTfcYUL/
         KR/DMO1wnNrF3kTMjZnvtvqovfSqnwoXmu7KzHdmu1sRyxnMZF6AKIdN/cw/jSE+2wyk
         sxr0eTkBQCVyhc0UEEJOfn+jKSAEZodaUS5qkR3adDEGL6n9Rr8OxAV2IQ9wcpPcQDCw
         mwiSoQKeWBD8EYUaLn63JhdCxXpZ7T7qFGCwoHCRtkupINrDbpGlIN34M8Fgdt1Tkoo5
         2m/A==
X-Gm-Message-State: AOAM533FN2vQPrvWHKrW4K0ktVtDFwvegYKyPeltbZsqPiy8ysnJhJ4x
        F2UOvtspsvD4i/8ABb5tNl4+rS3CvMhaLg==
X-Google-Smtp-Source: ABdhPJyYGJ21VvIodxsPyWyDEvILbb7YZRuw9ZZ3dEMgi89atndVP4uiKn8Ix/vVv5DASZBu/VRH/g==
X-Received: by 2002:a05:651c:200a:: with SMTP id s10mr200482ljo.492.1610056852941;
        Thu, 07 Jan 2021 14:00:52 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h21sm1581749lji.89.2021.01.07.14.00.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:00:52 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id m12so18217567lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:00:51 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr213194ljc.411.1610056851206;
 Thu, 07 Jan 2021 14:00:51 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
In-Reply-To: <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:00:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
Message-ID: <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 1:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> >
> > Now, I do agree that from a QoI standpoint, it would be really lovely
> > if we actually enforced it. I'm not entirely sure we can, but maybe it
> > would be reasonable to use that
> >
> >    mm->has_pinned && page_maybe_dma_pinned(page)
> >
> > at least as the beginning of a heuristic.
> >
> > In fact, I do think that "page_maybe_dma_pinned()" could possibly be
> > made stronger than it is. Because at *THAT* point, we might say "we
>
> What exactly did you have in mind, to make it stronger? I think the
> answer is in this email but I don't quite see it yet...

Literally just adding a " && page_mapcount(page) == 1" in there
(probably best done inside page_maybe_dma_pinned() itself)

> Direct IO pins, on the other hand, are more transient. We can probably live
> without tagging Direct IO pages as FOLL_PIN. I think.

Yes. I think direct-IO writes should be able to just do a transient
GUP, and if it causes a COW fault that isn't coherent, that's the
correct semantics, I think (ie the direct-IO will see the original
data, the COW faulter will get it's own private copy to make changes
to).

I think pinning should be primarily limited to things that _require_
coherency (ie you pin because you're going to do some active two-way
communication using that page)

Does that match your thinking?

               Linus
