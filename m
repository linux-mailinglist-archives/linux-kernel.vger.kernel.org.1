Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB93221ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGPIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:45:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbgGPIpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:45:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 27B9FFAAA139DCE18780;
        Thu, 16 Jul 2020 16:45:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:44:59 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Kershner <david.kershner@unisys.com>
CC:     <sparmaintainer@unisys.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drivers: visorbus: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:48:53 +0800
Message-ID: <20200716084853.8574-1-miaoqinglang@huawei.com>
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

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/visorbus/visorbus_main.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index a0b8142bd..b5417f1e7 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -471,18 +471,7 @@ static int bus_info_debugfs_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int bus_info_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bus_info_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations bus_info_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = bus_info_debugfs_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bus_info_debugfs);
 
 static void dev_periodic_work(struct timer_list *t)
 {
-- 
2.17.1

