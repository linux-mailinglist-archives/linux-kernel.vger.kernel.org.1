Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAEF2A1250
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgJaBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 21:13:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaBNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 21:13:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNLlj0BVDzhdJg;
        Sat, 31 Oct 2020 09:13:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 09:13:10 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] serial: txx9: add missing platform_driver_unregister() on error in serial_txx9_init
Date:   Sat, 31 Oct 2020 09:18:57 +0800
Message-ID: <20201031011857.137352-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_driver_unregister() before return
from serial_txx9_init in the error handling case when failed
to register serial_txx9_pci_driver with macro ENABLE_SERIAL_TXX9_PCI
defined.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/serial_txx9.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index b4d89e317..3d883cd55 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1280,10 +1280,13 @@ static int __init serial_txx9_init(void)
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
 	ret = pci_register_driver(&serial_txx9_pci_driver);
+	if (ret)
+		goto unreg_platform_drv;
 #endif
-	if (ret == 0)
-		goto out;
+	return 0;
 
+ unreg_platform_drv:
+	platform_driver_unregister(&serial_txx9_plat_driver);
  del_dev:
 	platform_device_del(serial_txx9_plat_devs);
  put_dev:
-- 
2.23.0

