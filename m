Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C167E2F5F00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbhANKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbhANKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272CC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:39 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b3so3110828pft.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjSQX/DBq/dGDHDtI/eYRgdlVUdpJ6hklm+hnz97cjg=;
        b=EvUu9erDPTKjFMQD3ILkX2jgicEwa6KcpRq1JdSNIbVE1ROOWJ8eAvMmG2oczZokaA
         BDy8DaYvMSLKYCsF8qHjNPQg1UYIqEby4XLJrII5shLRtOR6/2ZEFEIkC1NClk7Wkqlw
         2cFMt5Cqwq5hILU44hNKzKCCpS2pr7faUepyWgoMhhd5wYjLAAwuXX6fScFUkqLERxNK
         LPnOPS9afJYFuW3gu6hjFsMjgaC7H8sk/TRwOB3awiY0PXJsQphqAabSLRRWV8pPjJca
         9ab7sQEpz6wb7RroZWJAgIZ3hoQ9H78mGwKbb3UPuP6nwGZ7TwAMyNR4pn9yplaRHjsS
         me/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjSQX/DBq/dGDHDtI/eYRgdlVUdpJ6hklm+hnz97cjg=;
        b=aKr4CbUECZgcUefHdKqDsW6MmhYIqx2LmxRozpktDmAxdfPs9dpjhHKtfA5Oadw0TW
         teQNQHDn+XiVdln/9ZwmraMcE0+FGT6jxygrNMLP0MQyk8WkP9Ww10o2D9qKi40u/QXB
         9rxwk4IxbvFVhEp2fNE/RNGzt90PWpCH4GONDwLBJXOOOcor4PyAaADmLkU7yWcfT9pn
         3aBfBAKmKe/jgHoz0MVrG6SPS2gmMLQw96dsrFSQBZxGpmq8vR+NtzW9KlsKfRPtp3dB
         Q3MnSjQ0qOzHjgXYlvhccoWABDWLV7SvxxTPkQvYJJDPczXJLIo841KsRVdVaJTNzPoZ
         7LFw==
X-Gm-Message-State: AOAM531oFKpWmxOapwy/7DYE+hEKaM2KlcgcsZIrjRKh1+n898XEQzLo
        vmQa4s7m96Jkkbp4ONg7CN3Iww==
X-Google-Smtp-Source: ABdhPJzETpjNokcaByGnWQuYbXi9vblyTMKU1rIC+MG3Lq3WcuLgGvyZScNVoVyzG4ltBJHwt445WA==
X-Received: by 2002:a63:50a:: with SMTP id 10mr6899209pgf.273.1610620718661;
        Thu, 14 Jan 2021 02:38:38 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id l12sm4970112pjq.7.2021.01.14.02.38.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:38:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, stable@vger.kernel.org
Subject: [PATCH v5 3/5] mm: hugetlb: fix a race between freeing and dissolving the page
Date:   Thu, 14 Jan 2021 18:35:13 +0800
Message-Id: <20210114103515.12955-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210114103515.12955-1-songmuchun@bytedance.com>
References: <20210114103515.12955-1-songmuchun@bytedance.com>
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

The race windows is between put_page() and dissolve_free_huge_page().

We should make sure that the page is already on the free list
when it is dissolved.

Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4741d60f8955..1b789d1fd06b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
+static inline bool PageHugeFreed(struct page *head)
+{
+	return page_private(head + 4) == -1UL;
+}
+
+static inline void SetPageHugeFreed(struct page *head)
+{
+	set_page_private(head + 4, -1UL);
+}
+
+static inline void ClearPageHugeFreed(struct page *head)
+{
+	set_page_private(head + 4, 0);
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
@@ -1504,6 +1521,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
+	ClearPageHugeFreed(page);
 	spin_unlock(&hugetlb_lock);
 }
 
@@ -1754,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
 
+retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
 		return 0;
@@ -1770,6 +1789,28 @@ int dissolve_free_huge_page(struct page *page)
 		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
+
+		/*
+		 * We should make sure that the page is already on the free list
+		 * when it is dissolved.
+		 */
+		if (unlikely(!PageHugeFreed(head))) {
+			spin_unlock(&hugetlb_lock);
+
+			/*
+			 * Theoretically, we should return -EBUSY when we
+			 * encounter this race. In fact, we have a chance
+			 * to successfully dissolve the page if we do a
+			 * retry. Because the race window is quite small.
+			 * If we seize this opportunity, it is an optimization
+			 * for increasing the success rate of dissolving page.
+			 */
+			while (PageHeadHuge(head) && !PageHugeFreed(head))
+				cond_resched();
+
+			goto retry;
+		}
+
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
 		 * which makes any subpages rather than the error page reusable.
-- 
2.11.0

