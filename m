Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F082F81D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbhAORMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733015AbhAORK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zNMLI73E9rvmIG628SfisA+2GLXaIOPoACKwF1DQC4=;
        b=KWgA614tIiaNornG29pkZ/9CPWKMOnyNiCcES9072YHaYPFLnmrq8RDiFuE0dfTcxgDc2Q
        Iv1hlV0LceIm35FP60Wecv77nEFH2bJEN33KnI9RDtr1owVFB6U+vsr1nUKWwX/xI+01it
        yYLPsw8kr72pyUJke5AwJ0zdwV8+cOQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-_Lv8xaxMOVasXcAzv8HO_w-1; Fri, 15 Jan 2021 12:09:30 -0500
X-MC-Unique: _Lv8xaxMOVasXcAzv8HO_w-1
Received: by mail-qv1-f72.google.com with SMTP id m1so8265050qvp.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zNMLI73E9rvmIG628SfisA+2GLXaIOPoACKwF1DQC4=;
        b=gfZpJy730YgdXNA3CncdC5zIaDWbwMPlD8G/uXoRNogtKbFwUikXefLa3ikyt8X+f5
         z+HgVaU0JEtu7DlgSTwxb8WvrRzsln8EWvC9ypJd+3xeDWhCgU2xQXysyJy1GPP3lTR5
         VxmogOWRUr9B8XXPu8Ydm7Wcss4GiWXs2QzqE/KMdMIaNQi+/kubem5qk70Jwi+vIWgO
         CQ/D4de1eZLK52eNjZYHGpFXZc+OGG9fjtbpwYSUpmha18sExeziM8LeDAb4j1/VsuaR
         jPqrLIZgZl5YxFJSxuZfyJnn3Dz34i20zfpJqcq6K6jqSG7eX9UGvjDEdnbplqlKibwC
         E+ig==
X-Gm-Message-State: AOAM530jrx1pIJDQCL89NmK8CmjeAlJI5Q+xNxTEAbwEoUSTnvKDzB3n
        VbWEERAVusx1K530XxjIWhAvb9/78YOg9k0sAMGYgLw8if+e23gw2c2x/PAFLzkN1V54JfY1Oo6
        quof4YL1gA5LBPv8BqNz6cxKwxU2Q4SxPoip5U6HqFkYuzP2L1nLPX4aLwzMGy4SzomVBMCWIEQ
        ==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr13052868qkg.195.1610730569435;
        Fri, 15 Jan 2021 09:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUyy20s6HzED7NEtKWLEp73vXuBFzUuQgA1QzITMcyJTdxXNmC/+9kNX4RpSO4M94ywIGwUg==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr13052827qkg.195.1610730569089;
        Fri, 15 Jan 2021 09:09:29 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:28 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 10/30] mm: Introduce zap_details.zap_flags
Date:   Fri, 15 Jan 2021 12:08:47 -0500
Message-Id: <20210115170907.24498-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to introduce one variable for every new zap_details fields,
let's introduce a flag so that it can start to encode true/false informations.

Let's start to use this flag first to clean up the only check_mapping variable.
Firstly, the name "check_mapping" implies this is a "boolean", but actually it
stores the mapping inside, just in a way that it won't be set if we don't want
to check the mapping.

To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
that we only check against the mapping if this bit set.  At the same time, we
can rename check_mapping into zap_mapping and set it always.

Since at it, introduce another helper zap_check_mapping_skip() and use it in
zap_pte_range() properly.

Some old comments have been removed in zap_pte_range() because they're
duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
easy to grep this information by simply grepping the flag.

It'll also make life easier when we want to e.g. pass in zap_flags into the
callers like unmap_mapping_pages() (instead of adding new booleans besides the
even_cows parameter).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++++++++-
 mm/memory.c        | 31 ++++++++-----------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index faf9538c13b2..2380e1df6a49 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1630,13 +1630,30 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct user_struct *);
 extern void user_shm_unlock(size_t, struct user_struct *);
 
+/* Whether to check page->mapping when zapping */
+#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *check_mapping;	/* Check page->mapping if set */
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
+	unsigned long zap_flags;		/* Special flags for zapping */
 };
 
+/* Return true if skip zapping this page, false otherwise */
+static inline bool
+zap_check_mapping_skip(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
+		return false;
+
+	return details->zap_mapping != page_rmapping(page);
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index dd49dea276e3..43d8641dbe18 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1226,16 +1226,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(details) && page) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping &&
-				    details->check_mapping != page_rmapping(page))
-					continue;
-			}
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1267,17 +1259,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (is_device_private_entry(entry)) {
 			struct page *page = device_private_entry_to_page(entry);
 
-			if (unlikely(details && details->check_mapping)) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping !=
-				    page_rmapping(page))
-					continue;
-			}
-
+			if (unlikely(zap_check_mapping_skip(details, page)))
+				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
@@ -3185,9 +3168,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { };
+	struct zap_details details = { .zap_mapping = mapping };
+
+	if (!even_cows)
+		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
 
-	details.check_mapping = even_cows ? NULL : mapping;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.26.2

