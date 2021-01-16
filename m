Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20C42F8FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 23:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbhAPWRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAPWRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 17:17:17 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9364C061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 14:16:36 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 34so1599904otd.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=hfLIQKTOI9IiPQSzWSR50RLwJdTPm03LLxmWFc+LDGc=;
        b=nQltEpP9IPDjL7NdVJ/qCUEezJSAkkgayb83tTFPyZX3OwDR5OUIjY8lomLuRt3SAH
         bWqRqWfjkYeJB2fcgcfIdVPphZuR8GvyzLRd0axgS3usqvbn72wGdDITn0vj7WgI/jSf
         VJcuoJUOR6qCKK/WABCynrRQeXTcY0O8uoQx2qQoEF6jdnVGFRtCFMYkvTtj9PZTaBo5
         TkggD2vEpPrxLBp7dHpLo5xirO5q+AA85BCcI62zBIB5qK2KVrXgVEag6MGcvFtuMXE3
         78zBqBUmQ6K6uo/Gd1abjH3ulo486Y6olbBX6dt8i4nOYWZK7bv6PNA6CUJpW2z/Rowc
         NR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=hfLIQKTOI9IiPQSzWSR50RLwJdTPm03LLxmWFc+LDGc=;
        b=jARXGnsuHR9SVegpVjmbQOHvPbCLlOIXut0YbWYj7f8X1EQGcYOGyl76UaJnYeIMA/
         OrPjcLSgyDy8eJ3U/rFvqMh7m90VCquCYBGo1kGB3NI5/ASniSSTLJXF0tJB5eG4z26n
         F7fG7F8RFbrVjxLWUlvbVxEnF51DyT6gP6E4rwsa5QGKLA6xh+AhPu8tLKZUefG8qPw8
         Y3/njx+Hiz0/8WNjKfkvZ+Xu0W/LFsv+uZw4mhNEoCUnBdJxMYHk5nkL9B6zSSFmXI2U
         6b64ExNJ67wUnin5b5t/zKvh1y4mftqCg0w/0Jh6xWFXeOy4ADvqtyLTEqYAY6Js6oQi
         COFQ==
X-Gm-Message-State: AOAM531Ta+qnHoRRHSv32CB4jzjf0PfKvat/mHgk+ZT+NlJHM9ZqQzCU
        qdX+INkxpMtRxY6KV52OLtr7/g==
X-Google-Smtp-Source: ABdhPJySQElsInHJUFhtoqiKGBkTqFBYNs36UvhaQZlN0hf32s6S0iXTuj3uVDIzXBeN5SssjxalQA==
X-Received: by 2002:a05:6830:1517:: with SMTP id k23mr13407136otp.348.1610835395565;
        Sat, 16 Jan 2021 14:16:35 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i1sm2911608otr.81.2021.01.16.14.16.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 16 Jan 2021 14:16:34 -0800 (PST)
Date:   Sat, 16 Jan 2021 14:16:24 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: fix MADV_REMOVE deadlock on shmem THP
Message-ID: <alpine.LSU.2.11.2101161409470.2022@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey reported deadlock between kswapd correctly doing its usual
lock_page(page) followed by down_read(page->mapping->i_mmap_rwsem),
and madvise(MADV_REMOVE) on an madvise(MADV_HUGEPAGE) area doing
down_write(page->mapping->i_mmap_rwsem) followed by lock_page(page).

This happened when shmem_fallocate(punch hole)'s unmap_mapping_range()
reaches zap_pmd_range()'s call to __split_huge_pmd().  The same deadlock
could occur when partially truncating a mapped huge tmpfs file, or using
fallocate(FALLOC_FL_PUNCH_HOLE) on it.

__split_huge_pmd()'s page lock was added in 5.8, to make sure that any
concurrent use of reuse_swap_page() (holding page lock) could not catch
the anon THP's mapcounts and swapcounts while they were being split.

Fortunately, reuse_swap_page() is never applied to a shmem or file THP
(not even by khugepaged, which checks PageSwapCache before calling),
and anonymous THPs are never created in shmem or file areas: so that
__split_huge_pmd()'s page lock can only be necessary for anonymous THPs,
on which there is no risk of deadlock with i_mmap_rwsem.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Fixes: c444eb564fb1 ("mm: thp: make the THP mapcount atomic against __split_huge_pmd_locked()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: stable@vger.kernel.org
---

The status of reuse_swap_page(), and its use on THPs, is currently under
discussion, and may need to be changed: but this patch is a simple fix
to the reported deadlock, which can go in now, and be easily backported
to whichever stable and longterm releases took in 5.8's c444eb564fb1.

 mm/huge_memory.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- 5.11-rc3/mm/huge_memory.c	2020-12-27 20:39:37.667932292 -0800
+++ linux/mm/huge_memory.c	2021-01-16 08:02:08.265551393 -0800
@@ -2202,7 +2202,7 @@ void __split_huge_pmd(struct vm_area_str
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
-	bool was_locked = false;
+	bool do_unlock_page = false;
 	pmd_t _pmd;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -2218,7 +2218,6 @@ void __split_huge_pmd(struct vm_area_str
 	VM_BUG_ON(freeze && !page);
 	if (page) {
 		VM_WARN_ON_ONCE(!PageLocked(page));
-		was_locked = true;
 		if (page != pmd_page(*pmd))
 			goto out;
 	}
@@ -2227,19 +2226,29 @@ repeat:
 	if (pmd_trans_huge(*pmd)) {
 		if (!page) {
 			page = pmd_page(*pmd);
-			if (unlikely(!trylock_page(page))) {
-				get_page(page);
-				_pmd = *pmd;
-				spin_unlock(ptl);
-				lock_page(page);
-				spin_lock(ptl);
-				if (unlikely(!pmd_same(*pmd, _pmd))) {
-					unlock_page(page);
+			/*
+			 * An anonymous page must be locked, to ensure that a
+			 * concurrent reuse_swap_page() sees stable mapcount;
+			 * but reuse_swap_page() is not used on shmem or file,
+			 * and page lock must not be taken when zap_pmd_range()
+			 * calls __split_huge_pmd() while i_mmap_lock is held.
+			 */
+			if (PageAnon(page)) {
+				if (unlikely(!trylock_page(page))) {
+					get_page(page);
+					_pmd = *pmd;
+					spin_unlock(ptl);
+					lock_page(page);
+					spin_lock(ptl);
+					if (unlikely(!pmd_same(*pmd, _pmd))) {
+						unlock_page(page);
+						put_page(page);
+						page = NULL;
+						goto repeat;
+					}
 					put_page(page);
-					page = NULL;
-					goto repeat;
 				}
-				put_page(page);
+				do_unlock_page = true;
 			}
 		}
 		if (PageMlocked(page))
@@ -2249,7 +2258,7 @@ repeat:
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:
 	spin_unlock(ptl);
-	if (!was_locked && page)
+	if (do_unlock_page)
 		unlock_page(page);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
