Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3E2F228D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbhAKWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbhAKWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:19:15 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981D5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:18:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id n8so675545ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZZPmaTfycN5TXyDAk9rKbx2zlys0NKK1SueTrJQDAs=;
        b=bTIJUzCrdxQk1QHn4BFCFgsZs0eG+pXn3IDdsP8HnnoYfoAHYXfOqNUspdojwx3AAM
         Uw8dil2edj0p1CvkSRxWuB6HBUUKucloA2hk16Hk6ulj+Q1XTmjpKDHh/lwk8rVxaPrD
         +OMEk0lSgqDKNSTmwNth7bf5NXzC31UWUSFnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZZPmaTfycN5TXyDAk9rKbx2zlys0NKK1SueTrJQDAs=;
        b=m02iNHa66yzaMYKngxxJw6wA2iSN9lWaOUQmzK8ynrn1bIOfWBtpAGujXSG4qhO7ce
         bNPHFF9NqyI51Eg6dFTUg/2IaztTRNpG/FbeFECFPxA83KMuEvx1UukruXjWI9z0h8V/
         yeODl83+1yPYJg0m79wycFypyXQtxjkzMxDyqqNisVq9uIwwI1b5SEyqXRpQV71CD371
         W7Z1C3DOgartzerr1whpxfhw2JtikXANP2T2fvCgsRk/LrNDucTlvLBvhMG1DRFwdvV/
         mhHhJ38aircS8ONktSF7BPxa4QkPTrNP25iZOkoswvmYWJtw1RI2MrZU8iGHGscqr8J7
         +uUg==
X-Gm-Message-State: AOAM533k1vIUpALNuCz2Vu2WRhedyVe15XnctG7OKlBfa2aZvdKOxYTn
        KdhrV5av3KAhkOKaMTZP1KG7eVOSbIJHig==
X-Google-Smtp-Source: ABdhPJz4n+qyQDALgIjeC81FdowMGvDe2oCt7NRPE7NANuK+ZE6+zxBGc9rtLwWLjYpuVF2cf/e3Tg==
X-Received: by 2002:a2e:88c8:: with SMTP id a8mr673237ljk.148.1610403512288;
        Mon, 11 Jan 2021 14:18:32 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 10sm134159lfh.208.2021.01.11.14.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 14:18:31 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id n11so663737lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:18:30 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr652511ljj.465.1610403510200;
 Mon, 11 Jan 2021 14:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com> <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
In-Reply-To: <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 14:18:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
Message-ID: <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jan 10, 2021 at 11:27 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > IMHO, a lot of the bits in page _refcount are still being wasted (even
> > after GUP_PIN_COUNTING_BIAS overloading), because it's unlikely that
> > there are many callers of gup/pup per page.
>
> It may be unlikely under real loads.
>
> But we've actually had overflow issues on this because rather than
> real loads you can do attack loads (ie "lots of processes, lots of
> pipe file descriptors, lots of vmsplice() operations on the same
> page".
>
> We had to literally add that conditional "try_get_page()" that
> protects against overflow..

Actually, what I think might be a better model is to actually
strengthen the rules even more, and get rid of GUP_PIN_COUNTING_BIAS
entirely.

What we could do is just make a few clear rules explicit (most of
which we already basically hold to). Starting from that basic

 (a) Anonymous pages are made writable (ie COW) only when they have a
page_count() of 1

That very simple rule then automatically results in the corollary

 (b) a writable page in a COW mapping always starts out reachable
_only_ from the page tables

and now we could have a couple of really simple new rules:

 (c) we never ever make a writable page in a COW mapping read-only
_unless_ it has a page_count() of 1

 (d) we never create a swap cache page out of a writable COW mapping page

Now, if you combine these rules, the whole need for the
GUP_PIN_COUNTING_BIAS basically goes away.

Why? Because we know that the _only_ thing that can elevate the
refcount of a writable COW page is GUP - we'll just make sure nothing
else touches it.

The whole "optimistic page references throigh page cache" etc are
complete non-issues, because the whole point is that we already know
it's not a page cache page. There is simply no other way to reach that
page than through GUP.

Ergo: any writable pte in a COW mapping that has a page with a
page_count() > 1 is pinned by definition, and thus our

   page_maybe_dma_pinned(page)

could remove that "maybe" part, and simply check for

    page_count(page) > 1

(although the rule would be that this is only valid for a cow_mapping
pte, and only while holding the page table lock! So maybe it would be
good to pass in the vma and have an assert for that lock too).

And the thing is, none of the above rules are complicated.

The only new one would be the requirement that you cannot add a page
to the swap cache unless it is read-only in the page tables. That may
be the biggest hurdle here.

The way we handle swap cache is that we *first* add it to the swap
cache, and then we do a "try_to_unmap()" on it. So we currently don't
actually try to walk the page tables until we have already done that
swap cache thing.

But I do think that the only major problem spot is that
shrink_page_list() -> add_to_swap() case, and I think we could make
add_to_swap() just do the rmap walk and turn it read-only first.

(And it's worth pointing out that I'm only talking about regular
non-huge pages above, the rules for splitting hugepages may impact
those cases differently, I didn't really even try to think about those
cases).

But thatadd_to_swap() case might make it too painful. It _would_
simplify our rules wrt anonymous mappings enormously, though.

               Linus
