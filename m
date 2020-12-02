Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3D2CB149
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgLBAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgLBAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606867357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOKslSMFXp+gHqdCS6zP2bPZnZtHEzSQ+a3tu6KrYZg=;
        b=hsdQQLTqR5aRl/8Jt1p6eoBAAsVjg99vw74/Wu3K2SqQFCEHzu6+ub0aKDs1z4epGtkX0O
        1ixfXogUSAYFGLphcfiQVhH1x0SjSdqb32SPmCtWAw+SEjdlkKmAggoBxYHg5J5+T90LxN
        9vAmBV92sXGgTBQNVN4QhmkY8n3YtZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-6KZOHBeNMX-OA0eR6iGzTQ-1; Tue, 01 Dec 2020 19:02:35 -0500
X-MC-Unique: 6KZOHBeNMX-OA0eR6iGzTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BB231005E44;
        Wed,  2 Dec 2020 00:02:34 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 355FA60BFA;
        Wed,  2 Dec 2020 00:02:28 +0000 (UTC)
Date:   Tue, 1 Dec 2020 19:02:27 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <X8bZk3jTGU8QyJWc@redhat.com>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223033.GG3277@xz-x1>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:30:33PM -0500, Peter Xu wrote:
> On Tue, Dec 01, 2020 at 12:59:27PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 30, 2020 at 06:06:03PM -0500, Peter Xu wrote:
> > > Faulting around for reads are in most cases helpful for the performance so that
> > > continuous memory accesses may avoid another trip of page fault.  However it
> > > may not always work as expected.
> > > 
> > > For example, userfaultfd registered regions may not be the best candidate for
> > > pre-faults around the reads.
> > > 
> > > For missing mode uffds, fault around does not help because if the page cache
> > > existed, then the page should be there already.  If the page cache is not
> > > there, nothing else we can do, either.  If the fault-around code is destined to
> > > be helpless for userfault-missing vmas, then ideally we can skip it.
> > 
> > This sounds like you're thinking of a file which has exactly one user.
> > If there are multiple processes mapping the same file, then no, there's
> > no reason to expect a page to be already present in the page table,
> > just because it's present in the page cache.
> > 
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
> > This still doesn't make sense.  If the page is Uptodate in the page
> > cache, then userspace gets to access it.  If you don't want the page to
> > be accessible, ClearPageUptodate().  read() can also access it if it's
> > marked Uptodate.  A write fault on a page will call the filesystem's
> > page_mkwrite() and you can block it there.
> 
> I still don't think the page_mkwrite() could help here... Though Andrea pointed

I tend to agree page_mkwrite won't help, there's no I/O, nor dirty
memory pressure, not even VM_FAULT_MISSING can work on real
filesystems yet. The uffd context is associated to certain virtual
addresses in the "mm", read/write syscalls shouldn't notice any
difference, as all other mm shouldn't notice anything either.

It should be enough to check the bit in shmem_fault invoked in ->fault
for this purpose, the problem is we need the bit to survive the invalidate.

> out an more important issue against swap cache (in the v1 thread [1]).  Indeed
> if we have those figured out maybe we'll also rethink this patch then it could
> become optional; while that seems to be required to allow shmem swap in/out
> with uffd-wp which I haven't yet tested.  As Hugh pointed out, purely reuse the
> _PAGE_SWP_UFFD_WP in swap cache may not work trivially since uffd-wp is per-pte
> rather than per-page, so I probably need to think a bit more on how to do
> that...
> 
> I don't know whether a patch like this could still be good in the future.  For
> now, let's drop this patch until we solve all the rest of the puzzle.
>
> My thanks to all the reviewers, and sorry for the noise!

Thanks to you Peter! No noise here, it's great progress to have found
the next piece of the puzzle.

Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
survive the pte invalidates in a way that remains associated to a
certain vaddr in a single mm (so it can shoot itself in the foot if it
wants, but it can't interfere with all other mm sharing the shmem
file) would be welcome...

Andrea

