Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D258271935
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIUCOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:14:05 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37152 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbgIUCOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:14:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9XT8LB_1600654442;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9XT8LB_1600654442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 10:14:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm: remove unused alloc_page_vma_node()
Date:   Mon, 21 Sep 2020 10:14:01 +0800
Message-Id: <20200921021401.84508-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one use this macro anymore.

Also fix code style of policy_node().

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/gfp.h | 2 --
 mm/mempolicy.c      | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..e83cc7f5a2fc 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -560,8 +560,6 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
 	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
-#define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..906adc58d86f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1885,8 +1885,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 }
 
 /* Return the node id preferred by the given mempolicy, or the given id */
-static int policy_node(gfp_t gfp, struct mempolicy *policy,
-								int nd)
+static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
 	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL))
 		nd = policy->v.preferred_node;
-- 
2.20.1 (Apple Git-117)

