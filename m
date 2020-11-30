Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D742C9006
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgK3V07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388536AbgK3V06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:26:18 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c71so10679789qkg.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2T4CzNDNx4ovq3nbcuNk95GOc5ZjwGkewHwCo4TGL3Y=;
        b=bxscp2oQd2VWRqpNiTk92TI43TF/ZXf1VWPn5sL2wcu684LMaH1T0uk3WhHcf/9qs8
         oVm6cl7nmdTzOzqyoza3aeAAOumo87vF5FKs3capWApbOLktKYwI7FNZfgrS/gVkuQnU
         2UhC9qJstLny9JbC1/+be0Jmhd6i36D7B2kS+SI/7YjrkdowXGpGhoDgcUzgKnnksfhX
         7u3aqE9YCgQD1k976saF5zaT8n/Xdzu1Sp+RUiKDm9uWES+aOgPQvRQlhZXZ8+fyKy5G
         hxR5xsNluP261L/ZnM8HgxQ/V06rP+bimrXG5mVw65PbojGksMwRwqP3oUbd3GBAMqR4
         wRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2T4CzNDNx4ovq3nbcuNk95GOc5ZjwGkewHwCo4TGL3Y=;
        b=nbkHMpzhPGmxJcPcuSVDqmaUTzGsB06CpZnVT9cT3oTapNGOgA3V9iNOVtqJaey7B5
         gM+RGqPXsdm3huVeoWsEf9+DRWvmhbg9II1CvptCAotPI6rkmJzaxZL7iX+GnJ5XfiSP
         vP8SPcZVuvWq/VTQQ3qYpavFka5PacsNW0OSuBXhiOga/PRKChM0FAPez/aE2QYyZMLG
         +czppR9PODW6yuSUTzLIeyQpiUq/gdNFvNmJtOgcKxfKuV4HGaT4AhFsKR3zeFSj3DfT
         7wGQZ6T9hA3IsGHySPQdNL+PEdvYh4nnyeU/oxSTYU1GJuXrBzK6ntWavIi98Ci0fEPe
         Qy9g==
X-Gm-Message-State: AOAM530iT1B3TKJv+NzbGAD6VGOrB+dbYgmDhWxyvZi4eUo+cvCay/7Y
        F4jXyIItqlFxIgZ5iHlvjpRiuwKKHaj5qA==
X-Google-Smtp-Source: ABdhPJxr1JQCHKdrtZrevy7IJ/u1lvnIWeLqviwX97C68EqfZANoY5YY7UZyN6rTF1G5l5FhSVDPweMu3DxWbw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:ac8:6c49:: with SMTP id z9mr23993384qtu.82.1606771577578;
 Mon, 30 Nov 2020 13:26:17 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:25:41 -0800
In-Reply-To: <20201130212541.2781790-1-shakeelb@google.com>
Message-Id: <20201130212541.2781790-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20201130212541.2781790-1-shakeelb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 2/2] mm: memcontrol: account pagetables per node
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <guro@fb.com>

---
Changes since v1:
- Fixes vmstat_text in vmstat.c based on Johannes's comment.

 Documentation/admin-guide/cgroup-v2.rst | 3 +++
 arch/nds32/mm/mm-nds32.c                | 6 +++---
 drivers/base/node.c                     | 2 +-
 fs/proc/meminfo.c                       | 2 +-
 include/linux/mm.h                      | 8 ++++----
 include/linux/mmzone.h                  | 2 +-
 mm/memcontrol.c                         | 1 +
 mm/page_alloc.c                         | 6 +++---
 mm/vmstat.c                             | 2 +-
 9 files changed, 18 insertions(+), 14 deletions(-)

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
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8d77ee426e22..663f49ed1fd6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1162,7 +1162,6 @@ const char * const vmstat_text[] = {
 	"nr_zone_unevictable",
 	"nr_zone_write_pending",
 	"nr_mlock",
-	"nr_page_table_pages",
 	"nr_bounce",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
 	"nr_zspages",
@@ -1220,6 +1219,7 @@ const char * const vmstat_text[] = {
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
+	"nr_page_table_pages",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.29.2.454.gaff20da3a2-goog

