Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7227822BB97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 03:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGXBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 21:38:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgGXBie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:38:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE385FC44019511714EE;
        Fri, 24 Jul 2020 09:38:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 09:38:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix use-after-free issue
Date:   Fri, 24 Jul 2020 09:38:11 +0800
Message-ID: <20200724013811.106825-1-yuchao0@huawei.com>
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

From: Li Guifu <bluce.liguifu@huawei.com>

During umount, f2fs_put_super() unregisters procfs entries after
f2fs_destroy_segment_manager(), it may cause use-after-free
issue when umount races with procfs accessing, fix it by relocating
f2fs_unregister_sysfs().

[Chao Yu: change commit title/message a bit]

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix typo in commit message.
- improve comment in f2fs_put_super() a bit.
 fs/f2fs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 80cb7cd358f8..5e0a3eeb8ca4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1175,6 +1175,9 @@ static void f2fs_put_super(struct super_block *sb)
 	int i;
 	bool dropped;
 
+	/* unregister procfs/sysfs entries in advance to avoid race case */
+	f2fs_unregister_sysfs(sbi);
+
 	f2fs_quota_off_umount(sb);
 
 	/* prevent remaining shrinker jobs */
@@ -1240,8 +1243,6 @@ static void f2fs_put_super(struct super_block *sb)
 
 	kvfree(sbi->ckpt);
 
-	f2fs_unregister_sysfs(sbi);
-
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-- 
2.26.2

