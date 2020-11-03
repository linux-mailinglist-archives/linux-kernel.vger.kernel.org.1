Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02A32A3DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgKCH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 02:28:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7037 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgKCH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:28:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQLws0zP7zhgD1;
        Tue,  3 Nov 2020 15:28:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:28:04 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH v2] serial: txx9: add missing platform_driver_unregister() on error in serial_txx9_init
Date:   Tue, 3 Nov 2020 15:33:41 +0800
Message-ID: <20201103073341.144512-1-miaoqinglang@huawei.com>
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

Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/serial_txx9.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index b4d89e317..7a07e7272 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1280,6 +1280,9 @@ static int __init serial_txx9_init(void)
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
 	ret = pci_register_driver(&serial_txx9_pci_driver);
+	if (ret) {
+		platform_driver_unregister(&serial_txx9_plat_driver);
+	}
 #endif
 	if (ret == 0)
 		goto out;
-- 
2.23.0

