Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730952748DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIVTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:11:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61897C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:11:19 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so10099556qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJzybE70QTOPMpDnlJVwD/ZPuk6VG/Jsid2ppZBVbg8=;
        b=fSgjqGxhSdA2emNUxN5J3kJsAInQNePdNNyRlh0DibVU1PK6HY+XFWRbK0A+GZ8xd6
         f/f5ds0qAFNBOg/U6Kubc4kxUul6pSup+XlKjeg6JTC8TFPClElz8ajgvmqV0c6nVXJm
         h0GaGzvAK1FAYVnCL5mi7mjykrgni4pNZFgFZP9suG42agx6xnJrNZgG7BIgD2SSGo8y
         JG+UNIjCh9Swt0JMp1rDO6dEczR0DW8MpWYWY/z+hV32QPbbaJW9gyBOzE7bwGU3u/HP
         wvFt40309MaHemZoodAJzlGd9DbvQwOhiAX/7GJRSrJojhwLigngsm4oqW9XcD/Gy3Ne
         bo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJzybE70QTOPMpDnlJVwD/ZPuk6VG/Jsid2ppZBVbg8=;
        b=nd05jviF8v7mahiq237+wuXBPJ1C/h9UtHmAvBhMQiNaXuo6ol9IUmMVjl78mK7b1x
         eEi5W7Y4X2N3PyyBNsKxGuecRAm2SizYt1cqQdrK4mgaRlecxxVj7tjZ293R7SVzq3Pa
         hJ+0IKicX+HVRAMzHAu3FkCVhotgvfEX4SSO0atF9UOfzzglK3PkxkPVSOSD6FANML6l
         dG8anryeYezxcqzSr+Lk3eBfshItQO4o0WjSWg1eywB6IdJFO5ekq9vh8HcXQi9KngMs
         WnWcdBnuXyTZI4RYtKKnerfbYuNTxqToxLtApM7N9Opob5/RKTtPdfVSOV4+PGqGh9D1
         wukA==
X-Gm-Message-State: AOAM533Cq7cWtgRNcozbFGfyTVg+cNRmB69VW0AQRK5OeXAJ7rCnNUIQ
        3dvbieYnwXxWKan/x1V5Lu5B/w==
X-Google-Smtp-Source: ABdhPJxgNsemk9TCKYufv5zWpiXrJqwTy+d9RJH+Ya2JMq9rnWECwJGQxJNp6HGFkTkZ5UY03xNq8w==
X-Received: by 2002:a0c:c492:: with SMTP id u18mr7589580qvi.18.1600801878171;
        Tue, 22 Sep 2020 12:11:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e24sm11954844qka.76.2020.09.22.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:11:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKnh6-003EqE-UY; Tue, 22 Sep 2020 16:11:16 -0300
Date:   Tue, 22 Sep 2020 16:11:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922191116.GK8409@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922175415.GI19098@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:54:15PM -0400, Peter Xu wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f3521be80ca..6591f3f33299 100644
> +++ b/mm/memory.c
> @@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>                  * Because we'll need to release the locks before doing cow,
>                  * pass this work to upper layer.
>                  */
> -               if (READ_ONCE(src_mm->has_pinned) && wp &&
> -                   page_maybe_dma_pinned(page)) {
> +               if (wp && page_maybe_dma_pinned(page) &&
> +                   READ_ONCE(src_mm->has_pinned)) {
>                         /* We've got the page already; we're safe */
>                         data->cow_old_page = page;
>                         data->cow_oldpte = *src_pte;
> 
> I can also add some more comment to emphasize this.

It is not just that, but the ptep_set_wrprotect() has to be done
earlier.

Otherwise it races like:

   pin_user_pages_fast()                   fork()
    atomic_set(has_pinned, 1);
    [..]
                                           atomic_read(page->_refcount) //false
                                           // skipped atomic_read(has_pinned)
    atomic_add(page->_refcount)
    ordered check write protect()
                                           ordered set write protect()

And now have a write protect on a DMA pinned page, which is the
invarient we are trying to create.

The best algorithm I've thought of is something like:

 pte_map_lock()
  if (page) {
      if (wp) {
	  ptep_set_wrprotect()
	  /* Order with try_grab_compound_head(), either we see
	   * page_maybe_dma_pinned(), or they see the wrprotect */
	  get_page();

	  if (page_maybe_dma_pinned() && READ_ONCE(src_mm->has_pinned)) {
	       put_page();
	       ptep_clear_wrprotect()

	       // do copy
	       return
	  }
      } else {
	  get_page();
      }
      page_dup_rmap()
 pte_unmap_lock()

Then the do_wp_page() path would have to detect that the page is not
write protected under the pte lock inside the fault handler and just
do nothing. Ie the set/clear could be visible to the CPU and trigger a
spurious fault, but never trigger a COW.

Thus 'wp' becomes a 'lock' that prevents GUP from returning this page.

Very tricky, deserves a huge comment near the ptep_clear_wrprotect()

Consider the above algorithm beside the gup_fast() algorithm:

		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
			goto pte_unmap;
                [..]
		head = try_grab_compound_head(page, 1, flags);
		if (!head)
			goto pte_unmap;
		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
			put_compound_head(head, 1, flags);
			goto pte_unmap;

That last *ptep will check that the WP is not set after making
page_maybe_dma_pinned() true.

It still looks reasonable, the extra work is still just the additional
atomic in page_maybe_dma_pinned(), just everything else has to be very
carefully sequenced due to unlocked page table accessors.

> I think the WRITE_ONCE/READ_ONCE can actually be kept, because atomic ops
> should contain proper memory barriers already so the memory access orders
> should be guaranteed 

I always have to carefully check ORDERING in
Documentation/atomic_t.txt when asking those questions..

It seems very subtle to me, but yes, try_grab_compound_head() and
page_maybe_dma_pinned() are already paired ordering barriers, so both
the pte_val() on the GUP side and the READ_ONCE(has_pinned) look OK.

Jason
