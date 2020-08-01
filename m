Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9823543A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHAUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 16:05:04 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:35463 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAUFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:05:03 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 071K4nvF072403;
        Sun, 2 Aug 2020 05:04:49 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Sun, 02 Aug 2020 05:04:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 071K4h2M072388
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 2 Aug 2020 05:04:49 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64
Date:   Sun,  2 Aug 2020 05:04:33 +0900
Message-Id: <20200801200433.2617429-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables HDMI sound (I2S0) and Analog sound (I2S1) which
are defined in rk3328.dtsi, and replace SPDIF nodes.

We can use SPDIF passthrough with suitable ALSA settings and on
mpv or other media players.
  - Settings: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
  - Ex.: mpv foo.ac3 --audio-spdif=ac3 --audio-device='alsa/SPDIF.pcm.iec958.0:SPDIF'

[Why use simple-audio-card for SPDIF?]

For newly adding nodes, ASoC guys recommend to use audio-graph-card.
But all other sound nodes for rk3328 have already been defined by
simple-audio-card. In this time, I chose consistency of sound nodes.

[DMA allocation problem]

After apply this patch, UART2 will fail to allocate DMA resources
but UART driver can work fine without DMA.

This error is related to the DMAC of rk3328 (pl330 or compatible).
DMAC connected to 16 DMA sources. Each sources have ID number that is
called 'Req number' in rk3328 TRM. After apply this patch total 7
sources will be activated as follows:

| Req number | Source | Required  |
|            |        | channels  |
|------------+--------+-----------|
|  8,  9     | SPI0   | 2ch       |
| 11, 12     | I2S0   | 2ch       |
| 14, 15     | I2S1   | 2ch       |
|     10     | SPDIF  | 1ch       |
|------------+--------+-----------|
|            | Total  | 7ch       |
|------------+--------+-----------|
|  6,  7     | UART2  | 2ch       | -> cannot get DMA channels

Due to rk3328 DMAC specification we can use max 8 channels at same
time. If SPI0/I2S0/I2S1/SPDIF will be activated by this patch,
required DMAC channels reach to 7. So last two channels (for UART2)
cannot get DMA resources.

Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 58 +++++++++----------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 86cfb5c50a94..4608f8fc6ff3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -84,34 +84,34 @@ standby_led: led-1 {
 		};
 	};
 
-	sound {
-		compatible = "audio-graph-card";
-		label = "rockchip,rk3328";
-		dais = <&i2s1_p0
-			&spdif_p0>;
+	spdif_sound: spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+		status = "okay";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_dit>;
+		};
 	};
 
-	spdif-dit {
+	spdif_dit: spdif-dit {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;
-
-		port {
-			dit_p0_0: endpoint {
-				remote-endpoint = <&spdif_p0_0>;
-			};
-		};
+		status = "okay";
 	};
 };
 
+&analog_sound {
+	status = "okay";
+};
+
 &codec {
 	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	port@0 {
-		codec_p0_0: endpoint {
-			remote-endpoint = <&i2s1_p0_0>;
-		};
-	};
 };
 
 &cpu0 {
@@ -163,6 +163,10 @@ &hdmi {
 	status = "okay";
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &hdmiphy {
 	status = "okay";
 };
@@ -278,16 +282,12 @@ regulator-state-mem {
 	};
 };
 
-&i2s1 {
+&i2s0 {
 	status = "okay";
+};
 
-	i2s1_p0: port {
-		i2s1_p0_0: endpoint {
-			dai-format = "i2s";
-			mclk-fs = <256>;
-			remote-endpoint = <&codec_p0_0>;
-		};
-	};
+&i2s1 {
+	status = "okay";
 };
 
 &io_domains {
@@ -337,12 +337,6 @@ &sdmmc {
 &spdif {
 	pinctrl-0 = <&spdifm0_tx>;
 	status = "okay";
-
-	spdif_p0: port {
-		spdif_p0_0: endpoint {
-			remote-endpoint = <&dit_p0_0>;
-		};
-	};
 };
 
 &spi0 {
-- 
2.27.0

