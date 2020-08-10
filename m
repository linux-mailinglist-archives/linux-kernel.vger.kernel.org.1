Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964112404DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHJKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 06:39:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgHJKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:39:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA3FDE0191CA346124EE;
        Mon, 10 Aug 2020 18:38:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 18:38:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] f2fs: fix compile warning
Date:   Mon, 10 Aug 2020 18:38:45 +0800
Message-ID: <20200810103845.37649-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below compile warning reported by LKP
(kernel test robot)

cppcheck warnings: (new ones prefixed by >>)

>> fs/f2fs/file.c:761:9: warning: Identical condition 'err', second condition is always false [identicalConditionAfterEarlyExit]
    return err;
           ^
   fs/f2fs/file.c:753:6: note: first condition
    if (err)
        ^
   fs/f2fs/file.c:761:9: note: second condition
    return err;

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8a422400e824..f16120352f0c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -753,11 +753,14 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		return err;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (from != free_from)
+	if (from != free_from) {
 		err = f2fs_truncate_partial_cluster(inode, from, lock);
+		if (err)
+			return err;
+	}
 #endif
 
-	return err;
+	return 0;
 }
 
 int f2fs_truncate(struct inode *inode)
-- 
2.26.2

