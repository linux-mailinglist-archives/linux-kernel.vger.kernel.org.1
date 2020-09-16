Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AB26BA35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIPC3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:29:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgIPC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F66E912A19B44A2A8FB;
        Wed, 16 Sep 2020 10:27:52 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] dlm: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:19 +0800
Message-ID: <20200916025019.3992471-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/dlm/debug_fs.c | 104 ++++------------------------------------------
 1 file changed, 8 insertions(+), 96 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index d6bbccb0ed15..c4d1860b9e41 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -571,126 +571,38 @@ static void table_seq_stop(struct seq_file *seq, void *iter_ptr)
 	}
 }
 
-static const struct seq_operations format1_seq_ops = {
+static const struct seq_operations format1_sops = {
 	.start = table_seq_start,
 	.next  = table_seq_next,
 	.stop  = table_seq_stop,
 	.show  = table_seq_show,
 };
 
-static const struct seq_operations format2_seq_ops = {
+static const struct seq_operations format2_sops = {
 	.start = table_seq_start,
 	.next  = table_seq_next,
 	.stop  = table_seq_stop,
 	.show  = table_seq_show,
 };
 
-static const struct seq_operations format3_seq_ops = {
+static const struct seq_operations format3_sops = {
 	.start = table_seq_start,
 	.next  = table_seq_next,
 	.stop  = table_seq_stop,
 	.show  = table_seq_show,
 };
 
-static const struct seq_operations format4_seq_ops = {
+static const struct seq_operations format4_sops = {
 	.start = table_seq_start,
 	.next  = table_seq_next,
 	.stop  = table_seq_stop,
 	.show  = table_seq_show,
 };
 
-static const struct file_operations format1_fops;
-static const struct file_operations format2_fops;
-static const struct file_operations format3_fops;
-static const struct file_operations format4_fops;
-
-static int table_open1(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format1_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
-}
-
-static int table_open2(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format2_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
-}
-
-static int table_open3(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format3_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
-}
-
-static int table_open4(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format4_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
-}
-
-static const struct file_operations format1_fops = {
-	.owner   = THIS_MODULE,
-	.open    = table_open1,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations format2_fops = {
-	.owner   = THIS_MODULE,
-	.open    = table_open2,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations format3_fops = {
-	.owner   = THIS_MODULE,
-	.open    = table_open3,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations format4_fops = {
-	.owner   = THIS_MODULE,
-	.open    = table_open4,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
+DEFINE_SEQ_ATTRIBUTE(format1);
+DEFINE_SEQ_ATTRIBUTE(format2);
+DEFINE_SEQ_ATTRIBUTE(format3);
+DEFINE_SEQ_ATTRIBUTE(format4);
 
 /*
  * dump lkb's on the ls_waiters list
-- 
2.25.1

