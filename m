Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9471127F390
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgI3Uty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3Uty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:49:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601498992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wWSwUKaEdNYXYOTbkT6FPomWbqjHcpFhZwbuG1aa2jU=;
        b=gHo0ZB6mdzVUsdB7V93hsgSn6yKy3HmYs/gSJwh9qIP0hSsBZghcJG02QZTba8WRbsNDtI
        VCemimunhYF/Q6JAdw0pp6Ojipasq/a+YA1Uw6jIaojbIb6sVl1QSX9oCrQJ89ufwOSWk9
        T97VZi76Hk3rHMFb8eZRRXF+3l69CDM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-YZbnU086Mwu_fRgyuwyT_w-1; Wed, 30 Sep 2020 16:49:50 -0400
X-MC-Unique: YZbnU086Mwu_fRgyuwyT_w-1
Received: by mail-qk1-f200.google.com with SMTP id m186so1715425qkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWSwUKaEdNYXYOTbkT6FPomWbqjHcpFhZwbuG1aa2jU=;
        b=spMRNELZao0gO2j8mfpLn3d+z25dcObxp9uAcsfh7gouEi1f53nTfHR2aZgSxH3Lfq
         Uci2Txpo+kGEIweBRClun+DR1jTo4ZHhXrBP5yDCja3imhHW+BQMHkDg0yKJkriYKbgF
         6j8TWL1JuYdh6DmjTv4j/Wnu+X4rBDY+oIqBLdxht+/fKFhlqsaKlRObaP9QQpeDSn1K
         LjCIu3Lt5QaEuDzz0xF3H5HUDOT/Q0hu+xz3aex+jdfziK+67e3oYdJZ4s7siNfEtZYX
         PD4WOj8VPMX9QaeUJ/XgQweT+j5EP3Pn+jYn0EH3BG2MJCdsmgA6UCwVIraPP5B1ijeE
         +XMQ==
X-Gm-Message-State: AOAM532uUcvrJoOXlV0x9QhcRrbJMVk+C1CtkaJpAxldAS0Yh+ih2udf
        Gm4lxfkvt68J7VzTYFAh/jL3OTTfccNlE9R51CPJbWjvZuX3TTAHdkCeYngRpERQnTGbJOvcqmK
        t6eLD3G/MDwrnwSPbPPf4zJte
X-Received: by 2002:a05:620a:69b:: with SMTP id f27mr4575161qkh.309.1601498989562;
        Wed, 30 Sep 2020 13:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynh16cVt7K0tO31NGZl+8SHopqWHX+o131B5IQHAMNx6x33b/HtCai6oGjOiwD3XM0/dFtwg==
X-Received: by 2002:a05:620a:69b:: with SMTP id f27mr4575141qkh.309.1601498989318;
        Wed, 30 Sep 2020 13:49:49 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id 7sm3411494qkc.73.2020.09.30.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:49:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, peterx@redhat.com
Subject: [PATCH] mm: Remove src/dst mm parameter in copy_page_range()
Date:   Wed, 30 Sep 2020 16:49:50 -0400
Message-Id: <20200930204950.6668-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of the mm pointers are not needed after commit 7a4830c380f3 ("mm/fork:
Pass new vma pointer into copy_page_range()").

Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  3 +--
 kernel/fork.c      |  2 +-
 mm/memory.c        | 43 ++++++++++++++++++++++---------------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b799a0522c..8a0ec8dce5f6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1645,8 +1645,7 @@ struct mmu_notifier_range;
 
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-		    struct vm_area_struct *vma, struct vm_area_struct *new);
+int copy_page_range(struct vm_area_struct *vma, struct vm_area_struct *new);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..5f42d4afe0ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -589,7 +589,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(mm, oldmm, mpnt, tmp);
+			retval = copy_page_range(mpnt, tmp);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/memory.c b/mm/memory.c
index fcfc4ca36eba..251bb5082f4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -957,11 +957,12 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	return new_page;
 }
 
-static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
-		   struct vm_area_struct *new,
+static int copy_pte_range(pmd_t *dst_pmd, pmd_t *src_pmd,
+		   struct vm_area_struct *vma, struct vm_area_struct *new,
 		   unsigned long addr, unsigned long end)
 {
+	struct mm_struct *dst_mm = new->vm_mm;
+	struct mm_struct *src_mm = vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1061,11 +1062,12 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	return ret;
 }
 
-static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
+static inline int copy_pmd_range(pud_t *dst_pud, pud_t *src_pud,
+		struct vm_area_struct *vma, struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
+	struct mm_struct *dst_mm = new->vm_mm;
+	struct mm_struct *src_mm = vma->vm_mm;
 	pmd_t *src_pmd, *dst_pmd;
 	unsigned long next;
 
@@ -1089,18 +1091,18 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-				   vma, new, addr, next))
+		if (copy_pte_range(dst_pmd, src_pmd, vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
+static inline int copy_pud_range(p4d_t *dst_p4d, p4d_t *src_p4d,
+		struct vm_area_struct *vma, struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
+	struct mm_struct *dst_mm = new->vm_mm;
+	struct mm_struct *src_mm = vma->vm_mm;
 	pud_t *src_pud, *dst_pud;
 	unsigned long next;
 
@@ -1124,18 +1126,17 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		}
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-				   vma, new, addr, next))
+		if (copy_pmd_range(dst_pud, src_pud, vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pud++, src_pud++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		struct vm_area_struct *new,
+static inline int copy_p4d_range(pgd_t *dst_pgd, pgd_t *src_pgd,
+		struct vm_area_struct *vma, struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
+	struct mm_struct *dst_mm = new->vm_mm;
 	p4d_t *src_p4d, *dst_p4d;
 	unsigned long next;
 
@@ -1147,20 +1148,20 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(src_p4d))
 			continue;
-		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
-				   vma, new, addr, next))
+		if (copy_pud_range(dst_p4d, src_p4d, vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_p4d++, src_p4d++, addr = next, addr != end);
 	return 0;
 }
 
-int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		    struct vm_area_struct *vma, struct vm_area_struct *new)
+int copy_page_range(struct vm_area_struct *vma, struct vm_area_struct *new)
 {
 	pgd_t *src_pgd, *dst_pgd;
 	unsigned long next;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
+	struct mm_struct *dst_mm = new->vm_mm;
+	struct mm_struct *src_mm = vma->vm_mm;
 	struct mmu_notifier_range range;
 	bool is_cow;
 	int ret;
@@ -1209,7 +1210,7 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
-		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
+		if (unlikely(copy_p4d_range(dst_pgd, src_pgd,
 					    vma, new, addr, next))) {
 			ret = -ENOMEM;
 			break;
-- 
2.26.2

