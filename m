Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C815825535A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 05:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgH1Ddg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 23:33:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbgH1Ddg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:33:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3048085FE2F224C0F4FC;
        Fri, 28 Aug 2020 11:33:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 11:33:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard.weinberger@gmail.com>, <yi.zhang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] ubifs: setflags: Don't show error message when vfs_ioc_setflags_prepare() fails
Date:   Fri, 28 Aug 2020 11:32:50 +0800
Message-ID: <20200828033250.910168-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following process will trigger ubifs_err:
  1. useradd -m freg                                        (Under root)
  2. cd /home/freg && mkdir mp                              (Under freg)
  3. mount -t ubifs /dev/ubi0_0 /home/freg/mp               (Under root)
  4. cd /home/freg && echo 123 > mp/a			    (Under root)
  5. cd mp && chown freg a && chgrp freg a && chmod 777 a   (Under root)
  6. chattr +i a                                            (Under freg)

UBIFS error (ubi0:0 pid 1723): ubifs_ioctl [ubifs]: can't modify inode
65 attributes
chattr: Operation not permitted while setting flags on a

This is not an UBIFS problem, it was caused by task priviliage checking
on file operations. Remove error message printing from kernel just like
other filesystems (eg. ext4), since we already have enough information
from userspace tools.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 3df9be2c684c..4363d85a3fd4 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -134,7 +134,6 @@ static int setflags(struct inode *inode, int flags)
 	return err;
 
 out_unlock:
-	ubifs_err(c, "can't modify inode %lu attributes", inode->i_ino);
 	mutex_unlock(&ui->ui_mutex);
 	ubifs_release_budget(c, &req);
 	return err;
-- 
2.25.4

