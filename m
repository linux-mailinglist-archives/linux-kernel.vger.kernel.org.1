Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8585326F0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgIRCqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:46:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgIRCqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:46:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2C04DC9A7DFDD0AEF78B;
        Fri, 18 Sep 2020 10:46:06 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 10:45:59 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] USB: bcma: use module_bcma_driver to simplify the code
Date:   Fri, 18 Sep 2020 11:08:30 +0800
Message-ID: <20200918030830.3946254-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_bcma_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/usb/host/bcma-hcd.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index b1b777f33521..337b425dd4b0 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -498,15 +498,4 @@ static struct bcma_driver bcma_hcd_driver = {
 	.suspend	= bcma_hcd_suspend,
 	.resume		= bcma_hcd_resume,
 };
-
-static int __init bcma_hcd_init(void)
-{
-	return bcma_driver_register(&bcma_hcd_driver);
-}
-module_init(bcma_hcd_init);
-
-static void __exit bcma_hcd_exit(void)
-{
-	bcma_driver_unregister(&bcma_hcd_driver);
-}
-module_exit(bcma_hcd_exit);
+module_bcma_driver(bcma_hcd_driver);
-- 
2.25.1

