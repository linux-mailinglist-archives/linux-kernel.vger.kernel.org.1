Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340332CAB75
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404292AbgLATKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727356AbgLATKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606849725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x27ej+cvhobcDYLClQ426MBIsoY+Wt3KVHORmvWrlOg=;
        b=fHx+FApv0jKhyZWuUysqTK/LkLG8G6D3RwQeSE4Zuz1OsbU5sUpjE9PwLAUiyWZz34hMwH
        la/4cZEmbHQXYMPp/FwR2zbC6XXuQRp9fbUVvH0KbbY1hJ/cJMk0DfumplvexjjukZoZG0
        mh1OGcafZSGPeVg56gKr56hw+19NwNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-KAo5HetdOLaeBg-3NsdpnQ-1; Tue, 01 Dec 2020 14:08:43 -0500
X-MC-Unique: KAo5HetdOLaeBg-3NsdpnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFD62425CB;
        Tue,  1 Dec 2020 19:08:41 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9501460BFA;
        Tue,  1 Dec 2020 19:08:38 +0000 (UTC)
Date:   Tue, 1 Dec 2020 14:08:38 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <X8aUthdJdxhG2TzJ@redhat.com>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127122224.GX4327@casper.infradead.org>
 <X8Ga44uXHmzn/vB9@redhat.com>
 <20201128152903.GK6573@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128152903.GK6573@xz-x1>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Nov 28, 2020 at 10:29:03AM -0500, Peter Xu wrote:
> Yes.  A trivial supplementary detail is that filemap_map_pages() will only set
> it read-only since alloc_set_pte() will only set write bit if it's a write.  In
> our case it's read fault-around so without it.  However it'll be quickly marked
> as writable as long as the thread quickly writes to it again.

The problem here is that all the information injected into the kernel
through the UFFDIO_WRITEPROTECT syscalls is wiped by the quoted
unmap_mapping_range.

We can later discuss we actually check _PAGE_UFFD_WP, but that's not
the first thing to solve here.

Here need to we find a way to retain _PAGE_UFFD_WP until the page is
actually locked and is atomically disappearing from the xarray index
as far as further shmem page faults are concerned.

Adding that information to the xarray isn't ideal because it's mm
specific and not a property of the "pagecache", but keeping that
information in the pagetables as we do for anon memory is also causing
issue as shown below, because the shmem pagetables are supposed to be
zapped at any time and be re-created on the fly based on the
xarray. As opposed this never happens with anon memory.

For example when shmem swap the swap entry is written in the xarray
not in the pagetable, how are we going to let _PAGE_UFFD_WP survive
swapping of a shmem if we store the _PAGE_UFFD_WP in the pte? Did you
test swap?

So here I'm afraid there's something more fundamental in how to have
_PAGE_UFFD_WP survive swapping and a random pte zap, and we need more
infrastructure in the unmap_mapping_range to retain that information
so then swapping also works then.

So I don't think we can evaluate this patch without seeing the full
patchset and how the rest is being handled. Still it's great you found
the source of the corruption for the current shmem uffd-wp codebase so
we can move forward!

> > However filemap_map_pages isn't capable to fill a hole and to undo the
> > hole punch, all it can do are minor faults to re-fill the ptes from a
> > not-yet-truncated inode page.
> > 
> > Now it would be ok if filemap_map_pages re-filled the ptes, after they
> > were zapped the first time by fallocate, and then the fallocate would
> > zap them again before truncating the page, but I don't see a second
> > pte zap... there's just the below single call of unmap_mapping_range:
> > 
> > 		if ((u64)unmap_end > (u64)unmap_start)
> > 			unmap_mapping_range(mapping, unmap_start,
> > 					    1 + unmap_end - unmap_start, 0);
> > 		shmem_truncate_range(inode, offset, offset + len - 1);
> 
> IMHO the 2nd pte zap is inside shmem_truncate_range(), where we will call
> truncate_inode_page() then onto truncate_cleanup_page().

I wrongly assumed there was only one invalidate and I guessed that is what
caused the problem since it run outside the page lock so it wasn't
"atomic" with respect to the page truncation in the xarray.

The comment "refrain from faulting pages into the hole while it's
being punched" and the "inode->i_private waitqueue" logic is just to
slowly throttle the faulting so the truncation is faster. It's still
not entirely clear why it's needed since shmem_getpage_gfp uses
find_lock_entry and the page had to be locked. I didn't look at the
history to see the order of where those changes were added to see if
it's still needed.

Anyway it was already suspect that "unlikely(inode->i_private)" would
be enough as an out of order check to fully serialize things but for a
performance "throttling" logic it's fine and non concerning (worst
case it is not needed and the page lock waitqueue would have
serialized the faults against the slow invalidate loops already).

> Since we're at it, some more context: this is actually where I started to
> notice the issue, that we'll try to pre-unmap the whole region first before
> shmem_truncate_range().  The thing is shmem_truncate_range() will zap the ptes
> too, in an even safer way (with page lock held).  So before I came up with the
> current patch, I also tried below patch, and it also fixes the data corrupt
> issue:
> 
> -----8<-----
> diff --git a/mm/shmem.c b/mm/shmem.c
> index efa19e33e470..b275f401fe1f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2777,7 +2777,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         inode_lock(inode);
>  
>         if (mode & FALLOC_FL_PUNCH_HOLE) {
> -               struct address_space *mapping = file->f_mapping;
>                 loff_t unmap_start = round_up(offset, PAGE_SIZE);
>                 loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
>                 DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
> @@ -2795,9 +2794,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>                 inode->i_private = &shmem_falloc;
>                 spin_unlock(&inode->i_lock);
>  
> -               if ((u64)unmap_end > (u64)unmap_start)
> -                       unmap_mapping_range(mapping, unmap_start,
> -                                           1 + unmap_end - unmap_start, 0);
>                 shmem_truncate_range(inode, offset, offset + len - 1);
>                 /* No need to unmap again: hole-punching leaves COWed pages */
> -----8<-----
>  
> Above code existed starting from the 1st day of shmem fallocate code, so I was
> thinking why we did that.  One reason could be for performance, since this
> pre-unmap of explicit unmap_mapping_range() will try to walk the page tables
> once rather than walking for every single page, so when the hole is huge it
> could benefit us since truncate_cleanup_page() is able to avoid those per-page
> walks then because page_mapped() could be more likely to be zero:
> 
> 	if (page_mapped(page)) {
> 		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
> 		unmap_mapping_pages(mapping, page->index, nr, false);
> 	}
> 
> It would be good if Hugh can help confirm whether my understanding is correct,
> though..
> 
> As a summary, that's why I didn't try to remove the optimization (which fixes
> the issue too) but instead I tried to dissable fault around instead for uffd,
> which sounds a better thing to do.

I'm afraid the real problem is the above invalidate though, and not
the invalidate itself but the fact uffd-wp shmem cannot cope with it
and we need to find a way to have the _PAGE_UFFD_WP information
survive even without applying your above patch.

> So far I still think it's necessary to have this patch or equivilant to avoid
> fault-around.
> 
> As discussed above, current map_pages of shmem (which is the general
> filemap_map_pages) should be safe without uffd as long as we'll remove ptes
> correctly, but also with page lock held (that should be exactly what we do
> right now in shmem_truncate_range).
> 
> But since we have that optimization on pre-unmap, then uffd-wp is not safe any
> more, because of the race that this patch tries to avoid.
> 
> And if my understanding above is correct, we may still want to keep shmem fault
> around logic, however it just may not suitable for uffd-wp, or uffd in general.

Since there's the second invalidate in truncate_inode_page unde the
page lock I agree it means filemap_map_pages is perfectly safe for
shmem.

However it also means filemap_map_pages is a 100% bypass as far as
userfaultfd is concerned. That applies to all modes including missing
faults not just wp faults.

In fact, no matter the workload, given the current semantics of uffd
on filebacked mappings: it's always guaranteed there cannot be even a
single extra userfault, regardless if filemap_map_pages is active or
inactive in shmem, hugetlbfs or any other filesystem.

So it's not intuitive why it shouldn't be suitable for uffd, given its
presence is also completely unnoticeable to userland. Despite what the
faultaround name, it's not a real fault.

If later David send the work to handle minor faults the above will
change (so that the huge final dirty bitmap can be delivered to the
destination node while the guest already runs in the destination),
because the uffd semantics will be extended to cover minor faults. But
the current upstream only trigger userfault on a file hole, so major
faults only, and filemap_map_pages by definition cannot fill a file
hole.

So again it's not clear why we should even care if filemap_map_pages
is active or not, when uffd is armed, no matter if in wp or missing
mode.

More interesting is how to retain the _PAGE_UFFD_WP during swapping
that will get rid of all pagetables too, since that looks a much
wider loss of info, than the above race and it looks the same issue.

I didn't see the full patchset yet, so I cannot tell if you solved
swapping some other way already, but until that is clear, the above
looks a minor concern and whatever solution that works to retain the
_PAGE_UFFD_WP information during shmem swapping should also solve the
above without extra changes to filemap_map_pages and the fault around
logic if the uffd is armed.

What I'm really saying is that there's no point to apply this patch,
until we see the full patchset of shmem uffd-wp and then it's possible
to evaluate if there are no other losses for the _PAGE_UFFD_WP bit.

Anon memory is completely different, it's impossible to lose
_PAGE_UFFD_WP there, since the swap entry format contains it, for
shmem the pte is zero instead during swap.

Thanks!
Andrea

