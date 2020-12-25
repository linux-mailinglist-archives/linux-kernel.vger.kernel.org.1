Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73FD2E2A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgLYJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 04:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgLYJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 04:30:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBEC061575
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so2356309pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpW2sWQQiHoxQtJSvZTgROQggONQuj6JLwoHM4c5b9s=;
        b=qIMav+mzgIAW7g0LrirZYpLxCgws1BwK2bIZJQQ7rqrcM7WaJuHOHEgzK5VBJwPqfU
         cbozQEFWvwn4bbxCWFOscvSia2WFVcHJ8As++dsiMWLv3TOUXIho26mfusnp8hvjuSzC
         rwqh7aY1mOHs1zy4EkJtA/9KLx5MQFKjtIbW8B1qGeSI2xrM7tEuk67RhC878DPeKTW1
         swIo81e//qTnYwIQbT7bFiqTp1yNnVJ2ZDwjUjHSmPYgbTrVvnAw41lJ9vFQzE1/Lmit
         bFKZdZR+F7Up72ndlgf1kfjkKTYZYXnogJ7JOzKiltesjTZFxtT+WNXW6Tcv7jXMphhz
         JKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpW2sWQQiHoxQtJSvZTgROQggONQuj6JLwoHM4c5b9s=;
        b=U7YRTqDit5mHpURpOFY10Z060nWefEiMlGiDjmlqBObXMbOcHblvn/l4Zpl2vwFYVP
         AAt4ZLtTFCJ+yFUrA6sqeVbbYwh3QC74TpWgB/eXVD6PQruj64YkeivXpg0f5kUb+OKT
         WJWBlQ4aHTnAMmXvWt53kfOLU3y0cXnEqBFMKZe/C+cs304AzdpA8w4ZKyO3XW4892xj
         K6xd3J7UP7tZJjBowz90N57McQl8SGX74LvIhEkjfa6aRq7GxEb8ZJVDlmf0YYMzfpwI
         YNkYOZDdMsPGtXz3gkxNigqgNVMKZJtwxb8Vs25gVyoGL8pb6gF9zsepKUXsFwm0zyoT
         SV9A==
X-Gm-Message-State: AOAM530pzlmYHhJPp2Genn6UpL9roRbRLulKpjcbo5cuznsEwWVvZapQ
        Fqets0gOTWpVklHGQFsx/W0=
X-Google-Smtp-Source: ABdhPJzo19NhjDgpPlOPmmbFArkEFCZaD9tv7zY5etpFZLNE69F/+Mw5J7PU6MgQJcB6e4++YPZuQQ==
X-Received: by 2002:a62:5547:0:b029:1a4:cb2a:2833 with SMTP id j68-20020a6255470000b02901a4cb2a2833mr30296026pfb.35.1608888578285;
        Fri, 25 Dec 2020 01:29:38 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s13sm28966659pfd.99.2020.12.25.01.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 01:29:37 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to writeprotect
Date:   Fri, 25 Dec 2020 01:25:28 -0800
Message-Id: <20201225092529.3228466-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201225092529.3228466-1-namit@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Userfaultfd self-test fails occasionally, indicating a memory
corruption.

Analyzing this problem indicates that there is a real bug since
mmap_lock is only taken for read in mwriteprotect_range() and defers
flushes, and since there is insufficient consideration of concurrent
deferred TLB flushes in wp_page_copy(). Although the PTE is flushed from
the TLBs in wp_page_copy(), this flush takes place after the copy has
already been performed, and therefore changes of the page are possible
between the time of the copy and the time in which the PTE is flushed.

To make matters worse, memory-unprotection using userfaultfd also poses
a problem. Although memory unprotection is logically a promotion of PTE
permissions, and therefore should not require a TLB flush, the current
userrfaultfd code might actually cause a demotion of the architectural
PTE permission: when userfaultfd_writeprotect() unprotects memory
region, it unintentionally *clears* the RW-bit if it was already set.
Note that this unprotecting a PTE that is not write-protected is a valid
use-case: the userfaultfd monitor might ask to unprotect a region that
holds both write-protected and write-unprotected PTEs.

The scenario that happens in selftests/vm/userfaultfd is as follows:

cpu0				cpu1			cpu2
----				----			----
							[ Writable PTE
							  cached in TLB ]
userfaultfd_writeprotect()
[ write-*unprotect* ]
mwriteprotect_range()
mmap_read_lock()
change_protection()

change_protection_range()
...
change_pte_range()
[ *clear* “write”-bit ]
[ defer TLB flushes ]
				[ page-fault ]
				...
				wp_page_copy()
				 cow_user_page()
				  [ copy page ]
							[ write to old
							  page ]
				...
				 set_pte_at_notify()

A similar scenario can happen:

cpu0		cpu1		cpu2		cpu3
----		----		----		----
						[ Writable PTE
				  		  cached in TLB ]
userfaultfd_writeprotect()
[ write-protect ]
[ deferred TLB flush ]
		userfaultfd_writeprotect()
		[ write-unprotect ]
		[ deferred TLB flush]
				[ page-fault ]
				wp_page_copy()
				 cow_user_page()
				 [ copy page ]
				 ...		[ write to page ]
				set_pte_at_notify()

As Yu Zhao pointed, these races became more apparent since commit
09854ba94c6a ("mm: do_wp_page() simplification") which made
wp_page_copy() more likely to take place, specifically if
page_count(page) > 1.

Note that one might consider additional potentially dangerous scenarios,
which are not directly related to the deferred TLB flushes.  A memory
corruption might in theory occur if after the page is copied by
cow_user_page() and before the PTE is set, the PTE is write-unprotected
(by a concurrent page-fault handler) and then protected again (by
subsequent calls to userfaultfd_writeprotect() to protect and unprotect
the page). In practice, it seems that such scenarios cannot happen.

To resolve the aforementioned races, acquire mmap_lock for write when
write-protecting userfaultfd region using ioctl's. Keep acquiring
mmap_lock for read when unprotecting memory, but do not change the
write-bit set when performing userfaultfd write-unprotection.

This solution can introduce performance regression to userfaultfd
write-protection.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/mprotect.c    |  3 ++-
 mm/userfaultfd.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab709023e9aa..c08c4055b051 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		oldpte = *pte;
 		if (pte_present(oldpte)) {
 			pte_t ptent;
-			bool preserve_write = prot_numa && pte_write(oldpte);
+			bool preserve_write = (prot_numa || uffd_wp_resolve) &&
+					      pte_write(oldpte);
 
 			/*
 			 * Avoid trapping faults against the zero or KSM
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..7423808640ef 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -652,7 +652,15 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	/* Does the address range wrap, or is the span zero-sized? */
 	BUG_ON(start + len <= start);
 
-	mmap_read_lock(dst_mm);
+	/*
+	 * Although we do not change the VMA, we have to ensure deferred TLB
+	 * flushes are performed before page-faults can be handled. Otherwise
+	 * we can get inconsistent TLB state.
+	 */
+	if (enable_wp)
+		mmap_write_lock(dst_mm);
+	else
+		mmap_read_lock(dst_mm);
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -686,6 +694,9 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 	err = 0;
 out_unlock:
-	mmap_read_unlock(dst_mm);
+	if (enable_wp)
+		mmap_write_unlock(dst_mm);
+	else
+		mmap_read_unlock(dst_mm);
 	return err;
 }
-- 
2.25.1

