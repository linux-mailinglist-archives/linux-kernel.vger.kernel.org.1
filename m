Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707332E90B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhADHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbhADHDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:03:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C478C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:02:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq13so9465583pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ecn176xO4zQ8Y5+qvJO+NXfQmQmbZVPueFRQXY2zG70=;
        b=V1viqRcLBhAjMI4s5hkLwNzsHo44mZ1JVGTUfwxULDQ4QljgyDmKFC7FWmn5TTH6Sx
         OCeUI59t+P/ZcDGB60unp9LOjdx5uwLi8PxK6IuO7n5b1teoQDHDUq8OXtp7K7WySchi
         5r8YZA+2YSFbwY1YdjU1RoPe1YGiEJSVH4Lc2tIVDFxCTJDL6iKXy9WgAFNsygxk/izN
         N+Pcs5HnmXZxLZwHBB7IDlFDZ8RWKR0aXdVYHtHjPv+jcqvqS2S4Czad3Z00iGBc3Set
         pbHT3VLWs30Kk3+NDES94Y4BM5SIDCw1xtAB4eVrFsJjVs00HWyFm0/q/aUESg6fL6B9
         C7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ecn176xO4zQ8Y5+qvJO+NXfQmQmbZVPueFRQXY2zG70=;
        b=SzPhQOQQxXozSNQfZsv/HGgmIEMtjWo7pbHTbqhTAiqUiIMI6pbeWNnJdeu/KWhrm5
         08oT8IWu/FdAFmIGD0gPt4wW9nBK9c6VbZQDz+y36TRz93ggTg/4VuK1QPNE3PzY7/06
         p8XJhwkWjgzuXzDEeqAL2J6KNQBXKyFekC5L5Mx1QIvnBBF12fUr0jNXfzS74Dblfb5e
         VUEv7V0sRnZk0sDaNNkzfs4axMNEpgQHrUMA7DtI6hzFYcKO4izCd6T4JGV7lQMNoz0a
         5dDag0fjNgcSeqv+qqSQI4kKFAD/IGxwQvHOgStp96bF1reMW1LCGuOgJTCyIGrLZ092
         moYg==
X-Gm-Message-State: AOAM533C9W9lK343dorxM4qFbUFtDjf2wWeiccimEmKW2wc0wBAYCCRx
        r8hVStEDvTLqUioaFUamYWdW5g==
X-Google-Smtp-Source: ABdhPJxoUVmQraBDL53NIFbrMpNmkyyk7mkatnVzcuLbK4z/W+93TnPT0tjGcq72noGrgnbp0oofLg==
X-Received: by 2002:a17:902:b948:b029:dc:102c:b4a with SMTP id h8-20020a170902b948b02900dc102c0b4amr62777604pls.3.1609743753038;
        Sun, 03 Jan 2021 23:02:33 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:02:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/6] mm: hugetlb: fix a race between freeing and dissolving the page
Date:   Mon,  4 Jan 2021 14:58:40 +0800
Message-Id: <20210104065843.5658-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f3bf1710b66..72608008f8b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
+static inline bool PageHugeFreed(struct page *head)
+{
+	return page_private(head) == -1UL;
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
 
@@ -1770,6 +1788,36 @@ int dissolve_free_huge_page(struct page *page)
 		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
+
+		/*
+		 * There is a race condition between __free_huge_page()
+		 * and dissolve_free_huge_page().
+		 *
+		 * CPU0:                         CPU1:
+		 *
+		 * // page_count(page) == 1
+		 * put_page(page)
+		 *   __free_huge_page(page)
+		 *                               dissolve_free_huge_page(page)
+		 *                                 spin_lock(&hugetlb_lock)
+		 *                                 // PageHuge(page) && !page_count(page)
+		 *                                 update_and_free_page(page)
+		 *                                 // page is freed to the buddy
+		 *                                 spin_unlock(&hugetlb_lock)
+		 *     spin_lock(&hugetlb_lock)
+		 *     enqueue_huge_page(page)
+		 *     // It is wrong, the page is already freed
+		 *     spin_unlock(&hugetlb_lock)
+		 *
+		 * The race window is between put_page() and spin_lock() which
+		 * is in the __free_huge_page().
+		 *
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

