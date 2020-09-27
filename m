Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A832727A29E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI0T3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgI0T3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A16C0613D5;
        Sun, 27 Sep 2020 12:29:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so9537637wrs.5;
        Sun, 27 Sep 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TQWIqgvaw89lJDj44ur6CfXLBdvHwh5oAFQqUb8yKI=;
        b=rKfMWekhk7Ns8FICmbviit95Pt+WpU7TuXkoPXKkf/DGkKAG3sWtM2kxCDfM58R6fx
         iVEiO1d6KYmkiz7thtuGvxuwOSXzNXG9eql/5LS4M5wiO8ysiFXpKONZ/TlmKAEQQr8j
         fHVqVk7/lOlOXEbzw6z80vG6C/quZb7hMDfffn2WuK9FHEjWsAVhi0ClxuKduKBqakRE
         SUhEkcSa2y5pLO7vsJ1CIcBXpNL41i72YlDSFiuBUtXNq+4vHRsECc9+b587v5PhByPS
         F3PARu87zvOHatIjf788LXYpRCGbGFQPpLcxSxgiNjnGKgJ9833xFZxPWxecLIPUcYY8
         5TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TQWIqgvaw89lJDj44ur6CfXLBdvHwh5oAFQqUb8yKI=;
        b=bRbtDDj2sPpPnfhFUjOvk/v9ExM1bKEfnA1dLKjKz+wszc6EdjsVMSoVlcwoJXmJoY
         vRDWC/e5Vb/OitLs7Sic5hIcVNNgPzCzv7WoA0h5qNcZLZz7qmvhFP04Xg/hP8GTo0VX
         F/YEB7wGBDi0EjrrYuqgd68ZhMlvdFBnDnkrV15YzcAfGybAt8pfF8DzAMbZheKtEnaH
         6Edrz1D7vfw1DXH1MzIZgDAYXpBIyg3UcrGLeZUo8zo8nCJowxhbg5pBTFYEG5Z2GP/u
         iqPGEhObbZUKkhVNf2NUxulkGaJLHMv/ra/q8fRiwSDccxqzYZSiA5zS6RXlYQxYo63l
         dSeg==
X-Gm-Message-State: AOAM530XgTctenatkpkxvoVSL+LaQSODPsycimpQwE73h2m8FGI83J5P
        MiUa5e7+LkulGzoYYX+URzc=
X-Google-Smtp-Source: ABdhPJzBvHHOuka+qYBTkGrJbTxh9J56urhJS3nHGtKfbwHU33hQ2wR1ys5AololhKsYuJSIYeYALg==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr14893492wrt.162.1601234971305;
        Sun, 27 Sep 2020 12:29:31 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:30 -0700 (PDT)
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
Subject: [PATCH v5 12/20] arm64: dts: allwinner: a64: Add DAI node and soundcard for HDMI
Date:   Sun, 27 Sep 2020 21:29:04 +0200
Message-Id: <20200927192912.46323-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI block for I2S2 which is used for HDMI audio
and a simple-soundcard to link audio between HDMI and I2S.

Note that the HDMI codec requires an inverted frame clock and
a fixed I2S width. As there is no such option for I2S we use
TDM property of the simple-soundcard to do that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..ba8a84e6e993 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -846,6 +865,20 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			dmas = <&dma 27>, <&dma 27>;
+			status = "disabled";
+		};
+
 		dai: dai@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-codec-i2s";
@@ -1143,6 +1176,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

