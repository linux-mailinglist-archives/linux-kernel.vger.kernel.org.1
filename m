Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD0279429
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgIYW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgIYW0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:26:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9s+mr3bMsoB4MuUwSCXxdu8k0Nki9gAjB7hXXinthg=;
        b=BTGzafeE9oUkHfhkLwdHngMKagHPfi/rwPLsFZxjugZWzGKfILjGI2phtrerS3hrt2mx7l
        blmF96kO6OMNevt2b43gs2M8yBlKejN8qUWJkTbNmlLZ4i+KxQv2wiHikc/CiWFaMnLEbG
        y/PaCGig0bsuAaCKjQgOkbXyAVCQnPk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-6tKqYXKkPZ2U2J6voGK_wQ-1; Fri, 25 Sep 2020 18:26:01 -0400
X-MC-Unique: 6tKqYXKkPZ2U2J6voGK_wQ-1
Received: by mail-qk1-f198.google.com with SMTP id 196so3172216qkn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9s+mr3bMsoB4MuUwSCXxdu8k0Nki9gAjB7hXXinthg=;
        b=eZeZkOysifeGH8w+N/zDDLiXGDlZTDEeYeKQAFvv76ZpGDVY0mQXSi+2xVYi9ICG3Z
         X5ulF69Lr99S2hgIcbNi9MAaMMWuDkXYeHVPcjkGCEOldvYiR3ke3uxT+JnxaK+tBWFi
         XT6wegmepzkC/Ob2Xwny0Hx/jN4jd2CpQnDMXx7kOd65wdYpJHbaUD7crNks/dMpzCcY
         XJ59VafNOhpmS2h0Yb+bPupgot2wCDOyOnW2/u6QmQ5kHBwAHYS9MH7W63IxM0uJfNNB
         6gIS8/VSuj0rSeJWAORIWclO1L7aZGpXwyRNxYJiypJ++H0VAUcVtKbWPm8T0/y4kbP4
         PmWQ==
X-Gm-Message-State: AOAM531ayajTJMX6aciL6vEjRreuXxhkDRLjtGLtTgdhcuwv6q/APkFo
        J8pO4jiAmKy8mAM4t2N5VpKDJDC1NkutJQfzmeoUbJF21kwEghtLygHQQ0X82elHZWH0cqBGRyO
        7HaZ7JhUrAJ5HbIEuOS6ZoVod
X-Received: by 2002:a37:9d88:: with SMTP id g130mr2293143qke.185.1601072760337;
        Fri, 25 Sep 2020 15:26:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkCQ0KWaGvyn4yX3yI4tLqcIVC13jgzjD2MfwexLOz4ZJw8pv6FU85VPx13F++9UIdIvBX7Q==
X-Received: by 2002:a37:9d88:: with SMTP id g130mr2293120qke.185.1601072760046;
        Fri, 25 Sep 2020 15:26:00 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w44sm3051471qth.9.2020.09.25.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:25:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 2/4] mm/fork: Pass new vma pointer into copy_page_range()
Date:   Fri, 25 Sep 2020 18:25:58 -0400
Message-Id: <20200925222600.6832-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925222600.6832-1-peterx@redhat.com>
References: <20200925222600.6832-1-peterx@redhat.com>
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
index b2f370f0b420..ae914be004b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1646,7 +1646,7 @@ struct mmu_notifier_range;
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma);
+		    struct vm_area_struct *vma, struct vm_area_struct *new);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/kernel/fork.c b/kernel/fork.c
index e65d8192d080..da8d360fb032 100644
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
index e315b1f1ef08..4c56d7b92b0e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -819,6 +819,7 @@ copy_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
+		   struct vm_area_struct *new,
 		   unsigned long addr, unsigned long end)
 {
 	pte_t *orig_src_pte, *orig_dst_pte;
@@ -889,6 +890,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pmd_t *src_pmd, *dst_pmd;
@@ -915,7 +917,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
@@ -923,6 +925,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pud_t *src_pud, *dst_pud;
@@ -949,7 +952,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
 		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pud++, src_pud++, addr = next, addr != end);
 	return 0;
@@ -957,6 +960,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	p4d_t *src_p4d, *dst_p4d;
@@ -971,14 +975,14 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
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
@@ -1033,7 +1037,7 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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

