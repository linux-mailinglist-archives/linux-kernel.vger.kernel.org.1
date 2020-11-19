Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87A2B94B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgKSOfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:35:42 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24883 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796541; x=1637332541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pu4zHArCx7KCyzZyOyKJXXGhkZDmCrLU7naItIywUJE=;
  b=rOUKSTVyVxuH7G4r/BWb3m4gQB9wlAO2T7urzAD6JBHGb6tkBMpzeSq7
   lBiKQLKAFBOoDopV7uR8+g8CsH1Q3U/tTbejcP1QHS4PmHeVv07/d47zO
   ADaE+rZwtDLH7Y+ZRMIb4qRx9dMyVlwzb9AyPufemCSFHjRW8P0A+oblP
   FBANNEyea+PKRJOq3bO1B/0GbiScE5xrSY+/MEI16wUW2KjfNcIQX3kmX
   CT8rnzn/d2bcKSp8UhQxAFe5XZGx8SiZyFcYSIgd5d9FhtzYVADd2O3Ay
   njNHqWNWhZLz7aGnkVgoJctbDXqPtI/3ca7SFKkW706P0qVXwkCwIx8yq
   A==;
IronPort-SDR: qoOjCb59VjBET8xaiHdUawCLoOxkkpOb11trhiF9oQG/TCXeHxvL4v2K1lOIwvOn66rR6Mk8p/
 cHTi7Bu8cuuWJ7yI6ApyNOY1t2z1Or91G9XOPz3QI7Q600JJv3zmCaoymt0IAfSlb/BblQKFaD
 TBJpLHjXO0Ja3VrX7m4zUPqVI2b6BcEIcKnr+xDvMKnFS6iVBOlDeXvegoLg1t2tz6drI+uCrk
 yFCXJJPTH+NfQgjsKkw2hLb8yNW47UgChe+NrngQalWzUrX72Ll5TKfgDhRd06uj+c+BtKNafS
 N4o=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="99677683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:35:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:35:40 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:35:38 -0700
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
Subject: [PATCH v3 2/4] phy: Add ethernet serdes configuration option
Date:   Thu, 19 Nov 2020 15:35:25 +0100
Message-ID: <20201119143527.1881404-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119143527.1881404-1-steen.hegelund@microchip.com>
References: <20201119143527.1881404-1-steen.hegelund@microchip.com>
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
 include/linux/phy/phy-ethernet-serdes.h | 33 +++++++++++++++++++++++++
 include/linux/phy/phy.h                 |  4 +++
 2 files changed, 37 insertions(+)
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

diff --git a/include/linux/phy/phy-ethernet-serdes.h b/include/linux/phy/phy-ethernet-serdes.h
new file mode 100644
index 000000000000..b800ff22d93f
--- /dev/null
+++ b/include/linux/phy/phy-ethernet-serdes.h
@@ -0,0 +1,33 @@
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
+ * @clk: Specifies the serdes clock in MHz. Default: 0 will provide the highest
+ * supported clock.
+ */
+struct phy_configure_opts_eth_serdes {
+	u32                        speed;
+	enum ethernet_media_type   media_type;
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

