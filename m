Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D392D3EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgLIJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:29:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9140 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgLIJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:29:39 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrWtw3ZdRz15YWk;
        Wed,  9 Dec 2020 17:28:24 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 17:28:48 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <johan@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] usb: serial: simplify the ark3116_write_reg()
Date:   Wed, 9 Dec 2020 17:29:17 +0800
Message-ID: <20201209092917.20681-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/usb/serial/ark3116.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 71a9206ea1e2..0f9fa0e7c50e 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -77,16 +77,11 @@ struct ark3116_private {
 static int ark3116_write_reg(struct usb_serial *serial,
 			     unsigned reg, __u8 val)
 {
-	int result;
 	 /* 0xfe 0x40 are magic values taken from original driver */
-	result = usb_control_msg(serial->dev,
-				 usb_sndctrlpipe(serial->dev, 0),
-				 0xfe, 0x40, val, reg,
-				 NULL, 0, ARK_TIMEOUT);
-	if (result)
-		return result;
-
-	return 0;
+	return usb_control_msg(serial->dev,
+			       usb_sndctrlpipe(serial->dev, 0),
+			       0xfe, 0x40, val, reg,
+			       NULL, 0, ARK_TIMEOUT);
 }
 
 static int ark3116_read_reg(struct usb_serial *serial,
-- 
2.22.0

