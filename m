Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1942CB102
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgLAXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgLAXnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606866142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fYN72Vc1ksEdLS02U8r6R3GAd3TEksP02Cj+AmRSto=;
        b=e5ZJG2pIkiz+Tfr680BR//kqQAwQUC5jFPKx+5QS4mCGM+bXNAeh8nMoF3QgmuDlVU0IsM
        1haRSrQCjJ0uFQS8KU0XedKoAP24xd3rhI6jWbz74lNzJoU2FwQV7vzNMkBU/azKLMLFC5
        IKBJgkjv6jqtwGTG+12O9xQ72rD2x8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-bFkd3oyFNwmOgRFmZbcTTg-1; Tue, 01 Dec 2020 18:42:18 -0500
X-MC-Unique: bFkd3oyFNwmOgRFmZbcTTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC22185E485;
        Tue,  1 Dec 2020 23:42:17 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C95EE5C1B4;
        Tue,  1 Dec 2020 23:42:13 +0000 (UTC)
Date:   Tue, 1 Dec 2020 18:42:13 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <X8bU1eIMdF7rpTkK@redhat.com>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127122224.GX4327@casper.infradead.org>
 <X8Ga44uXHmzn/vB9@redhat.com>
 <20201128152903.GK6573@xz-x1>
 <alpine.LSU.2.11.2012011250070.1582@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012011250070.1582@eggly.anvils>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Tue, Dec 01, 2020 at 01:31:21PM -0800, Hugh Dickins wrote:
> Please don't ever rely on that i_private business for correctness: as

The out of order and lockless "if (inode->i_private)" branch didn't
inspire much confidence in terms of being able to rely on it for
locking correctness indeed.

> more of the comment around "So refrain from" explains, it was added
> to avoid a livelock with the trinity fuzzer, and I'd gladly delete
> it all, if I could ever be confident that enough has changed in the
> intervening years that it's no longer necessary.

I was wondering if it's still needed, so now I checked the old code
and it also did an unconditional lock_page in shmem_fault, so I assume
it's still necessary.

> It tends to prevent shmem faults racing hole punches in the same area
> (without quite guaranteeing no race at all).  But without the livelock
> issue, I'd just have gone on letting them race.  "Punch hole" ==
> "Lose data" - though I can imagine that UFFD would like more control
> over that.  Since map_pages is driven by faulting, it should already
> be throttled too.

Yes I see now it just needs to "eventually" stop the shmem_fault
activity, it doesn't need to catch those faults already in flight, so
it cannot relied upon as the form of serialization to zap the
pageteables while truncating the page.

> But Andrea in next mail goes on to see other issues with UFFD_WP
> in relation to shmem swap, so this thread is probably dead now.
> If there's a bit to spare for UFFD_WP in the anonymous swap entry,
> then that bit should be usable for shmem too: but a shmem page
> (and its swap entry) can be shared between many different users,
> so I don't know whether that will make sense.

An UFFD_WP software bit exists both for the present pte and for the
swap entry:

#define _PAGE_UFFD_WP		(_AT(pteval_t, 1) << _PAGE_BIT_UFFD_WP)
#define _PAGE_SWP_UFFD_WP	_PAGE_USER

It works similarly to soft dirty, if the page is swapped _PAGE_UFFD_WP
it's translated to _PAGE_SWP_UFFD_WP and the other way around during
swapin.

The problem is that the bit represents an information that is specific
to an mm and a single mapping.

If you punch an hole in a shmem, you map the shmem file in two
processes A and B, you register the mapped range in a uffd opened by
process A using VM_UFFD_MISSING, only process A will generate
userfaults if you access the virtual address that corresponds to the
hole in the file, process B will still fill the hole normally and it
won't trigger userfaults in process A.

The uffd context is attached to an mm, and the notification only has
effect on that mm, the mm that created the context. Only the UFFDIO_
operations that resolve the fault (like UFFDIO_COPY) have effect
visible by all file sharers.

So VM_UFFD_WP shall work the same, and the _PAGE_SWP_UFFD_WP
information of a swapped out shmem page shouldn't go in the xarray
because doing so would share it with all "mm" sharing the mapping.

Currently uffd-wp only works on anon memory so this is a new challenge
in extending uffd-wp to shmem it seems.

If any pagetable of an anonymous memory mapping is zapped, then not
just the _PAGE_SWP_UFFD_WP bit is lost, the whole data is lost too so
it'd break not just uffd-wp. As opposed with shmem the ptes can be
zapped at all times by memory pressure alone even before the final
->writepage swap out is invoked.

It's always possible to make uffd-wp work without those bits (anon
memory also would work without those bits), but the reason those bits
exist is to avoid a flood of UFFDIO_WRITEPROTECT ioctl false-negatives
after fork or after swapping (in the anon case). In the shmem case if
we'd it without a bitflag to track which page was wrprotected in which
vma, the uffd handler would be required to mark each pte writable with
a syscall every time a new pte has been established on the range and
there's a write to the page.

One possibility could be to store the bit set by UFFDIO_WRITEPROTECT
in a vmalloc bitmap associated with the shmem vma at uffd registration
time, so it can be checked during the shmem_fault() if VM_UFFD_WP is
set on the vma? The vma_splits and vma_merge would be the hard part.

Another possibility would be to change how the pte invalidate work for
vmas with VM_UFFD_WP set, the pte and the _PAGE_UFFD_WP would need to
survive all invalidates... only the final truncation under page lock
would be really allowed to clear the whole pte and destroy the
_PAGE_UFFD_WP information in the pte and then to free the pgtables on
those ranges.

Once we find a way to make that bit survive the invalidates, we can
check it in shmem_fault to decide if to invoke handle_userfault if the
bit is set and FAULT_FLAG_WRITE is set in vmf->flags, or if to map the
page wrprotected in that vaddr if the bit is set and FAULT_FLAG_WRITE
is not set.

Thanks,
Andrea

