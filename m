Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E8272438
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgIUMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:53:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgIUMxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:53:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70A2CC5B7ED38BAEA8BE;
        Mon, 21 Sep 2020 20:53:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 20:53:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: relocate blkzoned feature check
Date:   Mon, 21 Sep 2020 20:53:14 +0800
Message-ID: <20200921125314.99297-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921125314.99297-1-yuchao0@huawei.com>
References: <20200921125314.99297-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate blkzoned feature check into parse_options() like
other feature check.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e0423b091b30..dc3edc9a5640 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -970,6 +970,17 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
+	/*
+	 * The BLKZONED feature indicates that the drive was formatted with
+	 * zone alignment optimization. This is optional for host-aware
+	 * devices, but mandatory for host-managed zoned block devices.
+	 */
+#ifndef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		f2fs_err(sbi, "Zoned block device support is not enabled");
+		return -EINVAL;
+	}
+#endif
 
 	if (F2FS_IO_SIZE_BITS(sbi) && !f2fs_lfs_mode(sbi)) {
 		f2fs_err(sbi, "Should set mode=lfs with %uKB-sized IO",
@@ -3494,18 +3505,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
 						sizeof(raw_super->uuid));
 
-	/*
-	 * The BLKZONED feature indicates that the drive was formatted with
-	 * zone alignment optimization. This is optional for host-aware
-	 * devices, but mandatory for host-managed zoned block devices.
-	 */
-#ifndef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi)) {
-		f2fs_err(sbi, "Zoned block device support is not enabled");
-		err = -EOPNOTSUPP;
-		goto free_sb_buf;
-	}
-#endif
 	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
-- 
2.26.2

