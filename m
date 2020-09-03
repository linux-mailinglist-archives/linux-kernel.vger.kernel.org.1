Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC025C5FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgICP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:59:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18641C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=988CY6B1yy7GRnNZ5PKCVmB7hu3+qSzVzJgqP0YBJhY=; b=S0hCOLQ+xifH2ZdFBT5u3HrSRk
        +gUkY3pWQAL6FRRPiN/OIRCwMHyxAee0EcMJQaLJxzZdU0WHFV2/jGuNbcGeYJxW6ouj9tc8jooPO
        r6Kw1FV2vAVcPDn1pHXqPnd4SA12xYuFj5kN2oXXQjvQoAGeY9NBaaCZM6d2iYwRY8EeZfp/O4oLF
        UN7RNSgZlJfnsVCi8nEDYoYOuWFSMYUWF1MBzWslnDwOkvR/jbH8EFar+kAiRcKadi5/wzRwdZ/2o
        VhjIdWooYqK3kiQntyLboAKCE7IBLHk9JjSdMeM/rj3Jy5susO4ivwW2zIfTDl/kj8f1m+PIqcv1e
        wV+HpXBw==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDrdz-0002uE-Di; Thu, 03 Sep 2020 15:59:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
Subject: [PATCH] /dev/zero: also implement ->read
Date:   Thu,  3 Sep 2020 17:59:22 +0200
Message-Id: <20200903155922.1111551-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe reported a major speedup due to avoiding the iov_iter
overhead, so just add this trivial function.  Note that /dev/zero
already implements both an iter and non-iter writes so this just
makes it more symmetric.

Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/mem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index abd4ffdc8cdebc..1dc99ab158457a 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
+static ssize_t read_zero(struct file *file, char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	size_t cleared = 0;
+
+	while (count) {
+		size_t chunk = min_t(size_t, count, PAGE_SIZE);
+
+		if (clear_user(buf + cleared, chunk))
+			return cleared ? cleared : -EFAULT;
+		cleared += chunk;
+		count -= chunk;
+
+		if (signal_pending(current))
+			return cleared ? cleared : -ERESTARTSYS;
+		cond_resched();
+	}
+
+	return cleared;
+}
+
 static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 {
 #ifndef CONFIG_MMU
@@ -921,6 +942,7 @@ static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
 	.write		= write_zero,
 	.read_iter	= read_iter_zero,
+	.read		= read_zero,
 	.write_iter	= write_iter_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
-- 
2.28.0

