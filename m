Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A742C9005
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgK3V0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388536AbgK3V0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:50 -0500
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F77C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:26:09 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id p199so4531462vkp.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EFoVO+lSdVAJutntFB2ytZH6fkFJJMr2Nf5tr9t/pjk=;
        b=dl2VBn3i2owzUJl1AtbfcSuL8V2wBcn6o8l10VwLj2GCm/QIA4j1jfdIhRVCiatxTZ
         dkKMd4ahQ3Ct4PY5OimdGEr/Z9lO9v5iIVK+tU5YULtnCFI7SjP/Zn+xZ+qsEjhZ5Gly
         yiQxTRqo2wTkxqihKirfOpUZ3bBX7pTBLAEIUJJfTqebV288VSbqHk/kDU1rjYsO6nWM
         nvFcPuTYsCYUgFnLX8sXQjcFyC3s39eVc4eYDBilk6WDQmzLIbtaffR3Q85KmWpMweli
         mevxFFIoPflO0Ua/ApNxW6mgvwHopBVctEjNO0Cwnvy+gPUDYKs8jQktBIqle93LDJQX
         jNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EFoVO+lSdVAJutntFB2ytZH6fkFJJMr2Nf5tr9t/pjk=;
        b=qO+B3wJLFSliUm2PFuJ7c7jMyi+JKJM/IkNBn86lSw82tZ5LTKxlR3awmGMtDqXYyX
         7mJUJXCkNy44Ja72oepOoNwJu4RRsNMPXCgBsvmj3PeoEumN5THN9CVwbQqrpJ7rECcG
         91WI7BKXVLzjI6sLcRdMmHAl7OxtyKMKb53Mf2VvWdDW1c7movWoarogX6ROV3fiB4Xq
         gdOCm+Rxrj8CWtXv7t6PnoJGkkq07cGAXPgxxVgWNQxxfPQf1C+/FBAn5jmBStrAHvUZ
         UcWJ2iiqNxk3n4AK35WykZG8iMS78O75CY5T/BHJVEVJqXZ91sEoOrcSuy2iCwwk+V76
         PP8w==
X-Gm-Message-State: AOAM533/EskmMkBUnwcjUeNgyltZ2HZS6uGoYZ06ySJj4t2KAnNFzOu+
        FPbcBqO4HcRTIYnTqhh0H/44viyGHJivYA==
X-Google-Smtp-Source: ABdhPJyL3042aQWZSEoi23lVyCn0Reo5YY6NXEcwOycC/NF4eckOjCcAO5O7aG1GY/Z5Is4hXT92uwtEfFdQGA==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a05:6102:4b0:: with SMTP id r16mr18363459vsa.29.1606771568969;
 Mon, 30 Nov 2020 13:26:08 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:25:40 -0800
In-Reply-To: <20201130212541.2781790-1-shakeelb@google.com>
Message-Id: <20201130212541.2781790-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20201130212541.2781790-1-shakeelb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 1/2] mm: move lruvec stats update functions to vmstat.h
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
include the memcontrol.h in that file. Also this is a better place for
this interface in general. The lruvec abstraction, while invented for
memcg, isn't specific to memcg at all.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <guro@fb.com>

---
Changes since v1:
- Updated the commit message based on Johannes's comment.

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

