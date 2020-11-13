Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363202B1997
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKMLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgKMLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:04:58 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0DCC061A56
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:57 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f38so6832016pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH/Hq+5EQ/oi9mKzhIRZsbYyftv0OzxuKDhe9q6sjjU=;
        b=JSAXh7YJcNqokebrRU/knl5iBmIG32+URS2ypuie9/klOs+fNW0xtemZbdsT107jfi
         lGi/TvUQdp5z0vY73XRc/ke5HV2aJ+najoRsKGG6lVTCKaB0FzSPbjvmw9BLEZV9+eUG
         83de/2ing92BFVJLQSpg4tP+1UDpnLvpFGtjyYRO4wcTDKbJLIQ2N2ri6hPeKBOk1blq
         Am9Lx3pv2T9+zLAsEMK1zi2XjGmY65iKnJGaK2dCgYZyeTR7AYAFn5TePk1u3QXQu5VY
         LD5W9BRuPxg9l0FK/SApUcfDPtVMoODKZAAqajaTDPmP60/aR4gD/My6VACXBDkrOT29
         jwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH/Hq+5EQ/oi9mKzhIRZsbYyftv0OzxuKDhe9q6sjjU=;
        b=opjU9UAnkkXtMSMAtr1h/zGw66GKouV9Sj8hGR2EvIBuJAXm5oBogBvA+gRrA4UNtg
         4PnhKUtCjvuKjy9OED5WX0PnB5OE3kT8qHWc6wNL0rPetmbConYZawrQys2O9JkAyxIA
         n2mYLbVpgnVsPklzu8NDfvLoKIaY3kGsaCUL59Zy90cgMwFOkbSxlMYSxqvgofTa1B6N
         uOKR0SyHbV1zIM/9ONrIJ3R+YhNK98LcWaxfkYVesAYA6gcTZoVEXSNEWaSZ3IIht91v
         dLhjZj2kku82FBbFmzr5IuvGLN6pREH0PqU7D3LeMtab7Nay8GpCENPBjmKtN+PN2kro
         6c6Q==
X-Gm-Message-State: AOAM532tiXzaH4X2pokHlVoZpEhtucA8UL785+7R37r/qPHWmgQO5Q2e
        D0Lxof5XlTpfag2U0AZp7AzzEg==
X-Google-Smtp-Source: ABdhPJxTymz2DHvUvoJr0lCEEIthLi1WvzQlf/oZUISFpWsZvJkwBMH21yPfXI+wXT2WzCZZPRkW/A==
X-Received: by 2002:a63:1865:: with SMTP id 37mr1712731pgy.322.1605265436829;
        Fri, 13 Nov 2020 03:03:56 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.03.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:56 -0800 (PST)
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
Subject: [PATCH v4 16/21] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Fri, 13 Nov 2020 18:59:47 +0800
Message-Id: <20201113105952.11638-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
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

