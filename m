Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91EC2FD75C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbhATRmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbhATRiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:38:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5004B233EA;
        Wed, 20 Jan 2021 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164201;
        bh=nZ0EDBk5rDq2VDhiLnpGwPqd3bpBQursOySVujIsCMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCUTKTKul7XMKhPhUsZ3RU4YTZs8hTEuZLgYaE/oqPKF3PkCQ80A0PnrSu7LH79y8
         RJGsvw9H7y/jbKRPAAJ8xOvUnNljRDEPMk80xckfTEuFPBNHOtL3gXMKjyMz1t8XiQ
         3IiMiNjAcWMGwzEYPGls03u3RRLf7wMGP09bGukK3KyWK2eVWgwKc4GAwXZu70cjIM
         /9A+dliD3NS43Y434oLUAwb61ZSx96AOJpFX97acCjHM7JQo8oALGl15Inz12qehZ7
         BC4jXwdTjT5pXoZ6kZgBwYepGeQ7fU5LhKq9JBsTbVpKPA3XxUX07fSmLsYebkSOgV
         XeWB/VG1Zvfrg==
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
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: [PATCH v4 7/8] mm: Use static initialisers for immutable fields of 'struct vm_fault'
Date:   Wed, 20 Jan 2021 17:36:11 +0000
Message-Id: <20210120173612.20913-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for const-ifying the anonymous struct field of
'struct vm_fault', ensure that it is initialised using static
initialisers.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/shmem.c    |  6 +++---
 mm/swapfile.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7c6b6d8f6c39..1b254fbfdf52 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1520,11 +1520,11 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 {
 	struct vm_area_struct pvma;
 	struct page *page;
-	struct vm_fault vmf;
+	struct vm_fault vmf = {
+		.vma = &pvma,
+	};
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	vmf.vma = &pvma;
-	vmf.address = 0;
 	page = swap_cluster_readahead(swap, gfp, &vmf);
 	shmem_pseudo_vma_destroy(&pvma);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fffc5af29d1..2b570a566276 100644
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
 
@@ -1968,9 +1966,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		swap_map = &si->swap_map[offset];
 		page = lookup_swap_cache(entry, vma, addr);
 		if (!page) {
-			vmf.vma = vma;
-			vmf.address = addr;
-			vmf.pmd = pmd;
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = addr,
+				.pmd = pmd,
+			};
+
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						&vmf);
 		}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

