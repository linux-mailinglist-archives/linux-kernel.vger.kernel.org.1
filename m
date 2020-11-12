Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9C2B07D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgKLOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:52:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgKLOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:52:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CX4MN1WtwzhkLK;
        Thu, 12 Nov 2020 22:52:32 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 22:52:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>, <maco@android.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] loop: Fix passing zero to 'PTR_ERR' warning
Date:   Thu, 12 Nov 2020 22:52:33 +0800
Message-ID: <20201112145233.53060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

drivers/block/loop.c:799 loop_attr_backing_file_show() warn: passing zero to 'PTR_ERR'

file_path() never returns 0, so use IS_ERR instead of
IS_ERR_OR_NULL to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 83701c2ae3ca..65d392307c6a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -795,7 +795,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 		p = file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
 	spin_unlock_irq(&lo->lo_lock);
 
-	if (IS_ERR_OR_NULL(p))
+	if (IS_ERR(p))
 		ret = PTR_ERR(p);
 	else {
 		ret = strlen(p);
-- 
2.17.1

