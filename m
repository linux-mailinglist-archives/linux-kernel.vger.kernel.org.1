Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F62272439
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgIUMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:53:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgIUMxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:53:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6BEEB16731AB41C1103F;
        Mon, 21 Sep 2020 20:53:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 20:53:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: do sanity check on zoned block device path
Date:   Mon, 21 Sep 2020 20:53:13 +0800
Message-ID: <20200921125314.99297-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbi->devs would be initialized only if image enables multiple device
feature or blkzoned feature, if blkzoned feature flag was set by fuzz
in non-blkzoned device, we will suffer below panic:

get_zone_idx fs/f2fs/segment.c:4892 [inline]
f2fs_usable_zone_blks_in_seg fs/f2fs/segment.c:4943 [inline]
f2fs_usable_blks_in_seg+0x39b/0xa00 fs/f2fs/segment.c:4999
Call Trace:
 check_block_count+0x69/0x4e0 fs/f2fs/segment.h:704
 build_sit_entries fs/f2fs/segment.c:4403 [inline]
 f2fs_build_segment_manager+0x51da/0xa370 fs/f2fs/segment.c:5100
 f2fs_fill_super+0x3880/0x6ff0 fs/f2fs/super.c:3684
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3216
 do_mount fs/namespace.c:3229 [inline]
 __do_sys_mount fs/namespace.c:3437 [inline]
 __se_sys_mount fs/namespace.c:3414 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

Add sanity check to inconsistency on factors: blkzoned flag, device
path and device character to avoid above panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 427ce4cbd124..e0423b091b30 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2852,6 +2852,12 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 					segment_count, dev_seg_count);
 			return -EFSCORRUPTED;
 		}
+	} else {
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_BLKZONED) &&
+					!bdev_is_zoned(sbi->sb->s_bdev)) {
+			f2fs_info(sbi, "Zoned block device path is missing");
+			return -EFSCORRUPTED;
+		}
 	}
 
 	if (secs_per_zone > total_sections || !secs_per_zone) {
-- 
2.26.2

