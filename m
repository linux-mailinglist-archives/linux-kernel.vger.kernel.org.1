Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F333304707
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbhAZRPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbhAZGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:10:28 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE18C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:08:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4HWR-0068BS-7z; Tue, 26 Jan 2021 06:08:15 +0000
Date:   Tue, 26 Jan 2021 06:08:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] do_splice_to(): move the logics for limiting the read
 length in
Message-ID: <20210126060815.GA1461355@zeniv-ca.linux.org.uk>
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

Both callers have the identical logics limiting the amount of
data we try to read into pipe - no more than would fit into
that pipe.  Move that into do_splice_to() itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 866d5c2367b2..c1ca2cc63b43 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -771,11 +771,16 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe, size_t len,
 			 unsigned int flags)
 {
+	unsigned int p_space;
 	int ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
 
+	/* Don't try to read more the pipe has space for. */
+	p_space = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);
+	len = min_t(size_t, len, p_space << PAGE_SHIFT);
+
 	ret = rw_verify_area(READ, in, ppos, len);
 	if (unlikely(ret < 0))
 		return ret;
@@ -856,15 +861,10 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	WARN_ON_ONCE(!pipe_empty(pipe->head, pipe->tail));
 
 	while (len) {
-		unsigned int p_space;
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
-		/* Don't try to read more the pipe has space for. */
-		p_space = pipe->max_usage -
-			pipe_occupancy(pipe->head, pipe->tail);
-		read_len = min_t(size_t, len, p_space << PAGE_SHIFT);
-		ret = do_splice_to(in, &pos, pipe, read_len, flags);
+		ret = do_splice_to(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
 
@@ -1083,15 +1083,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
-		if (!ret) {
-			unsigned int p_space;
-
-			/* Don't try to read more the pipe has space for. */
-			p_space = opipe->max_usage - pipe_occupancy(opipe->head, opipe->tail);
-			len = min_t(size_t, len, p_space << PAGE_SHIFT);
-
+		if (!ret)
 			ret = do_splice_to(in, &offset, opipe, len, flags);
-		}
 		pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
-- 
2.11.0

