Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB02EBB4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhAFIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbhAFIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:50:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D1C061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v3so1200213plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90s6LK3gLF/6oFq+lOVMbrh8BJ60hxrqeIvsRF2lESM=;
        b=x3RU16oGuaT9sj2vIkIgRGzTxCPsAJdSnMd8sWAyflNmD0NnMx1rKjuocHYi397T9D
         RF+7WdL0V2t096pAAfJkwWwOl36sla9UeFGrx5nfzIaIPZV/J9pnj0/4icH7FiUKBqgN
         ldv+68PZgSRVHgvJ+pxM9ZgSUVLak8lEKUfZ0bIHj9lQH0McLpydQItaiBCUb2fo6lWE
         owYdYy9m0KdlGsCroggp8cUG7c6GIkamaMe/S80o2Jn/D4raYVvsEqvHxHBEJzHfR6rh
         nBuZhve0ItidW5g8AruxveGDuIczgSLUQzP5qi9doNPuQ51oNJ1+hp8/rLUA6Ce0QIar
         5u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90s6LK3gLF/6oFq+lOVMbrh8BJ60hxrqeIvsRF2lESM=;
        b=ffn/+DqcYb4ebnD0tK0c1t/+lBrDvO5uaNHWl9cBedZ/rfxYqc5B8udjqgo2piKKxD
         h6ObwBi6sNLiPZCnYTuhoOi+vYQ4ZSMkZlN4I/26iEytLoBvDZZdYAkUO+OYleSN1msE
         MLHvpscRWrzNuaAunEf1ta4KhE9wZL+7ITDk9efdDZbMpYD5DunrNwg3Mk3O0FKBBGSP
         hSA/AeQOnguEcdu9obIdOjwIS16WraWMfQibbFpxI8f2ER6tcqMh2S0GVpTl8vticmAN
         Fak8YLaPgpiSCprS7BLlreH3w0Jtwviz9dDjZhSstyLCmKY9IRWX0DjAummQ/rHm8xFH
         K0Fw==
X-Gm-Message-State: AOAM530UzcgQQZerbj/r6oPA+ZFI8ax8fe7QI+riS55TOgNOv00hIfOt
        tjvzOFdwq5KvWjXVHe35qwkACQ==
X-Google-Smtp-Source: ABdhPJwzdYvHQSuz/lHuo7gp/98j1oFQJ+7wjSIWQAntgC/87EdZgm6Fv43aPtl5McyEwfidSM/5KQ==
X-Received: by 2002:a17:90b:4a03:: with SMTP id kk3mr3237244pjb.97.1609922994744;
        Wed, 06 Jan 2021 00:49:54 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:49:54 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
Date:   Wed,  6 Jan 2021 16:47:37 +0800
Message-Id: <20210106084739.63318-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dissolve_free_huge_page() races with __free_huge_page(), we can
do a retry. Because the race window is small.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8ff138c17129..bf02e81e3953 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1775,10 +1775,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1805,8 +1806,10 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -1825,6 +1828,14 @@ int dissolve_free_huge_page(struct page *page)
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
 
@@ -1847,7 +1858,12 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
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

