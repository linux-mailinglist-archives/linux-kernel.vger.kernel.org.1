Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0965D270A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgISCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BE50A26CAD265533467
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 10:51:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:23 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] bus: mvebu-mbus: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:51:55 +0800
Message-ID: <20200919025155.16973-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/bus/mvebu-mbus.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2519ceede..4439612b3 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -470,17 +470,7 @@ static int mvebu_sdram_debug_show(struct seq_file *seq, void *v)
 	return mbus->soc->show_cpu_target(mbus, seq, v);
 }
 
-static int mvebu_sdram_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_sdram_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_sdram_debug_fops = {
-	.open = mvebu_sdram_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_sdram_debug);
 
 static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 {
@@ -520,17 +510,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int mvebu_devs_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_devs_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_devs_debug_fops = {
-	.open = mvebu_devs_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_devs_debug);
 
 /*
  * SoC-specific functions and definitions
-- 
2.23.0

