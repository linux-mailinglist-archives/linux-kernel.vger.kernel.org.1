Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB352CCD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgLCDeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:34:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8994 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgLCDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:34:07 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CmhHZ2HnbzhhMd;
        Thu,  3 Dec 2020 11:32:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 11:33:14 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: deny setting unsupported compress algorithm
Date:   Thu, 3 Dec 2020 11:33:09 +0800
Message-ID: <20201203033309.42734-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel doesn't support certain kinds of compress algorithm, deny to
set them as compress algorithm of f2fs via 'compress_algorithm=%s' mount
option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6e186e365efc..1b9d2592b1ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -504,15 +504,10 @@ static int f2fs_compress_set_level(struct f2fs_sb_info *sbi, const char *str,
 		return 0;
 #endif
 	} else if (type == COMPRESS_ZSTD) {
-#ifdef CONFIG_F2FS_FS_ZSTD
 		if (!level || level > ZSTD_maxCLevel()) {
 			f2fs_info(sbi, "invalid zstd compress level: %d", level);
 			return -EINVAL;
 		}
-#else
-		f2fs_info(sbi, "doesn't support zstd compression");
-		return 0;
-#endif
 	}
 	F2FS_OPTION(sbi).compress_level = level;
 	return 0;
@@ -937,9 +932,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!name)
 				return -ENOMEM;
 			if (!strcmp(name, "lzo")) {
+#ifdef CONFIG_F2FS_FS_LZO
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZO;
+#else
+				f2fs_info(sbi, "Image doesn't support lzo compression");
+#endif
 			} else if (!strncmp(name, "lz4", 3)) {
+#ifdef CONFIG_F2FS_FS_LZ4
 				ret = f2fs_compress_set_level(sbi, name,
 								COMPRESS_LZ4);
 				if (ret) {
@@ -948,7 +948,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZ4;
+#else
+				f2fs_info(sbi, "Image doesn't support lz4 compression");
+#endif
 			} else if (!strncmp(name, "zstd", 4)) {
+#ifdef CONFIG_F2FS_FS_ZSTD
 				ret = f2fs_compress_set_level(sbi, name,
 								COMPRESS_ZSTD);
 				if (ret) {
@@ -957,9 +961,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_ZSTD;
+#else
+				f2fs_info(sbi, "Image doesn't support zstd compression");
+#endif
 			} else if (!strcmp(name, "lzo-rle")) {
+#ifdef CONFIG_F2FS_FS_LZORLE
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZORLE;
+#else
+				f2fs_info(sbi, "Image doesn't support lzorle compression");
+#endif
 			} else {
 				kfree(name);
 				return -EINVAL;
-- 
2.26.2

