Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88182C71B5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbgK1VvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729913AbgK1Scc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606588264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGfZka8PHnD4/7sEZdIEHQXZ+bWPmZHPE5/C9A6phNE=;
        b=HXJdCv8GH00eI3GRYodbhyThjEVw5sxOAMRoJbJ2tmVXfmlVxlMN2iNe5g/BCrAFN/HOyT
        hvjBbNVyUZV5tcNwAGlovmfeff0pTMwUPLBmJruPyLey4c6s+azf0ciKi0jVOOweOalG9O
        6SLOGkQC2KvCa1rE/27lIaJW1ZQ7H5o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-XcBU6ZQLOLqsDlWW9oQ_Ew-1; Sat, 28 Nov 2020 10:29:07 -0500
X-MC-Unique: XcBU6ZQLOLqsDlWW9oQ_Ew-1
Received: by mail-qv1-f70.google.com with SMTP id fb9so863280qvb.21
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 07:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGfZka8PHnD4/7sEZdIEHQXZ+bWPmZHPE5/C9A6phNE=;
        b=sdGtGfsFMRTZnckAbLhxf9DEDoLkutuK047Q0TG3ZeRu1h2sZYEM3ROQdevOg+OZuP
         QRV+Xb5o+vI6qo2Ar6OuI0vfwVtL16z4UvAyFCfy78gEGNYlybDktsq7TDJtBU5KVy2s
         W0AKP7YhRzczfrfpASmO95nG+s2ZiYoZn0J3zASugzfzKGWu/FRG21cYu68RQb55fk2w
         81/Z3w5w5sbOGy52iIcLzkhSK0qI+y2wNFcZLEN6ZBQEEm121arsXyh7Yf658rbm2sxu
         OwFiT0I/1iQ3cMcL/7GG3brHU325vflQVGUlVBzcqfj21UiNsgNKp5deFCsjU0gu/Kfs
         acKA==
X-Gm-Message-State: AOAM5320dHpBraBBoarphT2EHwHHRWh9Lut/mOZ8DE5OgYz2vKmX8vuG
        hilkRAfN0/rsMaAhA6+BvX3MsgQbe05AVLhRAcdvJZPQEolXNJcsJmfiQjiqcetK5VWmN0zA2bN
        biME9X5/Fboyxcn/AtAjyRd3A
X-Received: by 2002:a37:480f:: with SMTP id v15mr14458573qka.30.1606577346450;
        Sat, 28 Nov 2020 07:29:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4jHhU5kclGOD32m4Jejkvmj4OtHLwvjVfJKi+O1q7aFAcxD/GZihwEeHTOOwPvxy/pQCSOw==
X-Received: by 2002:a37:480f:: with SMTP id v15mr14458538qka.30.1606577346124;
        Sat, 28 Nov 2020 07:29:06 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id g11sm8961329qkk.72.2020.11.28.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:29:05 -0800 (PST)
Date:   Sat, 28 Nov 2020 10:29:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201128152903.GK6573@xz-x1>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127122224.GX4327@casper.infradead.org>
 <X8Ga44uXHmzn/vB9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8Ga44uXHmzn/vB9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 07:33:39PM -0500, Andrea Arcangeli wrote:
> Hello,

Hi, Andrea!

> 
> On Fri, Nov 27, 2020 at 12:22:24PM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> > > For wr-protected mode uffds, errornously fault in those pages around could lead
> > > to threads accessing the pages without uffd server's awareness.  For example,
> > > when punching holes on uffd-wp registered shmem regions, we'll first try to
> > > unmap all the pages before evicting the page cache but without locking the
> > > page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> > > before shmem_truncate_range()).  When fault-around happens near a hole being
> > > punched, we might errornously fault in the "holes" right before it will be
> > > punched.  Then there's a small window before the page cache was finally
> > > dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> > > information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> > > page can be writable within the small window).  That's severe data loss.
> > 
> > Sounds like you have a missing page_mkwrite implementation.
> 
> If the real fault happened through the pagetable (which got dropped by
> the hole punching), a "missing type" userfault would be delivered to
> userland (because the pte would be none). Userland would invoke
> UFFDIO_COPY with the UFFDIO_COPY_MODE_WP flag. Such flag would then
> map the filled shmem page (not necessarily all zero and not
> necessarily the old content before the hole punch) with _PAGE_RW not
> set and _PAGE_UFFD_WP set, so the next write would also trigger a
> wrprotect userfault (this is what the uffd-wp app expects).
> 
> filemap_map_pages doesn't notify userland when it fills a pte and it
> will map again the page read-write.

Yes.  A trivial supplementary detail is that filemap_map_pages() will only set
it read-only since alloc_set_pte() will only set write bit if it's a write.  In
our case it's read fault-around so without it.  However it'll be quickly marked
as writable as long as the thread quickly writes to it again.

> 
> However filemap_map_pages isn't capable to fill a hole and to undo the
> hole punch, all it can do are minor faults to re-fill the ptes from a
> not-yet-truncated inode page.
> 
> Now it would be ok if filemap_map_pages re-filled the ptes, after they
> were zapped the first time by fallocate, and then the fallocate would
> zap them again before truncating the page, but I don't see a second
> pte zap... there's just the below single call of unmap_mapping_range:
> 
> 		if ((u64)unmap_end > (u64)unmap_start)
> 			unmap_mapping_range(mapping, unmap_start,
> 					    1 + unmap_end - unmap_start, 0);
> 		shmem_truncate_range(inode, offset, offset + len - 1);

IMHO the 2nd pte zap is inside shmem_truncate_range(), where we will call
truncate_inode_page() then onto truncate_cleanup_page().

Since we're at it, some more context: this is actually where I started to
notice the issue, that we'll try to pre-unmap the whole region first before
shmem_truncate_range().  The thing is shmem_truncate_range() will zap the ptes
too, in an even safer way (with page lock held).  So before I came up with the
current patch, I also tried below patch, and it also fixes the data corrupt
issue:

-----8<-----
diff --git a/mm/shmem.c b/mm/shmem.c
index efa19e33e470..b275f401fe1f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2777,7 +2777,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
        inode_lock(inode);
 
        if (mode & FALLOC_FL_PUNCH_HOLE) {
-               struct address_space *mapping = file->f_mapping;
                loff_t unmap_start = round_up(offset, PAGE_SIZE);
                loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
                DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
@@ -2795,9 +2794,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
                inode->i_private = &shmem_falloc;
                spin_unlock(&inode->i_lock);
 
-               if ((u64)unmap_end > (u64)unmap_start)
-                       unmap_mapping_range(mapping, unmap_start,
-                                           1 + unmap_end - unmap_start, 0);
                shmem_truncate_range(inode, offset, offset + len - 1);
                /* No need to unmap again: hole-punching leaves COWed pages */
-----8<-----
 
Above code existed starting from the 1st day of shmem fallocate code, so I was
thinking why we did that.  One reason could be for performance, since this
pre-unmap of explicit unmap_mapping_range() will try to walk the page tables
once rather than walking for every single page, so when the hole is huge it
could benefit us since truncate_cleanup_page() is able to avoid those per-page
walks then because page_mapped() could be more likely to be zero:

	if (page_mapped(page)) {
		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
		unmap_mapping_pages(mapping, page->index, nr, false);
	}

It would be good if Hugh can help confirm whether my understanding is correct,
though..

As a summary, that's why I didn't try to remove the optimization (which fixes
the issue too) but instead I tried to dissable fault around instead for uffd,
which sounds a better thing to do.

> 
> So looking at filemap_map_pages in shmem, I'm really wondering if the
> non-uffd case is correct or not.
> 
> Do we end up with ptes pointing to non pagecache, so then the virtual
> mapping is out of sync also with read/write syscalls that will then
> allocate another shmem page out of sync of the ptes?
> 
> If a real page fault happened instead of filemap_map_pages, the
> shmem_fault() would block during fallocate punch hole by checking
> inode->i_private, as the comment says:
> 
> 	 * So refrain from
> 	 * faulting pages into the hole while it's being punched.
> 
> It's not immediately clear where filemap_map_pages refrains from
> faulting pages into the hole while it's being punched... given it's
> ignoring inode->i_private.
> 
> So I'm not exactly sure how shmem can safely faulted in through
> filemap_map_pages, without going through shmem_fault... I suppose
> shmem simply is unsafe to use filemap_map_pages and it'd require
> a specific shmem_map_pages?
> 
> If only filemap_map_pages was refraining re-faulting ptes of a shmem
> page that is about to be truncated (whose original ptes had _PAGE_RW
> unset and _PAGE_UFFD_WP set) there would be no problem with the uffd
> interaction. So a proper shmem_map_pages could co-exist with uffd, the
> userfaultfd_armed check would be only an optimization but it wouldn't
> be required to avoid userland memory corruption?

So far I still think it's necessary to have this patch or equivilant to avoid
fault-around.

As discussed above, current map_pages of shmem (which is the general
filemap_map_pages) should be safe without uffd as long as we'll remove ptes
correctly, but also with page lock held (that should be exactly what we do
right now in shmem_truncate_range).

But since we have that optimization on pre-unmap, then uffd-wp is not safe any
more, because of the race that this patch tries to avoid.

And if my understanding above is correct, we may still want to keep shmem fault
around logic, however it just may not suitable for uffd-wp, or uffd in general.

Thanks!

> 
> From 8c6fb1b7dde309f0c8b5666a8e13557ae46369b4 Mon Sep 17 00:00:00 2001
> From: Andrea Arcangeli <aarcange@redhat.com>
> Date: Fri, 27 Nov 2020 19:12:44 -0500
> Subject: [PATCH 1/1] shmem: stop faulting in pages without checking
>  inode->i_private
> 
> Per shmem_fault comment shmem need to "refrain from faulting pages
> into the hole while it's being punched" and to do so it must check
> inode->i_private, which filemap_map_pages won't so it's unsafe to use
> in shmem because it can leave ptes pointing to non-pagecache pages in
> shmem backed vmas.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  mm/shmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8e2b35ba93ad..f6f29b3e67c6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3942,7 +3942,6 @@ static const struct super_operations shmem_ops = {
>  
>  static const struct vm_operations_struct shmem_vm_ops = {
>  	.fault		= shmem_fault,
> -	.map_pages	= filemap_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
>  	.get_policy     = shmem_get_policy,
> 
> 
> Thanks,
> Andrea
> 

-- 
Peter Xu

