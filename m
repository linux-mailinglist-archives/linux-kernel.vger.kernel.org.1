Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396DC2CDF24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgLCTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbgLCTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607024666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLmcXdoEqTDQRrtxyyPXRoFpt6pYAZupiGwcwJRuqyI=;
        b=HnMIdImJk3GJPHj63qM3CT8erOj0Im6neQbQTB4I/dEFIzw7nhgKSnsDWMAPs6VlKrBBUV
        fXlZjyZ/BrAXuh26t2/aLwm2wDdGvgwpIVTdFGmllqOFvoVUuc+rRYpDEUdHSB6anCcYzk
        nrKBNOaN9RJ1Tme+Od0DO2tCU3YXE9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-oVEVamjZN1KAjXqz73HmhA-1; Thu, 03 Dec 2020 14:44:22 -0500
X-MC-Unique: oVEVamjZN1KAjXqz73HmhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DE9939388;
        Thu,  3 Dec 2020 19:44:21 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2505010013C0;
        Thu,  3 Dec 2020 19:44:15 +0000 (UTC)
Date:   Thu, 3 Dec 2020 14:44:14 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <X8lADgHCRqlQi3Xa@redhat.com>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203180234.GJ108496@xz-x1>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:02:34PM -0500, Peter Xu wrote:
> On Wed, Dec 02, 2020 at 09:36:45PM -0800, Hugh Dickins wrote:
> > On Wed, 2 Dec 2020, Peter Xu wrote:
> > > On Wed, Dec 02, 2020 at 02:37:33PM -0800, Hugh Dickins wrote:
> > > > On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> > > > > 
> > > > > Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> > > > > survive the pte invalidates in a way that remains associated to a
> > > > > certain vaddr in a single mm (so it can shoot itself in the foot if it
> > > > > wants, but it can't interfere with all other mm sharing the shmem
> > > > > file) would be welcome...
> > > > 
> > > > I think it has to be a new variety of swap-like non_swap_entry() pte,
> > > > see include/linux/swapops.h.  Anything else would be more troublesome.

Agreed. Solving it by changing the unmapping of the ptes is also some
trouble but less troublesome than adding new bitmaps to the vma to
handle in vma_merge/vma_split.

> > But those ptes will be pte_present(), so you must provide a pfn,
> 
> Could I ask why?

_PAGE_PROTNONE exists only for one reason, so pte_present returns true
and the page is as good as mapped, the pfn is real and mapped,
everything is up and running fine except _PAGE_PRESENT is not set in
the pte. _PAGE_PROTNONE doesn't unmap the pte, it only triggers faults
on a mapped pte.

When we set _PAGE_PROTNONE and clear _PAGE_PRESENT atomically, nothing
changes at all for all pte_present and all other VM common code,
except now you get page faults.

So numa hinting faults use that and it's a perfect fit for that,
because you just want to change nothing, but still be notified on
access.

Here instead you need to really unmap the page and lose any pfn or
page reference and everything along with it, just one bit need to
survive the unmap: the _PAGE_UFFD_WP bit.

I tend to agree this needs to work more similarly to the migration
entry like Hugh suggested or an entirely new mechanism to keep "vma
specific state" alive, for filebacked mappings that get zapped but
that have still a vma intact.

The vma removal in munmap() syscall, is then the only point where the
pte is only allowed to be cleared for good and only then the pte can
be freed.

Not even MADV_DONTNEED should be allowed to zero out the pte, it can
drop everything but that single bit.

> Meanwhile, this reminded me another option - besides _PAGE_PROTNONE, can we use
> _PAGE_SPECIAL?  That sounds better at least from its naming that it tells it's
> a special page already. We can also leverage existing pte_special() checks here
> and there, then mimic what we do with pte_devmap(), maybe?

That's also for mapped pages VM_PFNMAP or similar I think.

By memory the !pte_present case for filebacked vmas only exists as
migration entry so I think we'll just add a branch to that case so
that it can disambiguate the migration entry from the _PAGE_UFFDP_WP
bit.

So we can reserve one bit in the migration entry that is always
enforced zero when it is a migration entry.

When that bit is set on a non-present page in a filebacked vma, it
will mean _UFFD_PAGE_WP is set for that vaddr in that mm.

Then we need to pass a parameter in all pte zapping operations to tell
if the unmap event is happening because the vma has been truncated, or
if it's happening for any other reason.

If it's happening for any other reasons (page truncate, MADV_DONTNEED,
memory pressure to swap/writepage) we just convert any present pte
with _UFFD_PAGE_WP set, to the non-migration entry non-present pte
with the reserved migration entry bit set.

If the present pte has no _UFFD_PAGE_WP then it'll be zapped as usual
regardless of VM_UFFD_WP in the vma or not.

If the pte zapping is instead invoked because of a vma truncation, and
it means it's the last unmap operation on that vaddr, the pte zap
logic will be told to ignore the _UFFD_PAGE_WP in any present pte so
the ptes will be zeroed out and later freed as needed.

Thanks,
Andrea

