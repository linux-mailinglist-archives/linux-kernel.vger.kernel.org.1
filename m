Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E422D0D82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgLGJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:55:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8716 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:55:45 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CqJYr4FQMzkltR;
        Mon,  7 Dec 2020 17:54:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 17:54:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account inline xattr correctly during recovery
Date:   Mon, 7 Dec 2020 17:54:41 +0800
Message-ID: <20201207095441.73567-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During recovery, we may missed to update inline xattr count correctly,
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e65d73293a3f..3a24423ac65f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2594,9 +2594,15 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 
 	ri = F2FS_INODE(page);
 	if (ri->i_inline & F2FS_INLINE_XATTR) {
-		set_inode_flag(inode, FI_INLINE_XATTR);
+		if (!f2fs_has_inline_xattr(inode)) {
+			set_inode_flag(inode, FI_INLINE_XATTR);
+			stat_inc_inline_xattr(inode);
+		}
 	} else {
-		clear_inode_flag(inode, FI_INLINE_XATTR);
+		if (f2fs_has_inline_xattr(inode)) {
+			stat_dec_inline_xattr(inode);
+			clear_inode_flag(inode, FI_INLINE_XATTR);
+		}
 		goto update_inode;
 	}
 
-- 
2.29.2

