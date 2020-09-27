Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9327A29D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI0T3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI0T3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2273C0613D6;
        Sun, 27 Sep 2020 12:29:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so4630377wmi.0;
        Sun, 27 Sep 2020 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qinYT+htnv5raGBG7/lcRXg3HUQ8nsG0V/iyMvoCrjw=;
        b=dtm3KvhWEjETON47MufCoWFczcCy9gWFncPJN6+SivV/cbZW/bpplLpDhNS2X0TXos
         jrLvrLhY8Gt3YHD7TK/49WPAmIbIkFLCj3UAv83nMC7/J3v0M+WIinhl7DHjoRP4Twgx
         QBK7KlThYbVtGDz3gCtB2VNdG24PNDqJLbTPrM7r1yLM2r6gefMj+CHG63Ykq3F+8XjN
         O+EMH2d+GRLYyXbFBffJbyFVJ68RBufeP4Bz7dccEOGoVKR5bg1C+P4XOegesib4PYNO
         JyRDGEYeO6zzYIMuzv/2lCkRnZyu9+LXe9h9nGlipwMPacBDG2XZ8Dk2UR62MjpFL167
         qsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qinYT+htnv5raGBG7/lcRXg3HUQ8nsG0V/iyMvoCrjw=;
        b=uQyHH8CnIGJJd5Bnu43wSChr23D81XjR5W6KitcTfrJXPBKupkVWJ9m6DSG6a3s0QS
         VWbb/aTW5OA5deN/71/uhdhHOOrE8InEx5ryqOGQucqVVNkNGa/bWk1KNM5P+UaRCj79
         Br9AQ7lrbPeWx08HCj17c6WY6FG4K8XSd+pkEwZtYgVaUnKk7W39Ztqa8BFuT9AVGNv1
         XAF0gZAdPSOVfKMtIO44RH0YWtLPH9nZ2MRkEcIKMWV+TniNL+9C86dHL9Z1DsP6WGIv
         9oWvHS01nDqDl7Nguh9g84K5mKHj1XQk29w+1YUyc4xO27DuVlh31F7NZkUv5Vm29Xst
         wlOQ==
X-Gm-Message-State: AOAM5336shFeMeF2bpg8s4OFjtLQoUh2xy0S+XmUV765DE95BGgvWvir
        c7fcnooAYYhvqeLMQ2SRrmk=
X-Google-Smtp-Source: ABdhPJz85EH46sP614KXnsZfvh9Dt7ZgvmqNA47Uzmxfxe/quEF4Yk8pjPcdOy+HpsevslnpZ/rqLQ==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr7685544wmi.108.1601234970301;
        Sun, 27 Sep 2020 12:29:30 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:29 -0700 (PDT)
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
Subject: [PATCH v5 11/20] arm: dts: sunxi: h3/h5: Add DAI node and soundcard for HDMI
Date:   Sun, 27 Sep 2020 21:29:03 +0200
Message-Id: <20200927192912.46323-12-peron.clem@gmail.com>
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

Add the new DAI block for I2S2 which is used for HDMI audio and
a simple-soundcard to link audio between HDMI and I2S.

Note that the HDMI codec requires an inverted frame clock and
a fixed I2S width. As there is no such option for I2S we use
TDM property of the simple-soundcard to do that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..7168e9412410 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
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
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -662,6 +681,19 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>, <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
@@ -793,6 +825,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

