Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A944B2F68BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbhANSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbhANSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2201A23B7B;
        Thu, 14 Jan 2021 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647263;
        bh=UOOQn8aCFd3pZXIiqay3cOTmr2/VUals3JSnLnuVXaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qw3ul7VZOXmQfLhGGd5KUaxpLTo9scgDthT7+I1yx/5/bWC+jYk/YXgDqPaTjR6ip
         q+j0W1hvPNLm6VP7PNwpMTwS/qoHIK7JpqxN1XET/v0KaGuDQPe6dKGVWkI5PrwqSU
         CJvdAWW6XX3mdgCJZz87CHr5jK1YtoDXUh8A9cSk3yKKWhM4O2ccJ/IKt3xfnATUhy
         QS3QqGrvpCRRpPY+9IsSs/iiBOV558SU9E6BVQyirOBjEpTYLdDkDqjMPvmetjRC2v
         PEMq+gSvD9MbvyF3RbMCa5FzSUEqy1M8/1Ios9oVY1LcwIZOffLb/cllGifvrETKie
         4im6p5nTNgnug==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [RFC PATCH 7/8] mm: Use static initialisers for 'info' field of 'struct vm_fault'
Date:   Thu, 14 Jan 2021 17:59:33 +0000
Message-Id: <20210114175934.13070-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for const-ifying the 'info' field of 'struct vm_fault',
ensure that it is initialised using static initialisers.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/shmem.c    |  8 +++++---
 mm/swapfile.c | 13 ++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6831d662fe01..4429e488636e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1520,11 +1520,13 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 {
 	struct vm_area_struct pvma;
 	struct page *page;
-	struct vm_fault vmf;
+	struct vm_fault vmf = {
+		.info = {
+			.vma = &pvma,
+		},
+	};
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	vmf.info.vma = &pvma;
-	vmf.info.address = 0;
 	page = swap_cluster_readahead(swap, gfp, &vmf);
 	shmem_pseudo_vma_destroy(&pvma);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 96ac0725feff..2a21bf3cfdbf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1951,8 +1951,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	si = swap_info[type];
 	pte = pte_offset_map(pmd, addr);
 	do {
-		struct vm_fault vmf;
-
 		if (!is_swap_pte(*pte))
 			continue;
 
@@ -1968,9 +1966,14 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		swap_map = &si->swap_map[offset];
 		page = lookup_swap_cache(entry, vma, addr);
 		if (!page) {
-			vmf.info.vma = vma;
-			vmf.info.address = addr;
-			vmf.pmd = pmd;
+			struct vm_fault vmf = {
+				.info = {
+					.vma = vma,
+					.address = addr,
+				},
+				.pmd = pmd,
+			};
+
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						&vmf);
 		}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

