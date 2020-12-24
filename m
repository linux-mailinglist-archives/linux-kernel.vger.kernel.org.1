Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2838B2E274F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgLXN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:26:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9923 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgLXNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:25:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D1rQd17CQzhvxG;
        Thu, 24 Dec 2020 21:24:41 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:25:08 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] usb: host: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:25:45 +0800
Message-ID: <20201224132545.31677-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/usb/host/u132-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 995bc52d2d22..fb692719a03a 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -78,7 +78,7 @@ static DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
 * u132_module_lock exists to protect access to global variables
 *
 */
-static struct mutex u132_module_lock;
+static DEFINE_MUTEX(u132_module_lock);
 static int u132_exiting;
 static int u132_instances;
 /*
@@ -3190,7 +3190,6 @@ static int __init u132_hcd_init(void)
 	int retval;
 	u132_instances = 0;
 	u132_exiting = 0;
-	mutex_init(&u132_module_lock);
 	if (usb_disabled())
 		return -ENODEV;
 	printk(KERN_INFO "driver %s\n", hcd_name);
-- 
2.22.0

