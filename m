Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528712B4ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgKPQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgKPQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:21:29 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:21:28 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g15so13213440qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxYe6xP9BxtFN11ha4FhOBWiOj//ZK0qmD5RgTOXB7I=;
        b=BBgRbdVBoiX2qs/wO793dpNhNRalVYCt6OpNRNdUYaTy4Gs9NUBQfGl9HUI1XsXdb+
         6vujxhjJeSvuVlMYM13L8Srjjp8531TC40eU7qSu/oD0H5P75GkVi4Y8WpWCdQuS4XfN
         P4CRhbbPvdUCwHR9GNuwPLPckam0U7/ZfHTOd9qnhHDHMcLmYwB5XWwV0z033Jj0jzAs
         HeitJ939FHdHjKbh67bOWGW7sKu1weGOirqOvMuFFbSfGFTKPlw5gVNaR7piw8Ih6TYZ
         TqLb5xYGf2tH+rDWuTxmcV83tcYmrFb/CE1V/M+UEP93ZkUzQ4ad7Kq49ONUaoqBa5t0
         tK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxYe6xP9BxtFN11ha4FhOBWiOj//ZK0qmD5RgTOXB7I=;
        b=BwOC8FW2Zq1NwPd/3xVVaOgbGL2xsUTQropmbuUnC7z8Dz60yTt37nt9O3+sSkOj+s
         JSzwPsKgKnSGTBLdeN5F2mp+ecKq4XTE42TBy5Tpsv05HgwT43J19oSYiCOHVxVGfktC
         lFiam7egud5iHV+oXUJGYp6fW4sxU0m+40+vt2JqYN0dG+aM3Qq5IqX/9n+qua/o9DzR
         dXqGtdpYhEhHkHpFi90E2dZzyeU45c+aHSbJySPcKzeUN6pl7/T062itDBGCyI3P5XGa
         QrQryDbzGTOzolTCETuqfpDezROYIioFh3wXeLhlsXuGa8JIi8F+3mUjbNkNy26ctOh8
         SrtQ==
X-Gm-Message-State: AOAM531XDGW1Lno9ljtKmp2W/B9ZCGoEAD/lxml3Iw8xhXuyU9BZepXY
        /WW7YV1b4HEDSVOmYPECJ8ZEBQ==
X-Google-Smtp-Source: ABdhPJxVQx0C5hJWD8pmCM3be+a3oFSYKxb2wdjIvpif+8FR9FEi5mf5pHEkVwO/xRdIusO2IVh5IQ==
X-Received: by 2002:a05:622a:1ca:: with SMTP id t10mr15376552qtw.40.1605543687844;
        Mon, 16 Nov 2020 08:21:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e49])
        by smtp.gmail.com with ESMTPSA id v204sm12900838qka.4.2020.11.16.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:21:27 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:19:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm]  be5d0a74c6:  will-it-scale.per_thread_ops -9.1% regression
Message-ID: <20201116161936.GB924708@cmpxchg.org>
References: <20201115095543.GC32502@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115095543.GC32502@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 05:55:44PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -9.1% regression of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: be5d0a74c62d8da43f9526a5b08cdd18e2bbc37a ("mm: memcontrol: switch to native NR_ANON_MAPPED counter")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	nr_task: 50%
> 	mode: thread
> 	test: page_fault2
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01

I suspect it's the lock_page_memcg() in page_remove_rmap(). We already
needed it for shared mappings, and this patch added it to private path
as well, which this test exercises.

The slowpath for this lock is extremely cold - most of the time it's
just an rcu_read_lock(). But we're still doing the function call.

Could you try if this patch helps, please?

From f6e8e56b369109d1362de2c27ea6601d5c411b2e Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 16 Nov 2020 10:48:06 -0500
Subject: [PATCH] lockpagememcg

---
 include/linux/memcontrol.h | 61 ++++++++++++++++++++++++++--
 mm/memcontrol.c            | 82 +++++++-------------------------------
 2 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20108e426f84..b4b73e375948 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -842,9 +842,64 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
-struct mem_cgroup *lock_page_memcg(struct page *page);
-void __unlock_page_memcg(struct mem_cgroup *memcg);
-void unlock_page_memcg(struct page *page);
+struct mem_cgroup *lock_page_memcg_slowpath(struct page *page,
+					    struct mem_cgroup *memcg);
+void unlock_page_memcg_slowpath(struct mem_cgroup *memcg);
+
+/**
+ * lock_page_memcg - lock a page and memcg binding
+ * @page: the page
+ *
+ * This function protects unlocked LRU pages from being moved to
+ * another cgroup.
+ *
+ * It ensures lifetime of the memcg -- the caller is responsible for
+ * the lifetime of the page; __unlock_page_memcg() is available when
+ * @page might get freed inside the locked section.
+ */
+static inline struct mem_cgroup *lock_page_memcg(struct page *page)
+{
+	struct page *head = compound_head(page); /* rmap on tail pages */
+	struct mem_cgroup *memcg;
+
+	/*
+	 * The RCU lock is held throughout the transaction.  The fast
+	 * path can get away without acquiring the memcg->move_lock
+	 * because page moving starts with an RCU grace period.
+	 *
+	 * The RCU lock also protects the memcg from being freed when
+	 * the page state that is going to change is the only thing
+	 * preventing the page itself from being freed. E.g. writeback
+	 * doesn't hold a page reference and relies on PG_writeback to
+	 * keep off truncation, migration and so forth.
+         */
+	rcu_read_lock();
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	memcg = page_memcg(head);
+	if (unlikely(!memcg))
+		return NULL;
+
+	if (likely(!atomic_read(&memcg->moving_account)))
+		return memcg;
+
+	return lock_page_memcg_slowpath(head, memcg);
+}
+
+static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
+{
+	if (unlikely(memcg && memcg->move_lock_task == current))
+		unlock_page_memcg_slowpath(memcg);
+
+	rcu_read_unlock();
+}
+
+static inline void unlock_page_memcg(struct page *page)
+{
+	__unlock_page_memcg(page_memcg(compound_head(page)));
+}
 
 /*
  * idx can be of type enum memcg_stat_item or node_stat_item.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69a2893a6455..9acc42388b86 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2084,49 +2084,19 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 	pr_cont(" are going to be killed due to memory.oom.group set\n");
 }
 
-/**
- * lock_page_memcg - lock a page and memcg binding
- * @page: the page
- *
- * This function protects unlocked LRU pages from being moved to
- * another cgroup.
- *
- * It ensures lifetime of the returned memcg. Caller is responsible
- * for the lifetime of the page; __unlock_page_memcg() is available
- * when @page might get freed inside the locked section.
- */
-struct mem_cgroup *lock_page_memcg(struct page *page)
+struct mem_cgroup *lock_page_memcg_slowpath(struct page *page,
+					    struct mem_cgroup *memcg)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
-	struct mem_cgroup *memcg;
 	unsigned long flags;
-
-	/*
-	 * The RCU lock is held throughout the transaction.  The fast
-	 * path can get away without acquiring the memcg->move_lock
-	 * because page moving starts with an RCU grace period.
-	 *
-	 * The RCU lock also protects the memcg from being freed when
-	 * the page state that is going to change is the only thing
-	 * preventing the page itself from being freed. E.g. writeback
-	 * doesn't hold a page reference and relies on PG_writeback to
-	 * keep off truncation, migration and so forth.
-         */
-	rcu_read_lock();
-
-	if (mem_cgroup_disabled())
-		return NULL;
 again:
-	memcg = page_memcg(head);
-	if (unlikely(!memcg))
-		return NULL;
-
-	if (atomic_read(&memcg->moving_account) <= 0)
-		return memcg;
-
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page_memcg(head)) {
+	if (memcg != page_memcg(page)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
+		memcg = page_memcg(page);
+		if (unlikely(!memcg))
+			return NULL;
+		if (!atomic_read(&memcg->moving_account))
+			return memcg;
 		goto again;
 	}
 
@@ -2140,39 +2110,17 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 
 	return memcg;
 }
-EXPORT_SYMBOL(lock_page_memcg);
-
-/**
- * __unlock_page_memcg - unlock and unpin a memcg
- * @memcg: the memcg
- *
- * Unlock and unpin a memcg returned by lock_page_memcg().
- */
-void __unlock_page_memcg(struct mem_cgroup *memcg)
-{
-	if (memcg && memcg->move_lock_task == current) {
-		unsigned long flags = memcg->move_lock_flags;
-
-		memcg->move_lock_task = NULL;
-		memcg->move_lock_flags = 0;
-
-		spin_unlock_irqrestore(&memcg->move_lock, flags);
-	}
-
-	rcu_read_unlock();
-}
+EXPORT_SYMBOL(lock_page_memcg_slowpath);
 
-/**
- * unlock_page_memcg - unlock a page and memcg binding
- * @page: the page
- */
-void unlock_page_memcg(struct page *page)
+void unlock_page_memcg_slowpath(struct mem_cgroup *memcg)
 {
-	struct page *head = compound_head(page);
+	unsigned long flags = memcg->move_lock_flags;
 
-	__unlock_page_memcg(page_memcg(head));
+	memcg->move_lock_task = NULL;
+	memcg->move_lock_flags = 0;
+	spin_unlock_irqrestore(&memcg->move_lock, flags);
 }
-EXPORT_SYMBOL(unlock_page_memcg);
+EXPORT_SYMBOL(unlock_page_memcg_slowpath);
 
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
-- 
2.29.1

