Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B62F937A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbhAQPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbhAQPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:15:23 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE8C061798
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q4so7222449plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dASYKFPFHjiUnTmEMcq8ifWiWDwHax4a4AuznfbkXhg=;
        b=fWMqIgVimAbohcSo2EpgXsd0ZyJcaZzla1+P95eOMhnyBL67qm5KAucfNimJ/Y8PPb
         6lF03rRUJiEGIKgB/d1AF+BsYCsr8ZT/Pkx2QnCiOzg30HL6dN6laFtm47lJUIMes242
         fLMU5PBdfikWpoU3XtBfxGbxS21r+dNKUIs0erFDXDnITMS6DorxcHLayrDhExX+u1kd
         LKu1pnMupUMbBV/W81fmIsxl2VIip0Rjx4irqQjbsT4/3aLaB+AP+zMyGWoJlzg4xCTQ
         XUmjXCkW9w6/ar5htk+JxAIb65JCm2a9ZELvCKmKVdv+ntoLKXK7+b4P7Ny7qpDyk5jR
         /pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dASYKFPFHjiUnTmEMcq8ifWiWDwHax4a4AuznfbkXhg=;
        b=FRRkZu7Ee8WKGeT3U2F5OUty9fZxJCmLGAYQAbUfSa/dvvtPnKBZyyBpe9XGXxtn1q
         Q+8YRzenEqQycYH/8CBLS+ue5eMwP6GwWrSBgf+qyEde9cG2UlSkevlPGB3zVkvJ4+We
         kiMchOLZsA5394P15dn+JY/lFK93pL/rC7j2EStD9iDYVeMPp99mYd71PQ20n5d3Ec4U
         R0e7V2L7m5YBEy04SKaByEBoyqX2se8FXtFxMdDum2AuDdzyQQm2G2VLDCDEk+b9SKcF
         tP0xxWTMELdzLXv93gUt7MJC/MCTYudYQTnJW1Fw/PmG6HO34aru9QmN4sBQfTmfu4wH
         OXnA==
X-Gm-Message-State: AOAM530dYgDlP1QFztf+/iawSaCFqiIvZPW+FiOg63+ngPvNZDSEe/MI
        nsM56VmpDpMrL+suljSIsxTZVw==
X-Google-Smtp-Source: ABdhPJyLwFkAudGuCIo1upuVxlqgazAYTsuwjbaVLNbfgDm7FzQG69F7R66FSfzEmpPd+yF9XBCLig==
X-Received: by 2002:a17:90a:df84:: with SMTP id p4mr21024876pjv.81.1610896494542;
        Sun, 17 Jan 2021 07:14:54 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:14:54 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v13 07/12] mm: hugetlb: flush work when dissolving a HugeTLB page
Date:   Sun, 17 Jan 2021 23:10:48 +0800
Message-Id: <20210117151053.24600-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should flush work when dissolving a HugeTLB page to make sure that
the HugeTLB page is freed to the buddy allocator. Because the caller
of dissolve_free_huge_pages() relies on this guarantee.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6caaa7e5dd2a..3222bad8b112 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1337,6 +1337,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
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
@@ -1887,6 +1893,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1900,8 +1907,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1915,6 +1923,14 @@ int dissolve_free_huge_page(struct page *page)
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

