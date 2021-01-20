Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B82FCCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbhATIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:41:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11111 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbhATIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:41:23 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLJpp60pGz15v9W;
        Wed, 20 Jan 2021 16:39:14 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 16:40:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] z3fold: Remove unused attribute for release_z3fold_page
Date:   Wed, 20 Jan 2021 03:40:08 -0500
Message-ID: <20210120084008.58432-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit dcf5aedb24f8 ("z3fold: stricter locking and more careful
reclaim"), release_z3fold_page() is used again. So we can drop the unused
attribute safely.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index dacb0d70fa61..8e53cdf4d190 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -541,8 +541,7 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	spin_unlock(&pool->stale_lock);
 }
 
-static void __attribute__((__unused__))
-			release_z3fold_page(struct kref *ref)
+static void release_z3fold_page(struct kref *ref)
 {
 	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
 						refcount);
-- 
2.19.1

