Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFF2C3EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgKYLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:20:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgKYLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:20:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFCF9AF10;
        Wed, 25 Nov 2020 11:20:55 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 3/4] mm,memory_hotplug: Add mhp_supports_memmap_on_memory
Date:   Wed, 25 Nov 2020 12:20:47 +0100
Message-Id: <20201125112048.8211-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201125112048.8211-1-osalvador@suse.de>
References: <20201125112048.8211-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhp_supports_memmap_on_memory is meant to be used by the caller prior
to hot-adding memory in order to figure out whether it can enable
MHP_MEMMAP_ON_MEMORY or not.

Enabling MHP_MEMMAP_ON_MEMORY requires:

 - CONFIG_SPARSEMEM_VMEMMAP
 - architecture support for altmap
 - hot-added range spans a single memory block

At the moment, only three architectures support passing altmap when
building the page tables: x86, POWERPC and ARM.
Define an arch_support_memmap_on_memory function on those architectures
that returns true, and define a __weak variant of it that will be used
on the others.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/mm/mmu.c   |  5 +++++
 arch/powerpc/mm/mem.c |  5 +++++
 arch/x86/mm/init_64.c |  5 +++++
 mm/memory_hotplug.c   | 24 ++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca692a815731..0da4e4f8794f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1456,6 +1456,11 @@ static bool inside_linear_region(u64 start, u64 size)
 	       (start + size - 1) <= __pa(PAGE_END - 1);
 }
 
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3fc325bebe4d..18e7e28fe713 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -121,6 +121,11 @@ static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
 	}
 }
 
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
+
 int __ref arch_add_memory(int nid, u64 start, u64 size,
 			  struct mhp_params *params)
 {
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..ffb9d87c77e8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -860,6 +860,11 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 87fbc2cc0d90..10255606ff85 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1028,6 +1028,20 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
+bool __weak arch_support_memmap_on_memory(void)
+{
+	return false;
+}
+
+bool mhp_supports_memmap_on_memory(unsigned long size)
+{
+	if (!arch_support_memmap_on_memory() ||
+	    !IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
+	    size > memory_block_size_bytes())
+		return false;
+	return true;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1064,6 +1078,16 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 	new_node = ret;
 
+	/*
+	 * Return -EINVAL if caller specified MHP_MEMMAP_ON_MEMORY and we do
+	 * not support it.
+	 */
+	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
+	    !mhp_supports_memmap_on_memory(size)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	/*
 	 * Self hosted memmap array
 	 */
-- 
2.26.2

