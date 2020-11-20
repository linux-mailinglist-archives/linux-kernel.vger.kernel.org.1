Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577A2BA29C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKTGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgKTGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2555EC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:45 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so6946087pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH/Hq+5EQ/oi9mKzhIRZsbYyftv0OzxuKDhe9q6sjjU=;
        b=oWDyzyq+dmGpl9uNGNrMrsM6EXsNni7+X0imlQSsWu4R1nxGalcVhmbeoUlxgFYiA8
         9Oy8mwvmKN2m4utS4QX/h/Gt4xfyYaHVOfrpU3wVsrh74EWb37tASIzHMGqCMR95HZr6
         Gghyyb2TOGsOwFqD16ajMcQt71XhiHnPcpry55159JjoEXpeEpmQq9s2/VS4JfJ+FOM2
         Dz5L2yie3tf8kPA8V93tIb/ZgFaVs/OXnh3je1kWzyjfgpxE0W9/eRgDYFRlL4lYFzWs
         kLBDAEvYUarT7qLPadNxBUQGXeCim/43gLgJEECnN3hSvGLIUF+mlAp+h4WPl9X+Lzra
         vSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH/Hq+5EQ/oi9mKzhIRZsbYyftv0OzxuKDhe9q6sjjU=;
        b=Oin+isLLgbVuNbZ9sTDQNFDcpe5xLyDI8rBZtqkWqxl26t5Ok8wENljckl3NJMaNxp
         vTNYtPOa5CeK3CpVAOCiDqKVdikzrRh0KdzCYTUZz8SzS8emgQYLuJ9yBeqese//IVrr
         J+tZ0Hox7bc2Kpp+DwVGmhdW2OC4NQntKLP1jSAMVWmYyIlUuDlS57P0M5h95Iq0x3JN
         AZj2tOCbwmuTsklz5PrlfOd93W6ZwNJQUs8tqnRFLKJNEGE8nGR/y0uxUcV7oQSWIhiU
         q12ncLSAYw2OODAfHlqFX0szIsS5JI5cLgQrXSlOpgcCaOgSJwpSMnr6TQu7DcLjpxJI
         yOOQ==
X-Gm-Message-State: AOAM530UXm1ER7chJPFsahNYGrvvJxxoF+1FVZfEufi0gwEHjuUrlKdA
        X8QjtxXXVTBLk3S/4r5bqYSrew==
X-Google-Smtp-Source: ABdhPJwDvG7GsuYtBL0kSSFWUAuwbp52LipL66IhZf9RaKJAS1nviAYWM5o/UWaxVi0myGODxMhyHg==
X-Received: by 2002:a17:90a:a481:: with SMTP id z1mr1626175pjp.202.1605854924788;
        Thu, 19 Nov 2020 22:48:44 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:44 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 16/21] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Fri, 20 Nov 2020 14:43:20 +0800
Message-Id: <20201120064325.34492-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
index b853aacd5c16..9aad0b63d369 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1328,6 +1328,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
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
@@ -1928,6 +1934,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1941,8 +1948,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1956,6 +1964,14 @@ int dissolve_free_huge_page(struct page *page)
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

