Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DC2DCB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgLQDrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 22:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLQDrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:47:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BC4C0611CB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 19:45:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id k65so9096051pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 19:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChPy3SYz1507gCWRlnvA5RU8RNcwK6R9U8YqgL54fkc=;
        b=JLO/0y47sQz7EC+4uaKewlvvDxhNaJ7IMfmItkyYaKNL0/UduSC1AqhLpJcgLhYD4i
         mINmRlssJshSO4JkFuXJV4S1eHZqSYm0lxI2OQCKH7unbaAgoxE1Wd2YGbPu55lSqnxB
         FlGyoiwg0FVhhzBKBCxvXre94vECLc9vTH4QYDeLbKFhWvs/r0X4lA5AzkgMGQxSq7Gt
         Ur1XayIC5dOJuzSy88KOwPwGZrmnvVpX77SyJZ32r+vXwJxI+Qs2VmVNMmIhmgLewOq8
         PCWQfgZP2mX62knI/ZgY2zlKUvzsUhfoEpo6sfBSRUwx77/TahmyNtRj5fTI8FjZU1p5
         3OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChPy3SYz1507gCWRlnvA5RU8RNcwK6R9U8YqgL54fkc=;
        b=PPtDVtKRpwS4QlWEz8GwK3h1mMZPe7LYJzM5zCRluB/D8v+oa0/AZ2JR1oT7mdWa4F
         AZIVWOq5kNC/gBo2siF678Jwg1lWsXXF/i39rr7p3Ua9Ym6JtfzJ9boDluXNBWbo0Of2
         7qsHhTeTGCHJjWGyfWtwxFrl47wDgqe3UUUdnzQa1keboJaaXejfuYhoepreGQqMqaUJ
         JIJo7oIR4CrGlRKt0nCDr6EuIEXsp7Fxv7jmoGfPEaYjLJUsRDJbb4CUSp+NJ4NX9vkl
         R+8WgeDJMgdO7CPCLyadYjonONurXeQPwGGVmaKJT47nkXZnZE4SUUSsoWZqArL+2opy
         r7tA==
X-Gm-Message-State: AOAM532xwCpHO2O26UjeD4dbQ3p5ONkovPs2ovJx6aNX7IThgzBV2+2K
        roge/8qtbnO/ol4hNZeNv0JQCQ==
X-Google-Smtp-Source: ABdhPJxP3PP2vH+nLB1q8F0lLYL41DTLr53Moyw79kHaXuI2zxof2mGKryd3jKFYZFhYGLMwpkJdtg==
X-Received: by 2002:a65:4785:: with SMTP id e5mr7988863pgs.0.1608176757741;
        Wed, 16 Dec 2020 19:45:57 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:45:57 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 3/7] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Thu, 17 Dec 2020 11:43:52 +0800
Message-Id: <20201217034356.4708-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217034356.4708-1-songmuchun@bytedance.com>
References: <20201217034356.4708-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics expecially THP
vmstat counters. In the systems with hundreads of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_FILE_THPS account to pages. This patch
is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
on compound page arrival"). Doing this also can make the unit
of vmstat counters more unified. Finally, the unit of the vmstat
counters are pages, kB and bytes. The B/KB suffix can tell us
that the unit is bytes or kB. The rest which is without suffix
are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/filemap.c           | 2 +-
 mm/huge_memory.c       | 5 ++++-
 mm/khugepaged.c        | 4 +++-
 mm/memcontrol.c        | 5 ++---
 7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6da0c3508bc9..d5952f754911 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
-			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a635c8a84ddf..7ea4679880c8 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -135,7 +135,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
-		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 71029c09782b..19e77f656410 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -216,7 +216,8 @@ enum node_stat_item {
  */
 static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 {
-	return item == NR_ANON_THPS;
+	return item == NR_ANON_THPS ||
+	       item == NR_FILE_THPS;
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 78090ee08ac2..c5e6f5202476 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66ec454120de..cdf61596ef76 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2745,10 +2745,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
+			int nr = thp_nr_pages(head);
+
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_lruvec_page_state(head, NR_FILE_THPS);
+				__mod_lruvec_page_state(head, NR_FILE_THPS,
+							-nr);
 		}
 
 		__split_huge_page(page, list, end);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 494d3cb0b58a..23f93a3e2e69 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1654,6 +1654,7 @@ static void collapse_file(struct mm_struct *mm,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
+	int nr;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -1865,11 +1866,12 @@ static void collapse_file(struct mm_struct *mm,
 		put_page(page);
 		goto xa_unlocked;
 	}
+	nr = thp_nr_pages(new_page);
 
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b18e25a5cdf3..04985c8c6a0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1533,7 +1533,7 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", 0, NR_FILE_THPS },
+	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		if (memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
 		VM_BUG_ON(!memory_stats[i].ratio);
-- 
2.11.0

