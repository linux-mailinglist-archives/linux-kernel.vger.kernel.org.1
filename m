Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B2928F1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJOMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:16:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgJOMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:16:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB12D79062E39210F1E9;
        Thu, 15 Oct 2020 20:16:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 20:15:51 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH] mm: fix potential pte_unmap_unlock pte error
Date:   Thu, 15 Oct 2020 08:15:34 -0400
Message-ID: <20201015121534.50910-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code breaks
 and passing origin pte - 1 to pte_unmap_unlock seems like not a good idea.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: linmiaohe <linmiaohe@huawei.com>
---
 mm/mempolicy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3fde772ef5ef..01f088630d1d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -571,7 +571,11 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		} else
 			break;
 	}
-	pte_unmap_unlock(pte - 1, ptl);
+
+	if (addr >= end)
+		pte = pte - 1;
+
+	pte_unmap_unlock(pte, ptl);
 	cond_resched();
 
 	if (has_unmovable)
-- 
2.19.1

