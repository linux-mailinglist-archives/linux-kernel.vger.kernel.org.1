Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1152A0BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgJ3QvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:51:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3QvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:51:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F781AFEA;
        Fri, 30 Oct 2020 16:51:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A33481E12F3; Fri, 30 Oct 2020 17:51:05 +0100 (CET)
Date:   Fri, 30 Oct 2020 17:51:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201030165105.GH19757@quack2.suse.cz>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-10-20 11:46:21, Jason Gunthorpe wrote:
> Since commit 70e806e4e645 ("mm: Do early cow for pinned pages during
> fork() for ptes") pages under a FOLL_PIN will not be write protected
> during COW for fork. This means that pages returned from
> pin_user_pages(FOLL_WRITE) should not become write protected while the pin
> is active.
> 
> However, there is a small race where get_user_pages_fast(FOLL_PIN) can
> establish a FOLL_PIN at the same time copy_present_page() is write
> protecting it:
> 
>         CPU 0                             CPU 1
>    get_user_pages_fast()
>     internal_get_user_pages_fast()
>                                        copy_page_range()
>                                          pte_alloc_map_lock()
>                                            copy_present_page()
>                                              atomic_read(has_pinned) == 0
> 					     page_maybe_dma_pinned() == false
>      atomic_set(has_pinned, 1);
>      gup_pgd_range()
>       gup_pte_range()
>        pte_t pte = gup_get_pte(ptep)
>        pte_access_permitted(pte)
>        try_grab_compound_head()
>                                              pte = pte_wrprotect(pte)
> 	                                     set_pte_at();
>                                          pte_unmap_unlock()
>       // GUP now returns with a write protected page
> 
> The first attempt to resolve this by using the write protect caused
> problems (and was missing a barrrier), see commit f3c64eda3e50 ("mm: avoid
> early COW write protect games during fork()")
> 
> Instead wrap copy_p4d_range() with the write side of a seqcount and check
> the read side around gup_pgd_range(). If there is a collision then
> get_user_pages_fast() fails and falls back to slow GUP.
> 
> Slow GUP is safe against this race because copy_page_range() is only
> called while holding the exclusive side of the mmap_lock on the src
> mm_struct.
> 
> Fixes: f3c64eda3e50 ("mm: avoid early COW write protect games during fork()")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Looks good to me. Just one nit below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -446,6 +447,12 @@ struct mm_struct {
>  		 */
>  		atomic_t has_pinned;
>  
> +		/**
> +		 * @write_protect_seq: Odd when any thread is write protecting
> +		 * pages in this mm, for instance during fork().
> +		 */
> +		seqcount_t write_protect_seq;
> +

So this comment isn't quite true. We can be writeprotecting pages due to
many other reasons and not touch write_protect_seq. E.g. for shared
mappings or due to explicit mprotect() calls. So the write_protect_seq
protection has to be about something more than pure write protection. One
requirement certainly is that the VMA has to be is_cow_mapping(). What
about mprotect(2) calls? I guess the application would have only itself to
blame so we don't care?

Anyway my point is just that the comment should tell more what this is
about. I'd even go as far as making it "page table copying during fork in
progress".

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
