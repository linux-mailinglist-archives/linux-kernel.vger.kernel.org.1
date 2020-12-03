Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07F12CCF17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgLCG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgLCG0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:26:39 -0500
Date:   Thu, 3 Dec 2020 08:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606976758;
        bh=fG6F0yV3WbLa0cb7k6rq9oA20/ozyUgqvrBOtlDU1Ck=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfwqIdRZwhgbkHv64aE2ZfYC1P7LJZdagDQPvjet5qFdNAkcwqm9aZ4E4ZZoUaGiT
         eyhhz6kkFFkUzIHOexv+V2Det/UAEYMTqYSi4hLzqOwWcgbUOIqnzV4b1d3TQCG2gw
         Wt4N2mMFWU2lD4O1Np0G+sP/QxhQisLa10c5pyUkQHpLtx9hQBud7/qJ2cO17MKrYX
         ZHnyK6vBeb2emMHleGiyDEAdug+3wYEPdS2QnANlj2VwUjEyI81CKPRq7Nfp40hhuz
         KbcPZgneOOoRYMF+aTceHOEJ/rh59wri5D7D+BuxoR4Rdpo3c5XIH02VysDX9c3J16
         P57gUw+KIoy0w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: refactor initialization of stuct page for holes in
 memory layout
Message-ID: <20201203062549.GG751215@kernel.org>
References: <20201201181502.2340-1-rppt@kernel.org>
 <20201202154736.5799e01b4c27a75b98e863fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202154736.5799e01b4c27a75b98e863fc@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 03:47:36PM -0800, Andrew Morton wrote:
> On Tue,  1 Dec 2020 20:15:02 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > There could be struct pages that are not backed by actual physical memory.
> > This can happen when the actual memory bank is not a multiple of
> > SECTION_SIZE or when an architecture does not register memory holes
> > reserved by the firmware as memblock.memory.
> > 
> > Such pages are currently initialized using init_unavailable_mem() function
> > that iterated through PFNs in holes in memblock.memory and if there is a
> > struct page corresponding to a PFN, the fields if this page are set to
> > default values and it is marked as Reserved.
> > 
> > init_unavailable_mem() does not take into account zone and node the page
> > belongs to and sets both zone and node links in struct page to zero.
> > 
> > On a system that has firmware reserved holes in a zone above ZONE_DMA, for
> > instance in a configuration below:
> > 
> > 	# grep -A1 E820 /proc/iomem
> > 	7a17b000-7a216fff : Unknown E820 type
> > 	7a217000-7bffffff : System RAM
> > 
> > unset zone link in struct page will trigger
> > 
> > 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> 
> That sounds pretty serious.
> 
> > because there are pages in both ZONE_DMA32 and ZONE_DMA (unset zone link in
> > struct page) in the same pageblock.
> > 
> > Interleave initialization of pages that correspond to holes with the
> > initialization of memory map, so that zone and node information will be
> > properly set on such pages.
> > 
> 
> Should this be backported to -stable?  If so, do we have a suitable Fixes:?

Sorry, I forgot to add

Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")


-- 
Sincerely yours,
Mike.
