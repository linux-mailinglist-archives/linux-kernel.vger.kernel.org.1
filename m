Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF22C408C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgKYMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:50:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38960 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgKYMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:50:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0APCnfkL051870;
        Wed, 25 Nov 2020 06:49:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606308581;
        bh=zWWGgUMSGxnizl3YzE/a0cEYMXJUAtkjAwP6xo5TOzo=;
        h=From:To:CC:Subject:Date;
        b=bQj5TkBx965qu2zyh61pQ89CY8JmM4fl6lw/UlAZrUulFW5qQiXQy5AyWqYfDESdQ
         W9fesQH+KmNobMc2F4L7U2Ys0Gzwz1gS5dlhLy1SJ9L4GFg3apK2GRItwjntt0/+ai
         HGO0c54gRibwOtgn6sjTj6RlfBLYssTG7x1VQVeQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0APCnfKK083844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 06:49:41 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 25
 Nov 2020 06:49:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 25 Nov 2020 06:49:40 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0APCncb4029736;
        Wed, 25 Nov 2020 06:49:38 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <peter.chen@nxp.com>, <pawell@cadence.com>
CC:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: cdns3: Fix hardware based role switch
Date:   Wed, 25 Nov 2020 14:49:36 +0200
Message-ID: <20201125124936.5929-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware based role switch is broken as the driver always skips it.
Fix this by registering for  SW role switch only if 'usb-role-switch'
property is present in the device tree.

Fixes: 50642709f659 ("usb: cdns3: core: quit if it uses role switch class")
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..170deb3eacf0 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -427,7 +427,6 @@ static irqreturn_t cdns3_wakeup_irq(int irq, void *data)
  */
 static int cdns3_probe(struct platform_device *pdev)
 {
-	struct usb_role_switch_desc sw_desc = { };
 	struct device *dev = &pdev->dev;
 	struct resource	*res;
 	struct cdns3 *cdns;
@@ -529,18 +528,21 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (ret)
 		goto err2;
 
-	sw_desc.set = cdns3_role_set;
-	sw_desc.get = cdns3_role_get;
-	sw_desc.allow_userspace_control = true;
-	sw_desc.driver_data = cdns;
-	if (device_property_read_bool(dev, "usb-role-switch"))
+	if (device_property_read_bool(dev, "usb-role-switch")) {
+		struct usb_role_switch_desc sw_desc = { };
+
+		sw_desc.set = cdns3_role_set;
+		sw_desc.get = cdns3_role_get;
+		sw_desc.allow_userspace_control = true;
+		sw_desc.driver_data = cdns;
 		sw_desc.fwnode = dev->fwnode;
 
-	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
-	if (IS_ERR(cdns->role_sw)) {
-		ret = PTR_ERR(cdns->role_sw);
-		dev_warn(dev, "Unable to register Role Switch\n");
-		goto err3;
+		cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
+		if (IS_ERR(cdns->role_sw)) {
+			ret = PTR_ERR(cdns->role_sw);
+			dev_warn(dev, "Unable to register Role Switch\n");
+			goto err3;
+		}
 	}
 
 	if (cdns->wakeup_irq) {
@@ -582,7 +584,8 @@ static int cdns3_probe(struct platform_device *pdev)
 	return 0;
 err4:
 	cdns3_drd_exit(cdns);
-	usb_role_switch_unregister(cdns->role_sw);
+	if (cdns->role_sw)
+		usb_role_switch_unregister(cdns->role_sw);
 err3:
 	set_phy_power_off(cdns);
 err2:
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

