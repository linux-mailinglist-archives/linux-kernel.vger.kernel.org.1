Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF102CFD4B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgLESaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgLES3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:39 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FA0C094254
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:03:18 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so4656222plo.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/ByzOD9hz0YZpM+oDBw2TLHq41qvMWpZTD0cqZGx4I=;
        b=EPbjwaB9bJDW0LzCf2yQYjATnBpm0Th60ZbMY9bsk2dPEMEfNS9bPgB7ty5q5wOzBB
         UiHdsfr9ogMWYH7TvvzqvrO6EoPVUMNK1x+1ydqTdreqCEu+/KpnzwSr0w73mgKDJGvk
         aSR5MzsuSDls159UCz7r42D8qQO+2u/g1NP4uciuI15nyxVO1pkuIM9G3tOWAtjcTqzk
         uOnFwiQfpKH13sRYjk/L7DMll/r1662AJqcNsxRL22WLA3xqWdJgYAeMUUZl0HR2bTDd
         ZEnm6lHxNfhzUNl6pyRHHeB29a8nUbf0+Zz2VjLBtAfGCI9mVhTBW6JycPut5UccvzLv
         8ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/ByzOD9hz0YZpM+oDBw2TLHq41qvMWpZTD0cqZGx4I=;
        b=rkJS7QOFdNi4BSTG2xK3ndNplRQkgQa7llz9R/3/xPjIdCe4vBKHk9VjhkRlDKCZwy
         hd6VooEj/AbrJUKEq2pgTClGucqThNgxod74C73wLTKMoN6SdpvenjwOZVjp1JNUbuAy
         Gn6I8yJhaAzvLhPycOHE9cCIe5qSKj7pWZwuUAMnA3kkqH3Dp9M58++YNj+vh1qF8kot
         D4iLD5Si6h2NuQ0XCHCyY25mOHy2HQnakOZ1c5Wbqm9u214WBsfXEa1dMEP32/n1t9Km
         +xOQt4f/cptJDG6QZad6+AD1exVjAZkASIFEBTTF0yjhmtoV8cF4Y9CHeFxmI3JkeDCe
         CG8A==
X-Gm-Message-State: AOAM5335WfNPNOEnNyvqEphAp2wnkFUlL7EYxASh6reCTcWH/X0JfWNN
        vOZ4z1EsAnEe9j4rfFx76CAi0w==
X-Google-Smtp-Source: ABdhPJzxxvs7f3dkKh/KtxLlbQ1Ivsj2ntK724skGrCgujhkDGeVXhFTomMBpOV1Wdd0fWXsK7Jm7A==
X-Received: by 2002:a17:902:ed11:b029:da:3137:2695 with SMTP id b17-20020a170902ed11b02900da31372695mr8311259pld.1.1607173397620;
        Sat, 05 Dec 2020 05:03:17 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.03.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:03:17 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/9] mm: memcontrol: convert NR_ANON_THPS account to pages
Date:   Sat,  5 Dec 2020 21:02:19 +0800
Message-Id: <20201205130224.81607-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NR_ANON_THPS account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c |  3 +--
 fs/proc/meminfo.c   |  2 +-
 mm/huge_memory.c    |  3 ++-
 mm/memcontrol.c     | 20 ++++++--------------
 mm/page_alloc.c     |  2 +-
 mm/rmap.c           |  7 ++++---
 6 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 855886a6ba0e..05c369e93e16 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -461,8 +461,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(sunreclaimable)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
-			     nid, K(node_page_state(pgdat, NR_ANON_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index c396b6cfba82..f447ac191d24 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -129,7 +129,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
-		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_ANON_THPS));
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c94dfc0cc1a3..1a13e1dab3ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2178,7 +2178,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		lock_page_memcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
-			__dec_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS,
+						-HPAGE_PMD_NR);
 			if (TestClearPageDoubleMap(page)) {
 				/* No need in mapcount reference anymore */
 				for (i = 0; i < HPAGE_PMD_NR; i++)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a7ec79dcb7dc..39cb7f1b00d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1513,7 +1513,7 @@ static struct memory_stat memory_stats[] = {
 	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
 	 * constant(e.g. powerpc).
 	 */
-	{ "anon_thp", 0, NR_ANON_THPS },
+	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
 	{ "file_thp", 0, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
@@ -1546,8 +1546,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS ||
-		    memory_stats[i].idx == NR_FILE_THPS ||
+		if (memory_stats[i].idx == NR_FILE_THPS ||
 		    memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
@@ -4069,10 +4068,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
 	}
 
@@ -4103,10 +4098,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
 						(u64)nr * PAGE_SIZE);
 	}
@@ -5634,10 +5625,11 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__dec_lruvec_state(from_vec, NR_ANON_THPS);
-				__inc_lruvec_state(to_vec, NR_ANON_THPS);
+				__mod_lruvec_state(from_vec, NR_ANON_THPS,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_ANON_THPS,
+						   nr_pages);
 			}
-
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c28f8e1f1ef6..fabdbb340806 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5570,7 +5570,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
-			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,
diff --git a/mm/rmap.c b/mm/rmap.c
index 08c56aaf72eb..f59e92e26b61 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS,
+						HPAGE_PMD_NR);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1186,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_lruvec_page_state(page, NR_ANON_THPS);
+		__mod_lruvec_page_state(page, NR_ANON_THPS, HPAGE_PMD_NR);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1292,7 +1293,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_lruvec_page_state(page, NR_ANON_THPS);
+	__mod_lruvec_page_state(page, NR_ANON_THPS, -HPAGE_PMD_NR);
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
-- 
2.11.0

