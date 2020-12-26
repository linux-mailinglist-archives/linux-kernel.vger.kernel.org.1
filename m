Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37992E2DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgLZKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 05:08:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9996 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLZKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 05:08:36 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D2zxl62b9zhvX6;
        Sat, 26 Dec 2020 18:07:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 26 Dec 2020 18:07:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: relocate f2fs_precache_extents()
Date:   Sat, 26 Dec 2020 18:07:41 +0800
Message-ID: <20201226100741.30307-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate f2fs_precache_extents() in prior to check_swap_activate(),
then extent cache can be enabled before its use.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index baa9ccf84e2c..3a6d848b7e38 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4129,12 +4129,13 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!f2fs_disable_compressed_file(inode))
 		return -EINVAL;
 
+	f2fs_precache_extents(inode);
+
 	ret = check_swap_activate(sis, file, span);
 	if (ret < 0)
 		return ret;
 
 	set_inode_flag(inode, FI_PIN_FILE);
-	f2fs_precache_extents(inode);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
 }
-- 
2.29.2

