Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF72BAC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgKTPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:04:13 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52704 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgKTPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605884650; x=1637420650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MTG9rLE45dKyigkrf9bp8Y8yuOya/pIlVclPBkXj0os=;
  b=SzIH5m13fhKrGdFaAKtwobGwIO78rNE8Qs+yHobQqm1v7XOzoJeoplsT
   IH8yi7wJhIjCpZNvtaPeQ22pJqO/YatPHj3RdPNusp2bBsZVHh0iWIlx+
   hpzTLQcvN99ay7KjLXq7We5iTUc0qtZMggFq89aKYUoS1emO7/uYvPMK8
   R3ZzZvZAELIAfTNhO9AsHjMM5ovB6R4kSol6nztKaHCCkGwHv78TodjQt
   tND5aRcQ8eZaWXbaCzrQfLv9Ap0JtWTr3LvarYD6+Xu31KmtIscUJnD3e
   w0yS29/51ZmuqMKpNw2yGsUu/3iUeBMMckKmMjZbuD7tNwIX3ZGadtjR/
   A==;
IronPort-SDR: WSZ8WoUnToRJDcRg21DfrmZ9m8zl/eYaZYggmRADHwilLjCq8qXbVhaA/bASc34aIPGpKEh9k+
 031giYcUWRpJuevWaPK3cncRJdPnnr9gGQc+8T8u2h5ljuaKAlVl/Ap5iT4ckzgUHdRVN+YwM5
 zfyX5E82HWwukcp7QkUemcC2PwrsM87OWXV5Ibs3zDEN4vgWd8xJCfC38Jc6xF/YzxXQBx5GBH
 BjfmI0ZYYqZxloUsje07L+/IcsuapFj6HdlLNT9damis5QtHK1jHkjQTLCi0fSpzW0SpOBUhi0
 ns0=
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="97073352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2020 08:04:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 08:04:09 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 20 Nov 2020 08:04:07 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Device Tree List <devicetree@vger.kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: phy: Add sparx5-serdes bindings
Date:   Fri, 20 Nov 2020 16:03:56 +0100
Message-ID: <20201120150359.2041940-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120150359.2041940-1-steen.hegelund@microchip.com>
References: <20201120150359.2041940-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Sparx5 ethernet serdes phy driver bindings.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 .../bindings/phy/microchip,sparx5-serdes.yaml | 296 ++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
new file mode 100644
index 000000000000..0bfb752e7686
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
@@ -0,0 +1,296 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/microchip,sparx5-serdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 Serdes controller
+
+maintainers:
+  - Steen Hegelund <steen.hegelund@microchip.com>
+
+description: |
+  The Sparx5 SERDES interfaces share the same basic functionality, but
+  support different operating modes and line rates.
+
+  The following list lists the SERDES features:
+
+  * RX Adaptive Decision Feedback Equalizer (DFE)
+  * Programmable continuous time linear equalizer (CTLE)
+  * Rx variable gain control
+  * Rx built-in fault detector (loss-of-lock/loss-of-signal)
+  * Adjustable tx de-emphasis (FFE)
+  * Tx output amplitude control
+  * Supports rx eye monitor
+  * Multiple loopback modes
+  * Prbs generator and checker
+  * Polarity inversion control
+
+  SERDES6G:
+
+  The SERDES6G is a high-speed SERDES interface, which can operate at
+  the following data rates:
+
+  * 100 Mbps (100BASE-FX)
+  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
+  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
+  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
+
+  SERDES10G
+
+  The SERDES10G is a high-speed SERDES interface, which can operate at
+  the following data rates:
+
+  * 100 Mbps (100BASE-FX)
+  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
+  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
+  * 5 Gbps (QSGMII/USGMII)
+  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
+  * 10 Gbps (10G-USGMII)
+  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
+
+  SERDES25G
+
+  The SERDES25G is a high-speed SERDES interface, which can operate at
+  the following data rates:
+
+  * 1.25 Gbps (SGMII/1000BASE-X/1000BASE-KX)
+  * 3.125 Gbps (2.5GBASE-X/2.5GBASE-KX)
+  * 5 Gbps (QSGMII/USGMII)
+  * 5.15625 Gbps (5GBASE-KR/5G-USXGMII)
+  * 10 Gbps (10G-USGMII)
+  * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
+  * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
+
+properties:
+  $nodename:
+    pattern: "^serdes@[0-9a-f]+$"
+
+  compatible:
+    const: microchip,sparx5-serdes.yaml
+
+  reg:
+    description: Address and length of the register set for the device
+
+  reg-names:
+    description: |
+      Names for each of the address spaces defined in
+      the 'reg' property. Expects the names in the same order as the
+      corresponding memory region in the that property.
+
+  '#phy-cells':
+    const: 1
+    description: |
+      - The main serdes input port
+
+  clocks:
+    description:
+      A list containing the phandle to the core clock of the Sparx5 device.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#phy-cells'
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    serdes: serdes@10808000 {
+      compatible = "microchip,sparx5-serdes";
+      #phy-cells = <1>;
+      clocks = <&sys_clk>;
+      reg = <0x10808000 0x8000>, /* sd_cmu_0 */
+        <0x10810000 0x8000>, /* sd_cmu_1 */
+        <0x10818000 0x8000>, /* sd_cmu_2 */
+        <0x10820000 0x8000>, /* sd_cmu_3 */
+        <0x10828000 0x8000>, /* sd_cmu_4 */
+        <0x10830000 0x8000>, /* sd_cmu_5 */
+        <0x10838000 0x8000>, /* sd_cmu_6 */
+        <0x10840000 0x8000>, /* sd_cmu_7 */
+        <0x10848000 0x8000>, /* sd_cmu_8 */
+        <0x10850000 0x8000>, /* sd_cmu_cfg_0 */
+        <0x10858000 0x8000>, /* sd_cmu_cfg_1 */
+        <0x10860000 0x8000>, /* sd_cmu_cfg_2 */
+        <0x10868000 0x8000>, /* sd_cmu_cfg_3 */
+        <0x10870000 0x8000>, /* sd_cmu_cfg_4 */
+        <0x10878000 0x8000>, /* sd_cmu_cfg_5 */
+        <0x10880000 0x8000>, /* sd_cmu_cfg_6 */
+        <0x10888000 0x8000>, /* sd_cmu_cfg_7 */
+        <0x10890000 0x8000>, /* sd_cmu_cfg_8 */
+        <0x10898000 0x8000>, /* sd6g_lane_0 */
+        <0x108a0000 0x8000>, /* sd6g_lane_1 */
+        <0x108a8000 0x8000>, /* sd6g_lane_2 */
+        <0x108b0000 0x8000>, /* sd6g_lane_3 */
+        <0x108b8000 0x8000>, /* sd6g_lane_4 */
+        <0x108c0000 0x8000>, /* sd6g_lane_5 */
+        <0x108c8000 0x8000>, /* sd6g_lane_6 */
+        <0x108d0000 0x8000>, /* sd6g_lane_7 */
+        <0x108d8000 0x8000>, /* sd6g_lane_8 */
+        <0x108e0000 0x8000>, /* sd6g_lane_9 */
+        <0x108e8000 0x8000>, /* sd6g_lane_10 */
+        <0x108f0000 0x8000>, /* sd6g_lane_11 */
+        <0x108f8000 0x8000>, /* sd6g_lane_12 */
+        <0x10900000 0x8000>, /* sd10g_lane_0 */
+        <0x10908000 0x8000>, /* sd10g_lane_1 */
+        <0x10910000 0x8000>, /* sd10g_lane_2 */
+        <0x10918000 0x8000>, /* sd10g_lane_3 */
+        <0x109a8000 0x8000>, /* sd_lane_0 */
+        <0x109b0000 0x8000>, /* sd_lane_1 */
+        <0x109b8000 0x8000>, /* sd_lane_2 */
+        <0x109c0000 0x8000>, /* sd_lane_3 */
+        <0x109c8000 0x8000>, /* sd_lane_4 */
+        <0x109d0000 0x8000>, /* sd_lane_5 */
+        <0x109d8000 0x8000>, /* sd_lane_6 */
+        <0x109e0000 0x8000>, /* sd_lane_7 */
+        <0x109e8000 0x8000>, /* sd_lane_8 */
+        <0x109f0000 0x8000>, /* sd_lane_9 */
+        <0x109f8000 0x8000>, /* sd_lane_10 */
+        <0x10a00000 0x8000>, /* sd_lane_11 */
+        <0x10a08000 0x8000>, /* sd_lane_12 */
+        <0x10a10000 0x8000>, /* sd_lane_13 */
+        <0x10a18000 0x8000>, /* sd_lane_14 */
+        <0x10a20000 0x8000>, /* sd_lane_15 */
+        <0x10a28000 0x8000>, /* sd_lane_16 */
+        <0x10c08000 0x8000>, /* sd_cmu_9 */
+        <0x10c10000 0x8000>, /* sd_cmu_10 */
+        <0x10c18000 0x8000>, /* sd_cmu_11 */
+        <0x10c20000 0x8000>, /* sd_cmu_12 */
+        <0x10c28000 0x8000>, /* sd_cmu_13 */
+        <0x10c30000 0x8000>, /* sd_cmu_cfg_9 */
+        <0x10c38000 0x8000>, /* sd_cmu_cfg_10 */
+        <0x10c40000 0x8000>, /* sd_cmu_cfg_11 */
+        <0x10c48000 0x8000>, /* sd_cmu_cfg_12 */
+        <0x10c50000 0x8000>, /* sd_cmu_cfg_13 */
+        <0x10c58000 0x8000>, /* sd10g_lane_4 */
+        <0x10c60000 0x8000>, /* sd10g_lane_5 */
+        <0x10c68000 0x8000>, /* sd10g_lane_6 */
+        <0x10c70000 0x8000>, /* sd10g_lane_7 */
+        <0x10c78000 0x8000>, /* sd10g_lane_8 */
+        <0x10c80000 0x8000>, /* sd10g_lane_9 */
+        <0x10c88000 0x8000>, /* sd10g_lane_10 */
+        <0x10c90000 0x8000>, /* sd10g_lane_11 */
+        <0x10c98000 0x8000>, /* sd25g_lane_0 */
+        <0x10ca0000 0x8000>, /* sd25g_lane_1 */
+        <0x10ca8000 0x8000>, /* sd25g_lane_2 */
+        <0x10cb0000 0x8000>, /* sd25g_lane_3 */
+        <0x10cb8000 0x8000>, /* sd25g_lane_4 */
+        <0x10cc0000 0x8000>, /* sd25g_lane_5 */
+        <0x10cc8000 0x8000>, /* sd25g_lane_6 */
+        <0x10cd0000 0x8000>, /* sd25g_lane_7 */
+        <0x10d58000 0x8000>, /* sd_lane_17 */
+        <0x10d60000 0x8000>, /* sd_lane_18 */
+        <0x10d68000 0x8000>, /* sd_lane_19 */
+        <0x10d70000 0x8000>, /* sd_lane_20 */
+        <0x10d78000 0x8000>, /* sd_lane_21 */
+        <0x10d80000 0x8000>, /* sd_lane_22 */
+        <0x10d88000 0x8000>, /* sd_lane_23 */
+        <0x10d90000 0x8000>, /* sd_lane_24 */
+        <0x10d98000 0x8000>, /* sd_lane_25g_25 */
+        <0x10da0000 0x8000>, /* sd_lane_25g_26 */
+        <0x10da8000 0x8000>, /* sd_lane_25g_27 */
+        <0x10db0000 0x8000>, /* sd_lane_25g_28 */
+        <0x10db8000 0x8000>, /* sd_lane_25g_29 */
+        <0x10dc0000 0x8000>, /* sd_lane_25g_30 */
+        <0x10dc8000 0x8000>, /* sd_lane_25g_31 */
+        <0x10dd0000 0x8000>; /* sd_lane_25g_32 */
+      reg-names =
+        "sd_cmu_0",
+        "sd_cmu_1",
+        "sd_cmu_2",
+        "sd_cmu_3",
+        "sd_cmu_4",
+        "sd_cmu_5",
+        "sd_cmu_6",
+        "sd_cmu_7",
+        "sd_cmu_8",
+        "sd_cmu_cfg_0",
+        "sd_cmu_cfg_1",
+        "sd_cmu_cfg_2",
+        "sd_cmu_cfg_3",
+        "sd_cmu_cfg_4",
+        "sd_cmu_cfg_5",
+        "sd_cmu_cfg_6",
+        "sd_cmu_cfg_7",
+        "sd_cmu_cfg_8",
+        "sd6g_lane_0",
+        "sd6g_lane_1",
+        "sd6g_lane_2",
+        "sd6g_lane_3",
+        "sd6g_lane_4",
+        "sd6g_lane_5",
+        "sd6g_lane_6",
+        "sd6g_lane_7",
+        "sd6g_lane_8",
+        "sd6g_lane_9",
+        "sd6g_lane_10",
+        "sd6g_lane_11",
+        "sd6g_lane_12",
+        "sd10g_lane_0",
+        "sd10g_lane_1",
+        "sd10g_lane_2",
+        "sd10g_lane_3",
+        "sd_lane_0",
+        "sd_lane_1",
+        "sd_lane_2",
+        "sd_lane_3",
+        "sd_lane_4",
+        "sd_lane_5",
+        "sd_lane_6",
+        "sd_lane_7",
+        "sd_lane_8",
+        "sd_lane_9",
+        "sd_lane_10",
+        "sd_lane_11",
+        "sd_lane_12",
+        "sd_lane_13",
+        "sd_lane_14",
+        "sd_lane_15",
+        "sd_lane_16",
+        "sd_cmu_9",
+        "sd_cmu_10",
+        "sd_cmu_11",
+        "sd_cmu_12",
+        "sd_cmu_13",
+        "sd_cmu_cfg_9",
+        "sd_cmu_cfg_10",
+        "sd_cmu_cfg_11",
+        "sd_cmu_cfg_12",
+        "sd_cmu_cfg_13",
+        "sd10g_lane_4",
+        "sd10g_lane_5",
+        "sd10g_lane_6",
+        "sd10g_lane_7",
+        "sd10g_lane_8",
+        "sd10g_lane_9",
+        "sd10g_lane_10",
+        "sd10g_lane_11",
+        "sd25g_lane_0",
+        "sd25g_lane_1",
+        "sd25g_lane_2",
+        "sd25g_lane_3",
+        "sd25g_lane_4",
+        "sd25g_lane_5",
+        "sd25g_lane_6",
+        "sd25g_lane_7",
+        "sd_lane_17",
+        "sd_lane_18",
+        "sd_lane_19",
+        "sd_lane_20",
+        "sd_lane_21",
+        "sd_lane_22",
+        "sd_lane_23",
+        "sd_lane_24",
+        "sd_lane_25g_25",
+        "sd_lane_25g_26",
+        "sd_lane_25g_27",
+        "sd_lane_25g_28",
+        "sd_lane_25g_29",
+        "sd_lane_25g_30",
+        "sd_lane_25g_31",
+        "sd_lane_25g_32";
+    };
+
+...
-- 
2.29.2

