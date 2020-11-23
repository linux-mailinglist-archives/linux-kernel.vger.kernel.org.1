Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE39B2C0FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgKWQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgKWQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:14:35 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:14:34 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id e202so8166153vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=BsqWv4H/ufsdI2enRXP/dhtCNxc7q7+QGCOqB9klA0M=;
        b=E73TtGYlXIPv5BXhSLTiLYKMuw3vS2alfGMoummcGqb7QNatr9be19pVmj9hbD8+Rq
         YkIW+Kb9l+7OUYfSnxD0V4C0duWbj/2dvNcdMejih4/WS9r6q65zmiwknhkMGO1Yci3t
         yTdcp1ZkeBs5yBllDCAFXY3i89n0WoRCjtieqkVL3Q7KbeoOe6FHzzA6W/N+7Zq//fu/
         SBBDUi8Qtf/Ii4I75Rbys83TfdTD53pZxu0+TUqBHcx3at2gEj+j8G1DWYPbhn6lWRfC
         LDGmGo8oC7Ob8+5d0jrvGcmCdVjRWXioEpt7yGJkeRtSJzTiskjQ+JjBP1v4mRrIWw/F
         RDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=BsqWv4H/ufsdI2enRXP/dhtCNxc7q7+QGCOqB9klA0M=;
        b=reATzpI/4c/I4jFCp3q60VQT25pPp+hOkChx1TRXuFV7mDEEPmWgv6cpLEVJdH9tkM
         x/2P8gCvanE3BUZHBZH48BucL0z/nNZocoBZbY+FZATJx3hiB6z2EJrqnlkdjRfZm9l/
         afWddkTynfRPxSPGnpujc7yC08yaCXeVLmZtKbAc6Z5Opvkd6ralcn5i88NOzIW4Hia9
         DBnkcT3//x4F3kTC13dCfgetompP7JvdQj86GQxE7fz5+5pCkMl//eXS8n4OXwbpjsMT
         xQJmfKVnIvVGa11M4lCBmR01defYrViZjiPmxZWKyhA0t31cHd1Vr7Tw7l4dmo9L9OGN
         g/5Q==
X-Gm-Message-State: AOAM530rE5Qt86jlGEc1j7++h4uQx3FDW0haV4Gzt5UM+QFvQiif/KUe
        PxOvUV+2dAX4csF9oqlDBT43YnvC3tebYQ==
X-Google-Smtp-Source: ABdhPJzPAR0FIGIXZmaPU04YGbCUhzxYAyiHlFXUkog/zks7W5viLRusblL/tIacNEJvmSJh3o9jo72jHNEx0g==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a67:2085:: with SMTP id g127mr92049vsg.16.1606148073233;
 Mon, 23 Nov 2020 08:14:33 -0800 (PST)
Date:   Mon, 23 Nov 2020 08:14:25 -0800
Message-Id: <20201123161425.341314-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] mm: memcontrol: account pagetables per node
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For many workloads, pagetable consumption is significant and it makes
sense to expose it in the memory.stat for the memory cgroups. However at
the moment, the pagetables are accounted per-zone. Converting them to
per-node and using the right interface will correctly account for the
memory cgroups as well.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- Tried to fix linking errors for m68k and nds32


 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 arch/m68k/include/asm/mcf_pgalloc.h     |  1 +
 arch/nds32/mm/mm-nds32.c                |  7 ++++---
 drivers/base/node.c                     |  2 +-
 fs/proc/meminfo.c                       |  2 +-
 include/linux/mm.h                      | 11 +++++++----
 include/linux/mmzone.h                  |  2 +-
 mm/memcontrol.c                         |  1 +
 mm/page_alloc.c                         |  6 +++---
 9 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 515bb13084a0..63521cd36ce5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1274,6 +1274,9 @@ PAGE_SIZE multiple when read back.
 	  kernel_stack
 		Amount of memory allocated to kernel stacks.
 
+	  pagetables
+                Amount of memory allocated for page tables.
+
 	  percpu(npn)
 		Amount of memory used for storing per-cpu kernel
 		data structures.
diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index bc1228e00518..9088812c2174 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -4,6 +4,7 @@
 
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <linux/memcontrol.h>
 
 extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
index 55bec50ccc03..d18e59877503 100644
--- a/arch/nds32/mm/mm-nds32.c
+++ b/arch/nds32/mm/mm-nds32.c
@@ -5,6 +5,7 @@
 
 #define __HAVE_ARCH_PGD_FREE
 #include <asm/pgalloc.h>
+#include <linux/memcontrol.h>
 
 #define FIRST_KERNEL_PGD_NR	(USER_PTRS_PER_PGD)
 
@@ -34,8 +35,8 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	cpu_dcache_wb_range((unsigned long)new_pgd,
 			    (unsigned long)new_pgd +
 			    PTRS_PER_PGD * sizeof(pgd_t));
-	inc_zone_page_state(virt_to_page((unsigned long *)new_pgd),
-			    NR_PAGETABLE);
+	inc_lruvec_page_state(virt_to_page((unsigned long *)new_pgd),
+			      NR_PAGETABLE);
 
 	return new_pgd;
 }
@@ -59,7 +60,7 @@ void pgd_free(struct mm_struct *mm, pgd_t * pgd)
 
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
-	dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
+	dec_lruvec_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
 	pte_free(mm, pte);
 	mm_dec_nr_ptes(mm);
 	pmd_free(mm, pmd);
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6ffa470e2984..04f71c7bc3f8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -450,7 +450,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-			     nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
+			     nid, K(node_page_state(pgdat, NR_PAGETABLE)),
 			     nid, 0UL,
 			     nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
 			     nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..d6fc74619625 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -107,7 +107,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   global_node_page_state(NR_KERNEL_SCS_KB));
 #endif
 	show_val_kb(m, "PageTables:     ",
-		    global_zone_page_state(NR_PAGETABLE));
+		    global_node_page_state(NR_PAGETABLE));
 
 	show_val_kb(m, "NFS_Unstable:   ", 0);
 	show_val_kb(m, "Bounce:         ",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7cfc4653dddf..15c8d082e32f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2177,12 +2177,15 @@ static inline void pgtable_init(void)
 	pgtable_cache_init();
 }
 
+static void inc_lruvec_page_state(struct page *page, enum node_stat_item idx);
+static void dec_lruvec_page_state(struct page *page, enum node_stat_item idx);
+
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
 	__SetPageTable(page);
-	inc_zone_page_state(page, NR_PAGETABLE);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
 
@@ -2190,7 +2193,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
 	__ClearPageTable(page);
-	dec_zone_page_state(page, NR_PAGETABLE);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2277,7 +2280,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
-	inc_zone_page_state(page, NR_PAGETABLE);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
 
@@ -2285,7 +2288,7 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
 	__ClearPageTable(page);
-	dec_zone_page_state(page, NR_PAGETABLE);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8b074e2ba12c..0dead297d1f1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -151,7 +151,6 @@ enum zone_stat_item {
 	NR_ZONE_UNEVICTABLE,
 	NR_ZONE_WRITE_PENDING,	/* Count of dirty, writeback and unstable pages */
 	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
-	NR_PAGETABLE,		/* used for pagetables */
 	/* Second 128 byte cacheline */
 	NR_BOUNCE,
 #if IS_ENABLED(CONFIG_ZSMALLOC)
@@ -206,6 +205,7 @@ enum node_stat_item {
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
+	NR_PAGETABLE,		/* used for pagetables */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 45465c03a8d7..29a558279520 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1501,6 +1501,7 @@ static struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "pagetables", PAGE_SIZE, NR_PAGETABLE },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 42c32e8a9c5d..074664f1ea23 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5515,7 +5515,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
-		global_zone_page_state(NR_PAGETABLE),
+		global_node_page_state(NR_PAGETABLE),
 		global_zone_page_state(NR_BOUNCE),
 		global_zone_page_state(NR_FREE_PAGES),
 		free_pcp,
@@ -5547,6 +5547,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_SHADOW_CALL_STACK
 			" shadow_call_stack:%lukB"
 #endif
+			" pagetables:%lukB"
 			" all_unreclaimable? %s"
 			"\n",
 			pgdat->node_id,
@@ -5572,6 +5573,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
+			K(node_page_state(pgdat, NR_PAGETABLE)),
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
 	}
@@ -5603,7 +5605,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" present:%lukB"
 			" managed:%lukB"
 			" mlocked:%lukB"
-			" pagetables:%lukB"
 			" bounce:%lukB"
 			" free_pcp:%lukB"
 			" local_pcp:%ukB"
@@ -5624,7 +5625,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone->present_pages),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
-			K(zone_page_state(zone, NR_PAGETABLE)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
 			K(this_cpu_read(zone->pageset->pcp.count)),
-- 
2.29.2.454.gaff20da3a2-goog

