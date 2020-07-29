Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84288231BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgG2I5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 04:57:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgG2I5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:57:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DEB747C83FEAD6812F18;
        Wed, 29 Jul 2020 16:57:37 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 16:57:36 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>
CC:     <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] 9p: Remove unneeded cast from memory allocation
Date:   Wed, 29 Jul 2020 16:59:00 +0800
Message-ID: <1596013140-49744-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove casting the values returned by memory allocation function.

Coccinelle emits WARNING:

./fs/9p/vfs_inode.c:226:12-29: WARNING: casting value returned by memory allocation function to (struct v9fs_inode *) is useless.

Signed-off-by: Li Heng <liheng40@huawei.com>
---
 fs/9p/vfs_inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0fd5bf2..ae0c38a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -223,8 +223,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
 struct inode *v9fs_alloc_inode(struct super_block *sb)
 {
 	struct v9fs_inode *v9inode;
-	v9inode = (struct v9fs_inode *)kmem_cache_alloc(v9fs_inode_cache,
-							GFP_KERNEL);
+	v9inode = kmem_cache_alloc(v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
 #ifdef CONFIG_9P_FSCACHE
-- 
2.7.4

