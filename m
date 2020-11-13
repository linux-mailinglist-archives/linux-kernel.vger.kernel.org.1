Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF902B1991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKMLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgKMLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:04:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27489C061A4F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:35 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so6794302pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/VUjVOYmsQwRKKait0CFs56LeGV8YzJZLIDQdYffzc=;
        b=xgIg3/QKGf6dxSoHKltSyre1Ol0iIRn4K27fY/8MiyrkhwK/SpyaIcaTlJheIKDlYY
         xHEt7C/tCkUHdvFjx6xSmMyGKpwSCtx5FF0QMhdZMw9l+KGR490zwmuBz0wNaJcr3AXu
         msqsZorMyilBA9m2JWYK3oOMPGAYRYljK9goKfyYBU6A1TZrB95VZpk5XgA6DmnD8UEP
         cqKCmBOENBH8FJlRNxYy3R+PxsqhxdJjYQNMVWV/k+jO34dupVzR9CwnRfWiqVBem3bW
         jP6v/1AWwPyd4jzVbWCH0Cgq/ManlpIVAp57aOowGE18K0dnczi5qx25bPvAyDDXKJqo
         9HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/VUjVOYmsQwRKKait0CFs56LeGV8YzJZLIDQdYffzc=;
        b=uek8m1gsUQFzXMuB2vFhgtNJpU5LB2Wm4o3Yg6vx+gE3tFqkcQTTQrz+UBNmyfKMQN
         zin53il3HQ78Y1tBd0KdPCrut3bNwbRTVjps8/Ou6wwhME8YOQWPoyT3KrazRcXfYMDC
         0RC9YQDV7tU5xRNaRoMJ0L+NqcKgxf4SLkwZl5tPTrnLlOZHBCI3eu83U4G4E3Bfv4+W
         DMN/sL0RSCszxKOBgdrUpk4vzbBC8Es+y5dzu7l9dq0jp3P3YRUxSpLhaCLrDPcs2yaC
         xySlidBA4gB41rxMrQ7hZVhzwUVYJkEw7FZ8ynXtJliTtT8uqFKcyVnSjstaahNlj4Ey
         F5Yg==
X-Gm-Message-State: AOAM530FqrLKCDzmMvJBZHHMfQw8LmYIXml760LNsAwiXbvNp3e4L8Mp
        PY2IbbVCnFwKBT4cgxuv1p6JiA==
X-Google-Smtp-Source: ABdhPJxz6GV3Upa7UIWM1o5ZtyqPLk+RKv5PF1MNTl6oGRUC5i/1X3kV5tm984yPZsLs/yu0dsyXSw==
X-Received: by 2002:a63:1924:: with SMTP id z36mr1660267pgl.354.1605265414712;
        Fri, 13 Nov 2020 03:03:34 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 14/21] mm/hugetlb: Support freeing vmemmap pages of gigantic page
Date:   Fri, 13 Nov 2020 18:59:45 +0800
Message-Id: <20201113105952.11638-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gigantic page is allocated by bootmem, if we want to free the
unused vmemmap pages. We also should allocate the page table. So
we also allocate page tables from bootmem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  5 +++++
 mm/hugetlb_vmemmap.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 13 ++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eed3dd3bd626..da18fc9ed152 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,6 +506,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	pte_t *vmemmap_pte;
+#endif
 };
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba927ae7f9bd..055604d07046 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2607,6 +2607,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
+		gather_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -2659,6 +2660,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			break;
 		cond_resched();
 	}
+
+	if (hstate_is_gigantic(h))
+		i -= gather_vmemmap_pgtable_prealloc();
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 58bff13a2301..47f81e0b3832 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -75,6 +75,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/bootmem_info.h>
+#include <linux/memblock.h>
 #include <asm/pgalloc.h>
 #include "hugetlb_vmemmap.h"
 
@@ -173,6 +174,60 @@ int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
 	return -ENOMEM;
 }
 
+unsigned long __init gather_vmemmap_pgtable_prealloc(void)
+{
+	struct huge_bootmem_page *m, *tmp;
+	unsigned long nr_free = 0;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
+		struct hstate *h = m->hstate;
+		unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+		unsigned int pgtable_size;
+
+		if (!nr)
+			continue;
+
+		pgtable_size = nr << PAGE_SHIFT;
+		m->vmemmap_pte = memblock_alloc_try_nid(pgtable_size,
+				PAGE_SIZE, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+				NUMA_NO_NODE);
+		if (!m->vmemmap_pte) {
+			nr_free++;
+			list_del(&m->list);
+			memblock_free_early(__pa(m), huge_page_size(h));
+		}
+	}
+
+	return nr_free;
+}
+
+void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					struct page *page)
+{
+	struct hstate *h = m->hstate;
+	unsigned long pte = (unsigned long)m->vmemmap_pte;
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	/* Store preallocated pages on huge page lru list */
+	INIT_LIST_HEAD(&page->lru);
+
+	while (nr--) {
+		struct page *pte_page = virt_to_page(pte);
+
+		__ClearPageReserved(pte_page);
+		list_add(&pte_page->lru, &page->lru);
+		pte += PAGE_SIZE;
+	}
+
+	/*
+	 * If we had gigantic hugepages allocated at boot time, we need
+	 * to restore the 'stolen' pages to totalram_pages in order to
+	 * fix confusing memory reports from free(1) and another
+	 * side-effects, like CommitLimit going negative.
+	 */
+	adjust_managed_page_count(page, nr);
+}
+
 /*
  * Walk a vmemmap address to the pmd it maps.
  */
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a5054f310528..79f330bb0714 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -15,6 +15,9 @@
 void __init hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
 void vmemmap_pgtable_free(struct page *page);
+unsigned long __init gather_vmemmap_pgtable_prealloc(void);
+void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					struct page *page);
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
@@ -36,6 +39,16 @@ static inline void vmemmap_pgtable_free(struct page *page)
 {
 }
 
+static inline unsigned long gather_vmemmap_pgtable_prealloc(void)
+{
+	return 0;
+}
+
+static inline void gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					       struct page *page)
+{
+}
+
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
-- 
2.11.0

