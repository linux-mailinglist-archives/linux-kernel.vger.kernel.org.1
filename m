Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122402E1A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgLWJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgLWJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:45:43 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D5C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 01:45:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y19so38545522lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGD/IzQ8B854voURxPB+V56vRqmJO6UpGkJrR67WHaw=;
        b=Q/sgS5Hi/obloj/5gsQkvmd2wLqZ6prYhK0W1YOEK2FQvZDEIB/tM9W58WLSQDPHDd
         rgZygccbXO5HlUib555+1dyxTlbXIqg45ICso56K8SBlVGavSYBi8xZPNBtkSGOke1cB
         xgiKQ4BGaiLF563JI063gBUzVI0x6h/e/YM6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGD/IzQ8B854voURxPB+V56vRqmJO6UpGkJrR67WHaw=;
        b=EheHe+F5p6mS/BdHTsMl7QxJv+7gKigN7WaMUcczmpTnLBPKI+GQ5UekK/Lyvse75W
         hdJEc72jXCRuGIKOHLgtFkkbwEYC5Lod/yy2ixxOymLNHECl0rJlH8WBAUlW8X3zOSdU
         Od8pY5uHO6BnKNNAUyXmxnTXDp+aeP+/NN9ZyZntbK6DMeUeqTTbwYZfaPv8Mp9YV4SG
         bN6NewBLssa3Om9GBtclSJ7tjX109et0R4MjZweOLD85m0E8ZLJWhLFjXTcDwUlZ7bfz
         /VM4DPBeQioROsl1sTrywmh23Za+C3rZCNekVnIPvmoBr+Rr700hDj5sE+7IaVOYt/IW
         LtmQ==
X-Gm-Message-State: AOAM532sTIR91Ze+aylvGU8UuDhjjAVaypiDpjoSWH9D7ZKcrI2aOhDj
        NK4rrRUVyaIEiz4krs4iNWXvUVRcPVsLOA==
X-Google-Smtp-Source: ABdhPJzUpe0xErTf0mDXQxeO5pnsH6nyyVNzRQLIA7qSKjpSTO1qVKs1agGxzjjdFH9JoHY3u0o7cw==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr11049486ljp.247.1608716700797;
        Wed, 23 Dec 2020 01:45:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u14sm3110074lfk.108.2020.12.23.01.44.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 01:44:59 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id h22so29162862lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 01:44:59 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr10914984lfc.253.1608716699063;
 Wed, 23 Dec 2020 01:44:59 -0800 (PST)
MIME-Version: 1.0
References: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
 <CALCETrV=8tY7h=aaudWBEn-MJnNkm2wz5qjH49SYqwkjYTpOaA@mail.gmail.com>
 <X+JJqK91plkBVisG@redhat.com> <X+JhwVX3s5mU9ZNx@google.com>
 <X+Js/dFbC5P7C3oO@redhat.com> <X+KDwu1PRQ93E2LK@google.com>
 <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com> <CAHk-=wjG7xx7Gsb=K0DteB1SPcKjus02zY2gFUoxMY5mm7tfsA@mail.gmail.com>
In-Reply-To: <CAHk-=wjG7xx7Gsb=K0DteB1SPcKjus02zY2gFUoxMY5mm7tfsA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Dec 2020 01:44:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNv1GQn+8stK419HAqK0ofkJ1vOR9YSWSNjbW3T5as9A@mail.gmail.com>
Message-ID: <CAHk-=wjNv1GQn+8stK419HAqK0ofkJ1vOR9YSWSNjbW3T5as9A@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The more I look at the mprotect code, the less I like it. We seem to
> be much better about the TLB flushes in other places (looking at
> mremap, for example). The mprotect code seems to be very laissez-faire
> about the TLB flushing.

No, this doesn't help.

> Does adding a TLB flush to before that
>
>         pte_unmap_unlock(pte - 1, ptl);
>
> fix things for you?

It really doesn't fix it. Exactly because - as pointed out earlier -
the actual page *copy* happens outside the pte lock.

So what can happen is:

 - CPU 1 holds the page table lock, while doing the write protect. It
has cleared the writable bit, but hasn't flushed the TLB's yet

 - CPU 2 did *not* have the TLB entry, sees the new read-only state,
takes a COW page fault, and reads the PTE from memory (into
vmf->orig_pte)

 - CPU 2 correctly decides it needs to be a COW, and copies the page contents

 - CPU 3 *does* have a stale TLB (because TLB invalidation hasn't
happened yet), and writes to that page in users apce

 - CPU 1 now does the TLB invalidate, and releases the page table lock

 - CPU 2 gets the page table lock, sees that its PTE matches
vmf->orig_pte, and switches it to be that writable copy of the page.

where the copy happened before CPU 3 had stopped writing to the page.

So the pte lock doesn't actually matter, unless we actually do the
page copy inside of it (on CPU2), in addition to doing the TLB flush
inside of it (on CPU1).

mprotect() is actually safe for two independent reasons: (a) it does
the mmap_sem for writing (so mprotect can't race with the COW logic at
all), and (b) it changes the vma permissions so turning something
read-only actually disables COW anyway, since it won't be a COW, it
will be a SIGSEGV.

So mprotect() is irrelevant, other than the fact that it shares some
code with that "turn it read-only in the page tables".

fork() is a much closer operation, in that it actually triggers that
COW behavior, but fork() takes the mmap_sem for writing, so it avoids
this too.

So it's really just userfaultfd and that kind of ilk that is relevant
here, I think. But that "you need to flush the TLB before releasing
the page table lock" was not true (well, it's true in other
circumstances - just not *here*), and is not part of the solution.

Or rather, if it's part of the solution here, it would have to be
matched with that "page copy needs to be done under the page table
lock too".

              Linus
