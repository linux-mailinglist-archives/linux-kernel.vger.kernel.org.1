Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87782734BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgIUVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:18:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727856AbgIUVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600723080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTIN/0m82g/0tsiCt+76p+QfS6VOaJI0W6pqKf7k5hA=;
        b=JjYI/qe4iVs2x+CqFpwGaUNtFv0KJHFMfJGZnOU3zdcKWh2JFchPF2rBTHtCmTdzdAcwkF
        qkx94SpLAGEm9/DqXAubbQBf3assD/saakzcc8DPOEFobUwmqw6RpCM6jGZE7cogLp1Hmo
        nUF9Iuu4JisHzLhHcXo34RpS4VuwdAM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-z8INEFQVPd6BjGt3TMF8Ng-1; Mon, 21 Sep 2020 17:17:59 -0400
X-MC-Unique: z8INEFQVPd6BjGt3TMF8Ng-1
Received: by mail-qt1-f197.google.com with SMTP id j35so14135197qtk.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTIN/0m82g/0tsiCt+76p+QfS6VOaJI0W6pqKf7k5hA=;
        b=EXloep7mX3542HcafudXwxi0rDSe/FVyB4JTHp3R4JsdrHHUAZmG6WyR26zEf2prrC
         wo0HQZDpt5isOoeQdnHtfnCk6bowPGqI+Gz56wu21CHGEvb+bjTM/r2tdwnkMsITUBOU
         B3Ycud+qhy3ESj1ILEoKMdlJDVL1CLJELLEPNdDXTSYY2Mbzd9yNiWUZkdehsalnQcVE
         z+/EG0UnH7B/dNmIei/USEBKoX1cjo1nvlBeKGWzffoPv0b2GCrMW/8SQDGcbS7wr3Ac
         qkzvqwNdCKISdjWeuoSxN3S29A4afqP3f9Z8MGVcPBpyuSuFJ2EF6Gsdo8upz9ZHgLBT
         9hZw==
X-Gm-Message-State: AOAM5338TNW1x4V6iHl4n5SXrxqHgBnn+mpVQXcsA5PqJfN7KWcBZF3A
        FkZ9/hrv35W7DXILlz7fGie2u8q7P34adJ0NkDsTpKQ5no1PcrWVUhL/XWYceBP5KZ9O+sL3Iws
        NNdIYG8wio4Ther/xqu7SemEP
X-Received: by 2002:aed:2703:: with SMTP id n3mr1534236qtd.235.1600723077744;
        Mon, 21 Sep 2020 14:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt8RshDX+lvoNSrWZH3Xg5icn5cC7XCPVU5E54lefll5SNgPSjaTbuR6wg7sno/CYs5QBTBg==
X-Received: by 2002:aed:2703:: with SMTP id n3mr1534216qtd.235.1600723077485;
        Mon, 21 Sep 2020 14:17:57 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h68sm10225108qkf.30.2020.09.21.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:17:56 -0700 (PDT)
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
Subject: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Date:   Mon, 21 Sep 2020 17:17:42 -0400
Message-Id: <20200921211744.24758-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921211744.24758-1-peterx@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one special path for copy_one_pte() with swap entries, in which
add_swap_count_continuation(GFP_ATOMIC) might fail.  In that case we'll return
the swp_entry_t so that the caller will release the locks and redo the same
thing with GFP_KERNEL.

It's confusing when copy_one_pte() must return a swp_entry_t (even if all the
ptes are non-swap entries).  More importantly, we face other requirement to
extend this "we need to do something else, but without the locks held" case.

Rework the return value into something easier to understand, as defined in enum
copy_mm_ret.  We'll pass the swp_entry_t back using the newly introduced union
copy_mm_data parameter.

Another trivial change is to move the reset of the "progress" counter into the
retry path, so that we'll reset it for other reasons too.

This should prepare us with adding new return codes, very soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7525147908c4..1530bb1070f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -689,16 +689,24 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 #endif
 
+#define  COPY_MM_DONE               0
+#define  COPY_MM_SWAP_CONT          1
+
+struct copy_mm_data {
+	/* COPY_MM_SWAP_CONT */
+	swp_entry_t entry;
+};
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
  */
 
-static inline unsigned long
+static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		unsigned long addr, int *rss, struct copy_mm_data *data)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -709,8 +717,10 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		swp_entry_t entry = pte_to_swp_entry(pte);
 
 		if (likely(!non_swap_entry(entry))) {
-			if (swap_duplicate(entry) < 0)
-				return entry.val;
+			if (swap_duplicate(entry) < 0) {
+				data->entry = entry;
+				return COPY_MM_SWAP_CONT;
+			}
 
 			/* make sure dst_mm is on swapoff's mmlist. */
 			if (unlikely(list_empty(&dst_mm->mmlist))) {
@@ -809,7 +819,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
-	return 0;
+	return COPY_MM_DONE;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -820,9 +830,9 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
-	int progress = 0;
+	int progress, copy_ret = COPY_MM_DONE;
 	int rss[NR_MM_COUNTERS];
-	swp_entry_t entry = (swp_entry_t){0};
+	struct copy_mm_data data;
 
 again:
 	init_rss_vec(rss);
@@ -837,6 +847,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	orig_dst_pte = dst_pte;
 	arch_enter_lazy_mmu_mode();
 
+	progress = 0;
 	do {
 		/*
 		 * We are holding two locks at this point - either of them
@@ -852,9 +863,9 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			progress++;
 			continue;
 		}
-		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-							vma, addr, rss);
-		if (entry.val)
+		copy_ret = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
+					vma, addr, rss, &data);
+		if (copy_ret != COPY_MM_DONE)
 			break;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
@@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
 
-	if (entry.val) {
-		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
+	switch (copy_ret) {
+	case COPY_MM_SWAP_CONT:
+		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
 			return -ENOMEM;
-		progress = 0;
+		break;
+	default:
+		break;
 	}
+
 	if (addr != end)
 		goto again;
+
 	return 0;
 }
 
-- 
2.26.2

