Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99F25B8A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgICCPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 22:15:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgICCPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:15:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C1F6282EE4D954215D6;
        Thu,  3 Sep 2020 10:15:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 10:15:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] f2fs: ignore compress mount option on image w/o compression feature
Date:   Thu, 3 Sep 2020 10:14:41 +0800
Message-ID: <20200903021441.100226-1-yuchao0@huawei.com>
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

to keep consistent with behavior when passing compress mount option
to kernel w/o compression feature, so that mount may not fail on
such condition.

Reported-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ae0b351671f4..9d4da2d13ab4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -871,8 +871,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		case Opt_compress_algorithm:
 			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_err(sbi, "Compression feature if off");
-				return -EINVAL;
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
 			}
 			name = match_strdup(&args[0]);
 			if (!name)
@@ -897,8 +897,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			break;
 		case Opt_compress_log_size:
 			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_err(sbi, "Compression feature is off");
-				return -EINVAL;
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
 			}
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
@@ -912,8 +912,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			break;
 		case Opt_compress_extension:
 			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_err(sbi, "Compression feature is off");
-				return -EINVAL;
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
 			}
 			name = match_strdup(&args[0]);
 			if (!name)
-- 
2.26.2

