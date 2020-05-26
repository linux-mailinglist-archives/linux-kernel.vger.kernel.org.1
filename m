Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94571DC2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgETX0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgETX0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so4062975qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qXY/GfTCL+Mr3UBVbQ4X5QzZETe/pl7Vv8oztEayYI=;
        b=PSsOIvSPlgXVB2PWgNn9RS9RdFPIsrwfa/83SQv3ZZf/Uvr9WVl1NH08U4jAfwTUod
         QJAh5J0PzfHdKRbyXV7fjK+H7YFSnYIyqeI4+n+922T1Vp7jvCdwiWf/d5/toiDLMvDk
         Hxri8JORn9NhXuBMoiwwGospfZD7yJyppmhtc1Mn+UUQyN4CYoIgO9nu6EiHOTs2f+7r
         sU0zICUqXiuR8vypJWT2L26oHyUgnyUC7mW9k0fHCuYIfvftxaw1JzhAsUbFOfodI01j
         ZY/Fy7ZuqoV0nf3mWpqipinUK0bVh66y/AdKSga06/X9ZcHOK7Kl1iOSkYtR6wCOcjbE
         Op/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qXY/GfTCL+Mr3UBVbQ4X5QzZETe/pl7Vv8oztEayYI=;
        b=MkaJk+BX+8eTiBDsYUpswmKYAxevh1SIS67v3AVO0TptTIN2u2bcIJHwejbpXqr2WE
         fPCQ5YWWoL+zRmG9nu7NYNgniZBOwKPbTsbPC7wepHvwa3JHOgF80i+iJuxFP/rqqyg8
         9Tzsmnz3hi2QL8uHAq16gTORCR6wbf4pL3wrofNdNyu+xXkpvsLVB33hZIHgMXKWoIWv
         sNpR/jip1yWjrCEISw/dFcIdeGuRBj1QWxWAjfPqOI8KQeH/IBtWbeu27B8ARemJIOO2
         r0loL6UjDm08L8NxxAH/rqm2iy6DU0+PrLJNn6B2rbe27ATzNFPDtn+n08E5DQz4wTgO
         tksA==
X-Gm-Message-State: AOAM531har1X1iVzcOFmTQMACXoXyYSYGVtdUCgiWF3J6oNzkuqkXaNq
        jDCxKG8wpA2SqdYRHb/k4ZWpYA==
X-Google-Smtp-Source: ABdhPJxi4EgJCESVIwdCAEwBX7lXykOt6rKu034N+rUoTj2Ks7dEIwot4dYtekJfafPemUXYI7SASw==
X-Received: by 2002:ac8:c8b:: with SMTP id n11mr8182253qti.49.1590017178581;
        Wed, 20 May 2020 16:26:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id t88sm3665378qtd.5.2020.05.20.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/14] mm: vmscan: determine anon/file pressure balance at the reclaim root
Date:   Wed, 20 May 2020 19:25:23 -0400
Message-Id: <20200520232525.798933-13-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We split the LRU lists into anon and file, and we rebalance the scan
pressure between them when one of them begins thrashing: if the file
cache experiences workingset refaults, we increase the pressure on
anonymous pages; if the workload is stalled on swapins, we increase
the pressure on the file cache instead.

With cgroups and their nested LRU lists, we currently don't do this
correctly. While recursive cgroup reclaim establishes a relative LRU
order among the pages of all involved cgroups, LRU pressure balancing
is done on an individual cgroup LRU level. As a result, when one
cgroup is thrashing on the filesystem cache while a sibling may have
cold anonymous pages, pressure doesn't get equalized between them.

This patch moves LRU balancing decision to the root of reclaim - the
same level where the LRU order is established.

It does this by tracking LRU cost recursively, so that every level of
the cgroup tree knows the aggregate LRU cost of all memory within its
domain. When the page scanner calculates the scan balance for any
given individual cgroup's LRU list, it uses the values from the
ancestor cgroup that initiated the reclaim cycle.

If one sibling is then thrashing on the cache, it will tip the
pressure balance inside its ancestors, and the next hierarchical
reclaim iteration will go more after the anon pages in the tree.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 13 ++++++++++++
 mm/swap.c                  | 32 ++++++++++++++++++++++++-----
 mm/vmscan.c                | 41 ++++++++++++++++----------------------
 3 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 32a0b4d47540..d982c80da157 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1303,6 +1303,19 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = lruvec_memcg(lruvec);
+	if (!memcg)
+		return NULL;
+	memcg = parent_mem_cgroup(memcg);
+	if (!memcg)
+		return NULL;
+	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/mm/swap.c b/mm/swap.c
index 2ff91656dea2..3d8aa46c47ff 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -266,11 +266,33 @@ void lru_note_cost(struct page *page)
 {
 	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 
-	/* Record new data point */
-	if (page_is_file_lru(page))
-		lruvec->file_cost++;
-	else
-		lruvec->anon_cost++;
+	do {
+		unsigned long lrusize;
+
+		/* Record cost event */
+		if (page_is_file_lru(page))
+			lruvec->file_cost++;
+		else
+			lruvec->anon_cost++;
+
+		/*
+		 * Decay previous events
+		 *
+		 * Because workloads change over time (and to avoid
+		 * overflow) we keep these statistics as a floating
+		 * average, which ends up weighing recent refaults
+		 * more than old ones.
+		 */
+		lrusize = lruvec_page_state(lruvec, NR_INACTIVE_ANON) +
+			  lruvec_page_state(lruvec, NR_ACTIVE_ANON) +
+			  lruvec_page_state(lruvec, NR_INACTIVE_FILE) +
+			  lruvec_page_state(lruvec, NR_ACTIVE_FILE);
+
+		if (lruvec->file_cost + lruvec->anon_cost > lrusize / 4) {
+			lruvec->file_cost /= 2;
+			lruvec->anon_cost /= 2;
+		}
+	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e7e6868bcbf7..1487ff5d4698 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -79,6 +79,12 @@ struct scan_control {
 	 */
 	struct mem_cgroup *target_mem_cgroup;
 
+	/*
+	 * Scan pressure balancing between anon and file LRUs
+	 */
+	unsigned long	anon_cost;
+	unsigned long	file_cost;
+
 	/* Can active pages be deactivated as part of reclaim? */
 #define DEACTIVATE_ANON 1
 #define DEACTIVATE_FILE 2
@@ -2231,10 +2237,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	int swappiness = mem_cgroup_swappiness(memcg);
 	u64 fraction[2];
 	u64 denominator = 0;	/* gcc */
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	unsigned long anon_prio, file_prio;
 	enum scan_balance scan_balance;
-	unsigned long anon, file;
 	unsigned long totalcost;
 	unsigned long ap, fp;
 	enum lru_list lru;
@@ -2285,7 +2289,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}
 
 	scan_balance = SCAN_FRACT;
-
 	/*
 	 * Calculate the pressure balance between anon and file pages.
 	 *
@@ -2300,30 +2303,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	anon_prio = swappiness;
 	file_prio = 200 - anon_prio;
 
-	/*
-	 * Because workloads change over time (and to avoid overflow)
-	 * we keep these statistics as a floating average, which ends
-	 * up weighing recent refaults more than old ones.
-	 */
-
-	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
-		lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
-	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
-		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
-
-	spin_lock_irq(&pgdat->lru_lock);
-	totalcost = lruvec->anon_cost + lruvec->file_cost;
-	if (unlikely(totalcost > (anon + file) / 4)) {
-		lruvec->anon_cost /= 2;
-		lruvec->file_cost /= 2;
-		totalcost /= 2;
-	}
+	totalcost = sc->anon_cost + sc->file_cost;
 	ap = anon_prio * (totalcost + 1);
-	ap /= lruvec->anon_cost + 1;
+	ap /= sc->anon_cost + 1;
 
 	fp = file_prio * (totalcost + 1);
-	fp /= lruvec->file_cost + 1;
-	spin_unlock_irq(&pgdat->lru_lock);
+	fp /= sc->file_cost + 1;
 
 	fraction[0] = ap;
 	fraction[1] = fp;
@@ -2679,6 +2664,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
+	/*
+	 * Determine the scan balance between anon and file LRUs.
+	 */
+	spin_lock_irq(&pgdat->lru_lock);
+	sc->anon_cost = target_lruvec->anon_cost;
+	sc->file_cost = target_lruvec->file_cost;
+	spin_unlock_irq(&pgdat->lru_lock);
+
 	/*
 	 * Target desirable inactive:active list ratios for the anon
 	 * and file LRU lists.
-- 
2.26.2

