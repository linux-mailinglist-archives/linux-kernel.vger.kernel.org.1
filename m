Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76CC2D71F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436963AbgLKIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:39:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbgLKIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:39:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cskgb405pz15bVW;
        Fri, 11 Dec 2020 16:37:47 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:38:14 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <dhowells@redhat.com>, <linux-afs@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fs/afs: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:38:43 +0800
Message-ID: <20201211083843.1684-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/afs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index b0d7b892090d..da728210cdb8 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -502,7 +502,7 @@ static int afs_iget5_set_root(struct inode *inode, void *opaque)
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
 	vnode->volume		= as->volume;
-	vnode->fid.vid		= as->volume->vid,
+	vnode->fid.vid		= as->volume->vid;
 	vnode->fid.vnode	= 1;
 	vnode->fid.unique	= 1;
 	inode->i_ino		= 1;
-- 
2.22.0

