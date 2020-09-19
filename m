Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CD2709FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgISCSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:18:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgISCSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:18:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35A51914B868A78A9708;
        Sat, 19 Sep 2020 10:18:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:17:59 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] mfd: ab3100-core: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:18:31 +0800
Message-ID: <20200919021831.191077-1-miaoqinglang@huawei.com>
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

 drivers/mfd/ab3100-core.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index ee71ae04b..4a347d059 100644
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
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_registers);
 
 struct ab3100_get_set_reg_priv {
 	struct ab3100 *ab3100;
-- 
2.23.0

