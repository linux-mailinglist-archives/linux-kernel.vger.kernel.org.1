Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6530240B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAYLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:02:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:52400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbhAYK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:57:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91279ACF4;
        Mon, 25 Jan 2021 10:56:04 +0000 (UTC)
Date:   Mon, 25 Jan 2021 11:56:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210125105557.GA28363@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125103951.GA27851@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:39:55AM +0100, Oscar Salvador wrote:
> > Interresting, so we automatically support differeing sizeof(struct
> > page). I guess it will be problematic in case of sizeof(struct page) !=
> > 64, because then, we might not have multiples of 2MB for the memmap of a
> > memory block.
> > 
> > IIRC, it could happen that if we add two consecutive memory blocks, that
> > the second one might reuse parts of the vmemmap residing on the first
> > memory block. If you remove the first one, you might be in trouble.
> > 
> > E.g., on x86-64
> >  vmemmap_populate()->vmemmap_populate_hugepages()->vmemmap_alloc_block_buf():
> > - Populate a huge page
> > 
> > vmemmap_free()->remove_pagetable()...->remove_pmd_table():
> > - memchr_inv() will leave the hugepage populated.
> > 
> > Do we want to fence that off, maybe in mhp_supports_memmap_on_memory()?
> > Or do we somehow want to fix that? We should never populate partial huge
> > pages from an altmap ...
> > 
> > But maybe I am missing something.
> 
> No, you are not missing anything.
> 
> I think that remove_pmd_table() should be fixed.
> vmemmap_populate_hugepages() allocates PMD_SIZE chunk and marks the PMD as
> PAGE_KERNEL_LARGE, so when remove_pmd_table() sees that 1) the PMD
> is large and 2) the chunk is not aligned, the memset() should be writing
> PAGE_INUSE for a PMD chunk.
> 
> I do not really a see a reason why this should not happen.
> Actually, we will be leaving pagetables behind as we never get to free
> the PMD chunk when sizeof(struct page) is not a multiple of 2MB.
> 
> I plan to fix remove_pmd_table(), but for now let us not allow to use this feature
> if the size of a struct page is not 64.
> Let us keep it simply for the time being, shall we?

My first intention was:

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..0c9756a2eb24 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1044,32 +1044,14 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 			continue;
 
 		if (pmd_large(*pmd)) {
-			if (IS_ALIGNED(addr, PMD_SIZE) &&
-			    IS_ALIGNED(next, PMD_SIZE)) {
-				if (!direct)
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
-
-				spin_lock(&init_mm.page_table_lock);
-				pmd_clear(pmd);
-				spin_unlock(&init_mm.page_table_lock);
-				pages++;
-			} else {
-				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
-
-				page_addr = page_address(pmd_page(*pmd));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
-						PMD_SIZE)) {
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
-
-					spin_lock(&init_mm.page_table_lock);
-					pmd_clear(pmd);
-					spin_unlock(&init_mm.page_table_lock);
-				}
-			}
+			if (!direct)
+				free_hugepage_table(pmd_page(*pmd),
+						    altmap);
 
+			spin_lock(&init_mm.page_table_lock);
+			pmd_clear(pmd);
+			spin_unlock(&init_mm.page_table_lock);
+			pages++;
 			continue;
 		}

I did not try it out yet and this might explode badly, but AFAICS, a PMD size
chunk is always allocated even when the section does not spand 2MB.
E.g: sizeof(struct page) = 56.

PAGES_PER_SECTION * 64 = 2097152
PAGES_PER_SECTION * 56 = 1835008

Even in the latter case, vmemmap_populate_hugepages will allocate a PMD size chunk
to satisfy the unaligned range.
So, unless I am missing something, it should not be a problem to free that 2MB in
remove_pmd_table when 1) the PMD is large and 2) the range is not aligned.


-- 
Oscar Salvador
SUSE L3
