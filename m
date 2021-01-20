Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032852FCD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbhATJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 04:00:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11112 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhATI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:59:47 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLKDP24Flz15wQP;
        Wed, 20 Jan 2021 16:57:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 16:58:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] z3fold: Simplify the zhdr initialization code in init_z3fold_page()
Date:   Wed, 20 Jan 2021 03:58:51 -0500
Message-ID: <20210120085851.16159-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the zhdr initialization by memset() the zhdr first instead
of set struct member to zero one by one. This would also make code more
compact and clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 8e53cdf4d190..c1ccf6bb0ffb 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -413,16 +413,10 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 	if (!slots)
 		return NULL;
 
+	memset(zhdr, 0, sizeof(*zhdr));
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
-	zhdr->first_chunks = 0;
-	zhdr->middle_chunks = 0;
-	zhdr->last_chunks = 0;
-	zhdr->first_num = 0;
-	zhdr->start_middle = 0;
 	zhdr->cpu = -1;
-	zhdr->foreign_handles = 0;
-	zhdr->mapped_count = 0;
 	zhdr->slots = slots;
 	zhdr->pool = pool;
 	INIT_LIST_HEAD(&zhdr->buddy);
-- 
2.19.1

