Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C123E1C8796
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEGLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:08:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGLIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:08:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5849DF3990535C0D14EE;
        Thu,  7 May 2020 19:08:11 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:08:01 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <hadess@hadess.net>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] USB: Remove dead code in usb_choose_configuration()
Date:   Thu, 7 May 2020 19:07:23 +0800
Message-ID: <20200507110723.37669-1-yanaijie@huawei.com>
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

This code is dead for more than 10 years. Remove it.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/core/generic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 4626227a6dd2..1c93192fc136 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -93,12 +93,6 @@ int usb_choose_configuration(struct usb_device *udev)
 		 * be reinstated when device firmwares become more reliable.
 		 * Don't hold your breath.
 		 */
-#if 0
-		/* Rule out self-powered configs for a bus-powered device */
-		if (bus_powered && (c->desc.bmAttributes &
-					USB_CONFIG_ATT_SELFPOWER))
-			continue;
-#endif
 
 		/*
 		 * The next test may not be as effective as it should be.
-- 
2.21.1

