Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C5304706
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbhAZRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbhAZGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:10:28 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C98C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:09:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4HXg-0068Dh-FC; Tue, 26 Jan 2021 06:09:32 +0000
Date:   Tue, 26 Jan 2021 06:09:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] teach sendfile(2) to handle send-to-pipe directly
Message-ID: <20210126060932.GC1461355@zeniv-ca.linux.org.uk>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca>
 <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210126060720.GJ740243@zeniv-ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126060720.GJ740243@zeniv-ca>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no point going through the intermediate pipe

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h   |  9 +++++++++
 fs/read_write.c | 19 +++++++++++++------
 fs/splice.c     |  2 +-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 77c50befbfbe..cff1f30cfefb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -15,6 +15,7 @@ struct mount;
 struct shrink_control;
 struct fs_context;
 struct user_namespace;
+struct pipe_inode_info;
 
 /*
  * block_dev.c
@@ -193,3 +194,11 @@ int sb_init_dio_done_wq(struct super_block *sb);
  */
 int do_statx(int dfd, const char __user *filename, unsigned flags,
 	     unsigned int mask, struct statx __user *buffer);
+
+/*
+ * fs/splice.c:
+ */
+long splice_file_to_pipe(struct file *in,
+			 struct pipe_inode_info *opipe,
+			 loff_t *offset,
+			 size_t len, unsigned int flags);
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..9db7adf160d2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1188,6 +1188,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 {
 	struct fd in, out;
 	struct inode *in_inode, *out_inode;
+	struct pipe_inode_info *opipe;
 	loff_t pos;
 	loff_t out_pos;
 	ssize_t retval;
@@ -1228,9 +1229,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	in_inode = file_inode(in.file);
 	out_inode = file_inode(out.file);
 	out_pos = out.file->f_pos;
-	retval = rw_verify_area(WRITE, out.file, &out_pos, count);
-	if (retval < 0)
-		goto fput_out;
 
 	if (!max)
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
@@ -1253,9 +1251,18 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (in.file->f_flags & O_NONBLOCK)
 		fl = SPLICE_F_NONBLOCK;
 #endif
-	file_start_write(out.file);
-	retval = do_splice_direct(in.file, &pos, out.file, &out_pos, count, fl);
-	file_end_write(out.file);
+	opipe = get_pipe_info(out.file, true);
+	if (!opipe) {
+		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
+		if (retval < 0)
+			goto fput_out;
+		file_start_write(out.file);
+		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
+					  count, fl);
+		file_end_write(out.file);
+	} else {
+		retval = splice_file_to_pipe(in.file, opipe, &pos, count, fl);
+	}
 
 	if (retval > 0) {
 		add_rchar(current, retval);
diff --git a/fs/splice.c b/fs/splice.c
index 74f968c65a93..b06846f1e6ee 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1002,7 +1002,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
 
-static long splice_file_to_pipe(struct file *in,
+long splice_file_to_pipe(struct file *in,
 			 struct pipe_inode_info *opipe,
 			 loff_t *offset,
 			 size_t len, unsigned int flags)
-- 
2.11.0

