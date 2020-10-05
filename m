Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC912838BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgJEPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:03:19 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:21191 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJEPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:03:19 -0400
X-Greylist: delayed 3583 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 11:03:18 EDT
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 095E3Kbe031802;
        Mon, 5 Oct 2020 23:03:20 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Mon, 05 Oct 2020 23:03:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (80.57.232.153.ap.dti.ne.jp [153.232.57.80])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 095E3Dnx031782
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 5 Oct 2020 23:03:20 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v3] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Mon,  5 Oct 2020 23:03:11 +0900
Message-Id: <20201005140311.2507530-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'disabled' SPDIF sound node and related settings
of SPDIF for rk3399-rockpro64.

RockPro64 has output pins for SPDIF Tx. But RK3399 does not have
enough DMA channel for enabling SPDIF tx. Current settings are:

  - I2S0     (Req num 0, 1): Enabled : Output to 40pins header CON40
  - I2S1     (Req num 2, 3): Enabled : Output to ES8316 on board
  - I2S2     (Req num 4, 5): Enabled : Output to internal HDMI core
  - SPDIF Tx (Req num 7)   : Disabled: Output to connector J10

If users want to enable ALL sound I/Os, we need 7 DMA channels for
it. But unfortunately, RK3399 has only 6 DMA channels. So users have
to choose from the following:

  - Disable one of I2S (Ex. I2S0) and enable SPDIF tx
  - Keep enable I2S0/1/2 and disable SPDIF tx

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes in v3:
  - Refine commit description why adding disabled node

Changes in v2:
  - Remove redundant status property
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6e553ff47534..58097245994a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -76,6 +76,23 @@ sound {
 		dais = <&i2s1_p0>;
 	};
 
+	sound-dit {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3399";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
+
 	vcc12v_dcin: vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -698,6 +715,16 @@ &sdhci {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdif_bus_1>;
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.28.0

