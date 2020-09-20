Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6E2716C7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgITSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgITSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47DC0613D2;
        Sun, 20 Sep 2020 11:08:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so10319776wmi.0;
        Sun, 20 Sep 2020 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
        b=pSxqCAT00PglZWdVW4BHbNa6M9AcP9KmANbWjTrGbvUoH3xSoYpLFaEwbcETSxaMpy
         6lDZJVQYv4TQULCf2yTfDWLCSUghJmAUCDY4J/TIopQKRnMoe+aWpJCpjVTGGWkQMu0i
         nwiJex5SzmKJKf1iBvGphD+V/2+uu27vUmaH6/ggW7P1TcnXxWAs96d2JM5m8yfU2iqr
         iHQ1rxZzE6AFoidsIj4cO736erBK9l3P8KXW+1avg0TS0NzD8XmWSWK6V54yQQJdSF2g
         yfA0mM490INXeX1vFnxnvQT8Ut1QOCJx9niKyUiE8tiyznjmQcRCBRAY22vrTL9F769T
         2rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
        b=i8nVOGyeHAl1SW+h82NabyEJnhPD+W4aosKKlwrW808KRC5JnqWhhg//iFXpp/QSof
         KTZX6nGT4d0AzZmkZG6mqF99ZXELScTkWn/DrP7O56JTRVCb0l9BzBF9eG6G02bBm3Y4
         rDgKJkaZa74PrrS7qLW8x8NjDHZH5xgc30uTrlyYHllGZ6ILy4D9O97GHoK9lm1xGJPT
         W4th6dAr8F6FUZM+kXesOFSwNbzj8ObcfYOfVeMp/lAVdn0j/R1cKhDo9lqmthTS6nEQ
         P0JEKtdQtV9pL1SbOT3sqMQx15NNWf8nt2l296Yg0IVkOTEZzRsEsLijJIHwdEIGj869
         4EfQ==
X-Gm-Message-State: AOAM533xtUd2RQjRbQuTyZYvQM4UX62C+vpLlx8tjkrbZTYRbn5w9qKu
        NtrU3E+PNxfhuANRA9D78ns=
X-Google-Smtp-Source: ABdhPJxiIKUkGTyKv49gyQgZ7o8Gt6ys1xGGR9jjdvD0yTLSiJ04rrIJxV/N7x3rqAx/M1n6vKFLjg==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr27556913wmj.134.1600625298266;
        Sun, 20 Sep 2020 11:08:18 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:17 -0700 (PDT)
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
Subject: [PATCH v3 07/19] arm64: dts: allwinner: h6: Add HDMI audio node
Date:   Sun, 20 Sep 2020 20:07:46 +0200
Message-Id: <20200920180758.592217-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add a simple-soundcard to link audio between HDMI and I2S.

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

