Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8182BAC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKTPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:04:14 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7430 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgKTPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605884652; x=1637420652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2lTcLRMDa7YDrD2Hrbv3LE+/dsYXTXmJXPfvfFRoUA=;
  b=DQmM0hZK+GKXygmfzut7ygFRR4opPtoUo08T/smhslCNNmJe6A0K259a
   bv20Lf/NBpu4L6Vn1V/IfBK7LcTK4FRiCurt3la2bPFPR/m3YaAxAO7AX
   h4bJw1U+7IL5kq0ETEuBGooAQlz0rgeHiedWA7S8NHNm3NYbL7wgT8Hnt
   1/i5yNVPY0BLloXZR7pesUirdX5Vhypw8CmumOr6llP2csh+bboddSqsz
   MPnI/JCJ9rzprGEmmfevv+CGnHMdUr2v2AewWC3SYWa61cyoHKpY3iPEv
   un26vp1i1ix9gNMWQPnMQaLrtx0BQ/oGOL5V1BFlkQHCm11Q7xbZdtt9b
   w==;
IronPort-SDR: g2WwOiu1vYQtBxyWtRf95IaunBEdxxJDmI6qfDCCrpz+xNoKUh+hgz6Jtsvb/k/JMXyUgPUDiD
 F9W/YSvY0yuZtEWG19mlIA2kg+5tWoMCwYAEoj35HNRGd4SzoBeygM+IbHITtN4a0q1LIxSeGb
 i5INZXz/EAqkWIdReEjXWctkcf45jDqHnSJoUDng7eWNomXPjxMR3MzQMJJnPy+HIaAoYJmuut
 X+m0YaSFwdB8rVIsxvvgfiMZxrKyUtwGJqvgyUrZGfjyGy+2ev2DLq5hjYXxDY7+IY9ILBeJwv
 +Ps=
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="99262571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2020 08:04:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 08:04:11 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 20 Nov 2020 08:04:09 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] phy: Add ethernet serdes configuration option
Date:   Fri, 20 Nov 2020 16:03:57 +0100
Message-ID: <20201120150359.2041940-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120150359.2041940-1-steen.hegelund@microchip.com>
References: <20201120150359.2041940-1-steen.hegelund@microchip.com>
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
index 000000000000..e261aa29951c
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
+#include <linux/phy.h>
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

