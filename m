Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75B2B7E25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKRNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:14:16 -0500
Received: from out28-75.mail.aliyun.com ([115.124.28.75]:39203 "EHLO
        out28-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:14:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1271669|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.048659-0.000333411-0.951008;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.IyM0iLp_1605705248;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.IyM0iLp_1605705248)
          by smtp.aliyun-inc.com(10.194.99.21);
          Wed, 18 Nov 2020 21:14:08 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang@zlingsmart.com>,
        Pan Jiagen <pan.jiagen@zlingsmart.com>
Subject: [PATCH] mm: hugetlb: fix type of delta parameter in gather_surplus_pages()
Date:   Wed, 18 Nov 2020 21:14:01 +0800
Message-Id: <1605705241-3561-1-git-send-email-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit machine, delta variable in hugetlb_acct_memory() may be larger
than 0xffffffff, but gather_surplus_pages() can only use the low 32-bit
value now.

Reported-by: Ma Chenggong <ma.chenggong@zlingsmart.com>
Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
Signed-off-by: Pan Jiagen <pan.jiagen@zlingsmart.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37f15c3..293b36d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1943,7 +1943,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
  */
-static int gather_surplus_pages(struct hstate *h, int delta)
+static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	struct list_head surplus_list;
-- 
1.9.1

