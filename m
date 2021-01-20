Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F102FDBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436657AbhATU7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389893AbhATUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:53:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F73C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yiIIPFniDUexDED92HORl5YatuVv3Uj67UYE3JopUt0=; b=vHpp+dqZ9lnR/Vs344tyk1I23m
        wAHAg9u2miLHYZJayFq43SQ5j1QjkC+l5W4qsOI2R4eeBTdNQe7YFIq9Cs7CA0v+tAgIQTCgj8FWI
        Ob2brhf8twzGazskVMPB1l6RYpauKuzz7mc/Y/5m42syhktRYPWOW5iLec+Th34AmVRL9tjtHAEnF
        oX0fDbrGeYPn+wVx5dqsHBBNZQwbMKlyqCVReVkW0FrHClpDFOIvy+tTP/BUMk6ZwR14rvOkwjohS
        qy3Y9meSVd6lwF95qsF5a1Ai1O7qDqDoEKvB2oBqh2gYoGoW6XTn9ZSaPAs1HIaGMYRHcN49Dn786
        dXWkx04g==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2KSh-00GCcu-T5; Wed, 20 Jan 2021 20:52:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kernfs: implement ->write_iter
Date:   Wed, 20 Jan 2021 21:46:30 +0100
Message-Id: <20210120204631.274206-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120204631.274206-1-hch@lst.de>
References: <20210120204631.274206-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch kernfs to implement the write_iter method instead of plain old
write to prepare to supporting splice and sendfile again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/kernfs/file.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8276e4c8722d8c..b1a5cccf189ec7 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -242,13 +242,7 @@ static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return kernfs_file_read_iter(iocb, iter);
 }
 
-/**
- * kernfs_fop_write - kernfs vfs write callback
- * @file: file pointer
- * @user_buf: data to write
- * @count: number of bytes
- * @ppos: starting offset
- *
+/*
  * Copy data in from userland and pass it to the matching kernfs write
  * operation.
  *
@@ -258,20 +252,18 @@ static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
  * modify only the the value you're changing, then write entire buffer
  * back.
  */
-static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct kernfs_open_file *of = kernfs_of(file);
+	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
+	ssize_t len = iov_iter_count(iter);
 	const struct kernfs_ops *ops;
-	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
-		len = count;
 		if (len > of->atomic_write_len)
 			return -E2BIG;
 	} else {
-		len = min_t(size_t, count, PAGE_SIZE);
+		len = min_t(size_t, len, PAGE_SIZE);
 	}
 
 	buf = of->prealloc_buf;
@@ -282,7 +274,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, user_buf, len)) {
+	if (copy_from_iter(buf, len, iter) != len) {
 		len = -EFAULT;
 		goto out_free;
 	}
@@ -301,7 +293,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 
 	ops = kernfs_ops(of->kn);
 	if (ops->write)
-		len = ops->write(of, buf, len, *ppos);
+		len = ops->write(of, buf, len, iocb->ki_pos);
 	else
 		len = -EINVAL;
 
@@ -309,7 +301,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 	mutex_unlock(&of->mutex);
 
 	if (len > 0)
-		*ppos += len;
+		iocb->ki_pos += len;
 
 out_free:
 	if (buf == of->prealloc_buf)
@@ -662,7 +654,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 
 	/*
 	 * Write path needs to atomic_write_len outside active reference.
-	 * Cache it in open_file.  See kernfs_fop_write() for details.
+	 * Cache it in open_file.  See kernfs_fop_write_iter() for details.
 	 */
 	of->atomic_write_len = ops->atomic_write_len;
 
@@ -950,7 +942,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
 
 const struct file_operations kernfs_file_fops = {
 	.read_iter	= kernfs_fop_read_iter,
-	.write		= kernfs_fop_write,
+	.write_iter	= kernfs_fop_write_iter,
 	.llseek		= generic_file_llseek,
 	.mmap		= kernfs_fop_mmap,
 	.open		= kernfs_fop_open,
-- 
2.29.2

