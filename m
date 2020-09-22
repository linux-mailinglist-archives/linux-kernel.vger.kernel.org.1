Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31744274092
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIVLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:18:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbgIVLS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:18:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33E77EE2DB2D97553BC3;
        Tue, 22 Sep 2020 19:18:53 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 22 Sep 2020
 19:18:50 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ide: Remove set but not used variable
Date:   Tue, 22 Sep 2020 19:18:49 +0800
Message-ID: <1600773529-45805-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/ide/ide-proc.c:457:37: warning:
‘ide_media_proc_fops’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/ide/ide-proc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3..2fad809 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -454,14 +454,6 @@ static int ide_media_proc_open(struct inode *inode, struct file *file)
 	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
 }

-static const struct file_operations ide_media_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_media_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
 	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
--
2.7.4

