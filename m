Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB902B93E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKSNt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:49:27 -0500
Received: from out28-149.mail.aliyun.com ([115.124.28.149]:51565 "EHLO
        out28-149.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKSNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:49:26 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1020446|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0602599-0.000565229-0.939175;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.IyqT2MD_1605793739;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.IyqT2MD_1605793739)
          by smtp.aliyun-inc.com(10.194.97.171);
          Thu, 19 Nov 2020 21:48:59 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang@zlingsmart.com>,
        Pan Jiagen <pan.jiagen@zlingsmart.com>
Subject: [PATCH v2] mm: hugetlb: fix type of delta parameter and related local variables in gather_surplus_pages()
Date:   Thu, 19 Nov 2020 21:48:53 +0800
Message-Id: <1605793733-3573-1-git-send-email-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit machine, delta variable in hugetlb_acct_memory() may be larger
than 0xffffffff, but gather_surplus_pages() can only use the low 32-bit
value now. So we need to fix type of delta parameter and related local
variables in gather_surplus_pages().

Reported-by: Ma Chenggong <ma.chenggong@zlingsmart.com>
Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
Signed-off-by: Pan Jiagen <pan.jiagen@zlingsmart.com>

---
Changes in v2:
  as suggested by Mike, apply the same fix to the related local
  variables in gather_surplus_pages().
---
---
 mm/hugetlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37f15c3..3797401 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1943,13 +1943,14 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
  */
-static int gather_surplus_pages(struct hstate *h, int delta)
+static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	struct list_head surplus_list;
 	struct page *page, *tmp;
-	int ret, i;
-	int needed, allocated;
+	int ret;
+	long i;
+	long needed, allocated;
 	bool alloc_ok = true;
 
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
-- 
1.9.1

