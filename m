Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013C2F8C92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbhAPJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:10:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAPJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:10:07 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHsdt1dXvzMGdM;
        Sat, 16 Jan 2021 17:08:02 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Sat, 16 Jan 2021
 17:09:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: make BUG_ON(!inode) takes effect in hugetlbfs_setattr
Date:   Sat, 16 Jan 2021 04:09:10 -0500
Message-ID: <20210116090910.5671-1-linmiaohe@huawei.com>
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
already been dereferenced via hstate_inode. In order to make BUG_ON(!inode)
takes effect, we should defer initializing hstate until we really need it.
Also do this for hugetlbfs_inode_info as it's only used when ia_valid is
verified with ATTR_SIZE.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 740693d7f255..9b221b87fbea 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -755,10 +755,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct hstate *h = hstate_inode(inode);
 	int error;
 	unsigned int ia_valid = attr->ia_valid;
-	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 	BUG_ON(!inode);
 
@@ -767,6 +765,8 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 		return error;
 
 	if (ia_valid & ATTR_SIZE) {
+		struct hstate *h = hstate_inode(inode);
+		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
 
-- 
2.19.1

