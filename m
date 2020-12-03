Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF42CE03A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLCU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgLCU4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:56:12 -0500
From:   Jaegeuk Kim <jaegeuk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: don't allow any writes on readonly mount
Date:   Thu,  3 Dec 2020 12:55:21 -0800
Message-Id: <20201203205522.891082-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_make_request: Trying to write to read-only block-device dm-5 (partno 0)
WARNING: CPU: 7 PID: 546 at block/blk-core.c:2190 generic_make_request_checks+0x664/0x690
pc : generic_make_request_checks+0x664/0x690
lr : generic_make_request_checks+0x664/0x690
Call trace:
 generic_make_request_checks+0x664/0x690
 generic_make_request+0xf0/0x3a4
 submit_bio+0x80/0x250
 __submit_merged_bio+0x368/0x4e0
 __submit_merged_write_cond.llvm.12294350193007536502+0xe0/0x3e8
 f2fs_wait_on_page_writeback+0x84/0x128
 f2fs_convert_inline_page+0x35c/0x6f8
 f2fs_convert_inline_inode+0xe0/0x2e0
 f2fs_file_mmap+0x48/0x9c
 mmap_region+0x41c/0x74c
 do_mmap+0x40c/0x4fc
 vm_mmap_pgoff+0xb8/0x114
 vm_mmap+0x34/0x48
 elf_map+0x68/0x108
 load_elf_binary+0x538/0xb70
 search_binary_handler+0xac/0x1dc
 exec_binprm+0x50/0x15c
 __do_execve_file+0x620/0x740
 __arm64_sys_execve+0x54/0x68
 el0_svc_common+0x9c/0x168
 el0_svc_handler+0x60/0x6c
 el0_svc+0x8/0xc

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 92e9852d316a..d09a0bdc0197 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -188,7 +188,8 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	struct page *ipage, *page;
 	int err = 0;
 
-	if (!f2fs_has_inline_data(inode))
+	if (!f2fs_has_inline_data(inode) ||
+			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
 		return 0;
 
 	page = f2fs_grab_cache_page(inode->i_mapping, 0, false);
-- 
2.29.2.576.ga3fc446d84-goog

