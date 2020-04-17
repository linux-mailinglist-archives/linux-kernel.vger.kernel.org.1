Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0B1AD6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgDQHF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:05:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgDQHF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:05:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21195FAFA0058E0C2AA7;
        Fri, 17 Apr 2020 15:05:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:05:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <baijiaju1990@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] usb: gadget: udc: remove unused 'driver_desc'
Date:   Fri, 17 Apr 2020 15:31:37 +0800
Message-ID: <20200417073137.39968-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/usb/gadget/udc/gr_udc.c:51:19: warning: ‘driver_desc’ defined
but not used [-Wunused-const-variable=]
 static const char driver_desc[] = DRIVER_DESC;
                   ^~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/gadget/udc/gr_udc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index aaf975c809bf..7164ad9800f1 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -48,7 +48,6 @@
 #define	DRIVER_DESC	"Aeroflex Gaisler GRUSBDC USB Peripheral Controller"
 
 static const char driver_name[] = DRIVER_NAME;
-static const char driver_desc[] = DRIVER_DESC;
 
 #define gr_read32(x) (ioread32be((x)))
 #define gr_write32(x, v) (iowrite32be((v), (x)))
-- 
2.21.1

