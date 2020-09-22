Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904F27444D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:31:46 -0400
Received: from verein.lst.de ([213.95.11.211]:44892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIVObp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:31:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C024567373; Tue, 22 Sep 2020 16:31:41 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:31:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Nitin Gupta <ngupta@vflare.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: use vmap in shmem_pin_map
Message-ID: <20200922143141.GA26637@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-4-hch@lst.de> <20200921191157.GX32101@casper.infradead.org> <20200922062249.GA30831@lst.de> <43d10588-2033-038b-14e4-9f41cd622d7b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d10588-2033-038b-14e4-9f41cd622d7b@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:23:59AM +0100, Tvrtko Ursulin wrote:
> If I understood this sub-thread correctly, iterating and freeing the pages 
> via the vmapped ptes, so no need for a
> shmem_read_mapping_page_gfp loop in shmem_unpin_map looks plausible to me.
>
> I did not get the reference to kernel/dma/remap.c though,

What I mean is the code in dma_common_find_pages, which returns the
page array for freeing.

>
> and also not sure 
> how to do the error unwind path in shmem_pin_map at which point the 
> allocated vm area hasn't been fully populated yet. Hand-roll the loop 
> walking vm area struct in there?

Yes.  What I originally did (re-created as I didn't save it) would be
something like this:

---
From 5605e77cda246df6dd7ded99ec22cb3f341ef5d5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Sep 2020 13:54:04 +0200
Subject: drm/i915: use vmap in shmem_pin_map

shmem_pin_map somewhat awkwardly reimplements vmap using
alloc_vm_area and manual pte setup.  The only practical difference
is that alloc_vm_area prefeaults the vmalloc area PTEs, which doesn't
seem to be required here (and could be added to vmap using a flag
if actually required).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gt/shmem_utils.c | 81 +++++++++------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 43c7acbdc79dea..7ec6ba4c1065b2 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -49,80 +49,53 @@ struct file *shmem_create_from_object(struct drm_i915_gem_object *obj)
 	return file;
 }
 
-static size_t shmem_npte(struct file *file)
+static size_t shmem_npages(struct file *file)
 {
 	return file->f_mapping->host->i_size >> PAGE_SHIFT;
 }
 
-static void __shmem_unpin_map(struct file *file, void *ptr, size_t n_pte)
-{
-	unsigned long pfn;
-
-	vunmap(ptr);
-
-	for (pfn = 0; pfn < n_pte; pfn++) {
-		struct page *page;
-
-		page = shmem_read_mapping_page_gfp(file->f_mapping, pfn,
-						   GFP_KERNEL);
-		if (!WARN_ON(IS_ERR(page))) {
-			put_page(page);
-			put_page(page);
-		}
-	}
-}
-
 void *shmem_pin_map(struct file *file)
 {
-	const size_t n_pte = shmem_npte(file);
-	pte_t *stack[32], **ptes, **mem;
-	struct vm_struct *area;
-	unsigned long pfn;
-
-	mem = stack;
-	if (n_pte > ARRAY_SIZE(stack)) {
-		mem = kvmalloc_array(n_pte, sizeof(*mem), GFP_KERNEL);
-		if (!mem)
-			return NULL;
-	}
+	size_t n_pages = shmem_npages(file), i;
+	struct page **pages;
+	void *vaddr;
 
-	area = alloc_vm_area(n_pte << PAGE_SHIFT, mem);
-	if (!area) {
-		if (mem != stack)
-			kvfree(mem);
+	pages = kvmalloc_array(n_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
 		return NULL;
-	}
-
-	ptes = mem;
-	for (pfn = 0; pfn < n_pte; pfn++) {
-		struct page *page;
 
-		page = shmem_read_mapping_page_gfp(file->f_mapping, pfn,
-						   GFP_KERNEL);
-		if (IS_ERR(page))
+	for (i = 0; i < n_pages; i++) {
+		pages[i] = shmem_read_mapping_page_gfp(file->f_mapping, i,
+						       GFP_KERNEL);
+		if (IS_ERR(pages[i]))
 			goto err_page;
-
-		**ptes++ = mk_pte(page,  PAGE_KERNEL);
 	}
 
-	if (mem != stack)
-		kvfree(mem);
-
+	vaddr = vmap(pages, n_pages, 0, PAGE_KERNEL);
+	if (!vaddr)
+		goto err_page;
 	mapping_set_unevictable(file->f_mapping);
-	return area->addr;
-
+	return vaddr;
 err_page:
-	if (mem != stack)
-		kvfree(mem);
-
-	__shmem_unpin_map(file, area->addr, pfn);
+	while (--i >= 0)
+		put_page(pages[i]);
+	kvfree(pages);
 	return NULL;
 }
 
 void shmem_unpin_map(struct file *file, void *ptr)
 {
+	struct vm_struct *area = find_vm_area(ptr);
+	size_t i = shmem_npages(file);
+
+	if (WARN_ON_ONCE(!area || !area->pages))
+		return;
+
 	mapping_clear_unevictable(file->f_mapping);
-	__shmem_unpin_map(file, ptr, shmem_npte(file));
+	for (i = 0; i < shmem_npages(file); i++)
+		put_page(area->pages[i]);
+	kvfree(area->pages);
+	vunmap(ptr);
 }
 
 static int __shmem_rw(struct file *file, loff_t off,
-- 
2.28.0

