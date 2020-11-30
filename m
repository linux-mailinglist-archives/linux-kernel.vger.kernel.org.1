Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DE2C835F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgK3Ljt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgK3Ljs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155DC061A04
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DNbURhpRXVFm+D5xOcWGNkmJVhljKHRLoeBZiWAdDOY=; b=WSukwZUW2AUbYsK4fJL0oXkaxW
        odUBv4mi6iNIvKmegNq3IpgMdtuPQIkrzmlWcC75IN8eUldqGCS3nmGICMnBMR6IKqRIunmhrG38k
        XTaPsHKDJkJLZjK5jA57vQFLECmfq/KSb8E/RS5IBee4jcHYXTDexcp/Jq3eT5/PkB7x7SnOIyuns
        T5h78gjjuC4GKj4sEb+2zMOJzrzKmSRTwSrTww5zMsjxjjYYz8Bb/9EDKMWJSRJtwU4fgL93RSGWN
        /MtrBbmLQKzFk0/exYFgJ1UzxthgzgjWWKRr+A9ipBU9tU7eIU5Qwm6AoHMqd6fJPXQ/WOc42GqoM
        KOlmPxHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0007Qo-5f; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35070305C22;
        Mon, 30 Nov 2020 12:38:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E283D2B84F9C7; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113603.079835817@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 5/9] mm: Rename pmd_read_atomic()
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in having the identical routines for PTE/PMD have
different names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h    |    7 +------
 mm/hmm.c                   |    2 +-
 mm/mapping_dirty_helpers.c |    2 +-
 mm/mprotect.c              |    2 +-
 mm/userfaultfd.c           |    2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1244,11 +1244,6 @@ static inline int pud_trans_unstable(pud
 #endif
 }
 
-static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
-{
-	return pmdp_get_lockless(pmdp);
-}
-
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
 #endif
@@ -1275,7 +1270,7 @@ static inline pmd_t pmd_read_atomic(pmd_
  */
 static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 	/*
 	 * The barrier will stabilize the pmdval in a register or on
 	 * the stack so that it will stop changing under the code.
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -356,7 +356,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * huge or device mapping one and compute corresponding pfn
 		 * values.
 		 */
-		pmd = pmd_read_atomic(pmdp);
+		pmd = pmdp_get_lockless(pmdp);
 		barrier();
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -123,7 +123,7 @@ static int clean_record_pte(pte_t *pte,
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	if (!pmd_trans_unstable(&pmdval))
 		return 0;
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -190,7 +190,7 @@ static unsigned long change_pte_range(st
  */
 static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -553,7 +553,7 @@ static __always_inline ssize_t __mcopy_a
 			break;
 		}
 
-		dst_pmdval = pmd_read_atomic(dst_pmd);
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
 		/*
 		 * If the dst_pmd is mapped as THP don't
 		 * override it and just be strict.


