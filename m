Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C702FCDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbhATKOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:14:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11409 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbhATJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:24:43 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DLKn94Fxgz7Wmv;
        Wed, 20 Jan 2021 17:22:53 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 17:23:52 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: make hugepage size conversion more readable
Date:   Wed, 20 Jan 2021 04:23:48 -0500
Message-ID: <20210120092348.13811-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation 1U << (h->order + PAGE_SHIFT - 10) is actually equal to
(PAGE_SHIFT << (h->order)) >> 10. So we can make it more readable by
replace it with huge_page_size(h) / SZ_1K.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 25c1857ff45d..f94b8f6553fa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
 		put_fs_context(fc);
 	}
 	if (IS_ERR(mnt))
-		pr_err("Cannot mount internal hugetlbfs for page size %uK",
-		       1U << (h->order + PAGE_SHIFT - 10));
+		pr_err("Cannot mount internal hugetlbfs for page size %luK",
+		       huge_page_size(h) / SZ_1K);
 	return mnt;
 }
 
-- 
2.19.1

