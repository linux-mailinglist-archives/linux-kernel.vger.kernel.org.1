Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FD2D217D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgLHDbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:31:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9127 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLHDbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:31:36 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cqm0G69S1z15YPk;
        Tue,  8 Dec 2020 11:30:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 11:30:46 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: compress: deny setting unsupported compress algorithm
Date:   Tue, 8 Dec 2020 11:30:33 +0800
Message-ID: <20201208033033.64582-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel doesn't support certain kinds of compress algorithm, deny to set
them as compress algorithm of f2fs via 'compress_algorithm=%s' mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix wrong message in log.
 fs/f2fs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 529ee8ef46c1..bf96f5776f99 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -936,9 +936,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!name)
 				return -ENOMEM;
 			if (!strcmp(name, "lzo")) {
+#ifdef CONFIG_F2FS_FS_LZO
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZO;
+#else
+				f2fs_info(sbi, "kernel doesn't support lzo compression");
+#endif
 			} else if (!strncmp(name, "lz4", 3)) {
+#ifdef CONFIG_F2FS_FS_LZ4
 				ret = f2fs_compress_set_level(sbi, name,
 								COMPRESS_LZ4);
 				if (ret) {
@@ -947,7 +952,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZ4;
+#else
+				f2fs_info(sbi, "kernel doesn't support lz4 compression");
+#endif
 			} else if (!strncmp(name, "zstd", 4)) {
+#ifdef CONFIG_F2FS_FS_ZSTD
 				ret = f2fs_compress_set_level(sbi, name,
 								COMPRESS_ZSTD);
 				if (ret) {
@@ -956,9 +965,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_ZSTD;
+#else
+				f2fs_info(sbi, "kernel doesn't support zstd compression");
+#endif
 			} else if (!strcmp(name, "lzo-rle")) {
+#ifdef CONFIG_F2FS_FS_LZORLE
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZORLE;
+#else
+				f2fs_info(sbi, "kernel doesn't support lzorle compression");
+#endif
 			} else {
 				kfree(name);
 				return -EINVAL;
-- 
2.29.2

