Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE12EBB4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhAFIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbhAFIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:50:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13AC061358
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q4so1217804plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJ6hRAKquF055Y1OoIKyzC/uqe2sOAj6aTfGxl8Ov5o=;
        b=lwRKGn/TMdWvGDwbh+I3PhFr+hVFNVubFO6mDlXQmjWeArVJAjaxvGB7GjgPg/Xl7Q
         Tr+8YP3+L1Qvii6CxDgJPvhJTSlQDOZXvOhEN+S1aqTHX/EsTK4EdwYBXhxz7Ag5RrOE
         GCce0HX0TIONUeffpf/dD9VmexumkkMbQ7AlUtgKxOu9i7Q7Qe0DuVJ8i5hF2+XD3r7F
         yY4OyX7HFREnzFvY/PJoENi/WP3Pzt4MPLmPYQNy8CElxM5KuVEdiiUJYGbnIEMdrg70
         1qRYZf8tfpYydljgGoDAY/CToBQjp5wK8ihPmgDkA9eR9/h9ZsHVlmIS0aN1ZrfSX0Bq
         sP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJ6hRAKquF055Y1OoIKyzC/uqe2sOAj6aTfGxl8Ov5o=;
        b=nAldqZvskaGMRFYy3+PRO1r7GgCXDNwC0EaXalDJiIzFmq+kmI5/YTK3nxn3gF3S6W
         scT57ZjiQ1dxD0nFQz6hVpiR+xFxPOh6T0pnWTndDrbRkT9jySwVIrOelQUf9nM6CV5K
         eRHBFmiVLYjFHuK/igwb6HbgQPUuEoJPEwEbFUrSXdUKnO3e7DbVcUG+iAasNG1NgLjg
         SjKSAuPdDnGVL2nEkkFmgnU7KGpzbK1Ya6f6qBIikdP5jkYfdez/mQl3i6mbi6gyDiDu
         c56nvVhVH7+AM/yUPdfByCueOaLNuwlqETsjXOZDRMr8sG1PUxB38qVSVmtmBMFucFK6
         R4PA==
X-Gm-Message-State: AOAM530l2JJ6N8F+LCovx1+soHwY+Eh8Kv9U6Ex/wl5zj7QhS3yRpAhY
        WVTiXEsrOHkHABKMk9QsgWjerg==
X-Google-Smtp-Source: ABdhPJzoLjhNr+suJcN6OMvbPP4mPjlFSjx8Cv3PSxcwuIgyqps+XldiscytJCAnQg0qL+Ae0XhHog==
X-Received: by 2002:a17:902:ed45:b029:da:c274:d7ac with SMTP id y5-20020a170902ed45b02900dac274d7acmr3281653plb.69.1609922990839;
        Wed, 06 Jan 2021 00:49:50 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:50 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 3/6] mm: hugetlb: fix a race between freeing and dissolving the page
Date:   Wed,  6 Jan 2021 16:47:36 +0800
Message-Id: <20210106084739.63318-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between __free_huge_page()
and dissolve_free_huge_page().

CPU0:                         CPU1:

// page_count(page) == 1
put_page(page)
  __free_huge_page(page)
                              dissolve_free_huge_page(page)
                                spin_lock(&hugetlb_lock)
                                // PageHuge(page) && !page_count(page)
                                update_and_free_page(page)
                                // page is freed to the buddy
                                spin_unlock(&hugetlb_lock)
    spin_lock(&hugetlb_lock)
    clear_page_huge_active(page)
    enqueue_huge_page(page)
    // It is wrong, the page is already freed
    spin_unlock(&hugetlb_lock)

The race windows is between put_page() and spin_lock() which
is in the __free_huge_page().

We should make sure that the page is already on the free list
when it is dissolved.

Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4741d60f8955..8ff138c17129 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
+static inline bool PageHugeFreed(struct page *head)
+{
+	return (unsigned long)head[3].mapping == -1U;
+}
+
+static inline void SetPageHugeFreed(struct page *head)
+{
+	head[3].mapping = (void *)-1U;
+}
+
+static inline void ClearPageHugeFreed(struct page *head)
+{
+	head[3].mapping = NULL;
+}
+
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
@@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	SetPageHugeFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
+		ClearPageHugeFreed(page);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		return page;
@@ -1291,6 +1308,17 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+/*
+ * Because we reuse the mapping field of some tail page structs, we should
+ * reset those mapping to initial value before @head is freed to the buddy
+ * allocator. The invalid value will be checked in the free_tail_pages_check().
+ */
+static inline void reset_tail_page_mapping(struct hstate *h, struct page *head)
+{
+	if (!hstate_is_gigantic(h))
+		head[3].mapping = TAIL_MAPPING;
+}
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -1298,6 +1326,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
+	reset_tail_page_mapping(h, page);
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h); i++) {
@@ -1504,6 +1533,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
+	ClearPageHugeFreed(page);
 	spin_unlock(&hugetlb_lock);
 }
 
@@ -1770,6 +1800,14 @@ int dissolve_free_huge_page(struct page *page)
 		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
+
+		/*
+		 * We should make sure that the page is already on the free list
+		 * when it is dissolved.
+		 */
+		if (unlikely(!PageHugeFreed(head)))
+			goto out;
+
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
 		 * which makes any subpages rather than the error page reusable.
-- 
2.11.0

