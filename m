Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E52AD93B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgKJOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:49:26 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9035 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgKJOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605019764; x=1636555764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ivjp1CbhHVITQi4NNYH/jJR1dyjRN3xPeVEdZV+zf8s=;
  b=BUVwFjR1BYXuoWqKcYUzUYBIrX8JgUY1wFJCtslQty6fYBU5hGqumGy4
   yUXAem0cSXXKzhfz3d13FxU3QP7g3QNZygiqxVq4ROEQXziv4DaMIXI8P
   8SDozmhSeqx7Ff3wyMyU+lQoJpRbter31XzIKw7uWsZqOiRymkWdQi8PN
   xLbkEMzVCNwO85TAVwDbXbfdQiDNdZlXub4sPK47IEk1eV3Vp4D5tTlrB
   CRhLVEywWz9NL/cGNi1z/ZWESEK2cuZd9yyFJ6QO+vvXnUg2Yc71SSPd2
   0ps9Bvqaf/8NyqY86yyo5yRBQr8w7CU2BlZFkR0jVBCbPq5HrHl2ZfP3o
   Q==;
IronPort-SDR: 2bvF2ltYIGQsaLHdWoDUzL0h/SKX05+x8v5p6Rokvz/mzvwdDzGIlz2jxLRza4pReNNLpkTRia
 OtwQ3WChxJkl7ifV38nIrnmdrDJydnaB1Fq9GjdCBL8GhirBehNIuUummn16gj5mQqlNvOdCZo
 HSHv9UvqbB6gwt5+WKY8xxSQOHYnw90p9Ly9rvztHXQgnLSBk9tpA/eq2z5t2PoALVK4iMIW9i
 5gtYGhl9iVxABCSzqaNFdKvFhaUEfXqOja2QkV2XUxGRhpb/9gWavM+enSb8E6jWz79oGqmU6n
 QJs=
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="98454903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2020 07:49:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 07:49:23 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 10 Nov 2020 07:49:21 -0700
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
Subject: [PATCH v2 2/4] phy: Add ethernet serdes configuration option
Date:   Tue, 10 Nov 2020 15:49:08 +0100
Message-ID: <20201110144910.558164-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110144910.558164-1-steen.hegelund@microchip.com>
References: <20201110144910.558164-1-steen.hegelund@microchip.com>
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
 include/linux/phy/phy-ethernet-serdes.h | 49 +++++++++++++++++++++++++
 include/linux/phy/phy.h                 |  4 ++
 2 files changed, 53 insertions(+)
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

diff --git a/include/linux/phy/phy-ethernet-serdes.h b/include/linux/phy/phy-ethernet-serdes.h
new file mode 100644
index 000000000000..04f496855b00
--- /dev/null
+++ b/include/linux/phy/phy-ethernet-serdes.h
@@ -0,0 +1,49 @@
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
+ * struct phy_configure_opts_eth_serdes - Ethernet SerDes
+ *
+ * This structure is used to represent the configuration state of a
+ * Ethernet Serdes PHY.
+ */
+struct phy_configure_opts_eth_serdes {
+	/**
+	 * @speed
+	 *
+	 * Speed of the serdes interface in Mbps
+	 */
+	u32                        speed;
+
+	/**
+	 * @media_type
+	 *
+	 * Specifies which media the serdes will be using
+	 */
+	enum ethernet_media_type   media_type;
+
+	/**
+	 * @clk
+	 *
+	 * Specifies the serdes clock in MHz
+	 * Default: 0 will provide the highest supported clock.
+	 */
+	u32                        clk;
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

