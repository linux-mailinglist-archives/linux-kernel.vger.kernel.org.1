Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF662734BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgIUVSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727856AbgIUVSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600723093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Czb1qrslD9yUv/Haw0aWfjN1eWciuskZPTm0uxjzTrw=;
        b=dDwpx1bFP3yINyQt85ltsd58wnXMMGg1l4+XmOYo1hN04BJylsTKrQc0lske3e+rMrUuEK
        paXJdqCwkRnf8iDDJzzAcxiWyM/cJdcMGABvTUMmHmzTfnwxV69ig6vpE8NeXBNRhScPFq
        FvmPL52ki7v3duQRq9swgbEQV4ORpqA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-irl6ED6VPgyhiI8rOd-APw-1; Mon, 21 Sep 2020 17:18:02 -0400
X-MC-Unique: irl6ED6VPgyhiI8rOd-APw-1
Received: by mail-qk1-f197.google.com with SMTP id w64so12033107qkc.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Czb1qrslD9yUv/Haw0aWfjN1eWciuskZPTm0uxjzTrw=;
        b=YwQWT8shIhRf1/5jgIPBuXUVAm6PfISVztsJfKg8GWlHrppf+QgA07bC8OJJo8NQ8s
         FHq8/MxxptuGh1YIGFRRb6cLfrjnGbYCRoNVINsOivcJfxgfhYzWeiRy09klKTxUpQaR
         C2P76OmXtScA1j9shvOcDIVmlAHST2Ykl1vh/mD+QavFYqRsazPmn6/x474JBJaf09Kx
         05iz7VK8/DN+Sazq/CAzYEpluYIrhCGYVPHZhn612m8LfDNThUk3McvhAurN7hcc5mNe
         /gIjeAju9adWSw0GyUYYmCJaJIf6beFjLQrWO0OlnfEWcIMVVV3wDrgaiFLW3gX0ph7W
         V+mw==
X-Gm-Message-State: AOAM531tubiUQnAzjhl6We56btvS/lSA8AB6LTDa/lNTL5upcuugHlv8
        SAlDLqGXibUEmBWT2E/uB+Fw7Q8T+mTrA1dAjBNH95ear/bGgZPSZi2PyzEQkojsH70olVShFJA
        6+IauhVMsxkuxut7njhvXhzQH
X-Received: by 2002:a37:a443:: with SMTP id n64mr1704860qke.288.1600723077999;
        Mon, 21 Sep 2020 14:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB9u04zjtBvkhW4vamCUqdPL1Um+sdXYj+ylUAkuu7tDAINW75kR2xK9/WpDWyhJDGrwYhGQ==
X-Received: by 2002:a37:a443:: with SMTP id n64mr1704410qke.288.1600723071183;
        Mon, 21 Sep 2020 14:17:51 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h68sm10225108qkf.30.2020.09.21.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:17:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 2/5] mm/fork: Pass new vma pointer into copy_page_range()
Date:   Mon, 21 Sep 2020 17:17:41 -0400
Message-Id: <20200921211744.24758-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921211744.24758-1-peterx@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for the future work to trigger early cow on pinned pages during
fork().  No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 +-
 kernel/fork.c      |  2 +-
 mm/memory.c        | 14 +++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..bf1ac54be55e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1644,7 +1644,7 @@ struct mmu_notifier_range;
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma);
+		    struct vm_area_struct *vma, struct vm_area_struct *new);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/kernel/fork.c b/kernel/fork.c
index 7237d418e7b5..843807ade6dd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -589,7 +589,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(mm, oldmm, mpnt);
+			retval = copy_page_range(mm, oldmm, mpnt, tmp);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..7525147908c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -814,6 +814,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
+		   struct vm_area_struct *new,
 		   unsigned long addr, unsigned long end)
 {
 	pte_t *orig_src_pte, *orig_dst_pte;
@@ -877,6 +878,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pmd_t *src_pmd, *dst_pmd;
@@ -903,7 +905,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
@@ -911,6 +913,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pud_t *src_pud, *dst_pud;
@@ -937,7 +940,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
 		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pud++, src_pud++, addr = next, addr != end);
 	return 0;
@@ -945,6 +948,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	p4d_t *src_p4d, *dst_p4d;
@@ -959,14 +963,14 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (p4d_none_or_clear_bad(src_p4d))
 			continue;
 		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_p4d++, src_p4d++, addr = next, addr != end);
 	return 0;
 }
 
 int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		struct vm_area_struct *vma)
+		    struct vm_area_struct *vma, struct vm_area_struct *new)
 {
 	pgd_t *src_pgd, *dst_pgd;
 	unsigned long next;
@@ -1021,7 +1025,7 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
 		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
-					    vma, addr, next))) {
+					    vma, new, addr, next))) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.26.2

