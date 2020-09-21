Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447F27210F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgIUK2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIUK1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43728C0613D2;
        Mon, 21 Sep 2020 03:27:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so12138396wrs.5;
        Mon, 21 Sep 2020 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
        b=RvDq5ACJPtcSlqQgNrS9a3nOGhIsFdBgxLfrl9P56YbGTStq55a6p52GECOAedqyy6
         gMzeOiMhfAAkyD/nxfsATltAVGFWBJgowmuHCg55dvJZsRffi2zdA12KmUko1g3Qp1SX
         ldXtluqJWmnRhJxX2W8IcIGn1tuSgwXJEYuta/HXu6wbAceQagBGidUQzmkWqMPnjg8t
         xPRcG6WBUZmwtL+ER3Ktd7IOHQol7NXZ85ztiwPCoWpMmkzu7f+dszG5Os71mmvDQXb4
         l4b+H3lTLectvTOx+hp/GkJzxBSwV9fkONw3EcPMvqpw2EeR4znqu+WZcC7qRhGMvT40
         sbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkdfxrLwBdjddup+rntjfNSMSYQlzu1HAdo40yPe7r0=;
        b=NkkbgBnMY/yl3Xt0GE1f1nvjNukHhjx6JFobfcREVv84U9MXasUM63kYZ4tmX7vXdF
         3byMzR3CtGGk1UW6/tP9plxA7//nSz94jUZtZm8gvIwJow1Svn1fXpM91ZYbSof8mRFw
         sjo1BFw3d8JJHDgfNOU7QED0xg/QBpjvBwKaAj4U0vGTzFVf+wYXdn0MyycUSaDX+tvl
         mP/1NoGYpM6GZ5P1iAy/Hi0ZuFuOfeIKAFFnvhnEof1wZCzMgFXF6pBOlPXFHNNwZK3p
         DQxIUBw4TvOwV5cLvy5BJL7OY3Oi20unPy9QHPkYDhaYVXbbB5jdB8ulM5PHvmE09DUZ
         KtJg==
X-Gm-Message-State: AOAM531/H8scs6sb1D51uMw0bPGyvqqmtH9IY0XmZzwj8IiFT4gYQrp2
        Gxkn0jl1XWQPD5/ThHxnDXk=
X-Google-Smtp-Source: ABdhPJzWiop5gOEboJyVl9N3SYa7aUJaakgTHf38lUDH0hociHufJWzfPObOk+9i3qTV7iU2vHQmKg==
X-Received: by 2002:adf:e385:: with SMTP id e5mr50763021wrm.129.1600684066825;
        Mon, 21 Sep 2020 03:27:46 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:45 -0700 (PDT)
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
Subject: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
Date:   Mon, 21 Sep 2020 12:27:18 +0200
Message-Id: <20200921102731.747736-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

