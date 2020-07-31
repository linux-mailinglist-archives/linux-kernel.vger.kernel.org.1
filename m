Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4123403A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgGaHla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 03:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbgGaHla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:41:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9E92067D;
        Fri, 31 Jul 2020 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596181290;
        bh=CG+f7G/BMk8PqwRiuW/mxJ+QjaxfXivzTQiS/AG/5rU=;
        h=From:To:Subject:Date:From;
        b=evf8FUspZwRBhjtByWSNvNGR74Q9fWsMQMytYVGV1XWa6PLASa2cjINjRDUBsMJDx
         JheDYRBCLhoFSn2LoJdW9KYScilUh81c87af0OUA2KFEf5N7TIll+nppNTa6WM+FRf
         j++RJ3ddE56RwT1BLff817G+gwB7G2cKRSTLwAZk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: s3c: Remove unused 'udc' variable
Date:   Fri, 31 Jul 2020 09:41:22 +0200
Message-Id: <20200731074122.6484-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'udc' variable to fix compile warnings:

    drivers/usb/gadget/udc/s3c2410_udc.c: In function 's3c2410_udc_dequeue':
    drivers/usb/gadget/udc/s3c2410_udc.c:1268:22: warning: variable 'udc' set but not used [-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index bc2e8eb737c3..e875a0b967c0 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1270,7 +1270,6 @@ static int s3c2410_udc_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct s3c2410_ep	*ep = to_s3c2410_ep(_ep);
-	struct s3c2410_udc	*udc;
 	int			retval = -EINVAL;
 	unsigned long		flags;
 	struct s3c2410_request	*req = NULL;
@@ -1283,8 +1282,6 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!_ep || !_req)
 		return retval;
 
-	udc = to_s3c2410_udc(ep->gadget);
-
 	local_irq_save(flags);
 
 	list_for_each_entry(req, &ep->queue, queue) {
-- 
2.17.1

