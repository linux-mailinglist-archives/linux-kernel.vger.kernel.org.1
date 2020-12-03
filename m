Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7312CDDDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgLCSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgLCSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607020502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJUw/pr4nf2NM2FpsqPAixF+QB/rQYSePgBJ4oHqJXc=;
        b=S0ZeWodFgwP5KKM7XcWYRUySeXJtERAQrbG0FSLeO/aTtnWbPGJWI0Zs6HT2qgC5Q/mZA9
        e32j0ce0J5pq2Fd9CXhCkd0JZBnsiRuSMJtFM4DVCgmd70Mr9DYw3Cy6Wz/ZPpOz4TQ+VT
        P3QMeL7zqIEWOzFe/rMDHxRXGoMclf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-JJKstRQZO3ivnDBBixqMBA-1; Thu, 03 Dec 2020 13:34:58 -0500
X-MC-Unique: JJKstRQZO3ivnDBBixqMBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B874AFA81;
        Thu,  3 Dec 2020 18:34:56 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A33395D6BA;
        Thu,  3 Dec 2020 18:34:52 +0000 (UTC)
Date:   Thu, 3 Dec 2020 13:34:52 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: refactor initialization of stuct page for holes in
 memory layout
Message-ID: <X8kvzEEul+gV5Uru@redhat.com>
References: <20201201181502.2340-1-rppt@kernel.org>
 <20201202154736.5799e01b4c27a75b98e863fc@linux-foundation.org>
 <20201203062549.GG751215@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203062549.GG751215@kernel.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 03, 2020 at 08:25:49AM +0200, Mike Rapoport wrote:
> On Wed, Dec 02, 2020 at 03:47:36PM -0800, Andrew Morton wrote:
> > On Tue,  1 Dec 2020 20:15:02 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > There could be struct pages that are not backed by actual physical memory.
> > > This can happen when the actual memory bank is not a multiple of
> > > SECTION_SIZE or when an architecture does not register memory holes
> > > reserved by the firmware as memblock.memory.
> > > 
> > > Such pages are currently initialized using init_unavailable_mem() function
> > > that iterated through PFNs in holes in memblock.memory and if there is a
> > > struct page corresponding to a PFN, the fields if this page are set to
> > > default values and it is marked as Reserved.
> > > 
> > > init_unavailable_mem() does not take into account zone and node the page
> > > belongs to and sets both zone and node links in struct page to zero.
> > > 
> > > On a system that has firmware reserved holes in a zone above ZONE_DMA, for
> > > instance in a configuration below:
> > > 
> > > 	# grep -A1 E820 /proc/iomem
> > > 	7a17b000-7a216fff : Unknown E820 type
> > > 	7a217000-7bffffff : System RAM
> > > 
> > > unset zone link in struct page will trigger
> > > 
> > > 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> > 
> > That sounds pretty serious.

My understanding is that with DEBUG_VM=n the invariant that broke
won't cause trouble, but Fedora is helping the upstream testing by
keeping DEBUG_VM=y and it's shipping with v5.8 and v5.9 for a while,
so it could very well crash those kernels if they've that type 20
thing in the e820 map.

> > 
> > > because there are pages in both ZONE_DMA32 and ZONE_DMA (unset zone link in
> > > struct page) in the same pageblock.
> > > 
> > > Interleave initialization of pages that correspond to holes with the
> > > initialization of memory map, so that zone and node information will be
> > > properly set on such pages.
> > > 
> > 
> > Should this be backported to -stable?  If so, do we have a suitable Fixes:?
> 
> Sorry, I forgot to add
> 
> Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")

I've been wondering already why I'm the only one getting a crash every
two weeks. Ince it crashed in MADV_HUGEPAGE of qemu that would
definitely happened even with Fedora despite the THP enabled =
madvise, and it hung qemu for good so it was noticeable since it was
in direction compaction.

Other times it was in kcompactd so it just killed the kernel thread
and it was only noticeable in the kernel logs and probably it doesn't
happen that frequently unless THP enabled = always, although it could
still happen, compaction isn't used just for THP.

Thanks,
Andrea

