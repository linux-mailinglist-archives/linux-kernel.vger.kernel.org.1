Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DB2FFE40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAVIeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:34:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbhAVIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:32:42 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMXXM4Sd2zj9ps;
        Fri, 22 Jan 2021 16:30:59 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 16:31:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] hugetlbfs: make hugepage size conversion more readable
Date:   Fri, 22 Jan 2021 03:31:41 -0500
Message-ID: <20210122083141.24548-1-linmiaohe@huawei.com>
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
replace it with huge_page_size(h) >> 10.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 25c1857ff45d..c87894b221da 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
 		put_fs_context(fc);
 	}
 	if (IS_ERR(mnt))
-		pr_err("Cannot mount internal hugetlbfs for page size %uK",
-		       1U << (h->order + PAGE_SHIFT - 10));
+		pr_err("Cannot mount internal hugetlbfs for page size %luK",
+		       huge_page_size(h) >> 10);
 	return mnt;
 }
 
-- 
2.19.1

