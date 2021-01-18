Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5C2F9DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbhARLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:09:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11416 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbhARLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:07:55 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DK89Q4ghSzj83j;
        Mon, 18 Jan 2021 19:06:18 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 19:07:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] hugetlbfs: Remove useless BUG_ON(!inode) in hugetlbfs_setattr()
Date:   Mon, 18 Jan 2021 06:07:00 -0500
Message-ID: <20210118110700.52506-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we reach here with inode = NULL, we should have crashed as inode has
already been dereferenced via hstate_inode. So this BUG_ON(!inode) does not
take effect and should be removed.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 016c863b493b..79464963f95e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -759,8 +759,6 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
-	BUG_ON(!inode);
-
 	error = setattr_prepare(dentry, attr);
 	if (error)
 		return error;
-- 
2.19.1

