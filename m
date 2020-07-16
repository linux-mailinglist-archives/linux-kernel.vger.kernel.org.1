Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39347221F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGPI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:59:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbgGPI7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:59:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E567242A69D24F0AA7B1;
        Thu, 16 Jul 2020 16:59:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:59:17 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
CC:     <llinux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bcache: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:03:13 +0800
Message-ID: <20200716090313.13216-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/md/bcache/closure.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 99222aa5d..37b9c5d49 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -159,7 +159,7 @@ void closure_debug_destroy(struct closure *cl)
 
 static struct dentry *closure_debug;
 
-static int debug_seq_show(struct seq_file *f, void *data)
+static int debug_show(struct seq_file *f, void *data)
 {
 	struct closure *cl;
 
@@ -188,17 +188,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
 	return 0;
 }
 
-static int debug_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debug_seq_show, NULL);
-}
-
-static const struct file_operations debug_ops = {
-	.owner		= THIS_MODULE,
-	.open		= debug_seq_open,
-	.read_iter		= seq_read_iter,
-	.release	= single_release
-};
+DEFINE_SHOW_ATTRIBUTE(debug);
 
 void  __init closure_debug_init(void)
 {
@@ -209,7 +199,7 @@ void  __init closure_debug_init(void)
 		 * about this.
 		 */
 		closure_debug = debugfs_create_file(
-			"closures", 0400, bcache_debug, NULL, &debug_ops);
+				"closures", 0400, bcache_debug, NULL, &debug_fops);
 }
 #endif
 
-- 
2.17.1

