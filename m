Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48A62824AC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgJCOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJCOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC40C0613D0;
        Sat,  3 Oct 2020 07:20:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so4845827wrp.8;
        Sat, 03 Oct 2020 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=u8GC3+J+LJHL0bHYqdtwcb3saMTpTg/ICMHyMfYfjlApBBb4bwA+VHYb//eiAZZMwV
         3xmfzwIbOsqMMYb9IaDEZEW/OGpDmXSg/+Vn+/x00zBkbN6N4mlp6nhEB6G9jsGMVLTO
         lVH7H2i4jWa+FZvUauEfJBPYJFK5dilmhU/Yxs2XI2ElpomZq0rsrYySZ9CwgjE9EnFv
         vpSurOm8cd03JBQvYfTW07dTigWjso/hQQUchefNbaVLHHI80Ozb+pyG0pJ+619nW3QT
         fJli5utqMvduQ5cmsuZCSOlz+l9xlRe9BoTULGcX/DaCpmfuMhHbJqq6+ZyX0RmLlCfj
         S4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=qW4WfoHheK58eOU2+r2Pe/HETXGzlzuD5CSmlJpfD3Q0pT5Hu2j6mZSPFzOnasPQDB
         lMGeCz6LA66d8XV/tO+unGTeQkOx2keQm50ZKg/2yhuSsa7skvKjZjqPQbEbxf+QayEW
         4PMUZdm8RQMDkItutORsoHuy7Agm/3NmdQqPfrN4e1KEPJ2K3QBKbBF9u15bqVCr4gOh
         gtPEAH6qtfrFHu5dznkBYh8qrO6evlfFpza0C43wANO+FeDZwXQ6dmGvWQN+QkzIeXj9
         8xkCwAUgUtu/vJJpP8IY2DaqinVacWrRDHaKH2AmSp0/SffsP2VdGMN+84dSVL9CvhAg
         RCMQ==
X-Gm-Message-State: AOAM532DQTvb9yl29bT+2SRbNygOoOLJ6/qYnKbcJCmDMpbA6HoYPrTh
        PQTW4hXd9g44P7hOd544UQY=
X-Google-Smtp-Source: ABdhPJxHfyuLH8+eJsmhPM4gM03KPgUvXhOFVldQ+mJwiPnHNBL32S2zcjp6aubvOgLXigkLM11n9A==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr2306431wrq.278.1601734824252;
        Sat, 03 Oct 2020 07:20:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:23 -0700 (PDT)
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
Subject: [PATCH v6 14/14] arm: dts: sunxi: h3/h5: Add I2S2 node
Date:   Sat,  3 Oct 2020 16:19:50 +0200
Message-Id: <20201003141950.455829-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add H3/H5 I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..9be13378d4df 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -662,6 +662,19 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

