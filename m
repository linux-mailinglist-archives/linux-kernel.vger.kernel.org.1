Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9C2B06F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKLNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:49:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7220 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKLNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:49:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CX2yQ5rqHzkhhY;
        Thu, 12 Nov 2020 21:49:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:49:23 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <weiyongjun1@huawei.com>,
        <jun.li@freescale.com>, <rogerq@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH v2] usb: gadget: mass_storage: fix error return code in msg_bind()
Date:   Thu, 12 Nov 2020 21:54:23 +0800
Message-ID: <20201112135423.89536-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case
instead of 0 in function msg_bind(), as done elsewhere in this
function.

Fixes: d86788979761 ("usb: gadget: mass_storage: allocate and init otg descriptor by otg capabilities")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/usb/gadget/legacy/mass_storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadget/legacy/mass_storage.c
index 9ed22c5fb7fe..ac1741126619 100644
--- a/drivers/usb/gadget/legacy/mass_storage.c
+++ b/drivers/usb/gadget/legacy/mass_storage.c
@@ -175,8 +175,10 @@ static int msg_bind(struct usb_composite_dev *cdev)
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail_string_ids;
+		}
 		usb_otg_descriptor_init(cdev->gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;
-- 
2.20.1

