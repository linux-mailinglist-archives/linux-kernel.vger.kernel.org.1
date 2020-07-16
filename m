Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE5221F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGPJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:00:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:00:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9127CF9C73E1179EB131;
        Thu, 16 Jul 2020 17:00:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:00:27 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bus: mvebu-mbus: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:04:22 +0800
Message-ID: <20200716090422.13633-1-miaoqinglang@huawei.com>
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

From: Liu Shixin <liushixin2@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/bus/mvebu-mbus.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index e76c866cd..3aaaf4848 100644
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
-	.read_iter = seq_read_iter,
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
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_devs_debug);
 
 /*
  * SoC-specific functions and definitions
-- 
2.17.1

