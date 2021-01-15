Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004A52F7DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbhAOOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbhAOOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:14:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98172C061757;
        Fri, 15 Jan 2021 06:13:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so603114plh.3;
        Fri, 15 Jan 2021 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CbZNeMTYUi7Mg7VyMn/xUQXZnoLVOk+YmqoECElgO5I=;
        b=QUTm2d97niOvJWqofhkNL9W7lxALHkiFYLbsnmHT0j6+l2dfDaVQyUZVkUTC1l0mdl
         EICM5zti7BnGQNrwu4DiXRWqFvaBLTaXJp/19o0TYCNYaDP2Snwoj15htcJAHpvMwipe
         NSqam4a9wE5z+mxPyB7GAYPZNLg+w0K4Eal2jElAfNitB8PrVW0VEIN2iAm2FetBHQLN
         W3WhorgQ03TvG6kvqY2qIEI3tH8uYI2+a2xEGi3Jw3GKnrmGg4lsIyr4GXpqFdlkTxQe
         lncTy92kOlFjxnnKl0b7d31JCFUFAgEfJgjr5DMfVuhvkOEkoO5xcdJIOahzNQUrx8b2
         EApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CbZNeMTYUi7Mg7VyMn/xUQXZnoLVOk+YmqoECElgO5I=;
        b=XwFawtYvV5QlbxxTMkHlvzkkKzA2h3kooPLAIsskyGnezCwpCT5SXET05bUoKE6gad
         DHxZpztMx7N4RomIvQ+xsiXqqTyzAOjKvG/A8JMNs0WRI6xVolucu3zWIt9dpI6Be8qO
         C8wlbtpKhd01UOVLq0kUPpJKn+E9ncSrYSgRnJ+RSA12ThWUe14mtHBntuKX9ewBjWWE
         zmLl9bffBjsFli0HIO1TklZGjWyQpV0SmBH17eniGWlsLt651P/4aI62b6V7RNYDL5E8
         h16NBK4eW4heYutMDT2IAEFevIanm6yt2qZ0dT4M2oKUaaYmWzbDx5ahUWZJWIRlsWBK
         0yEw==
X-Gm-Message-State: AOAM532SCis/6kwWrrSqch+JFg20x6O+LOwke/wrjdqZSjLDWfdcpw3a
        pGRQIZ5qQ1riqQuIBZh2VdGMO1XLNms=
X-Google-Smtp-Source: ABdhPJyGv8T8Tw0nXwlkPBk1os5KvQGNW2rZCV/3HHX43JkUZJkmNwkV4CuqIo7ieQn+gWYnNXksow==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr10781383pjr.197.1610720015990;
        Fri, 15 Jan 2021 06:13:35 -0800 (PST)
Received: from localhost.localdomain (1-171-15-80.dynamic-ip.hinet.net. [1.171.15.80])
        by smtp.gmail.com with ESMTPSA id h5sm8898408pgl.86.2021.01.15.06.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:13:34 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and external vbus supply control
Date:   Fri, 15 Jan 2021 22:13:20 +0800
Message-Id: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

MT6360 not support for TCPC command to control source and sink.
Uses external 5V vbus regulator as the vbus source control.

Also adds the capability to report vsafe0v.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index f1bd9e0..0edf4b6 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/tcpm.h>
 
 #include "tcpci.h"
@@ -36,6 +37,7 @@ struct mt6360_tcpc_info {
 	struct tcpci_data tdata;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct regulator *vbus;
 	int irq;
 };
 
@@ -51,6 +53,27 @@ static inline int mt6360_tcpc_write16(struct regmap *regmap,
 	return regmap_raw_write(regmap, reg, &val, sizeof(u16));
 }
 
+static int mt6360_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_data *data, bool src, bool snk)
+{
+	struct mt6360_tcpc_info *mti = container_of(data, struct mt6360_tcpc_info, tdata);
+	int ret;
+
+	/* To correctly handle the already enabled vbus and disable its supply first */
+	if (regulator_is_enabled(mti->vbus)) {
+		ret = regulator_disable(mti->vbus);
+		if (ret)
+			return ret;
+	}
+
+	if (src) {
+		ret = regulator_enable(mti->vbus);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
 	struct regmap *regmap = tdata->regmap;
@@ -138,7 +161,13 @@ static int mt6360_tcpc_probe(struct platform_device *pdev)
 	if (mti->irq < 0)
 		return mti->irq;
 
+	mti->vbus = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(mti->vbus))
+		return PTR_ERR(mti->vbus);
+
 	mti->tdata.init = mt6360_tcpc_init;
+	mti->tdata.set_vbus = mt6360_tcpc_set_vbus;
+	mti->tdata.vbus_vsafe0v = 1;
 	mti->tcpci = tcpci_register_port(&pdev->dev, &mti->tdata);
 	if (IS_ERR(mti->tcpci)) {
 		dev_err(&pdev->dev, "Failed to register tcpci port\n");
-- 
2.7.4

