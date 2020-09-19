Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB591270A40
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgISCwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:52:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgISCvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1BCBB63CA26479BB4EDA;
        Sat, 19 Sep 2020 10:51:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:33 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
CC:     <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] sh: mm: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:52:05 +0800
Message-ID: <20200919025205.17667-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 arch/sh/mm/asids-debugfs.c | 15 ++-------------
 arch/sh/mm/cache-debugfs.c | 15 ++-------------
 arch/sh/mm/pmb.c           | 15 ++-------------
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index 4c1ca197e..d16d6f5ec 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-static int asids_seq_show(struct seq_file *file, void *iter)
+static int asids_debugfs_show(struct seq_file *file, void *iter)
 {
 	struct task_struct *p;
 
@@ -48,18 +48,7 @@ static int asids_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int asids_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, asids_seq_show, inode->i_private);
-}
-
-static const struct file_operations asids_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= asids_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(asids_debugfs);
 
 static int __init asids_debugfs_init(void)
 {
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 17d780794..b0f185169 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -22,7 +22,7 @@ enum cache_type {
 	CACHE_TYPE_UNIFIED,
 };
 
-static int cache_seq_show(struct seq_file *file, void *iter)
+static int cache_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int cache_type = (unsigned int)file->private;
 	struct cache_info *cache;
@@ -94,18 +94,7 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int cache_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cache_seq_show, inode->i_private);
-}
-
-static const struct file_operations cache_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= cache_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(cache_debugfs);
 
 static int __init cache_debugfs_init(void)
 {
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index b20aba6e1..68eb7cc6e 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -812,7 +812,7 @@ bool __in_29bit_mode(void)
         return (__raw_readl(PMB_PASCR) & PASCR_SE) == 0;
 }
 
-static int pmb_seq_show(struct seq_file *file, void *iter)
+static int pmb_debugfs_show(struct seq_file *file, void *iter)
 {
 	int i;
 
@@ -846,18 +846,7 @@ static int pmb_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int pmb_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmb_seq_show, NULL);
-}
-
-static const struct file_operations pmb_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= pmb_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmb_debugfs);
 
 static int __init pmb_debugfs_init(void)
 {
-- 
2.23.0

