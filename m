Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635FE2AA9FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKHHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:38:18 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45628 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgKHHiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:38:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UEa2ewI_1604821095;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEa2ewI_1604821095)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 15:38:15 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs: remove unused varibles
Date:   Sun,  8 Nov 2020 15:38:12 +0800
Message-Id: <1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually don't use these varibles, so remove them to avoid gcc warning:
fs/ntfs/file.c:326:14: warning: variable ‘base_ni’ set but not used
[-Wunused-but-set-variable]
fs/ntfs/logfile.c:481:21: warning: variable ‘log_page_mask’ set but not
used [-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Anton Altaparmakov <anton@tuxera.com> 
Cc: linux-ntfs-dev@lists.sourceforge.net 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ntfs/file.c    | 5 +----
 fs/ntfs/logfile.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f42967b738eb..e5aab265dff1 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -323,7 +323,7 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 	unsigned long flags;
 	struct file *file = iocb->ki_filp;
 	struct inode *vi = file_inode(file);
-	ntfs_inode *base_ni, *ni = NTFS_I(vi);
+	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_volume *vol = ni->vol;
 
 	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
@@ -365,9 +365,6 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-	base_ni = ni;
-	if (NInoAttr(ni))
-		base_ni = ni->ext.base_ntfs_ino;
 	err = file_remove_privs(file);
 	if (unlikely(err))
 		goto out;
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index a0c40f1be7ac..bc1bf217b38e 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -478,7 +478,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 	u8 *kaddr = NULL;
 	RESTART_PAGE_HEADER *rstr1_ph = NULL;
 	RESTART_PAGE_HEADER *rstr2_ph = NULL;
-	int log_page_size, log_page_mask, err;
+	int log_page_size, err;
 	bool logfile_is_empty = true;
 	u8 log_page_bits;
 
@@ -501,7 +501,6 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 		log_page_size = DefaultLogPageSize;
 	else
 		log_page_size = PAGE_SIZE;
-	log_page_mask = log_page_size - 1;
 	/*
 	 * Use ntfs_ffs() instead of ffs() to enable the compiler to
 	 * optimize log_page_size and log_page_bits into constants.
-- 
1.8.3.1

