Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125CA2C6E01
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 01:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgK1Aqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730991AbgK1AeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 19:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606523626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFfdlT9oNUwho2w5XQHB2zyqSSAHo4d/LdFWl9C4gCA=;
        b=YsXt0CXwQ1CHO72X73KBCShx4OYl15OWyrrKkt0JbcXIgUBnrXF+3njlsvWhG5z1JhJ9d1
        a051cdOZM9Ir9lHjDZvCw7Ty3npyS9bje6zCDCSBdxDcOnqtjtPci3+WjKgULVH+y4kOYA
        nSyN5ChLTSxPIGbmzxnmYfEexW7J6Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Kqd8r88RMNacv7rPCQ94aA-1; Fri, 27 Nov 2020 19:33:45 -0500
X-MC-Unique: Kqd8r88RMNacv7rPCQ94aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7607F10059A2;
        Sat, 28 Nov 2020 00:33:43 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D5A96085D;
        Sat, 28 Nov 2020 00:33:40 +0000 (UTC)
Date:   Fri, 27 Nov 2020 19:33:39 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <X8Ga44uXHmzn/vB9@redhat.com>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127122224.GX4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127122224.GX4327@casper.infradead.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 27, 2020 at 12:22:24PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> > For wr-protected mode uffds, errornously fault in those pages around could lead
> > to threads accessing the pages without uffd server's awareness.  For example,
> > when punching holes on uffd-wp registered shmem regions, we'll first try to
> > unmap all the pages before evicting the page cache but without locking the
> > page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> > before shmem_truncate_range()).  When fault-around happens near a hole being
> > punched, we might errornously fault in the "holes" right before it will be
> > punched.  Then there's a small window before the page cache was finally
> > dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> > information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> > page can be writable within the small window).  That's severe data loss.
> 
> Sounds like you have a missing page_mkwrite implementation.

If the real fault happened through the pagetable (which got dropped by
the hole punching), a "missing type" userfault would be delivered to
userland (because the pte would be none). Userland would invoke
UFFDIO_COPY with the UFFDIO_COPY_MODE_WP flag. Such flag would then
map the filled shmem page (not necessarily all zero and not
necessarily the old content before the hole punch) with _PAGE_RW not
set and _PAGE_UFFD_WP set, so the next write would also trigger a
wrprotect userfault (this is what the uffd-wp app expects).

filemap_map_pages doesn't notify userland when it fills a pte and it
will map again the page read-write.

However filemap_map_pages isn't capable to fill a hole and to undo the
hole punch, all it can do are minor faults to re-fill the ptes from a
not-yet-truncated inode page.

Now it would be ok if filemap_map_pages re-filled the ptes, after they
were zapped the first time by fallocate, and then the fallocate would
zap them again before truncating the page, but I don't see a second
pte zap... there's just the below single call of unmap_mapping_range:

		if ((u64)unmap_end > (u64)unmap_start)
			unmap_mapping_range(mapping, unmap_start,
					    1 + unmap_end - unmap_start, 0);
		shmem_truncate_range(inode, offset, offset + len - 1);

So looking at filemap_map_pages in shmem, I'm really wondering if the
non-uffd case is correct or not.

Do we end up with ptes pointing to non pagecache, so then the virtual
mapping is out of sync also with read/write syscalls that will then
allocate another shmem page out of sync of the ptes?

If a real page fault happened instead of filemap_map_pages, the
shmem_fault() would block during fallocate punch hole by checking
inode->i_private, as the comment says:

	 * So refrain from
	 * faulting pages into the hole while it's being punched.

It's not immediately clear where filemap_map_pages refrains from
faulting pages into the hole while it's being punched... given it's
ignoring inode->i_private.

So I'm not exactly sure how shmem can safely faulted in through
filemap_map_pages, without going through shmem_fault... I suppose
shmem simply is unsafe to use filemap_map_pages and it'd require
a specific shmem_map_pages?

If only filemap_map_pages was refraining re-faulting ptes of a shmem
page that is about to be truncated (whose original ptes had _PAGE_RW
unset and _PAGE_UFFD_WP set) there would be no problem with the uffd
interaction. So a proper shmem_map_pages could co-exist with uffd, the
userfaultfd_armed check would be only an optimization but it wouldn't
be required to avoid userland memory corruption?

From 8c6fb1b7dde309f0c8b5666a8e13557ae46369b4 Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Fri, 27 Nov 2020 19:12:44 -0500
Subject: [PATCH 1/1] shmem: stop faulting in pages without checking
 inode->i_private

Per shmem_fault comment shmem need to "refrain from faulting pages
into the hole while it's being punched" and to do so it must check
inode->i_private, which filemap_map_pages won't so it's unsafe to use
in shmem because it can leave ptes pointing to non-pagecache pages in
shmem backed vmas.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8e2b35ba93ad..f6f29b3e67c6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3942,7 +3942,6 @@ static const struct super_operations shmem_ops = {
 
 static const struct vm_operations_struct shmem_vm_ops = {
 	.fault		= shmem_fault,
-	.map_pages	= filemap_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,


Thanks,
Andrea

