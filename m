Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00C2D9750
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407685AbgLNLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:22:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9603 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgLNLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:21:40 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cvf7X2cShzM52m;
        Mon, 14 Dec 2020 19:20:08 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 19:20:44 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] usb: xhci: remove unused variable
Date:   Mon, 14 Dec 2020 19:32:11 +0800
Message-ID: <1607945531-15059-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix variable set but not used compilation warnings:

drivers/usb/host/xhci.c:1338:15: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
  unsigned int len;
               ^~~

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/usb/host/xhci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 91ab81c..24e5a0f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
 
 static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 {
-	unsigned int len;
 	unsigned int buf_len;
 	enum dma_data_direction dir;
 
@@ -1351,10 +1350,10 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 				 dir);
 
 	if (usb_urb_dir_in(urb))
-		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
-					   urb->transfer_buffer,
-					   buf_len,
-					   0);
+		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
+				     urb->transfer_buffer,
+				     buf_len,
+				     0);
 
 	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
 	kfree(urb->transfer_buffer);
-- 
2.6.2

