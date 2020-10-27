Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8729A623
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508749AbgJ0IEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:04:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508699AbgJ0IDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:03:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id o129so459366pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiglRpBNWkrLFEUzSubzu7HQqvI3OKCdlqP2Lx2y8is=;
        b=P+Nz2tG9WB/qhj+FCO+gcFTyNF1I6MsxBKRw9kmsx8p6kTqOEUDww4WezfUMzA7ids
         ac0Zw4GET/vXhxCf8QG68dkLY5mwIlJRUt9Gm+jLihmcX0NoOz+Cp5twgR8DGsYW67qd
         PZLKcV4nEUGWtiN0RpyT1yxo4Vpm4Vkn4poFL4T2cKC8G6zrJxeA05Boleywdh/UF3ZC
         mRUnhoac0MFVouztQxbXWFTjsi/iFZUkv7BWXoxoXhK2tMu9Ey2RFTz7zACV5EhVfAwX
         vnFuZ5csx1UlaEVc6ELswrsJ5ZO+KZAEF/R9wChhpmuL/z63EgKtfFu5WfRU6MxRFo7g
         u0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiglRpBNWkrLFEUzSubzu7HQqvI3OKCdlqP2Lx2y8is=;
        b=W2gGkxZCgdyU56s3JGLrmFeJYHf6U2LNSx8+c1mkwk78w1RluuHNBK0f/jYg7ovC3q
         PfK52fjnbgGWM7567bpa/HFZadJfm8ufJY/Th/yYkAhL9Whw6Zivjq/BMThJoNgnXbvm
         awpCT5iL7asS9jSDMOMnL4AUF1Tnb8QieHVktbKpQpOTkG8vuKUiQ9VtGryI0BOjJDU9
         wHRYYHCZhQ2onVJEr6wLSBNnfOzFeMOp6CRqPWjtwmdDl8JNz4BHKI52HPLsJVqFoKKI
         2gbHL3sAvefdwXV8TwTQ0TBPT90o+oyQek8ZUfe/ZDY3muq017nI86YMCaT2LEewXye1
         Ao9Q==
X-Gm-Message-State: AOAM531BVX3IF6rbF0JuTd4RKPQIG3VpLQPULsGjbYho1h3IglLGdKsu
        AZMIYImCbSFbcen9W1arcp0+zg==
X-Google-Smtp-Source: ABdhPJxqNnFSCS9aSZpbv6+4QVNMOZB8yeIGk564y0BvOrg9NvzTp9pcjm2oymtvYwf9KBriDCrUgQ==
X-Received: by 2002:aa7:91c8:0:b029:155:c7c1:3fae with SMTP id z8-20020aa791c80000b0290155c7c13faemr1060014pfa.74.1603785834731;
        Tue, 27 Oct 2020 01:03:54 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/5] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
Date:   Tue, 27 Oct 2020 16:02:56 +0800
Message-Id: <20201027080256.76497-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201027080256.76497-1-songmuchun@bytedance.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can reuse the code of mem_cgroup_lruvec() to simplify the code
of the mem_cgroup_page_lruvec().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 44 +++++++++++++++++++++++++++-----------
 mm/memcontrol.c            | 40 ----------------------------------
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 95807bf6be64..5e8480e54cd8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -451,16 +451,9 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 	return memcg->nodeinfo[nid];
 }
 
-/**
- * mem_cgroup_lruvec - get the lru list vector for a memcg & node
- * @memcg: memcg of the wanted lruvec
- *
- * Returns the lru list vector holding pages for a given @memcg &
- * @node combination. This can be the node lruvec, if the memory
- * controller is disabled.
- */
-static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
-					       struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_node_lruvec(struct mem_cgroup *memcg,
+						    struct pglist_data *pgdat,
+						    int nid)
 {
 	struct mem_cgroup_per_node *mz;
 	struct lruvec *lruvec;
@@ -473,7 +466,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	mz = mem_cgroup_nodeinfo(memcg, nid);
 	lruvec = &mz->lruvec;
 out:
 	/*
@@ -486,7 +479,34 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return lruvec;
 }
 
-struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
+/**
+ * mem_cgroup_lruvec - get the lru list vector for a memcg & node
+ * @memcg: memcg of the wanted lruvec
+ *
+ * Returns the lru list vector holding pages for a given @memcg &
+ * @node combination. This can be the node lruvec, if the memory
+ * controller is disabled.
+ */
+static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
+					       struct pglist_data *pgdat)
+{
+	return mem_cgroup_node_lruvec(memcg, pgdat, pgdat->node_id);
+}
+
+/**
+ * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
+ * @page: the page
+ * @pgdat: pgdat of the page
+ *
+ * This function relies on page->mem_cgroup being stable - see the
+ * access rules in commit_charge().
+ */
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
+						    struct pglist_data *pgdat)
+{
+	return mem_cgroup_node_lruvec(page->mem_cgroup, pgdat,
+				      page_to_nid(page));
+}
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70345b15b150..7097f3fc4dee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1332,46 +1332,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
-/**
- * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
- * @page: the page
- * @pgdat: pgdat of the page
- *
- * This function relies on page->mem_cgroup being stable - see the
- * access rules in commit_charge().
- */
-struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
-{
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	if (mem_cgroup_disabled()) {
-		lruvec = &pgdat->__lruvec;
-		goto out;
-	}
-
-	memcg = page->mem_cgroup;
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
-	if (!memcg)
-		memcg = root_mem_cgroup;
-
-	mz = mem_cgroup_page_nodeinfo(memcg, page);
-	lruvec = &mz->lruvec;
-out:
-	/*
-	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->zone here;
-	 * and if offlined then reonlined, we need to reinitialize it.
-	 */
-	if (unlikely(lruvec->pgdat != pgdat))
-		lruvec->pgdat = pgdat;
-	return lruvec;
-}
-
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
-- 
2.20.1

