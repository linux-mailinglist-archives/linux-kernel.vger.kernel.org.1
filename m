Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC127A2B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgI0TaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI0T33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCAC0613D3;
        Sun, 27 Sep 2020 12:29:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so9506634wrw.11;
        Sun, 27 Sep 2020 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3W8D6ez0E1EN9kunjStsHDeyLV2So0bhgmjFnVu+y0o=;
        b=hYYtdT5J2lbYtw1h3CNjAzek2lH+LzJZdHVECbEvdTU/jLRW1oXuAcVlyA6z/Irotx
         kTZYef2GiX4xFbLOEoY68jUAsnlYyfybzCVmPVvjjDe9sU+NBQbH3BOJEQ2iyyjKwmZz
         XqA0syBhyivdtEC0L0MsNGIOojTDvboRPwon6/BuRRzKkfO0+AhaRjQBavKrMZz4Ccqv
         hSbB9A1D75lTZ/tXtw1LzOMs4bZo0PDdSYvbKNUM8f5HJSvMt9lDQZXaT4ICCHHfFCfi
         5MEinIW2essWfKAZFGgWWnRupJ/qb841ZTUqAiRIaUeNCoqYZAbZE/7p6YT0/NWgt++f
         cnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3W8D6ez0E1EN9kunjStsHDeyLV2So0bhgmjFnVu+y0o=;
        b=qUsMscHCctQ6d64D8NS/CNaEVBx5Rpt4+W/E3P06Y0c9i6m0Rg4hB6xKgZ3gXrGqm0
         NHJ5bsnxHgJZtDGZ4RQ69z4uC5uDceMvtFYgM1SO2QCvMBzVUiCUFxF/Q+zRy75f7cYn
         j7DcmiFKvnIgHXyCALAsPRwk983tyZT9VfZc5GvdaBo3Q+woTZTJO9xYvCCpoKVt8BPy
         2YYwpw0J5+dyLt1aXbeQel4K4SjMxl/nSxaHYngDlLvoImtKMZDDAHYmtUL1UdSpj+ce
         +XytvhBHxrEH/BR2B9LoA0rt7cvMT4W495BQABUVvtGlWiPV2T0E5/IEIZeRqwUCrSVr
         rmcQ==
X-Gm-Message-State: AOAM531v8pRHFe/OnYhsYX7Vu2zRXfZ00QRqAAuQ0bigzqiO0UxD+5Cs
        5fn3CUMt5P0A2B9YKUjbiS0=
X-Google-Smtp-Source: ABdhPJxdMPb3y8OLx5/uCv7BmgNFZaa3m3cSLR5JV5R5qBm9oAw2aUmQrVEJFSUhiTLVyvr2EGEGWQ==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr15006207wrc.258.1601234968172;
        Sun, 27 Sep 2020 12:29:28 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 09/20] arm64: dts: allwinner: h6: Add DAI node and soundcard for HDMI
Date:   Sun, 27 Sep 2020 21:29:01 +0200
Message-Id: <20200927192912.46323-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add the I2S node used by the HDMI and a simple-soundcard to
link audio between HDMI and I2S.

Note that the HDMI codec requires an inverted frame clock and
a fixed I2S width. As there is no such option for I2S we use
TDM property of the simple-soundcard to do that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 28c77d6872f6..a8853ee7885a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -67,6 +67,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-h6-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -609,6 +628,19 @@ mdio: mdio {
 			};
 		};
 
+		i2s1: i2s@5091000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-i2s";
+			reg = <0x05091000 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spdif: spdif@5093000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-spdif";
@@ -739,6 +771,7 @@ ohci3: usb@5311400 {
 		};
 
 		hdmi: hdmi@6000000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-dw-hdmi";
 			reg = <0x06000000 0x10000>;
 			reg-io-width = <1>;
-- 
2.25.1

