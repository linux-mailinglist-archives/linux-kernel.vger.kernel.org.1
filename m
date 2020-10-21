Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F662294932
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502168AbgJUIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:09:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60545 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408356AbgJUIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:09:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UCj.BMW_1603267785;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UCj.BMW_1603267785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Oct 2020 16:09:46 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     linux-mm@kvack.org
Cc:     hughd@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/shmem: fix up gfpmask for shmem hugepage allocation
Date:   Wed, 21 Oct 2020 16:09:39 +0800
Message-Id: <11e1ead211eb7d141efa0eb75a46ee2096ee63f8.1603267572.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the gfpmask used in shmem_alloc_hugepage is fixed, i.e.,
gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN, where gfp comes from
inode mapping, usually GFP_HIGHUSER_MOVABLE. This will introduce direct
or kswapd reclaim when fast path of shmem hugepage allocation fails,
which is unexpected sometimes.

This applies the effect of defrag option of anonymous hugepage to shmem
hugepage too. By doing so, we can control the defrag behavior of both
kinds of THP.

This also explicitly adds the SHMEM_HUGE_ALWAYS case in
shmem_getpage_gfp, for better code reading.

Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 mm/shmem.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..a0f5d02e479b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1780,6 +1780,47 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	return error;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline gfp_t shmem_hugepage_gfpmask_fixup(gfp_t gfp,
+						 enum sgp_type sgp_huge)
+{
+	const bool vma_madvised = sgp_huge == SGP_HUGE;
+
+	gfp |= __GFP_NOMEMALLOC;
+	gfp &= ~__GFP_RECLAIM;
+
+	/* Force do synchronous compaction */
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return gfp | __GFP_DIRECT_RECLAIM;
+
+	/* Always do synchronous compaction */
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
+		return gfp | __GFP_DIRECT_RECLAIM | (vma_madvised ? 0 : __GFP_NORETRY);
+
+	/* Kick kcompactd and fail quickly */
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
+		return gfp | __GFP_KSWAPD_RECLAIM;
+
+	/* Synchronous compaction if madvised, otherwise kick kcompactd */
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
+		return gfp |
+			(vma_madvised ? __GFP_DIRECT_RECLAIM :
+					__GFP_KSWAPD_RECLAIM);
+
+	/* Only do synchronous compaction if madvised */
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
+		return gfp | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
+
+	return gfp;
+}
+#else
+static inline gfp_t shmem_hugepage_gfpmask_fixup(gfp_t gfp,
+						 enum sgp_type sgp_huge)
+{
+	return gfp;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * shmem_getpage_gfp - find page in cache, or get from swap, or allocate
  *
@@ -1867,6 +1908,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	switch (sbinfo->huge) {
 	case SHMEM_HUGE_NEVER:
 		goto alloc_nohuge;
+	case SHMEM_HUGE_ALWAYS:
+		goto alloc_huge;
 	case SHMEM_HUGE_WITHIN_SIZE: {
 		loff_t i_size;
 		pgoff_t off;
@@ -1887,6 +1930,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 alloc_huge:
+	gfp = shmem_hugepage_gfpmask_fixup(gfp, sgp_huge);
 	page = shmem_alloc_and_acct_page(gfp, inode, index, true);
 	if (IS_ERR(page)) {
 alloc_nohuge:
-- 
2.20.1.2432.ga663e714

