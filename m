Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6DE22D580
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGYGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 02:30:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgGYGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:30:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5450C3B4E21CE1DB4F4D;
        Sat, 25 Jul 2020 14:30:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 14:30:45 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mtd: fix missing unlock on error in mtdchar_compat_ioctl()
Date:   Sat, 25 Jul 2020 06:34:16 +0000
Message-ID: <20200725063416.172037-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function mtdchar_compat_ioctl()
in the error handling case.

Fixes: 210bec567936 ("mtd: properly check all write ioctls for permissions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mtd/mtdchar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 52c120f9fb0d..b40f46a43fc6 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -1064,8 +1064,10 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
 		struct mtd_oob_buf32 buf;
 		struct mtd_oob_buf32 __user *buf_user = argp;
 
-		if (!(file->f_mode & FMODE_WRITE))
-			return -EPERM;
+		if (!(file->f_mode & FMODE_WRITE)) {
+			ret = -EPERM;
+			break;
+		}
 
 		if (copy_from_user(&buf, argp, sizeof(buf)))
 			ret = -EFAULT;



