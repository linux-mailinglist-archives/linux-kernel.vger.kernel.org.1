Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20550268CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgINODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:03:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgINN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88B5FB3D0255DF42B515;
        Mon, 14 Sep 2020 21:59:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 21:59:45 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 4/4] ubifs: Fix some kernel-doc warnings in tnc.c
Date:   Mon, 14 Sep 2020 21:56:54 +0800
Message-ID: <20200914135654.55120-5-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914135654.55120-1-wanghai38@huawei.com>
References: <20200914135654.55120-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/ubifs/tnc.c:3479: warning: Excess function parameter 'inum' description in 'dbg_check_inode_size'
fs/ubifs/tnc.c:366: warning: Excess function parameter 'node' description in 'lnc_free'

@inum in 'dbg_check_inode_size' should be @inode, fix it.
@node in 'lnc_free' is not in use, Remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/ubifs/tnc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index f609f6cdde70..de21625804a9 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -360,7 +360,6 @@ static int lnc_add_directly(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 /**
  * lnc_free - remove a leaf node from the leaf node cache.
  * @zbr: zbranch of leaf node
- * @node: leaf node
  */
 static void lnc_free(struct ubifs_zbranch *zbr)
 {
@@ -3466,7 +3465,7 @@ int ubifs_dirty_idx_node(struct ubifs_info *c, union ubifs_key *key, int level,
 /**
  * dbg_check_inode_size - check if inode size is correct.
  * @c: UBIFS file-system description object
- * @inum: inode number
+ * @inode: inode to check
  * @size: inode size
  *
  * This function makes sure that the inode size (@size) is correct and it does
-- 
2.17.1

