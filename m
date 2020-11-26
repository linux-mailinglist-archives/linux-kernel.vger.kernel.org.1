Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B930E2C4C54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgKZA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:56:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b11so334554pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZQe8Z5QZzANXcJJloEwBZILBRtdzSkAeGp8rSgUlcOo=;
        b=K6Wza4Zs2MaE/gjQ0+XTMxfB/YnItP4RTMDiso7QF7tSsx9yqAdwsbWPMrimIlrK2y
         z3S1YU+OBCYpfvQFfHvsoaPKj+g9bKDNJBFVSdtUk84nb7LYIh3ZV/euxC+zgvcpdiuA
         nt5XHKUmf5vcIl5qOr9LO0VIooTad3SDuufnoaNPfdcFAWC12EDg8M4i+383gMH7ne4O
         sAmm7V4On9NdkPnGuUCTOrfquWE6ziKc+h7qdXM3JSwMCzRP/d7oYpTaGyPDyUYF9Ijo
         GEBgQprw8mfO88SYRHObIuyfpr0eDFh6ibM5K+VbByyDDtiy6AQsbwyC+kp8el6i3zEN
         zzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZQe8Z5QZzANXcJJloEwBZILBRtdzSkAeGp8rSgUlcOo=;
        b=m8sewiwRXKArjjTr6l1UjUjxv2fXS5cNMmPaV/PVwrMhqWiqse7Qzzozoy1O/L3s+f
         ekaFNxu+0Yrac0fhQyoXWjeIR17vbWbTjrAUUlS4LbNt1RAxfwA8yg8S48V6MdlT6xr/
         5WyBhPB0O+U0ZgwrePu5//lgqUjO4Ap8h9auDuap+iQD3Hkwy49vyTjo5oiwwvEhVXVH
         HFCDba9uGcskhj7lJGZsfhUH+vHTb1df54ZiOjVCSgdBOu3vdV3e2sMW9X5e5aemsQx+
         RF04lpuk5Ca6ElUseIwD9Ynym/uTkJtbWT8/uUWUMDdHpQFRK/QC6BWu0lP7QW0oR1vx
         ESkQ==
X-Gm-Message-State: AOAM533wGfrMV2O6O/F+40e6IanY8zzdnlYxM6puSy2PNp8MNMXjj2xF
        PZzpocvjGaQeMzPojGx1Cjf8XeUhhf92aw==
X-Google-Smtp-Source: ABdhPJzAqHDnPNl+54bNWFlaDeDXLP3TujawVomPlsQaNuRAkK/xiyAtc82+0tqjmW4hjk4+nXCzU+S70MQymA==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a63:1b46:: with SMTP id b6mr480911pgm.92.1606352188135;
 Wed, 25 Nov 2020 16:56:28 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:56:02 -0800
In-Reply-To: <20201126005603.1293012-1-shakeelb@google.com>
Message-Id: <20201126005603.1293012-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20201126005603.1293012-1-shakeelb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 1/2] mm: move lruvec stats update functions to vmstat.h
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality and only move the functions
which update the lruvec stats to vmstat.h from memcontrol.h. The main
reason for this patch is to be able to use these functions in the page
table contructor function which is defined in mm.h and we can not
include the memcontrol.h in that file.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 112 -------------------------------------
 include/linux/vmstat.h     | 104 ++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  18 ++++++
 3 files changed, 122 insertions(+), 112 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87ed56dc75f9..cd7b9136fb39 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -947,8 +947,6 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
 
 static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
@@ -971,44 +969,6 @@ static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
 	local_irq_restore(flags);
 }
 
-static inline void mod_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_lruvec_state(lruvec, idx, val);
-	local_irq_restore(flags);
-}
-
-static inline void __mod_lruvec_page_state(struct page *page,
-					   enum node_stat_item idx, int val)
-{
-	struct page *head = compound_head(page); /* rmap on tail pages */
-	struct mem_cgroup *memcg = page_memcg(head);
-	pg_data_t *pgdat = page_pgdat(page);
-	struct lruvec *lruvec;
-
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg) {
-		__mod_node_page_state(pgdat, idx, val);
-		return;
-	}
-
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_lruvec_state(lruvec, idx, val);
-}
-
-static inline void mod_lruvec_page_state(struct page *page,
-					 enum node_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_lruvec_page_state(page, idx, val);
-	local_irq_restore(flags);
-}
-
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
@@ -1411,30 +1371,6 @@ static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 {
 }
 
-static inline void __mod_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx, int val)
-{
-	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
-}
-
-static inline void mod_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx, int val)
-{
-	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
-}
-
-static inline void __mod_lruvec_page_state(struct page *page,
-					   enum node_stat_item idx, int val)
-{
-	__mod_node_page_state(page_pgdat(page), idx, val);
-}
-
-static inline void mod_lruvec_page_state(struct page *page,
-					 enum node_stat_item idx, int val)
-{
-	mod_node_page_state(page_pgdat(page), idx, val);
-}
-
 static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					   int val)
 {
@@ -1490,30 +1426,6 @@ static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 }
 #endif /* CONFIG_MEMCG */
 
-static inline void __inc_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx)
-{
-	__mod_lruvec_state(lruvec, idx, 1);
-}
-
-static inline void __dec_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx)
-{
-	__mod_lruvec_state(lruvec, idx, -1);
-}
-
-static inline void __inc_lruvec_page_state(struct page *page,
-					   enum node_stat_item idx)
-{
-	__mod_lruvec_page_state(page, idx, 1);
-}
-
-static inline void __dec_lruvec_page_state(struct page *page,
-					   enum node_stat_item idx)
-{
-	__mod_lruvec_page_state(page, idx, -1);
-}
-
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
@@ -1524,30 +1436,6 @@ static inline void __dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
 	__mod_lruvec_kmem_state(p, idx, -1);
 }
 
-static inline void inc_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx)
-{
-	mod_lruvec_state(lruvec, idx, 1);
-}
-
-static inline void dec_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx)
-{
-	mod_lruvec_state(lruvec, idx, -1);
-}
-
-static inline void inc_lruvec_page_state(struct page *page,
-					 enum node_stat_item idx)
-{
-	mod_lruvec_page_state(page, idx, 1);
-}
-
-static inline void dec_lruvec_page_state(struct page *page,
-					 enum node_stat_item idx)
-{
-	mod_lruvec_page_state(page, idx, -1);
-}
-
 static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 {
 	struct mem_cgroup *memcg;
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 322dcbfcc933..773135fc6e19 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -450,4 +450,108 @@ static inline const char *vm_event_name(enum vm_event_item item)
 }
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 
+#ifdef CONFIG_MEMCG
+
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val);
+
+static inline void mod_lruvec_state(struct lruvec *lruvec,
+				    enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_lruvec_state(lruvec, idx, val);
+	local_irq_restore(flags);
+}
+
+void __mod_lruvec_page_state(struct page *page,
+			     enum node_stat_item idx, int val);
+
+static inline void mod_lruvec_page_state(struct page *page,
+					 enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_lruvec_page_state(page, idx, val);
+	local_irq_restore(flags);
+}
+
+#else
+
+static inline void __mod_lruvec_state(struct lruvec *lruvec,
+				      enum node_stat_item idx, int val)
+{
+	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+}
+
+static inline void mod_lruvec_state(struct lruvec *lruvec,
+				    enum node_stat_item idx, int val)
+{
+	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+}
+
+static inline void __mod_lruvec_page_state(struct page *page,
+					   enum node_stat_item idx, int val)
+{
+	__mod_node_page_state(page_pgdat(page), idx, val);
+}
+
+static inline void mod_lruvec_page_state(struct page *page,
+					 enum node_stat_item idx, int val)
+{
+	mod_node_page_state(page_pgdat(page), idx, val);
+}
+
+#endif /* CONFIG_MEMCG */
+
+static inline void __inc_lruvec_state(struct lruvec *lruvec,
+				      enum node_stat_item idx)
+{
+	__mod_lruvec_state(lruvec, idx, 1);
+}
+
+static inline void __dec_lruvec_state(struct lruvec *lruvec,
+				      enum node_stat_item idx)
+{
+	__mod_lruvec_state(lruvec, idx, -1);
+}
+
+static inline void __inc_lruvec_page_state(struct page *page,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_page_state(page, idx, 1);
+}
+
+static inline void __dec_lruvec_page_state(struct page *page,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_page_state(page, idx, -1);
+}
+
+static inline void inc_lruvec_state(struct lruvec *lruvec,
+				    enum node_stat_item idx)
+{
+	mod_lruvec_state(lruvec, idx, 1);
+}
+
+static inline void dec_lruvec_state(struct lruvec *lruvec,
+				    enum node_stat_item idx)
+{
+	mod_lruvec_state(lruvec, idx, -1);
+}
+
+static inline void inc_lruvec_page_state(struct page *page,
+					 enum node_stat_item idx)
+{
+	mod_lruvec_page_state(page, idx, 1);
+}
+
+static inline void dec_lruvec_page_state(struct page *page,
+					 enum node_stat_item idx)
+{
+	mod_lruvec_page_state(page, idx, -1);
+}
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9922f1510956..8b9352ddff0b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -847,6 +847,24 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		__mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
+void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
+			     int val)
+{
+	struct page *head = compound_head(page); /* rmap on tail pages */
+	struct mem_cgroup *memcg = page_memcg(head);
+	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
+
+	/* Untracked pages have no memcg, no lruvec. Update only the node */
+	if (!memcg) {
+		__mod_node_page_state(pgdat, idx, val);
+		return;
+	}
+
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	__mod_lruvec_state(lruvec, idx, val);
+}
+
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
-- 
2.29.2.454.gaff20da3a2-goog

