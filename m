Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6731E303C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405223AbhAZL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:56:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11194 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405206AbhAZL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:56:09 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQ4rg1t7Yzl2wG;
        Tue, 26 Jan 2021 19:53:55 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 26 Jan 2021
 19:55:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: Fix use after free when subpool max_hpages accounting is not enabled
Date:   Tue, 26 Jan 2021 06:55:10 -0500
Message-ID: <20210126115510.53374-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When subpool max_hpages accounting is not enabled, used_hpages is always 0
and might lead to release subpool prematurely because it indicates no pages
are used now while there might be.

In order to fix this issue, we should check used_hpages == 0 iff max_hpages
accounting is enabled. As max_hpages accounting should be enabled in most
common case, this is not worth a Cc stable.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 777bc0e45bf3..53ea65d1c5ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -97,16 +97,26 @@ static inline void ClearPageHugeFreed(struct page *head)
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
-static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
+static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
-	bool free = (spool->count == 0) && (spool->used_hpages == 0);
+	if (spool->count)
+		return false;
+	if (spool->max_hpages != -1)
+		return spool->used_hpages == 0;
+	if (spool->min_hpages != -1)
+		return spool->rsv_hpages == spool->min_hpages;
 
+	return true;
+}
+
+static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
+{
 	spin_unlock(&spool->lock);
 
 	/* If no pages are used, and no other handles to the subpool
 	 * remain, give up any reservations based on minimum size and
 	 * free the subpool */
-	if (free) {
+	if (subpool_is_free(spool)) {
 		if (spool->min_hpages != -1)
 			hugetlb_acct_memory(spool->hstate,
 						-spool->min_hpages);
-- 
2.19.1

