Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110432F6020
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhANLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:33:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11383 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbhANLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:32:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DGhw328WDz7VHW;
        Thu, 14 Jan 2021 19:31:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 19:32:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
Date:   Thu, 14 Jan 2021 06:31:40 -0500
Message-ID: <20210114113140.23069-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
and releasing hugetlb_lock.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 737b2dce19e6..fe2da9ad6233 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5241,7 +5241,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	 * reservations to be released may be adjusted.
 	 */
 	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
-	hugetlb_acct_memory(h, -gbl_reserve);
+	if (gbl_reserve)
+		hugetlb_acct_memory(h, -gbl_reserve);
 
 	return 0;
 }
-- 
2.19.1

