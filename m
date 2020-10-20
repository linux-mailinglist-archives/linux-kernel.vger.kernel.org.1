Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4930A28815F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgJIEbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgJIEbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:31:36 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F752223C;
        Fri,  9 Oct 2020 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602217895;
        bh=lcMTEuAIauNFQXeQzLSIjhCNIZtoQDsUjhK/lQf6OyA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UbCEniWMvoHXgwziU5NGi+hgCEK34a0+Mvs3pcgo4vyML15VLaMdD/OTT9X9gcPye
         hqc/YbhRax+0m+dZBQRnG/7SwQC8hv5fJjz4FBrVxm1MyjFerN/6+K0t1KN26wqeOU
         AwkjERcQVIiAT2xouKH7FJ3SmglpHquFBKigBnUA=
Date:   Thu, 8 Oct 2020 21:31:35 -0700
From:   jaegeuk@kernel.org
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH v2] f2fs: f2fs_get_meta_page_nofail should not be failed
Message-ID: <20201009043135.GA1973455@google.com>
References: <20201002213226.2862930-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002213226.2862930-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, f2fs can break the the consistency.
(e.g., BUG_ON in f2fs_get_sum_page)

Then, this reveals another issue where we go into an infinite loop on normal
error case. It turns out we abused f2fs_get_meta_page_nofail() in this path.

- f2fs_fill_super
 - f2fs_build_segment_manager
  - build_sit_entries
   - get_current_sit_page

Actually, we didn't have to use _nofail in this case, since we could return
error to mount(2) already with the error handler.

This was caught by syzbot as follows.

INFO: task syz-executor178:6870 can't die for more than 143 seconds.
task:syz-executor178 state:R
 stack:26960 pid: 6870 ppid:  6869 flags:0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1179:
 #0: ffffffff8a554da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6242
1 lock held by systemd-journal/3920:
1 lock held by in:imklog/6769:
 #0: ffff88809eebc130 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor178/6870:
 #0: ffff8880925120e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x201/0xaf0 fs/super.c:229

Reported-by: syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

v2 log:
 - fix syzbot issue

 fs/f2fs/checkpoint.c | 9 +++------
 fs/f2fs/f2fs.h       | 2 --
 fs/f2fs/segment.c    | 2 +-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f18386d30f031..7bb3a741a8f16 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -110,15 +110,12 @@ struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	struct page *page;
-	int count = 0;
-
 retry:
 	page = __get_meta_page(sbi, index, true);
 	if (IS_ERR(page)) {
-		if (PTR_ERR(page) == -EIO &&
-				++count <= DEFAULT_RETRY_IO_COUNT)
-			goto retry;
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_flush_merged_writes(sbi);
+		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+		goto retry;
 	}
 	return page;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae46d44bd5211..ce79b9b5b1eff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -593,8 +593,6 @@ enum {
 					 */
 };
 
-#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
-
 /* congestion wait timeout value, default: 20ms */
 #define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 13ecd2c2c361b..40001d80fa86d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3964,7 +3964,7 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
-	return f2fs_get_meta_page_nofail(sbi, current_sit_addr(sbi, segno));
+	return f2fs_get_meta_page(sbi, current_sit_addr(sbi, segno));
 }
 
 static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
-- 
2.28.0.1011.ga647a8990f-goog

