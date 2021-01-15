Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69A32F81CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbhAORMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733284AbhAORLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ez9VaM0jxqRxRHrokBxOLqFRU+5IpsC9OSJDJDSHKdU=;
        b=ab7dQkCwjU7bRT+J3mtE2ADaIylyUIw/VShUEKL2Mf3A6pnkK7ytl5xRP6kFMiLhfUayL3
        oJLJwHkNsKNZ9GGj5qjIYr3WnwtzbxBOs8d8On40aFwx6YydkfJGYYiVZ5dTiDd06lbrKL
        DX+kTk+zVOVV6Xy/EoJ+0b5fUej7Fbg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-dh9RnfRtOICMfAlni1DQxA-1; Fri, 15 Jan 2021 12:09:54 -0500
X-MC-Unique: dh9RnfRtOICMfAlni1DQxA-1
Received: by mail-qt1-f197.google.com with SMTP id h18so7896571qtr.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez9VaM0jxqRxRHrokBxOLqFRU+5IpsC9OSJDJDSHKdU=;
        b=cuR5LGRdtKJELbWRjMN7YY02c0dsbcZovjqGjywdzP31Z2jz6PHstrj2j20x3Kc89y
         Fhikknav/Acya15IlOwc/3m9Jok4/3Jy2fvV0Y6TJFXDUplJjX5WcXDVAKDS+P2l2T9K
         B/q9mOXXeKW3OJ1Ze8J1AkCQF5FzcWfAEhQ3iK8q4HiojjN1YqxV0pFVGbbnuQnf4gas
         UoWIuNI54ONM7NO9qwKwoHnB7jWJY/6QVcUiZhW/vBsnWiY1nRgj2FvGlDdIJH/6VA2n
         GMkb1TtPNj+yHkAHzRwD3RxRBzcaaKK/MCoE2FtIvIh2aWU/ku8ZBr9rENy8ZfRl52+z
         O9Eg==
X-Gm-Message-State: AOAM532fLzj2Cy7fWmVd0HmxoJ0x3ZDn8FELkzclDo6VCz+4cFB8W0JY
        p6MFz4EgDR6FSQ8UKofzjAK0EoGsPFJVywpmGZQ+WoR6sm8mKsrp6r1E+gZ7qh5niE3dKMeD9dv
        4qAt2rPczY9iVmfL59Z4bY9wjzzJdU0NGGATvIeanfqdzObhEra1ENrG34F2qTomlPjW7FOmvnw
        ==
X-Received: by 2002:a37:64c4:: with SMTP id y187mr13101261qkb.371.1610730593580;
        Fri, 15 Jan 2021 09:09:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyfJ5XAHeQaZql7ziGHlK2PdUYiLPmxsrv1KSOsOkkqMGGZaMw9BF6kuEjwLDe+dcyq4yjJA==
X-Received: by 2002:a37:64c4:: with SMTP id y187mr13101223qkb.371.1610730593288;
        Fri, 15 Jan 2021 09:09:53 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:52 -0800 (PST)
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
Subject: [PATCH RFC 22/30] hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
Date:   Fri, 15 Jan 2021 12:08:59 -0500
Message-Id: <20210115170907.24498-23-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge pmd sharing could bring problem to userfaultfd.  The thing is that
userfaultfd is running its logic based on the special bits on page table
entries, however the huge pmd sharing could potentially share page table
entries for different address ranges.  That could cause issues on either:

  - When sharing huge pmd page tables for an uffd write protected range, the
    newly mapped huge pmd range will also be write protected unexpectedly, or,

  - When we try to write protect a range of huge pmd shared range, we'll first
    do huge_pmd_unshare() in hugetlb_change_protection(), however that also
    means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
    region, which could lead to data loss.

Since at it, a few other things are done altogether:

  - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
    that's definitely something that arch code would like to use too

  - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
    trying to share huge pmd.  Switch to the want_pmd_share() helper.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c   |  3 +--
 include/linux/hugetlb.h       | 12 ++++++++++++
 include/linux/userfaultfd_k.h |  9 +++++++++
 mm/hugetlb.c                  |  5 ++---
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5b32ec888698..1a8ce0facfe8 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		ptep = pte_alloc_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
-		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
-		    pud_none(READ_ONCE(*pudp)))
+		if (want_pmd_share(vma) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7d4c5669e118..27ada597a8e6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
+#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -951,4 +952,15 @@ static inline __init void hugetlb_cma_check(void)
 }
 #endif
 
+static inline bool want_pmd_share(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+	return true;
+#else
+	return false;
+#endif
+}
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 7d6071a65ded..7d14444862d4 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -52,6 +52,15 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
 }
 
+/*
+ * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
+ * protect information is per pgtable entry.
+ */
+static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_WP;
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eb7cd0c7d6d2..dd2acb8b3f0f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5386,7 +5386,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
 	return 1;
 }
-#define want_pmd_share()	(1)
+
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5403,7 +5403,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
 }
-#define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
@@ -5425,7 +5424,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			pte = (pte_t *)pud;
 		} else {
 			BUG_ON(sz != PMD_SIZE);
-			if (want_pmd_share() && pud_none(*pud))
+			if (want_pmd_share(vma) && pud_none(*pud))
 				pte = huge_pmd_share(mm, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
-- 
2.26.2

