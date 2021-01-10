Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486C22F0741
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbhAJMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbhAJMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:42:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD800C0617A6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x126so9300927pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhlvFEw8jdfKSbqCegVc8DBdoL7Xly+0YXsiaFK68GM=;
        b=nKa0zwCZ2svXtZUVz4u93tOukfQ1rtXnodZzLZhzNw1D0tYe9JtTZFDbpoY1bK9Ae4
         p0r4U3LV61u3OUIaXpKBU6s8bKiOAbz3MGr/sYXcISksN4RvmQJYhO96VW2igbvtWCZO
         tuweADoElAyPvb5rZaYt+9AC0vLhUxyFP3/0SPCeUHpsigUZLZO6gDn0Tczo8q3OUNax
         JACLi7hxFufRkJs4tq2LpErAFIoyJuRMX4fhVybpmp1T5siBX/mHgdkb87tEpWSyPtFV
         1HFdOc6YrluZJzk2TcViU0uhqtJOv1KOVP4gFNFblSzqJoyQua1kNOFf+reaUu8xZLwS
         DUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhlvFEw8jdfKSbqCegVc8DBdoL7Xly+0YXsiaFK68GM=;
        b=rD/bzzj9wgY5/bIP9RnepXVk7iAu/BYYvA3TTpZ5TjnwzdKfA9PcRs2iU2Lq5vdqS4
         VFdsyB7aV50iJd4P7GAqvYpPzoa2pmZ+shtPqZwLIpcgrx+hUfHUPCNAQRdGC2GM6l8O
         md8M5/OMtfyaFKYTZ52f4HZvF8TmiteiSOCMf9zK9l8lO2Dv3KOw5t+Ek4RZY+S+ZlSO
         vEeHnrbYFSSHOp5fh8TVDZ+hMMF1MAeHRl3MxieFwoA2mEh9hcP3rD28SWBG0TQkhGVN
         6v91EkbBh3QLi3bQW9mvDaWwMYgHg06PTiiQ22itJdN6nhSJAm0LVrQGnANRYytAIFwT
         Q9LQ==
X-Gm-Message-State: AOAM530fOh1r0qpowVCVxZr2bYhQ0vGM10tke5mjlGi51qtVCQblyeiD
        gvLHut0VMgy0S1qrYCZ+4gJn5A==
X-Google-Smtp-Source: ABdhPJz16FQS6hGSFtI9gh/TUdc46pPEDeMctnvCGgRCVHKmu4bKwdmuvDxjYQLBqeHMn1ZWiX3K6Q==
X-Received: by 2002:aa7:8ad0:0:b029:1a9:3a46:78d1 with SMTP id b16-20020aa78ad00000b02901a93a4678d1mr12335934pfd.77.1610282499413;
        Sun, 10 Jan 2021 04:41:39 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p9sm16176960pfq.136.2021.01.10.04.41.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 04:41:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
Date:   Sun, 10 Jan 2021 20:40:15 +0800
Message-Id: <20210110124017.86750-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210110124017.86750-1-songmuchun@bytedance.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between dissolve_free_huge_page() and put_page(),
and the race window is quite small. Theoretically, we should return
-EBUSY when we encounter this race. In fact, we have a chance to
successfully dissolve the page if we do a retry. Because the race
window is quite small. If we seize this opportunity, it is an
optimization for increasing the success rate of dissolving page.

If we free a HugeTLB page from a non-task context, it is deferred
through a workqueue. In this case, we need to flush the work.

The dissolve_free_huge_page() can be called from memory hotplug,
the caller aims to free the HugeTLB page to the buddy allocator
so that the caller can unplug the page successfully.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a9011e12175..a176ceed55f1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * nothing for in-use hugepages and non-hugepages.
  * This function returns values like below:
  *
- *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
- *          (allocated or reserved.)
- *       0: successfully dissolved free hugepages or the page is not a
- *          hugepage (considered as already dissolved)
+ *  -EAGAIN: race with __free_huge_page() and can do a retry
+ *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
+ *           (allocated or reserved.)
+ *       0:  successfully dissolved free hugepages or the page is not a
+ *           hugepage (considered as already dissolved)
  */
 int dissolve_free_huge_page(struct page *page)
 {
@@ -1793,8 +1794,10 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head)))
+		if (unlikely(!PageHugeFreed(head))) {
+			rc = -EAGAIN;
 			goto out;
+		}
 
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
@@ -1813,6 +1816,14 @@ int dissolve_free_huge_page(struct page *page)
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * If the freeing of the HugeTLB page is put on a work queue, we should
+	 * flush the work before retrying.
+	 */
+	if (unlikely(rc == -EAGAIN))
+		flush_work(&free_hpage_work);
+
 	return rc;
 }
 
@@ -1835,7 +1846,12 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
 		page = pfn_to_page(pfn);
+retry:
 		rc = dissolve_free_huge_page(page);
+		if (rc == -EAGAIN) {
+			cpu_relax();
+			goto retry;
+		}
 		if (rc)
 			break;
 	}
-- 
2.11.0

