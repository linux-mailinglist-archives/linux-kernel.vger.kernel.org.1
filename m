Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5802028FD62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgJPEmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:42:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48272 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbgJPEmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:42:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C79B81A0B72;
        Fri, 16 Oct 2020 06:42:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D2691A0B3F;
        Fri, 16 Oct 2020 06:42:31 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E0B7C402A7;
        Fri, 16 Oct 2020 06:42:26 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] usb: gadget: fsl: fix null pointer checking
Date:   Fri, 16 Oct 2020 12:33:26 +0800
Message-Id: <20201016043326.40442-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl_ep_fifo_status() should return error if _ep->desc is null.

Fixes: 75eaa498c99e (“usb: gadget: Correct NULL pointer checking in fsl gadget”)
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index de528e3..ad6ff9c 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1051,7 +1051,7 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	u32 bitmask;
 	struct ep_queue_head *qh;
 
-	if (!_ep || _ep->desc || !(_ep->desc->bEndpointAddress&0xF))
+	if (!_ep || !_ep->desc || !(_ep->desc->bEndpointAddress&0xF))
 		return -ENODEV;
 
 	ep = container_of(_ep, struct fsl_ep, ep);
-- 
2.7.4

