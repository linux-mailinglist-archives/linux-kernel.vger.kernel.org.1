Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0559D29F16A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgJ2Q1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbgJ2Q1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603988866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4nyzmSBU6tHnfK5QmyUmL2LYzm2qnDBJQErcKljboI=;
        b=Et/y9hTZnw7Qd6XRiebVc17v1ZXge2oju5IJs41cIFEw+ILHcfj5woObwIUcIM0xgJxMVe
        5qUyRJZCu941LfX9h43saIe+1El0nH7Brcmhar01OeQ9r7FEtOuJ+5zMPVH9HJjNbXSkxj
        KGACIJ2qkpSEVSNvJRjM8znngih57rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-CwZU2kroO1Oz81RLU6hCUA-1; Thu, 29 Oct 2020 12:27:42 -0400
X-MC-Unique: CwZU2kroO1Oz81RLU6hCUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE22F80B730;
        Thu, 29 Oct 2020 16:27:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202B65C1C4;
        Thu, 29 Oct 2020 16:27:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 4/4] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
Date:   Thu, 29 Oct 2020 17:27:18 +0100
Message-Id: <20201029162718.29910-5-david@redhat.com>
In-Reply-To: <20201029162718.29910-1-david@redhat.com>
References: <20201029162718.29910-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use alloc_contig_pages() for allocating memory and remove the
linear mapping manually via arch_remove_linear_mapping(). Mark all pages
PG_offline, such that they will definitely not get touched - e.g.,
when hibernating. When freeing memory, try to revert what we did.

The original idea was discussed in:
 https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com

This is similar to CONFIG_DEBUG_PAGEALLOC handling on other
architectures, whereby only single pages are unmapped from the linear
mapping. Let's mimic what memory hot(un)plug would do with the linear
mapping.

We now need MEMORY_HOTPLUG and CONTIG_ALLOC as dependencies.

Simple test under QEMU TCG (10GB RAM, single NUMA node):

sh-5.0# mount -t debugfs none /sys/kernel/debug/
sh-5.0# cat /sys/devices/system/memory/block_size_bytes
40000000
sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
[   71.052836][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000
sh-5.0# echo 0x80000000 > /sys/kernel/debug/powerpc/memtrace/enable
[   75.424302][  T356] radix-mmu: Mapped 0x0000000080000000-0x00000000c0000000 with 64.0 KiB pages
[   75.430549][  T356] memtrace: Freed trace memory back on node 0
[   75.604520][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000
sh-5.0# echo 0x100000000 > /sys/kernel/debug/powerpc/memtrace/enable
[   80.418835][  T356] radix-mmu: Mapped 0x0000000080000000-0x0000000100000000 with 64.0 KiB pages
[   80.430493][  T356] memtrace: Freed trace memory back on node 0
[   80.433882][  T356] memtrace: Failed to allocate trace memory on node 0
sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
[   91.920158][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000

Note 1: We currently won't be allocating from ZONE_MOVABLE - because our
	pages are not movable. However, as we don't run with any memory
	hot(un)plug mechanism around, we could make an exception to
	increase the chance of allocations succeeding.

Note 2: PG_reserved isn't sufficient. E.g., kernel_page_present() used
	along PG_reserved in hibernation code will always return "true"
	on powerpc, resulting in the pages getting touched. It's too
	generic - e.g., indicates boot allocations.

Note 3: For now, we keep using memory_block_size_bytes() as minimum
	granularity. I'm not able to come up with a better guess (most
	probably, doing it on a section basis could be possible).

Suggested-by: Michal Hocko <mhocko@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/Kconfig    |   8 +-
 arch/powerpc/platforms/powernv/memtrace.c | 134 ++++++++--------------
 2 files changed, 49 insertions(+), 93 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 938803eab0ad..619b093a0657 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -27,11 +27,11 @@ config OPAL_PRD
 	  recovery diagnostics on OpenPower machines
 
 config PPC_MEMTRACE
-	bool "Enable removal of RAM from kernel mappings for tracing"
-	depends on PPC_POWERNV && MEMORY_HOTREMOVE
+	bool "Enable runtime allocation of RAM for tracing"
+	depends on PPC_POWERNV && MEMORY_HOTPLUG && CONTIG_ALLOC
 	help
-	  Enabling this option allows for the removal of memory (RAM)
-	  from the kernel mappings to be used for hardware tracing.
+	  Enabling this option allows for runtime allocation of memory (RAM)
+	  for hardware tracing.
 
 config PPC_VAS
 	bool "IBM Virtual Accelerator Switchboard (VAS)"
diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 6828108486f8..8f47797a78c2 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -50,83 +50,50 @@ static const struct file_operations memtrace_fops = {
 	.open	= simple_open,
 };
 
-static int check_memblock_online(struct memory_block *mem, void *arg)
-{
-	if (mem->state != MEM_ONLINE)
-		return -1;
-
-	return 0;
-}
-
-static int change_memblock_state(struct memory_block *mem, void *arg)
-{
-	unsigned long state = (unsigned long)arg;
-
-	mem->state = state;
-
-	return 0;
-}
-
-/* called with device_hotplug_lock held */
-static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
+static u64 memtrace_alloc_node(u32 nid, u64 size)
 {
-	const unsigned long start = PFN_PHYS(start_pfn);
-	const unsigned long size = PFN_PHYS(nr_pages);
+	const unsigned long nr_pages = PHYS_PFN(size);
+	unsigned long pfn, start_pfn;
+	struct page *page;
 
-	if (walk_memory_blocks(start, size, NULL, check_memblock_online))
-		return false;
-
-	walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
-			   change_memblock_state);
-
-	if (offline_pages(start_pfn, nr_pages)) {
-		walk_memory_blocks(start, size, (void *)MEM_ONLINE,
-				   change_memblock_state);
-		return false;
-	}
+	/*
+	 * Trace memory needs to be aligned to the size, which is guaranteed
+	 * by alloc_contig_pages().
+	 */
+	page = alloc_contig_pages(nr_pages, __GFP_THISNODE | __GFP_NOWARN,
+				  nid, NULL);
+	if (!page)
+		return 0;
 
-	walk_memory_blocks(start, size, (void *)MEM_OFFLINE,
-			   change_memblock_state);
+	/*
+	 * Set pages PageOffline(), to indicate that nobody (e.g., hibernation,
+	 * dumping, ...) should be touching these pages.
+	 */
+	start_pfn = page_to_pfn(page);
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++)
+		__SetPageOffline(pfn_to_page(pfn));
 
+	arch_remove_linear_mapping(PFN_PHYS(start_pfn), size);
 
-	return true;
+	return PFN_PHYS(start_pfn);
 }
 
-static u64 memtrace_alloc_node(u32 nid, u64 size)
+static int memtrace_free(int nid, u64 start, u64 size)
 {
-	u64 start_pfn, end_pfn, nr_pages, pfn;
-	u64 base_pfn;
-	u64 bytes = memory_block_size_bytes();
+	struct mhp_params params = { .pgprot = PAGE_KERNEL };
+	const unsigned long nr_pages = PHYS_PFN(size);
+	const unsigned long start_pfn = PHYS_PFN(start);
+	unsigned long pfn;
+	int ret;
 
-	if (!node_spanned_pages(nid))
-		return 0;
+	ret = arch_create_linear_mapping(nid, start, size, &params);
+	if (ret)
+		return ret;
 
-	start_pfn = node_start_pfn(nid);
-	end_pfn = node_end_pfn(nid);
-	nr_pages = size >> PAGE_SHIFT;
-
-	/* Trace memory needs to be aligned to the size */
-	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
-
-	lock_device_hotplug();
-	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
-		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true) {
-			/*
-			 * Remove memory in memory block size chunks so that
-			 * iomem resources are always split to the same size and
-			 * we never try to remove memory that spans two iomem
-			 * resources.
-			 */
-			end_pfn = base_pfn + nr_pages;
-			for (pfn = base_pfn; pfn < end_pfn; pfn += bytes>> PAGE_SHIFT) {
-				__remove_memory(nid, pfn << PAGE_SHIFT, bytes);
-			}
-			unlock_device_hotplug();
-			return base_pfn << PAGE_SHIFT;
-		}
-	}
-	unlock_device_hotplug();
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++)
+		__ClearPageOffline(pfn_to_page(pfn));
 
+	free_contig_range(start_pfn, nr_pages);
 	return 0;
 }
 
@@ -197,16 +164,11 @@ static int memtrace_init_debugfs(void)
 	return ret;
 }
 
-static int online_mem_block(struct memory_block *mem, void *arg)
-{
-	return device_online(&mem->dev);
-}
-
 /*
- * Iterate through the chunks of memory we have removed from the kernel
- * and attempt to add them back to the kernel.
+ * Iterate through the chunks of memory we allocated and attempt to expose
+ * them back to the kernel.
  */
-static int memtrace_online(void)
+static int memtrace_free_regions(void)
 {
 	int i, ret = 0;
 	struct memtrace_entry *ent;
@@ -214,7 +176,7 @@ static int memtrace_online(void)
 	for (i = memtrace_array_nr - 1; i >= 0; i--) {
 		ent = &memtrace_array[i];
 
-		/* We have onlined this chunk previously */
+		/* We have freed this chunk previously */
 		if (ent->nid == NUMA_NO_NODE)
 			continue;
 
@@ -224,30 +186,25 @@ static int memtrace_online(void)
 			ent->mem = 0;
 		}
 
-		if (add_memory(ent->nid, ent->start, ent->size, MHP_NONE)) {
-			pr_err("Failed to add trace memory to node %d\n",
+		if (memtrace_free(ent->nid, ent->start, ent->size)) {
+			pr_err("Failed to free trace memory on node %d\n",
 				ent->nid);
 			ret += 1;
 			continue;
 		}
 
-		lock_device_hotplug();
-		walk_memory_blocks(ent->start, ent->size, NULL,
-				   online_mem_block);
-		unlock_device_hotplug();
-
 		/*
-		 * Memory was added successfully so clean up references to it
-		 * so on reentry we can tell that this chunk was added.
+		 * Memory was freed successfully so clean up references to it
+		 * so on reentry we can tell that this chunk was freed.
 		 */
 		debugfs_remove_recursive(ent->dir);
-		pr_info("Added trace memory back to node %d\n", ent->nid);
+		pr_info("Freed trace memory back on node %d\n", ent->nid);
 		ent->size = ent->start = ent->nid = NUMA_NO_NODE;
 	}
 	if (ret)
 		return ret;
 
-	/* If all chunks of memory were added successfully, reset globals */
+	/* If all chunks of memory were freed successfully, reset globals */
 	kfree(memtrace_array);
 	memtrace_array = NULL;
 	memtrace_size = 0;
@@ -269,16 +226,15 @@ static int memtrace_enable_set(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	/* Re-add/online previously removed/offlined memory */
+	/* Free all previously allocated memory. */
 	if (memtrace_size) {
-		if (memtrace_online())
+		if (memtrace_free_regions())
 			return -EAGAIN;
 	}
 
 	if (!val)
 		return 0;
 
-	/* Offline and remove memory */
 	if (memtrace_init_regions_runtime(val))
 		return -EINVAL;
 
-- 
2.26.2

