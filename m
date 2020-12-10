Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE82D524F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgLJD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbgLJD7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:59:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA4C0611D0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 19:58:47 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e2so2966926pgi.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 19:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=176PtjQ6t2DAjS5fdPopd9OD/+n7FzwmGTlXcCy1dm8=;
        b=C7ZdSfiF0xslYxjshrxSgotJFtLtKbl5wrYbZ9v46FjB3W28QLcKfWl2JQ2xRxMyM7
         dxg10a27BHF9IK0doSiNQClnKl/vt8BpDAzEzd8tFdhnYVosBD7OSxORqbfQ3eMs9B0g
         +b241NsSvcEg1FqKUKf0i0XDu+8Yy5hFN92yWeOUZ1efPLFR/5yFFNWIVRHTqjc8Zdmi
         i/Ep2qicMBkuIgwxTOLFFEWX1E9Al7VBbSMS29RUCY0bxOygI1ZXNFztmPLc+RRv8D9g
         1V6qWvmmmJbitVGwTuuRVoOpJFP6QXGM0s1d00ykGPQwDiMw5hCZqan4QE/dT10ZlgP5
         A9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=176PtjQ6t2DAjS5fdPopd9OD/+n7FzwmGTlXcCy1dm8=;
        b=eYtGR6fvcNe6OhAJns/hGpDG3n4K1CbBlamVlEKMDz+WOZf8664G0j8EBIJtM20Mhm
         ugUnLyPmQoSE4202JqwJEL+APXgPvHoDBr1tKsR0+yKGkzYHWpbm2fRvcryuTBviIFHu
         IO6n4EgWg+pyZ7PSaYQgnaLGDOyaO1BFQkzawYR2bpN4d4pVBRLXGjoTC5kJDLQpbHE2
         4dHY5i0uGsgVKChMYk1jCAL5I9tGf6Fg20XbU2gO/agOoTgicNBwiLJwuxjqwMhXuyGi
         3Mxy4Sdm/BROx02bTruq8eJhwsrnkXEmv/1SgbLNA/zpxWA8QlbQz6Lwjl+SAJJmJRkK
         XH0w==
X-Gm-Message-State: AOAM533dkYvtukiVC37HcQVtNsN20MVssE3htovMVa1qt2+IS/rnF2pi
        ebVnjpHNXKMeumHMcwndvdC65w==
X-Google-Smtp-Source: ABdhPJzsBvpsa9mZt3NgVVOCD/xXL2ypdTNbGz/hRLJgNw7uQbI9CJZe5EVzyquqfN1+4t/uRnA3Zw==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr5418654pjb.2.1607572727573;
        Wed, 09 Dec 2020 19:58:47 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.58.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:58:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 08/12] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Thu, 10 Dec 2020 11:55:22 +0800
Message-Id: <20201210035526.38938-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should flush work when dissolving a hugetlb page to make sure that
the hugetlb page is freed to the buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 06157df08d8e..2e7a59b44364 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1326,6 +1326,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
 }
 static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
 
+static inline void flush_hpage_update_work(struct hstate *h)
+{
+	if (free_vmemmap_pages_per_hpage(h))
+		flush_work(&hpage_update_work);
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	/* No need to allocate vmemmap pages */
@@ -1865,6 +1871,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1878,8 +1885,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1893,6 +1901,14 @@ int dissolve_free_huge_page(struct page *page)
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * We should flush work before return to make sure that
+	 * the HugeTLB page is freed to the buddy.
+	 */
+	if (!rc && h)
+		flush_hpage_update_work(h);
+
 	return rc;
 }
 
-- 
2.11.0

