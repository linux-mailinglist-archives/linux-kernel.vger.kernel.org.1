Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEE2C4C55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgKZA4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgKZA4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:56:41 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352A5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:40 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id g6so128966uab.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4/fLZ0pZyU04/elNra0XV3HdYqCI9pvvs0fKCmvBkWs=;
        b=N/q663iuzAkh1zesQp32yy7PGFxXyIVX18j1my2XAJQvGVbccosXuQAiRu0QfEK5M7
         pV0PY3u0FFma0iJrDA/ixnz+p4o2t9xrhaI4SQFMmlbJsICfqr7ATgemyZNLSaSVmqtd
         T2qeQQ2D9H6G8cVE9VLIYIn19rW+87rADoe/E7o0FD75tC5iWHMAMxlfnAuo5AUdgkTD
         1k0UUgb2nmInRkqimvJFUU4D+LYCpbYujYckHs07CZA5RI2rMZwSqixAt1cVTsfAukfo
         RypgC4P1k8I0Q7gm/fmoWflFKP1Q2kF8d/d6024H/P85a7jJe+MBQQkGWV9yCJEgVH2r
         SlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4/fLZ0pZyU04/elNra0XV3HdYqCI9pvvs0fKCmvBkWs=;
        b=dBUv5W8jTOZ7oHKF8qhBa9vLz/HQLUp0Q+MS7yzhq24n6IgRAXb911qMP0mcF8CBJ1
         zRgVeoB5FJMlI3dr+XUzBjPmzAS8l+/DzyHMCKFqRuMtCHFufEk8Z2QV82Xk4EzJGDF0
         YCvaMoCEjT43LAyX/jHM07gSaVf9u08SAbGFeYdqul017sSHwfBZ0RD5x7IMlk1WXz4n
         56nDBxmd3zSZJNpvlPe3ef0x6JVdJDPLlUHbyfKgDYynUPz2fnoSEmYRUFDGeIFBJv1h
         cfK4bEl5z0Gq1F+wKNdVfW3OA9dlzRIyZjaybl487xjwbVFjAakG+2NyZPHVOJl9HhHe
         O8Og==
X-Gm-Message-State: AOAM531yA1QRAN3Qt+8ToKlGEOyKC+ifevfMh16TavQdXS2iGBL00i+z
        XK2nWQ2laG73JLrQdrU+fNDlc3Etah6XZg==
X-Google-Smtp-Source: ABdhPJzqbZGT3posohjEFHzT2eQT1LbBJXxwKg5SQgtAeOOqdvQcxUy781nEBMLg09AvjXrkMw3KyIlzthH0bQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a1f:1c92:: with SMTP id c140mr483589vkc.7.1606352199272;
 Wed, 25 Nov 2020 16:56:39 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:56:03 -0800
In-Reply-To: <20201126005603.1293012-1-shakeelb@google.com>
Message-Id: <20201126005603.1293012-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20201126005603.1293012-1-shakeelb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 2/2] mm: memcontrol: account pagetables per node
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
This patch was posted at [1] and [2] but more work was needed to make it
build for all archs.

[1] http://lkml.kernel.org/r/20201121022118.3143384-1-shakeelb@google.com
[2] http://lkml.kernel.org/r/20201123161425.341314-1-shakeelb@google.com

 Documentation/admin-guide/cgroup-v2.rst | 3 +++
 arch/nds32/mm/mm-nds32.c                | 6 +++---
 drivers/base/node.c                     | 2 +-
 fs/proc/meminfo.c                       | 2 +-
 include/linux/mm.h                      | 8 ++++----
 include/linux/mmzone.h                  | 2 +-
 mm/memcontrol.c                         | 1 +
 mm/page_alloc.c                         | 6 +++---
 8 files changed, 17 insertions(+), 13 deletions(-)

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
index eabe7d9f80d8..d1f64744ace2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2199,7 +2199,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 	if (!ptlock_init(page))
 		return false;
 	__SetPageTable(page);
-	inc_zone_page_state(page, NR_PAGETABLE);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
 
@@ -2207,7 +2207,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
 	__ClearPageTable(page);
-	dec_zone_page_state(page, NR_PAGETABLE);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2294,7 +2294,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
-	inc_zone_page_state(page, NR_PAGETABLE);
+	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
 
@@ -2302,7 +2302,7 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
 	__ClearPageTable(page);
-	dec_zone_page_state(page, NR_PAGETABLE);
+	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 15132adaa233..b593316bff3d 100644
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
index 8b9352ddff0b..b80328f52fb4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1519,6 +1519,7 @@ static struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
 	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "pagetables", PAGE_SIZE, NR_PAGETABLE },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f91df593bf71..df749013f539 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5520,7 +5520,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
-		global_zone_page_state(NR_PAGETABLE),
+		global_node_page_state(NR_PAGETABLE),
 		global_zone_page_state(NR_BOUNCE),
 		global_zone_page_state(NR_FREE_PAGES),
 		free_pcp,
@@ -5552,6 +5552,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_SHADOW_CALL_STACK
 			" shadow_call_stack:%lukB"
 #endif
+			" pagetables:%lukB"
 			" all_unreclaimable? %s"
 			"\n",
 			pgdat->node_id,
@@ -5577,6 +5578,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
+			K(node_page_state(pgdat, NR_PAGETABLE)),
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
 	}
@@ -5608,7 +5610,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" present:%lukB"
 			" managed:%lukB"
 			" mlocked:%lukB"
-			" pagetables:%lukB"
 			" bounce:%lukB"
 			" free_pcp:%lukB"
 			" local_pcp:%ukB"
@@ -5629,7 +5630,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone->present_pages),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
-			K(zone_page_state(zone, NR_PAGETABLE)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
 			K(this_cpu_read(zone->pageset->pcp.count)),
-- 
2.29.2.454.gaff20da3a2-goog

