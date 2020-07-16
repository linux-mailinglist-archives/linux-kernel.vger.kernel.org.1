Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25548221F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGPI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:58:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:58:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A2097B1935B7EFF40E69;
        Thu, 16 Jul 2020 16:58:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:58:40 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:02:36 +0800
Message-ID: <20200716090236.13057-1-miaoqinglang@huawei.com>
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
 drivers/mfd/ab3100-core.c | 15 ++-------------
 drivers/mfd/ab3100-otp.c  | 16 +++-------------
 drivers/mfd/tps65010.c    | 14 ++------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 092c78b5e..4a347d059 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -451,7 +451,7 @@ static irqreturn_t ab3100_irq_handler(int irq, void *data)
 /*
  * Some debugfs entries only exposed if we're using debug
  */
-static int ab3100_registers_print(struct seq_file *s, void *p)
+static int ab3100_registers_show(struct seq_file *s, void *p)
 {
 	struct ab3100 *ab3100 = s->private;
 	u8 value;
@@ -466,18 +466,7 @@ static int ab3100_registers_print(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ab3100_registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_registers_print, inode->i_private);
-}
-
-static const struct file_operations ab3100_registers_fops = {
-	.open = ab3100_registers_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_registers);
 
 struct ab3100_get_set_reg_priv {
 	struct ab3100 *ab3100;
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index 3c1157e7a..e5d294805 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -96,7 +96,7 @@ static int __init ab3100_otp_read(struct ab3100_otp *otp)
  * the contents of the OTP.
  */
 #ifdef CONFIG_DEBUG_FS
-static int ab3100_show_otp(struct seq_file *s, void *v)
+static int ab3100_otp_show(struct seq_file *s, void *v)
 {
 	struct ab3100_otp *otp = s->private;
 
@@ -110,23 +110,13 @@ static int ab3100_show_otp(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int ab3100_otp_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_show_otp, inode->i_private);
-}
-
-static const struct file_operations ab3100_otp_operations = {
-	.open		= ab3100_otp_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_otp);
 
 static void __init ab3100_otp_init_debugfs(struct device *dev,
 					   struct ab3100_otp *otp)
 {
 	otp->debugfs = debugfs_create_file("ab3100_otp", S_IFREG | S_IRUGO,
-					   NULL, otp, &ab3100_otp_operations);
+					   NULL, otp, &ab3100_otp_fops);
 }
 
 static void __exit ab3100_otp_exit_debugfs(struct ab3100_otp *otp)
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 31259867f..f6d6b6c18 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -179,7 +179,7 @@ static inline void show_chgconfig(int por, const char *label, u8 chgconfig) { }
 
 #ifdef	CONFIG_DEBUG_FS
 
-static int dbg_show(struct seq_file *s, void *_)
+static int debug_show(struct seq_file *s, void *_)
 {
 	struct tps65010	*tps = s->private;
 	u8		value, v2;
@@ -283,17 +283,7 @@ static int dbg_show(struct seq_file *s, void *_)
 	return 0;
 }
 
-static int dbg_tps_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= dbg_tps_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug);
 
 #define	DEBUG_FOPS	&debug_fops
 
-- 
2.17.1

