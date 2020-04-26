Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB71B8E78
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDZJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 05:42:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbgDZJmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:42:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7AE7CCED61829DEC30E5;
        Sun, 26 Apr 2020 17:42:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:42:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <chenyu56@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] usb: dwc3: use true,false for dwc->otg_restart_host
Date:   Sun, 26 Apr 2020 17:41:56 +0800
Message-ID: <20200426094156.23558-1-yanaijie@huawei.com>
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

drivers/usb/dwc3/drd.c:85:3-24: WARNING: Assignment of 0/1 to bool
variable
drivers/usb/dwc3/drd.c:59:2-23: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/dwc3/drd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 7db1ffc92bbd..30aac818cd36 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -56,7 +56,7 @@ static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
 	spin_lock(&dwc->lock);
 	if (dwc->otg_restart_host) {
 		dwc3_otg_host_init(dwc);
-		dwc->otg_restart_host = 0;
+		dwc->otg_restart_host = false;
 	}
 
 	spin_unlock(&dwc->lock);
@@ -82,7 +82,7 @@ static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST &&
 		    !(reg & DWC3_OEVT_DEVICEMODE))
-			dwc->otg_restart_host = 1;
+			dwc->otg_restart_host = true;
 		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
 		ret = IRQ_WAKE_THREAD;
 	}
-- 
2.21.1

