Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F742A86DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgKETPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:15:25 -0500
Received: from shelob.surriel.com ([96.67.55.147]:60598 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbgKETPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:15:24 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kakj1-00048T-FN; Thu, 05 Nov 2020 14:15:11 -0500
From:   Rik van Riel <riel@surriel.com>
To:     hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, vbabka@suse.cz, mhocko@suse.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
Date:   Thu,  5 Nov 2020 14:15:08 -0500
Message-Id: <20201105191508.1961686-3-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201105191508.1961686-1-riel@surriel.com>
References: <20201105191508.1961686-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox pointed out that the i915 driver opportunistically
allocates tmpfs memory, but will happily reclaim some of its
pool if no memory is available.

Make sure the gfp mask used to opportunistically allocate a THP
is always at least as restrictive as the original gfp mask.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 mm/shmem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6c3cb192a88d..ee3cea10c2a4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1531,6 +1531,26 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 	return page;
 }
 
+/*
+ * Make sure huge_gfp is always more limited than limit_gfp.
+ * Some of the flags set permissions, while others set limitations.
+ */
+static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
+{
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
+	gfp_t result = huge_gfp & ~allowflags;
+
+	/*
+	 * Minimize the result gfp by taking the union with the deny flags,
+	 * and the intersection of the allow flags.
+	 */
+	result |= (limit_gfp & denyflags);
+	result |= (huge_gfp & limit_gfp) & allowflags;
+
+	return result;
+}
+
 static struct page *shmem_alloc_hugepage(gfp_t gfp,
 		struct shmem_inode_info *info, pgoff_t index)
 {
@@ -1889,6 +1909,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 alloc_huge:
 	huge_gfp = vma_thp_gfp_mask(vma);
+	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
 	if (IS_ERR(page)) {
 alloc_nohuge:
-- 
2.25.4

