Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E82F5CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbhANJE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:04:29 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56270 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbhANJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:04:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULhZcSS_1610615004;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULhZcSS_1610615004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Jan 2021 17:03:30 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com, b-liu@ti.com,
        hminas@synopsys.com, jbi.octave@gmail.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drivers/usb/gadget/udc: Assign boolean values to a bool variable
Date:   Thu, 14 Jan 2021 17:03:22 +0800
Message-Id: <1610615002-66235-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/usb/gadget/udc/udc-xilinx.c:1957:2-18: WARNING:
Assignment of 0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index d5e9d20..77610b5 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1954,7 +1954,7 @@ static void xudc_nonctrl_ep_handler(struct xusb_udc *udc, u8 epnum,
 	if (intrstatus & (XUSB_STATUS_EP0_BUFF1_COMP_MASK << epnum))
 		ep->buffer0ready = 0;
 	if (intrstatus & (XUSB_STATUS_EP0_BUFF2_COMP_MASK << epnum))
-		ep->buffer1ready = 0;
+		ep->buffer1ready = false;
 
 	if (list_empty(&ep->queue))
 		return;
-- 
1.8.3.1

