Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D702FFF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbhAVJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:47:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11566 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbhAVJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:41:52 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMZ3G4nKBzMN5Y;
        Fri, 22 Jan 2021 17:39:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 22 Jan 2021 17:40:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: compress: deny setting unsupported compress algorithm
Date:   Fri, 22 Jan 2021 17:40:13 +0800
Message-ID: <20210122094013.46538-1-yuchao0@huawei.com>
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
v3:
- rebase to commit 03a9a1a64a11 ("f2fs: relocate f2fs_precache_extents()")
in dev branch
 fs/f2fs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b4a07fe62d1a..a275bd312ae5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -882,17 +882,33 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!name)
 				return -ENOMEM;
 			if (!strcmp(name, "lzo")) {
+#ifdef CONFIG_F2FS_FS_LZO
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZO;
+#else
+				f2fs_info(sbi, "kernel doesn't support lzo compression");
+#endif
 			} else if (!strcmp(name, "lz4")) {
+#ifdef CONFIG_F2FS_FS_LZ4
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZ4;
+#else
+				f2fs_info(sbi, "kernel doesn't support lz4 compression");
+#endif
 			} else if (!strcmp(name, "zstd")) {
+#ifdef CONFIG_F2FS_FS_ZSTD
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

