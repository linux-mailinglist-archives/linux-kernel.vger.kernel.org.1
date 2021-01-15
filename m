Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386192F8493
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbhAOSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732398AbhAOSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:38:04 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD261C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:37:23 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id f26so12640495qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q7tCZQob84PlN0gr0WSG12HEYI0WkF/OexcDulBQmLw=;
        b=A8qOWyQF85wa27E/deNxh/RtIOo5o1gZqNmr8yL+bFbBBgTA6Q1m/1N6q6DieMIuGU
         10taXyzkthKSA8e/Ci52/9mD+66H8LC+/sUBj+a/rEBwxZg040T6kKd+CgXqWhN8YiUe
         Q11ebc2NvxglAu/Z/8ssZA+isogvUraI0r6ZxRfcYT7yJTiSAdM9I7UCX7tfd5v31uy9
         0FI3nrpjbYdCURh3hUYue6sNuTcYfARWckqcsXsycnPAblStwNBocNpjIlrDW6sbkiuJ
         Xuv9q8+jkinVqH/+R0uMwh4mx2OVWR5RCCCmQ+Y7d6L6rsmEOzrB1PrP2Ni87F7dslHm
         1PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7tCZQob84PlN0gr0WSG12HEYI0WkF/OexcDulBQmLw=;
        b=tQmfAfj0OmCT10qT8/wveAu+DtKk3eYrvIBzsaNpqQ6M7lLQdGuVQhy/O766ap0JEx
         h03lLk3C4cvmMQHCvUDID3FpRjNmBaNRcAKumlFD+7O5l7xb47lf+rpPfGTQF1i5X86i
         y5iqKd6afzZrMW5THSHGb2GygowZ+I3srtqm+6u0TVDlWJh8cxJ0kRZeXal9l+s0BpOC
         BQL5mKuBKZcOdyx7Scr89sAXCfSjV9JpRhlTyxRqm4w2ljO9hTQTtLEH2qYnbSJxKkcS
         nsyA18u4LBY8x+RWTRrPJpUW/nI9rbnp0rMALNGv6PRCAUwoHnxgR/BQ32okrjOAq+9r
         +Ulg==
X-Gm-Message-State: AOAM532MuUaIEvxOMrne0pRwiH397vym+1xgRINy9/Dzhew9BbjtJBQ3
        dJikIn8/kWmNksXIG3CvSjGEXA==
X-Google-Smtp-Source: ABdhPJw8Bob4NuKRlGpLhtXJN83Ugnlg7e+FFcs7INhdL7ZsQpqfY1WqttKjTaaosyyIfs6CELP7Pg==
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr13468640qkv.435.1610735843024;
        Fri, 15 Jan 2021 10:37:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id i3sm5467107qkd.119.2021.01.15.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:37:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l0TyL-001hpB-Dx; Fri, 15 Jan 2021 14:37:21 -0400
Date:   Fri, 15 Jan 2021 14:37:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210115183721.GG4605@ziepe.ca>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 09:59:23AM +0100, David Hildenbrand wrote:

> AFAIU, a more extreme case is probably VFIO: A VM with VFIO (e.g.,
> passthrough of a PCI device) can essentially be corrupted by "echo 4 >
> /proc/[pid]/clear_refs".

I've been told when doing migration with RDMA the VM's memory also
ends up pinned, and then it does the stuff of #4. So it deliberately
does clear_refs(4) on RDMA pinned memory and requires no COW. This is
now a real world uABI break, unfortunately.

> 7) There is no easy way to detect if a page really was pinned: we might
> have false positives. Further, there is no way to distinguish if it was
> pinned with FOLL_WRITE or not (R vs R/W). To perform reliable tracking
> we most probably would need more counters, which we cannot fit into
> struct page. (AFAIU, for huge pages it's easier).

I think this is the real issue. We can only store so much information,
so we have to decide which things work and which things are broken. So
far someone hasn't presented a way to record everything at least..
 
> However, AFAIU, even being able to detect if (and how) a page was pinned
> would not completely help to solve the puzzle.

At least for COW reuuse, uf we assign labels to every page user, and
imagine we can track everything, I think we get this list:
 - # of ptes referencing the page (mapcount?)
 - # of page * pointer references that don't touch data 
   (ie the speculative page cache ref)
 - # of DMA/CPU readers
 - # of DMA/CPU writers
 - # of long term data accesses
 - # of other reader/writers (specifically process incoherent reader/writers,
   not "DMA with the CPU" like vmsplice/iouring)

Maybe there are more? This is what I've understood so far from
this thread?

Today's kernel makes the COW reuse decision as:

  # ptes == 1 &&
    # refs == 0 &&
    # DMA readers == 0 &&
    # DMA writers == 0 &&
    # of longterm == 0 &&
    # other reader/writers == 0

(in essence this is what _refcount == 1 is saying, I think)

From a GUP perspective I think the useful property is "a physical page
under GUP is not indirectly removed from the mm_struct that pinned
it". This is the idea that the process CPU page table and the ongoing
DMA remain synchronized. This is a generalized statement from the
clear_refs(4) and fork() regressions.

Therefore, COW should not copy a page just because it is under GUP, it
breaks the idea directly.

We've also said speculative #refs should not cause COW. Removing both
of those gets us to the COW reuse decision as:

  # ptes == 1 &&
    # other reader/writers == 0

And I think where Linus is coming from is '# ptes' (eg mapcount) alone
is not right because there are other relavent reader/writers too. (I'm
not sure what these are, has someone pointed at one?)

So, we have 64 bits for _refcount and _mapcount and we currently encode
things as:

 - # ptes                    (_mapcount)
 - # page pointers +         (low bits of _refcount)
   # DMA reader + writers +
   # other reader/writers +
   # ptes        # We incr both _mapcount and_refcount?
 - # long term data acesses  (high bits of _refcount

If we move '# other reader/writers' to _mapcount (maybe with a shift),
does it help?

We also talked about GUP as meaning wrprotect == 0, but we could also
change that to the idea that GUP means COW will always re-use, eg
'#ptes == 1 && # other reader/writers == 0'.

This gives some definition what mprotect(PROT_READ) means to pages
under DMA (though I still think PROT_READ of pages under DMA write is
weird)

> 8) We have a vmsplice security issue that has to be fixed by touching
> the code in question. A forked child process can read memory content of
> its parent, which was modified by the parent after fork. AFAIU, the fix
> will further lock us in into the direction of the code we are heading.

No, vmsplice is just wrong. vmsplice has to do
FOLL_LONGTERM|FOLL_FORCE|FOLL_WRITE for read only access to pages if
userspace controls the duration of the pin.

There are other bad bugs, like permanently locking
DAX/CMA/ZONE_MIGRATE memory if the above pattern is not used.

There was some debate over alternatives, but for a backport security
fix it has to be above. AFAIK.

Jason
