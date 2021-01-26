Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD83046FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbhAZRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbhAZGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:10:28 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86CC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:09:06 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4HXA-0068Cf-1R; Tue, 26 Jan 2021 06:09:00 +0000
Date:   Tue, 26 Jan 2021 06:09:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] take the guts of file-to-pipe splice into a helper
 function
Message-ID: <20210126060900.GB1461355@zeniv-ca.linux.org.uk>
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


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index c1ca2cc63b43..74f968c65a93 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1002,6 +1002,23 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
 
+static long splice_file_to_pipe(struct file *in,
+			 struct pipe_inode_info *opipe,
+			 loff_t *offset,
+			 size_t len, unsigned int flags)
+{
+	long ret;
+
+	pipe_lock(opipe);
+	ret = wait_for_space(opipe, flags);
+	if (!ret)
+		ret = do_splice_to(in, offset, opipe, len, flags);
+	pipe_unlock(opipe);
+	if (ret > 0)
+		wakeup_pipe_readers(opipe);
+	return ret;
+}
+
 /*
  * Determine where to splice to/from.
  */
@@ -1081,13 +1098,7 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		pipe_lock(opipe);
-		ret = wait_for_space(opipe, flags);
-		if (!ret)
-			ret = do_splice_to(in, &offset, opipe, len, flags);
-		pipe_unlock(opipe);
-		if (ret > 0)
-			wakeup_pipe_readers(opipe);
+		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 		if (!off_in)
 			in->f_pos = offset;
 		else
-- 
2.11.0

