Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A582CBDBD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgLBNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:05:59 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:37233 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgLBNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606914358; x=1638450358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zj8OkiqVP0y2v8pLf60YgrsvbAJ9ccfq8Fe3AUJvYA=;
  b=eyRCU2exM3dFp/LS/AoFr3CKq3AzCIkd3lRMtwNP5rv5fL1b8/vesQ2Q
   M+t7WgzbX0zI9UjShM4Trglm7Mhcdpi/qhu6A3OkVwr1rFHvmt+sieauB
   I1n5ylP+luxUj03yS0YOCVtgMB3LNoJQPHgBD3rnhSGzkWDjq2nypv9RO
   RgJlYXU7EOH8r2TiwgFJGs2oFIdzjiVzyAcW1aOFUJS1m5jbdohEI5sdz
   yv2eG2pk/Eubf0freTrOL2uhW3iJkiWWmEuThINWfR9RaD2DZHbR0zNP7
   Xk+SvwXBf+eIwy1Eaeaan1Jrh27aM2ziyfr6jRMJEdj0YLotN7ZBacpe7
   g==;
IronPort-SDR: d7zYue1ONbwHmpYXCcfPjq7P7hYvGEQQ0W9X8cS6o2xDJRE4wvS7eaaN8sTUHHZS38UZxMYkU2
 OsMTPPqD8iQzM3RU/J2cC99yJphqWPtiPCcQmi9Jo6dawzKFC4ubmd/EAbscyX76glSw40vwNN
 H2Z6XEUFbxRvZ16dNRTOCjdN0PX80Ssqe59ngYAWNM0oukN+nYRv6vvnw/Wz3G/UaonPMqjSbY
 tdei/XpkTzX5/2HdWJeSiv8ZxmPJuS8PmMC95oOeia6XKWQfqNMUXY9VgyN6F7trCUttAGDwPB
 qN4=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101125102"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 06:04:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 06:04:50 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 06:04:48 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] phy: Add ethernet serdes configuration option
Date:   Wed, 2 Dec 2020 14:04:36 +0100
Message-ID: <20201202130438.3330228-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202130438.3330228-1-steen.hegelund@microchip.com>
References: <20201202130438.3330228-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a new ethernet phy configuration structure, that
allow PHYs used for ethernet to be configured with
speed, media type and clock information.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 include/linux/phy/phy-ethernet-serdes.h | 30 +++++++++++++++++++++++++
 include/linux/phy/phy.h                 |  4 ++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

diff --git a/include/linux/phy/phy-ethernet-serdes.h b/include/linux/phy/phy-ethernet-serdes.h
new file mode 100644
index 000000000000..d2462fadf179
--- /dev/null
+++ b/include/linux/phy/phy-ethernet-serdes.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microchip Sparx5 Ethernet SerDes driver
+ *
+ * Copyright (c) 2020 Microschip Inc
+ */
+#ifndef __PHY_ETHERNET_SERDES_H_
+#define __PHY_ETHERNET_SERDES_H_
+
+#include <linux/types.h>
+
+enum ethernet_media_type {
+	ETH_MEDIA_DEFAULT,
+	ETH_MEDIA_SR,
+	ETH_MEDIA_DAC,
+};
+
+/**
+ * struct phy_configure_opts_eth_serdes - Ethernet SerDes This structure is used
+ * to represent the configuration state of a Ethernet Serdes PHY.
+ * @speed: Speed of the serdes interface in Mbps
+ * @media_type: Specifies which media the serdes will be using
+ */
+struct phy_configure_opts_eth_serdes {
+	u32                        speed;
+	enum ethernet_media_type   media_type;
+};
+
+#endif
+
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e435bdb0bab3..78ecb375cede 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -18,6 +18,7 @@
 
 #include <linux/phy/phy-dp.h>
 #include <linux/phy/phy-mipi-dphy.h>
+#include <linux/phy/phy-ethernet-serdes.h>
 
 struct phy;
 
@@ -49,11 +50,14 @@ enum phy_mode {
  *
  * @mipi_dphy:	Configuration set applicable for phys supporting
  *		the MIPI_DPHY phy mode.
+ * @eth_serdes: Configuration set applicable for phys supporting
+ *		the ethernet serdes.
  * @dp:		Configuration set applicable for phys supporting
  *		the DisplayPort protocol.
  */
 union phy_configure_opts {
 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
+	struct phy_configure_opts_eth_serdes	eth_serdes;
 	struct phy_configure_opts_dp		dp;
 };
 
-- 
2.29.2

