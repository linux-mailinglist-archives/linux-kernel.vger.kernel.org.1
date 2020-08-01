Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE002353E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 19:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHARuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 13:50:10 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:37968 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHARuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:50:10 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 071HntOn032520;
        Sun, 2 Aug 2020 02:49:56 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sun, 02 Aug 2020 02:49:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 071HnrDO032513
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 2 Aug 2020 02:49:55 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Sun,  2 Aug 2020 02:49:50 +0900
Message-Id: <20200801174950.2309273-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'disabled' SPDIF sound node and related settings
for rk3399-rockpro64.

There are 2 reasons:
  - All RK3399 dma-bus channels have been already used by I2S0/1/2
  - RockPro64 does not have SPDIF optical nor coaxial connector,
    just have 3pins

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6e553ff47534..e35b30f8a46e 100644
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
@@ -698,6 +715,17 @@ &sdhci {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdif_bus_1>;
+	status = "disabled";
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
2.27.0

