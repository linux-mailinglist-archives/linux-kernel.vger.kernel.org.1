Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92852F04D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 03:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAJCw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 21:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbhAJCwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 21:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610247089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIoIQn4ojBUCPSiaZ09DjloVv1kHMY3eIPXoRrSNrA8=;
        b=LLQHE5axSpO2ezhwdxZ+28WWyCM0oEK6YiOLtwP5mT2VNrS4er/PzvDU3QC5ZWPTR5ox+S
        IIQ8akdwG22wDWKgTMuR4SxfwMO3z7cerZjjrMM3hG2Eod5C2eMmux0Qa0B3t1EsD2p/o7
        +ptUV9GRluYS7YBpZVg8zBEtkg81xBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-bCKjKWr4Mgm76VpykG7jOQ-1; Sat, 09 Jan 2021 21:51:25 -0500
X-MC-Unique: bCKjKWr4Mgm76VpykG7jOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE7D801817;
        Sun, 10 Jan 2021 02:51:21 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEADF5D9D5;
        Sun, 10 Jan 2021 02:51:14 +0000 (UTC)
Date:   Sat, 9 Jan 2021 21:51:14 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <X/prosulFrEoNnoF@redhat.com>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Sat, Jan 09, 2021 at 05:19:51PM -0800, Linus Torvalds wrote:
> +#define is_cow_mapping(flags) (((flags) & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE)
> +
> +static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> +{
> +	struct page *page;
> +
> +	if (!is_cow_mapping(vma->vm_flags))
> +		return false;
> +	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
> +		return false;
> +	page = vm_normal_page(vma, addr, pte);
> +	if (!page)
> +		return false;
> +	if (page_mapcount(page) != 1)
> +		return false;
> +	return page_maybe_dma_pinned(page);
> +}

I just don't see the simplification coming from
09854ba94c6aad7886996bfbee2530b3d8a7f4f4. Instead of checking
page_mapcount above as an optimization, to me it looks much simpler to
check it in a single place, in do_wp_page, that in addition of
optimizing away the superfluous copy, would optimize away the above
complexity as well.

And I won't comment if it's actually safe to skip random pages or
not. All I know is for mprotect and uffd-wp, definitely the above
approach wouldn't work.

In addition I dislike has_pinned and FOLL_PIN.

has_pinned        450 include/linux/mm_types.h 		 * for instance during page table copying for fork().
has_pinned       1021 kernel/fork.c    	atomic64_set(&mm->pinned_vm, 0);
has_pinned       1239 mm/gup.c         		atomic_set(&mm->has_pinned, 1);
has_pinned       2579 mm/gup.c         		atomic_set(&current->mm->has_pinned, 1);
has_pinned       1099 mm/huge_memory.c 		     atomic_read(&src_mm->has_pinned) &&
has_pinned       1213 mm/huge_memory.c 		     atomic_read(&src_mm->has_pinned) &&
has_pinned        819 mm/memory.c      	if (likely(!atomic_read(&src_mm->has_pinned)))

Are we spending 32bit in mm_struct atomic_t just to call atomic_set(1)
on it? Why isn't it a MMF_HAS_PINNED that already can be set
atomically under mmap_read_lock too? There's bit left free there, we
didn't run out yet to justify wasting another 31 bits. I hope I'm
overlooking something.

The existence of FOLL_LONGTERM is good and makes a difference at times
for writeback if it's on a MAP_SHARED, or it makes difference during
GUP to do a page_migrate before taking the pin, but for the whole rest
of the VM it's irrelevant if it's long or short term, so I'm also
concerned from what Jason mentioned about long term pins being treated
differently within the VM. That to me looks fundamentally as flawed as
introducing inaccuracies in do_wp_page, that even ignoring the
performance implications caused by the inaccuracy, simply prevent to
do some useful things.

I obviously agree all common workloads with no GUP pins and no
clear_refs and no uffd, are way more important to be optimal, but I
haven't seen a single benchmark showing the benefit of not taking the
PG_lock before a page copy or any other runtime benefit coming from
page_count in do_wp_page.

To the contrary now I see additional branches in fork and in various
other paths.

The only thing again where I see page_count provides a tangible
benefit, is the vmsplice attack from child to parent, but that has not
been fully fixed and if page_count is added to fix it in all COW
faults, it'll introduce extra inefficiency to the the very common
important workloads, not only to the special GUP/clear_refs/uffd-wp
workloads as your patch above shows.

Thanks,
Andrea

