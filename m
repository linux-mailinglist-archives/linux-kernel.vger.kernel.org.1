Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B312D725F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437234AbgLKI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:56:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9165 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437223AbgLKI4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:56:16 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csl3R56m3z15bKK;
        Fri, 11 Dec 2020 16:54:59 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:55:24 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] usb: typec: tcpm: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:55:53 +0800
Message-ID: <20201211085553.2982-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a6fae1f86505..4451507d600c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5024,14 +5024,14 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
 		 port_dev_name);
 	port->psy_desc.name = psy_name;
-	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	port->psy_desc.usb_types = tcpm_psy_usb_types;
 	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
-	port->psy_desc.properties = tcpm_psy_props,
-	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
-	port->psy_desc.get_property = tcpm_psy_get_prop,
-	port->psy_desc.set_property = tcpm_psy_set_prop,
-	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+	port->psy_desc.properties = tcpm_psy_props;
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
+	port->psy_desc.get_property = tcpm_psy_get_prop;
+	port->psy_desc.set_property = tcpm_psy_set_prop;
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable;
 
 	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
 
-- 
2.22.0

