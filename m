Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2CE2BA298
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKTGsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgKTGsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE594C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so6913770pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YF/BLlniOkOqlOLuNwhoC17uEIWhpvSsCIax+QfC3Y=;
        b=mVgZ4mHIEX3s8Zda4GGNN1XhpnpwWrK9FhJz4NVGZ5Z0494vBrBobx06xswFqn6/rr
         1lV4CwYDyAGLXE9MJI2t4mqIiHFKxstajuTtTufgI/wvjninvZLxP5JZR8DJc/pOTbYq
         9YyU7YaNviau0//pkxfy24hNjNdwNuhjaZFTOHWDaOrTzeaqf1+jMT/VI16TCvykK3PY
         piX4KgJYDj95dbFMDCGIIrnC2P8OSPP391tzjX74bg8YJcFG+kZRoAi0lR/nWInRPjiv
         IdHeMT/EfNxJVoogxH1Ta+EiWnYxZFHGg6cvzSnZQtnO4ZGVqQAYxxLV9AtigYQBL6Ei
         YKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YF/BLlniOkOqlOLuNwhoC17uEIWhpvSsCIax+QfC3Y=;
        b=tKx/1I0gTJVTJEyr1S4thpCLPXNWJFLwjabHcZ/mSt2Pe46Z1MWiMb7fWSqt2Q4WoX
         2IJl8fJ6OWzWQYTdMm5gq6vvUAW0gu2PZn2NbsrvPvC3XEMevt/r31qQZ44agBY3PJO3
         fxf5sjqzuKsJaOT4kjgtV0HNuLAHL840yls3Qh7JZrKkV5v4/lYohcHr82HyCD2IDfox
         JgWBlBfCtcJoY2kmPqC4SWLtDqyeKCrtJWkXIr3/O3guEwdtq5IdOy61cEZqkcrbfaQP
         wUlB2uAD1JfY71t9FvNgQFiBR3vV52JlWvfAh+Bm0fcVzTuCO7keG0J+P3CjT9j4MQMt
         6G0w==
X-Gm-Message-State: AOAM533gMl0lQDunYc39udMxhZjFQ00t32cGAMS4Z6lf6XXMMPlgisAe
        zcFa4aFfAVIo9NZE1s9brnUfOA==
X-Google-Smtp-Source: ABdhPJzUxMIedTA7fjy9+8PXQ5X870hMnht0hWNgRLugfp9zuqD73EKTYWSoXGdNOucbnRdCj2YQyw==
X-Received: by 2002:aa7:84d0:0:b029:18b:fac7:29b with SMTP id x16-20020aa784d00000b029018bfac7029bmr12420886pfn.29.1605854915274;
        Thu, 19 Nov 2020 22:48:35 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:34 -0800 (PST)
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
Subject: [PATCH v5 15/21] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Fri, 20 Nov 2020 14:43:19 +0800
Message-Id: <20201120064325.34492-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we reuse the first tail page, if we set PageHWPosion on a
tail page. It indicates that we may set PageHWPoison on a series
of pages. So we can use the head[4].mapping to record the real
error page index and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 11 +++--------
 mm/hugetlb_vmemmap.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 055604d07046..b853aacd5c16 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1383,6 +1383,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	subpage_hwpoison_deliver(page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1944,14 +1945,8 @@ int dissolve_free_huge_page(struct page *page)
 		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
+
+		set_subpage_hwpoison(head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 779d3cb9333f..65e94436ffff 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,6 +20,29 @@ void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
+static inline void subpage_hwpoison_deliver(struct page *head)
+{
+	struct page *page = head;
+
+	if (PageHWPoison(head))
+		page = head + page_private(head + 4);
+
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	if (PageHWPoison(head))
+		set_page_private(head + 4, page - head);
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -56,6 +79,22 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void subpage_hwpoison_deliver(struct page *head)
+{
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (PageHWPoison(head) && page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
-- 
2.11.0

