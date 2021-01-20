Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A642FDB71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbhATUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388484AbhATUvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:51:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B36C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0lJSp5OYnejrQNXtZgDs8o2RqtJ7mfKpTa9Lt8Zcy3s=; b=MWoYAGb9LFPRCKhou3bPmHZnJK
        mT/j6S7PlZdlfHJthpZodI9fBnLTr/++yAD5WMcAsgBoAxqzQojk4Lnkhy2/gTFhLUldWcpAYTHSe
        TUKsqNedBAH4p+e4vHyqc4b0L4Fh8sNW7Sj8Q+tVow5I9wISsHLWuokq1rDJghV45VFKcf3KBbKDf
        sX53XZ6sPHPxHp/FYH5kfjKzcNPiEn4syWDBTN5LGXvHVM2D7c8FSWC5hK6ithZ3OppEp04oFlZCd
        JtvMfGZU7AvVGheg/WGpGzeY4T/QYS+deJyn63njTam0oclau/WwnDdJRjm+kNU/53aL1Mlj0FeYA
        hzG23QxA==;
Received: from [2001:4bb8:188:1954:aa9e:1db6:1a5a:7fd3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2KP7-00GCOf-Fe; Wed, 20 Jan 2021 20:49:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kernfs: implement ->read_iter
Date:   Wed, 20 Jan 2021 21:46:29 +0100
Message-Id: <20210120204631.274206-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120204631.274206-1-hch@lst.de>
References: <20210120204631.274206-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch kernfs to implement the read_iter method instead of plain old
read to prepare to supporting splice and sendfile again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/kernfs/file.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd14..8276e4c8722d8c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/fsnotify.h>
+#include <linux/uio.h>
 
 #include "kernfs-internal.h"
 
@@ -180,11 +181,10 @@ static const struct seq_operations kernfs_seq_ops = {
  * it difficult to use seq_file.  Implement simplistic custom buffering for
  * bin files.
  */
-static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
-				       char __user *user_buf, size_t count,
-				       loff_t *ppos)
+static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	ssize_t len = min_t(size_t, count, PAGE_SIZE);
+	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
+	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
 	char *buf;
 
@@ -210,7 +210,7 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	of->event = atomic_read(&of->kn->attr.open->event);
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
-		len = ops->read(of, buf, len, *ppos);
+		len = ops->read(of, buf, len, iocb->ki_pos);
 	else
 		len = -EINVAL;
 
@@ -220,12 +220,12 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	if (len < 0)
 		goto out_free;
 
-	if (copy_to_user(user_buf, buf, len)) {
+	if (copy_to_iter(buf, len, iter) != len) {
 		len = -EFAULT;
 		goto out_free;
 	}
 
-	*ppos += len;
+	iocb->ki_pos += len;
 
  out_free:
 	if (buf == of->prealloc_buf)
@@ -235,22 +235,11 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	return len;
 }
 
-/**
- * kernfs_fop_read - kernfs vfs read callback
- * @file: file pointer
- * @user_buf: data to write
- * @count: number of bytes
- * @ppos: starting offset
- */
-static ssize_t kernfs_fop_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct kernfs_open_file *of = kernfs_of(file);
-
-	if (of->kn->flags & KERNFS_HAS_SEQ_SHOW)
-		return seq_read(file, user_buf, count, ppos);
-	else
-		return kernfs_file_direct_read(of, user_buf, count, ppos);
+	if (kernfs_of(iocb->ki_filp)->kn->flags & KERNFS_HAS_SEQ_SHOW)
+		return seq_read_iter(iocb, iter);
+	return kernfs_file_read_iter(iocb, iter);
 }
 
 /**
@@ -960,7 +949,7 @@ void kernfs_notify(struct kernfs_node *kn)
 EXPORT_SYMBOL_GPL(kernfs_notify);
 
 const struct file_operations kernfs_file_fops = {
-	.read		= kernfs_fop_read,
+	.read_iter	= kernfs_fop_read_iter,
 	.write		= kernfs_fop_write,
 	.llseek		= generic_file_llseek,
 	.mmap		= kernfs_fop_mmap,
-- 
2.29.2

