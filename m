Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418927B947
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgI2BXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:23:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgI2BXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:23:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF77482D33A4B3447144;
        Tue, 29 Sep 2020 09:23:05 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 09:22:56 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>
Subject: [PATCH v3] f2fs: fix uninit-value in f2fs_lookup
Date:   Tue, 29 Sep 2020 09:22:50 +0800
Message-ID: <20200929012250.109536-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As syzbot reported:

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
 lookup_open fs/namei.c:3082 [inline]
 open_last_lookups fs/namei.c:3177 [inline]
 path_openat+0x2729/0x6a90 fs/namei.c:3365
 do_filp_open+0x2b8/0x710 fs/namei.c:3395
 do_sys_openat2+0xa88/0x1140 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_compat_sys_openat fs/open.c:1242 [inline]
 __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
 __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

In f2fs_lookup(), @res_page could be used before being initialized,
because in __f2fs_find_entry(), once F2FS_I(dir)->i_current_depth was
been fuzzed to zero, then @res_page will never be initialized, causing
this kmsan warning, relocating @res_page initialization place to fix
this bug.

Reported-by: syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- add reported-by tag.
 fs/f2fs/dir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..ceb4431b5669 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
+	*res_page = NULL;
+
 	if (f2fs_has_inline_dentry(dir)) {
-		*res_page = NULL;
 		de = f2fs_find_in_inline_dir(dir, fname, res_page);
 		goto out;
 	}
 
-	if (npages == 0) {
-		*res_page = NULL;
+	if (npages == 0)
 		goto out;
-	}
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
@@ -377,7 +376,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		*res_page = NULL;
 		de = find_in_level(dir, level, fname, res_page);
 		if (de || IS_ERR(*res_page))
 			break;
-- 
2.26.2

