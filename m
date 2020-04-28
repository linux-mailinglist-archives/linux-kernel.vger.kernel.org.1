Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690181BB6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD1Gee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:34:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbgD1Gee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:34:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 978DB28D69898C69969B;
        Tue, 28 Apr 2020 14:34:28 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:34:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Julia.Lawall@inria.fr>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] usb: gadget: omap_udc: remove unneeded semicolon
Date:   Tue, 28 Apr 2020 14:33:46 +0800
Message-ID: <20200428063346.9867-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/usb/gadget/udc/omap_udc.c:2579:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index bf87c6c0d7f6..4139da885651 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2576,7 +2576,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	case USB_ENDPOINT_XFER_INT:
 		ep->ep.caps.type_int = true;
 		break;
-	};
+	}
 
 	if (addr & USB_DIR_IN)
 		ep->ep.caps.dir_in = true;
-- 
2.21.1

