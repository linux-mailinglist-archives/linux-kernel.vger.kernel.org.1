Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7C2BBC27
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKUCVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKUCVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:21:25 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:21:23 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a20so8153800pgb.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rvJJKJqkMD7aeWohIVQ+pUDiFqCJD4u4sEkfGH1n7BM=;
        b=E/7iXlvFaHP13XfA3UT45noz3akcKcmjIWul3yGhjYyVMGHjqIyYUFyVSDuoa/lcOm
         KUWfTolRBKzCYi3wteh46GyQ5zl6kKTlLfOyZ5VZNyIPfC63rrx20sj0ylm7U8b3pxoM
         WYdv3sYSByZ6MXsFwyUfNGxVtEZyeMpqyqhDOu4GhKls3+klaKH9R4pCV6+7zdP8zn83
         nynEMF6uK+f1ZETdhxJPFgOnbgMg9UzS7mGqyrkLkXxvXnqiuHNe6Y7d3U6EhAQVCvAU
         9xNf3F08oMDFgu3L/k/xz46ToS5Q10PkX6CQeHUPEnVevOQjBhSXAVTWbmw6u4XhroMY
         r6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rvJJKJqkMD7aeWohIVQ+pUDiFqCJD4u4sEkfGH1n7BM=;
        b=a//dRV3eszaPd8kb1FVTR6PZXYUCtDEgVoigZML/mN9KyKdgMBiqNzUWUQN8efn2qX
         Yl8UNyN4xYJpIB+hcUn0BGCsdoh1JQOkiwkUR6Lpst+gw6C5ocIHYPKpDCzOqL4Zs6vZ
         ytzXFBQRq3MYHQ/n/sbsqi8EVOqgG/B4nTwfFx0kjrAPxi4Q3Lg4339qJBsE2wbSjf7s
         Hi7Ha1oicS9/Lts7CB165a0/7xPv+i30J4PIfZmk0uUg3mZ0HPtTWHTfYugmPJR+UQmi
         vvXBHPsKzDlF8oIyaMSX7FBc2HyboUeGpMsVs2jJz7JojFTh+WIPjUP8I7Kmvdcen5l4
         L28g==
X-Gm-Message-State: AOAM533+SLHKuXEf0iUVPmF0elaCxBcw9KKUfizGjRef9+MtE33IEJJe
        hFrWoFPNEEdHlIn3YfZuOhKofyRbP0VccQ==
X-Google-Smtp-Source: ABdhPJypqt8hc8LnmHjEZn4E1lshqwDkzpwMKup6l68QLCy5JeoelmTrmcjXT0lwsGQrhYIATw+yDX012a86ZQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a17:90b:19c4:: with SMTP id nm4mr12033350pjb.222.1605925283362;
 Fri, 20 Nov 2020 18:21:23 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:21:18 -0800
Message-Id: <20201121022118.3143384-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] mm: memcontrol: account pagetables per node
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
 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 arch/nds32/mm/mm-nds32.c                |  6 +++---
 drivers/base/node.c                     |  2 +-
 fs/proc/meminfo.c                       |  2 +-
 include/linux/mm.h                      | 11 +++++++----
 include/linux/mmzone.h                  |  2 +-
 mm/memcontrol.c                         |  1 +
 mm/page_alloc.c                         |  6 +++---
 8 files changed, 20 insertions(+), 13 deletions(-)

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
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
index 55bec50ccc03..f2778f2b39f6 100644
--- a/arch/nds32/mm/mm-nds32.c
+++ b/arch/nds32/mm/mm-nds32.c
@@ -34,8 +34,8 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	cpu_dcache_wb_range((unsigned long)new_pgd,
 			    (unsigned long)new_pgd +
 			    PTRS_PER_PGD * sizeof(pgd_t));
-	inc_zone_page_state(virt_to_page((unsigned long *)new_pgd),
-			    NR_PAGETABLE);
+	inc_lruvec_page_state(virt_to_page((unsigned long *)new_pgd),
+			      NR_PAGETABLE);
 
 	return new_pgd;
 }
@@ -59,7 +59,7 @@ void pgd_free(struct mm_struct *mm, pgd_t * pgd)
 
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

