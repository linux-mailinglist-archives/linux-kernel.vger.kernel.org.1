Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460922D725E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437221AbgLKI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:56:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9871 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437204AbgLKIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:55:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Csl2f2XsZz7CWl;
        Fri, 11 Dec 2020 16:54:18 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:54:43 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] usb: ucsi: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:55:10 +0800
Message-ID: <20201211085510.2928-1-zhengyongjun3@huawei.com>
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
 drivers/usb/typec/ucsi/psy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 571a51e16234..56bf56517f75 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -220,11 +220,11 @@ int ucsi_register_port_psy(struct ucsi_connector *con)
 		return -ENOMEM;
 
 	con->psy_desc.name = psy_name;
-	con->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	con->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	con->psy_desc.usb_types = ucsi_psy_usb_types;
 	con->psy_desc.num_usb_types = ARRAY_SIZE(ucsi_psy_usb_types);
-	con->psy_desc.properties = ucsi_psy_props,
-	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props),
+	con->psy_desc.properties = ucsi_psy_props;
+	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
 	con->psy_desc.get_property = ucsi_psy_get_prop;
 
 	con->psy = power_supply_register(dev, &con->psy_desc, &psy_cfg);
-- 
2.22.0

