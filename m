Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF782F8C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAPJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:19:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11029 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbhAPJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:19:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHsrv0KRVzj721;
        Sat, 16 Jan 2021 17:17:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 16 Jan 2021
 17:18:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: Use helper macro default_hstate in init_hugetlbfs_fs
Date:   Sat, 16 Jan 2021 04:18:27 -0500
Message-ID: <20210116091827.20982-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e5ff215941d5 ("hugetlb: multiple hstates for multiple page
sizes"), we can use macro default_hstate to get the struct hstate which
we use by default. But init_hugetlbfs_fs() forgot to use it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9b221b87fbea..88751e35e69d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1544,7 +1544,7 @@ static int __init init_hugetlbfs_fs(void)
 		goto out_free;
 
 	/* default hstate mount is required */
-	mnt = mount_one_hugetlbfs(&hstates[default_hstate_idx]);
+	mnt = mount_one_hugetlbfs(&default_hstate);
 	if (IS_ERR(mnt)) {
 		error = PTR_ERR(mnt);
 		goto out_unreg;
-- 
2.19.1

