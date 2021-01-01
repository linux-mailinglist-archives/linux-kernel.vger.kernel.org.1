Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B012E82CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 03:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbhAAClI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 21:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbhAAClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 21:41:08 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DFC061575
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 18:40:27 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id h15so9500204vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 18:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=T28TT+2o5ZSSMuOR0zVx7IEtsQs8xfEjV9DyNzlaDvM=;
        b=T0NqqcTQ9FQTLmzDjaNR8G+y/ZCzRsKg5ajH02CTe1o/pDhLPvJdAMdRAySRKhWICS
         awBFoEN8nllpYwiADJWfc0pCdHFCOZXQTgmsxpdL8nbJWucPoRbytuXXgv9f89kJn+28
         UslTZ7SNBn5VzjBnnxp8DHMi2xZnm8jPA4+iz6RnAo02IThDMOXcEYbXxMZJkWxVBSkG
         EIL5RCipZAI4EmNlguITiqwupBSDsztnOyF6OeibDuqSj0MSxqrHKzsXDihmQY/lCEA/
         klwmuQdmtSvJQbPuWya9nSlNLh9Ixa6u3YYTssYurPyS7MECtFexFCJ0V6fEEPOVvbAD
         MR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=T28TT+2o5ZSSMuOR0zVx7IEtsQs8xfEjV9DyNzlaDvM=;
        b=j9/jrkrx+hUhHJj8+kd8W6vZA0RQ0yDEBVQFhEMeYddbdBmWCCDCTzsi8KF5ALJiCn
         MZAeb0n3XTfZjmC74dfRUf15nMzwfsCN/tqurUX7kR4g/E//KY3PZd90u34KYiy+vpkw
         McNgP68zuPMX4y3Bd3J5AxDy4Li3dUfr/hQS+WoY9yPA4Ey0RU9lx7eeQNz/oC2xrr+o
         V14qXn8Z5hw25kNvfqUilDQjIBPTrwGpXiJ7LlnZxqX5tsiiKziYEhJjLNYa8DOvUiHl
         HAdM8OPLeZPylH5u7RUigvyZsMWG3vZfOETvR0tzAWiAHHT6X2qMc0zk0aabIuGWlgL7
         MZQw==
X-Gm-Message-State: AOAM533mkjTYD/3vnu7tL+2vzFZfzXt/mI0MxZhSLKKHAl1PZcW3OGXW
        0zp2K8doTuVuG8aHsJrNnyhiggCnWRvT5Q==
X-Google-Smtp-Source: ABdhPJxA0cGDhyuZ0Qg1d1qDiR83vDLBPfrySopkgGrhcN+UnASctKy45rPKV4FHdVW0iJJbMHnjg65zz2V1mQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a67:ecd5:: with SMTP id i21mr38544270vsp.18.1609468826562;
 Thu, 31 Dec 2020 18:40:26 -0800 (PST)
Date:   Thu, 31 Dec 2020 18:39:55 -0800
Message-Id: <20210101023955.250965-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] mm: memcg: add swapcache stat for memcg v2
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds swapcache stat for the cgroup v2. The swapcache
represents the memory that is accounted against both the memory and the
swap limit of the cgroup. The main motivation behind exposing the
swapcache stat is for enabling users to gracefully migrate from cgroup
v1's memsw counter to cgroup v2's memory and swap counters.

Cgroup v1's memsw limit allows users to limit the memory+swap usage of a
workload but without control on the exact proportion of memory and swap.
Cgroup v2 provides separate limits for memory and swap which enables
more control on the exact usage of memory and swap individually for the
workload.

With some little subtleties, the v1's memsw limit can be switched with
the sum of the v2's memory and swap limits. However the alternative for
memsw usage is not yet available in cgroup v2. Exposing per-cgroup
swapcache stat enables that alternative. Adding the memory usage and
swap usage and subtracting the swapcache will approximate the memsw
usage. This will help in the transparent migration of the workloads
depending on memsw usage and limit to v2' memory and swap counters.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 drivers/base/node.c                     |  6 ++++++
 include/linux/mmzone.h                  |  3 +++
 include/linux/swap.h                    |  6 +++++-
 mm/memcontrol.c                         |  1 +
 mm/migrate.c                            |  4 ++++
 mm/swap_state.c                         | 28 ++-----------------------
 mm/vmstat.c                             |  3 +++
 8 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 63521cd36ce5..5923e2c3e0e5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1299,6 +1299,10 @@ PAGE_SIZE multiple when read back.
 		Amount of cached filesystem data that was modified and
 		is currently being written back to disk
 
+	  swapcached
+		Amount of swap cached in memory. The swapcache is accounted
+		against both memory and swap usage.
+
 	  anon_thp
 		Amount of memory used in anonymous mappings backed by
 		transparent hugepages
diff --git a/drivers/base/node.c b/drivers/base/node.c
index d02d86aec19f..f449dbb2c746 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -372,14 +372,19 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	struct sysinfo i;
 	unsigned long sreclaimable, sunreclaimable;
+	unsigned long swapcached = 0;
 
 	si_meminfo_node(&i, nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
 	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
+#ifdef CONFIG_SWAP
+	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
+#endif
 	len = sysfs_emit_at(buf, len,
 			    "Node %d MemTotal:       %8lu kB\n"
 			    "Node %d MemFree:        %8lu kB\n"
 			    "Node %d MemUsed:        %8lu kB\n"
+			    "Node %d SwapCached:     %8lu kB\n"
 			    "Node %d Active:         %8lu kB\n"
 			    "Node %d Inactive:       %8lu kB\n"
 			    "Node %d Active(anon):   %8lu kB\n"
@@ -391,6 +396,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    nid, K(i.totalram),
 			    nid, K(i.freeram),
 			    nid, K(i.totalram - i.freeram),
+			    nid, K(swapcached),
 			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
 				   node_page_state(pgdat, NR_ACTIVE_FILE)),
 			    nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 66d68e5d5a0f..fc99e9241846 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,9 @@ enum node_stat_item {
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
+#ifdef CONFIG_SWAP
+	NR_SWAPCACHE,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5bba15ac5a2e..71166bc10d17 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,7 +408,11 @@ extern struct address_space *swapper_spaces[];
 #define swap_address_space(entry)			    \
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
-extern unsigned long total_swapcache_pages(void);
+static inline unsigned long total_swapcache_pages(void)
+{
+	return global_node_page_state(NR_SWAPCACHE);
+}
+
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
 extern void *get_shadow_from_swap_cache(swp_entry_t entry);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d74b80fa4de..e853bef32b23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1521,6 +1521,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
 	{ "file_writeback",		NR_WRITEBACK			},
+	{ "swapcached",			NR_SWAPCACHE			},
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	{ "anon_thp",			NR_ANON_THPS			},
 	{ "file_thp",			NR_FILE_THPS			},
diff --git a/mm/migrate.c b/mm/migrate.c
index c0efe921bca5..7336c6d40c13 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -500,6 +500,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
 			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
 		}
+		if (PageSwapCache(page)) {
+			__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
+			__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
+		}
 		if (dirty && mapping_can_writeback(mapping)) {
 			__mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
 			__mod_zone_page_state(oldzone, NR_ZONE_WRITE_PENDING, -nr);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6ecc84448d75..d0d417efeecc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -68,32 +68,6 @@ static struct {
 	unsigned long find_total;
 } swap_cache_info;
 
-unsigned long total_swapcache_pages(void)
-{
-	unsigned int i, j, nr;
-	unsigned long ret = 0;
-	struct address_space *spaces;
-	struct swap_info_struct *si;
-
-	for (i = 0; i < MAX_SWAPFILES; i++) {
-		swp_entry_t entry = swp_entry(i, 1);
-
-		/* Avoid get_swap_device() to warn for bad swap entry */
-		if (!swp_swap_info(entry))
-			continue;
-		/* Prevent swapoff to free swapper_spaces */
-		si = get_swap_device(entry);
-		if (!si)
-			continue;
-		nr = nr_swapper_spaces[i];
-		spaces = swapper_spaces[i];
-		for (j = 0; j < nr; j++)
-			ret += spaces[j].nrpages;
-		put_swap_device(si);
-	}
-	return ret;
-}
-
 static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
 
 void show_swap_cache_info(void)
@@ -161,6 +135,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 		address_space->nrexceptional -= nr_shadows;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
+		__mod_lruvec_page_state(page, NR_SWAPCACHE, nr);
 		ADD_CACHE_INFO(add_total, nr);
 unlock:
 		xas_unlock_irq(&xas);
@@ -201,6 +176,7 @@ void __delete_from_swap_cache(struct page *page,
 		address_space->nrexceptional += nr;
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
+	__mod_lruvec_page_state(page, NR_SWAPCACHE, -nr);
 	ADD_CACHE_INFO(del_total, nr);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 37c9e7b21e1e..03a0cbc1eefa 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1220,6 +1220,9 @@ const char * const vmstat_text[] = {
 	"nr_shadow_call_stack",
 #endif
 	"nr_page_table_pages",
+#ifdef CONFIG_SWAP
+	"nr_swapcached",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.29.2.729.g45daf8777d-goog

