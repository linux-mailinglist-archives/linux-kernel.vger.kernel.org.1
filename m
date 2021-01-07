Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85652EE7A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbhAGVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAGVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:30:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B0C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:30:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s26so18000943lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFwN+Sq2XfTerk/A+8SrWgplwXo55fv0jGeOVi5rS8A=;
        b=e4znJYsrF7HpZFiMj84eCu2UTWCl7asCEAgLSU2rZ8eobsfy6Befvf0MgrlbHOyogY
         NwGn2SYwqlGxT+EcquTQf/V5fTvmSJ9thicygv4XU5R5QV0Q6cXVQwi+FiemijIkh+67
         iUrnU8a/sj1R9Mo025blPYO4/4H25kw7YBT0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFwN+Sq2XfTerk/A+8SrWgplwXo55fv0jGeOVi5rS8A=;
        b=kkmTBiS/rTpaU+ZtyGEs0RiJMT2Du1A2nEvBIhahK7xi/vqLGSZ/sV3oyrLBFtUSBd
         F6qOCiIarUHmXJQxgR2mZGEowT6DFR1OZmKhYkK+QK0dujDYkS/KiKFwHuCE95fHsAz7
         WkSpmKmYlfDjLgsus1ibtOCoTuWpB/zA3praFfichG6dvy1rDFX94yRXtLLwWTELVkh8
         khxeZ+sDKx1idG0loX7v76HJ4pPoFAiTQQ0Hm/tCXR8X0sTHyN3jFWvm7qPM9E8WXj8k
         k51+kQd8sRRnNdByWBt7Hd820gPKmB3LU0Rin8K6WZ1hgwDzgO9jT2Q4dsjR5qeZThGh
         /LHQ==
X-Gm-Message-State: AOAM531KUqj1tevMtlhfcK3i14M45O7Q46a+W+EeEtrT62+0FttMq2qS
        NqH1G0q0m3akXFqxgJdNq1LGJmnGVJpXKA==
X-Google-Smtp-Source: ABdhPJw3vdGsQBsDEKBGadqLWMYMItXU8CJk4KiRxDtFWUiPKQe/9BQhcjoFYhW8N6NHRUPDVhYNLg==
X-Received: by 2002:a19:cbd4:: with SMTP id b203mr307233lfg.506.1610055001740;
        Thu, 07 Jan 2021 13:30:01 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x17sm1436396lfg.0.2021.01.07.13.30.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:30:00 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id l11so18143271lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:30:00 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr266319lfl.41.1610054999854;
 Thu, 07 Jan 2021 13:29:59 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com> <X/d2DyLfXZmBIreY@redhat.com>
In-Reply-To: <X/d2DyLfXZmBIreY@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 13:29:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
Message-ID: <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:59 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> The problem is it's not even possible to detect reliably if there's
> really a long term GUP pin because of speculative pagecache lookups.

So none of the normal code _needs_ that any more these days, which is
what I think is so nice. Any pinning will do the COW, and then we have
the logic to make sure it stays writable, and that keeps everything
nicely coherent and is all fairly simple.

And yes, it does mean that if somebody then explicitly write-protects
a page, it may end up being COW'ed after all, but if you first pinned
it, and then started playing with the protections of that page, why
should you be surprised?

So to me, this sounds like a "don't do that then" situation.

Anybody who does page pinning and wants coherency should NOT TOUCH THE
MAPPING IT PINNED.

(And if you do touch it, it's your own fault, and you get to keep both
of the broken pieces)

Now, I do agree that from a QoI standpoint, it would be really lovely
if we actually enforced it. I'm not entirely sure we can, but maybe it
would be reasonable to use that

  mm->has_pinned && page_maybe_dma_pinned(page)

at least as the beginning of a heuristic.

In fact, I do think that "page_maybe_dma_pinned()" could possibly be
made stronger than it is. Because at *THAT* point, we might say "we
know a pinned page always must have a page_mapcount() of 1" - since as
part of pinning it and doing the GUP_PIN, we forced the COW, and then
subsequent fork() operations enforce it too.

So I do think that it might be possible to make that clear_refs code
notice "this page is pinned, I can't mark it WP without the pinning
coherency breaking".

It might not even be hard. But admittedly I'm somewhat handwaving
here, and I might not have thought of some situation.

              Linus
