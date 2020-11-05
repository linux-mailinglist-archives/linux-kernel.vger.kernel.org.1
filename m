Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F542A8131
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgKEOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:44:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:29940 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgKEOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604587494; x=1636123494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=081Qz63Ju51wMnMZWgJ4IpVkl7T2NNioRjW6zh34pI8=;
  b=F/9cJkI+4ST2fbxNCEkPTT5Skde1V+Lmw4YCi6Zi3HleETHrSB9UoZEe
   yaLBEubGt0QVVaIvbNcaXAqHzOTllrENl9Qlxpvh9P7Ts6j6pUm0/HbYu
   rPkOxOH7cbTgGHsvFW6HZfYxLPhfV7pQm/2S9nbQ7I2eCyAIBG8ntJhp8
   IDaUBJirqqp+xUK58y3a1Z0macATCVb0XNUgnCquG4Ra+liIuXc7UAQb7
   JcDrFNHtSAdMUo+QMV7i6cbPYDWzEIUgexPUlgObWD62AXKLqN7P5QmzV
   2/PUJC/+BUbvlJ1NhgP7v/tGInI+MaTFnkT4uFJvh90AQ6/9tbQorhQXE
   A==;
IronPort-SDR: SIYS0i5e83sILUAWvkJgS8giuR86n5t7wiosDF44Rdb6n+fjAXKtQKbVAYDqs9dY8NYpDcv76V
 asszTafcD3yKcmFn3IqQLQ2TJi/E++S1Q/ieyOV75fBEO5o0uM/QlTVWEXwoeWqqbN7BMijNsI
 fYwJFUczO8l2SCtiFYQ/wcPWJjM4YSqjyExjrFYXnZL2ploMyF1r9RLiQ1AfloXzuswlOV6FXM
 4bjHdJdgrBiSzhSFPYJO1BFbPeFRE74JC9FAxW5s2p+PuLuPVFR41CN2EOSPyr8tg/nQJCrZIg
 5xw=
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="97880093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2020 07:44:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 07:44:54 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 5 Nov 2020 07:44:51 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/4] arm64: dts: sparx5: Add Sparx5 serdes driver node
Date:   Thu, 5 Nov 2020 15:44:29 +0100
Message-ID: <20201105144429.2438358-5-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201105144429.2438358-1-steen.hegelund@microchip.com>
References: <20201105144429.2438358-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sparx5 serdes driver node, and enable it generally for all
reference boards.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 195 ++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 8e7724d413fb..af927e0002ff 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -287,5 +287,200 @@ tmon0: tmon@610508110 {
 			#thermal-sensor-cells = <0>;
 			clocks = <&ahb_clk>;
 		};
+
+		serdes: serdes@10808000 {
+			compatible = "microchip,sparx5-serdes";
+			#phy-cells = <1>;
+			reg =	<0x6 0x10808000 0x8000>, /* sd_cmu_0 */
+				<0x6 0x10810000 0x8000>, /* sd_cmu_1 */
+				<0x6 0x10818000 0x8000>, /* sd_cmu_2 */
+				<0x6 0x10820000 0x8000>, /* sd_cmu_3 */
+				<0x6 0x10828000 0x8000>, /* sd_cmu_4 */
+				<0x6 0x10830000 0x8000>, /* sd_cmu_5 */
+				<0x6 0x10838000 0x8000>, /* sd_cmu_6 */
+				<0x6 0x10840000 0x8000>, /* sd_cmu_7 */
+				<0x6 0x10848000 0x8000>, /* sd_cmu_8 */
+				<0x6 0x10850000 0x8000>, /* sd_cmu_cfg_0 */
+				<0x6 0x10858000 0x8000>, /* sd_cmu_cfg_1 */
+				<0x6 0x10860000 0x8000>, /* sd_cmu_cfg_2 */
+				<0x6 0x10868000 0x8000>, /* sd_cmu_cfg_3 */
+				<0x6 0x10870000 0x8000>, /* sd_cmu_cfg_4 */
+				<0x6 0x10878000 0x8000>, /* sd_cmu_cfg_5 */
+				<0x6 0x10880000 0x8000>, /* sd_cmu_cfg_6 */
+				<0x6 0x10888000 0x8000>, /* sd_cmu_cfg_7 */
+				<0x6 0x10890000 0x8000>, /* sd_cmu_cfg_8 */
+				<0x6 0x10898000 0x8000>, /* sd6g_lane_0 */
+				<0x6 0x108a0000 0x8000>, /* sd6g_lane_1 */
+				<0x6 0x108a8000 0x8000>, /* sd6g_lane_2 */
+				<0x6 0x108b0000 0x8000>, /* sd6g_lane_3 */
+				<0x6 0x108b8000 0x8000>, /* sd6g_lane_4 */
+				<0x6 0x108c0000 0x8000>, /* sd6g_lane_5 */
+				<0x6 0x108c8000 0x8000>, /* sd6g_lane_6 */
+				<0x6 0x108d0000 0x8000>, /* sd6g_lane_7 */
+				<0x6 0x108d8000 0x8000>, /* sd6g_lane_8 */
+				<0x6 0x108e0000 0x8000>, /* sd6g_lane_9 */
+				<0x6 0x108e8000 0x8000>, /* sd6g_lane_10 */
+				<0x6 0x108f0000 0x8000>, /* sd6g_lane_11 */
+				<0x6 0x108f8000 0x8000>, /* sd6g_lane_12 */
+				<0x6 0x10900000 0x8000>, /* sd10g_lane_0 */
+				<0x6 0x10908000 0x8000>, /* sd10g_lane_1 */
+				<0x6 0x10910000 0x8000>, /* sd10g_lane_2 */
+				<0x6 0x10918000 0x8000>, /* sd10g_lane_3 */
+				<0x6 0x109a8000 0x8000>, /* sd_lane_0 */
+				<0x6 0x109b0000 0x8000>, /* sd_lane_1 */
+				<0x6 0x109b8000 0x8000>, /* sd_lane_2 */
+				<0x6 0x109c0000 0x8000>, /* sd_lane_3 */
+				<0x6 0x109c8000 0x8000>, /* sd_lane_4 */
+				<0x6 0x109d0000 0x8000>, /* sd_lane_5 */
+				<0x6 0x109d8000 0x8000>, /* sd_lane_6 */
+				<0x6 0x109e0000 0x8000>, /* sd_lane_7 */
+				<0x6 0x109e8000 0x8000>, /* sd_lane_8 */
+				<0x6 0x109f0000 0x8000>, /* sd_lane_9 */
+				<0x6 0x109f8000 0x8000>, /* sd_lane_10 */
+				<0x6 0x10a00000 0x8000>, /* sd_lane_11 */
+				<0x6 0x10a08000 0x8000>, /* sd_lane_12 */
+				<0x6 0x10a10000 0x8000>, /* sd_lane_13 */
+				<0x6 0x10a18000 0x8000>, /* sd_lane_14 */
+				<0x6 0x10a20000 0x8000>, /* sd_lane_15 */
+				<0x6 0x10a28000 0x8000>, /* sd_lane_16 */
+				<0x6 0x10c08000 0x8000>, /* sd_cmu_9 */
+				<0x6 0x10c10000 0x8000>, /* sd_cmu_10 */
+				<0x6 0x10c18000 0x8000>, /* sd_cmu_11 */
+				<0x6 0x10c20000 0x8000>, /* sd_cmu_12 */
+				<0x6 0x10c28000 0x8000>, /* sd_cmu_13 */
+				<0x6 0x10c30000 0x8000>, /* sd_cmu_cfg_9 */
+				<0x6 0x10c38000 0x8000>, /* sd_cmu_cfg_10 */
+				<0x6 0x10c40000 0x8000>, /* sd_cmu_cfg_11 */
+				<0x6 0x10c48000 0x8000>, /* sd_cmu_cfg_12 */
+				<0x6 0x10c50000 0x8000>, /* sd_cmu_cfg_13 */
+				<0x6 0x10c58000 0x8000>, /* sd10g_lane_4 */
+				<0x6 0x10c60000 0x8000>, /* sd10g_lane_5 */
+				<0x6 0x10c68000 0x8000>, /* sd10g_lane_6 */
+				<0x6 0x10c70000 0x8000>, /* sd10g_lane_7 */
+				<0x6 0x10c78000 0x8000>, /* sd10g_lane_8 */
+				<0x6 0x10c80000 0x8000>, /* sd10g_lane_9 */
+				<0x6 0x10c88000 0x8000>, /* sd10g_lane_10 */
+				<0x6 0x10c90000 0x8000>, /* sd10g_lane_11 */
+				<0x6 0x10c98000 0x8000>, /* sd25g_lane_0 */
+				<0x6 0x10ca0000 0x8000>, /* sd25g_lane_1 */
+				<0x6 0x10ca8000 0x8000>, /* sd25g_lane_2 */
+				<0x6 0x10cb0000 0x8000>, /* sd25g_lane_3 */
+				<0x6 0x10cb8000 0x8000>, /* sd25g_lane_4 */
+				<0x6 0x10cc0000 0x8000>, /* sd25g_lane_5 */
+				<0x6 0x10cc8000 0x8000>, /* sd25g_lane_6 */
+				<0x6 0x10cd0000 0x8000>, /* sd25g_lane_7 */
+				<0x6 0x10d58000 0x8000>, /* sd_lane_17 */
+				<0x6 0x10d60000 0x8000>, /* sd_lane_18 */
+				<0x6 0x10d68000 0x8000>, /* sd_lane_19 */
+				<0x6 0x10d70000 0x8000>, /* sd_lane_20 */
+				<0x6 0x10d78000 0x8000>, /* sd_lane_21 */
+				<0x6 0x10d80000 0x8000>, /* sd_lane_22 */
+				<0x6 0x10d88000 0x8000>, /* sd_lane_23 */
+				<0x6 0x10d90000 0x8000>, /* sd_lane_24 */
+				<0x6 0x10d98000 0x8000>, /* sd_lane_25g_25 */
+				<0x6 0x10da0000 0x8000>, /* sd_lane_25g_26 */
+				<0x6 0x10da8000 0x8000>, /* sd_lane_25g_27 */
+				<0x6 0x10db0000 0x8000>, /* sd_lane_25g_28 */
+				<0x6 0x10db8000 0x8000>, /* sd_lane_25g_29 */
+				<0x6 0x10dc0000 0x8000>, /* sd_lane_25g_30 */
+				<0x6 0x10dc8000 0x8000>, /* sd_lane_25g_31 */
+				<0x6 0x10dd0000 0x8000>; /* sd_lane_25g_32 */
+			reg-names =
+				"sd_cmu_0",
+				"sd_cmu_1",
+				"sd_cmu_2",
+				"sd_cmu_3",
+				"sd_cmu_4",
+				"sd_cmu_5",
+				"sd_cmu_6",
+				"sd_cmu_7",
+				"sd_cmu_8",
+				"sd_cmu_cfg_0",
+				"sd_cmu_cfg_1",
+				"sd_cmu_cfg_2",
+				"sd_cmu_cfg_3",
+				"sd_cmu_cfg_4",
+				"sd_cmu_cfg_5",
+				"sd_cmu_cfg_6",
+				"sd_cmu_cfg_7",
+				"sd_cmu_cfg_8",
+				"sd6g_lane_0",
+				"sd6g_lane_1",
+				"sd6g_lane_2",
+				"sd6g_lane_3",
+				"sd6g_lane_4",
+				"sd6g_lane_5",
+				"sd6g_lane_6",
+				"sd6g_lane_7",
+				"sd6g_lane_8",
+				"sd6g_lane_9",
+				"sd6g_lane_10",
+				"sd6g_lane_11",
+				"sd6g_lane_12",
+				"sd10g_lane_0",
+				"sd10g_lane_1",
+				"sd10g_lane_2",
+				"sd10g_lane_3",
+				"sd_lane_0",
+				"sd_lane_1",
+				"sd_lane_2",
+				"sd_lane_3",
+				"sd_lane_4",
+				"sd_lane_5",
+				"sd_lane_6",
+				"sd_lane_7",
+				"sd_lane_8",
+				"sd_lane_9",
+				"sd_lane_10",
+				"sd_lane_11",
+				"sd_lane_12",
+				"sd_lane_13",
+				"sd_lane_14",
+				"sd_lane_15",
+				"sd_lane_16",
+				"sd_cmu_9",
+				"sd_cmu_10",
+				"sd_cmu_11",
+				"sd_cmu_12",
+				"sd_cmu_13",
+				"sd_cmu_cfg_9",
+				"sd_cmu_cfg_10",
+				"sd_cmu_cfg_11",
+				"sd_cmu_cfg_12",
+				"sd_cmu_cfg_13",
+				"sd10g_lane_4",
+				"sd10g_lane_5",
+				"sd10g_lane_6",
+				"sd10g_lane_7",
+				"sd10g_lane_8",
+				"sd10g_lane_9",
+				"sd10g_lane_10",
+				"sd10g_lane_11",
+				"sd25g_lane_0",
+				"sd25g_lane_1",
+				"sd25g_lane_2",
+				"sd25g_lane_3",
+				"sd25g_lane_4",
+				"sd25g_lane_5",
+				"sd25g_lane_6",
+				"sd25g_lane_7",
+				"sd_lane_17",
+				"sd_lane_18",
+				"sd_lane_19",
+				"sd_lane_20",
+				"sd_lane_21",
+				"sd_lane_22",
+				"sd_lane_23",
+				"sd_lane_24",
+				"sd_lane_25g_25",
+				"sd_lane_25g_26",
+				"sd_lane_25g_27",
+				"sd_lane_25g_28",
+				"sd_lane_25g_29",
+				"sd_lane_25g_30",
+				"sd_lane_25g_31",
+				"sd_lane_25g_32";
+		};
+
 	};
 };
--
2.29.2

