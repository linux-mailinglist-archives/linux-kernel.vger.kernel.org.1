Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB19F299033
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782691AbgJZOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34600 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782153AbgJZOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id o129so761939pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11XX82E5ALlBD3J6m/pOUXlN+olXnY0ahZEaHw8en7Q=;
        b=zVQfczPdvHO0WAjgI/GMTiBOxzlaTaxOZvh3vn2SH4Wk0B2IymlcYWAOM7SGl7WqPT
         x/MCnfn45hQbgUyOm51SNa+iBx8Rlzmk1lgTcXHDVtn/agrnG5iR3vx7dzpbEsWe1vPG
         HSwjtSN0tSDYKYD8YRcd9H6yckYG5228OJgHkQHfWX7qv69RLbPBntpBd1/yiVwgCbz0
         pxfBU82m1SSMhV3gFdcqqUqZs02Th5i5HrMEI/m9DqYIsupt/XVaH3iYnYV08IWDNG6I
         8hi8KwmUCeB7S9rmFj1rF4KJc5uKiQeBS4iFZe8UmzPCet5YWyVItznQa18z8euez/qT
         kRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11XX82E5ALlBD3J6m/pOUXlN+olXnY0ahZEaHw8en7Q=;
        b=bUFoXhMzTXx99KQQkCfhD0XbcOUIDgGKxrnyo7lJ3upmWRo2tREfyzUM9LQjYRiwcN
         yRT9F4nrmk3+dvyqCz8hLKadUHmBH8FYOU+AyZH8Q2pBCJ0uD8SIvCpDesZSjLsPQjg1
         S84rUfLOv2GfuFXuV2RWWelban87vtBMCE5r1dI8EnwaitcSDD468t8q+NTKoYOXvqWd
         I5DVSFbAF7p7P9K+WeN5opYVj543OpqBx8fshe9Xr3vkstTQbdB27oVU+pyiQsn7gcRN
         gQY8kX5rIzif8T9kQL3/91LCjpJklwVb0Ou+ITvvOZNap8dZMjrKsGt9KHIFl8Hc8WHT
         LkWg==
X-Gm-Message-State: AOAM5322uO/c1sEWk0W9BouQ2y1xpbgpLHOioaKT2w9mZB+Fh9Dq4C5K
        tvTDjYZ2uWaadd2ZkXWHrgE6ag==
X-Google-Smtp-Source: ABdhPJz5Imrs9uD0mPyJBeReMuMs5DSGfhaWTNutnMIFEPMis/AmwcRJNx6daQhlnOuERkr7EhbxgA==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr17836069pgt.145.1603724124796;
        Mon, 26 Oct 2020 07:55:24 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 14/19] mm/hugetlb: Clear PageHWPoison on the non-error memory page
Date:   Mon, 26 Oct 2020 22:51:09 +0800
Message-Id: <20201026145114.59424-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we reuse the first tail page, if we set PageHWPosion on a
tail page. It indicates that we may set PageHWPoison on a series
of pages. So we need to clear PageHWPoison on the non-error pages.
We use the head[3].mapping to record the real error page index and
clear non-error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e3209fd2e6b2..7198bd9bdce5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1806,6 +1806,21 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 {
 	free_gigantic_page(page, huge_page_order(h));
 }
+
+static inline bool subpage_hwpoison(struct page *head, struct page *page)
+{
+	return page_private(head + 4) == page - head;
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	set_page_private(head + 4, page - head);
+}
+
+static inline void clear_subpage_hwpoison(struct page *head)
+{
+	set_page_private(head + 4, 0);
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -1853,6 +1868,19 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 	free_gigantic_page(page, huge_page_order(h));
 	spin_lock(&hugetlb_lock);
 }
+
+static inline bool subpage_hwpoison(struct page *head, struct page *page)
+{
+	return true;
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+}
+
+static inline void clear_subpage_hwpoison(struct page *head)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1877,6 +1905,9 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
+
+		if (PageHWPoison(page + i) && !subpage_hwpoison(page, page + i))
+			ClearPageHWPoison(page + i);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
@@ -2066,6 +2097,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	free_huge_page_vmemmap(h, page);
 	/* Must be called before the initialization of @page->lru */
 	vmemmap_pgtable_free(h, page);
+	clear_subpage_hwpoison(page);
 
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
@@ -2436,6 +2468,7 @@ int dissolve_free_huge_page(struct page *page)
 			SetPageHWPoison(page);
 			ClearPageHWPoison(head);
 		}
+		set_subpage_hwpoison(head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-- 
2.20.1

