Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3F2A0847
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgJ3Ort (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgJ3Orl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC0C0613D2;
        Fri, 30 Oct 2020 07:47:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w145so1223364oie.9;
        Fri, 30 Oct 2020 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=L8NewlTl2v389QZz8ht74WOfDH8lbv8sEbUY62YMCIc1MPp0XqhWtIMQqyPK3Pbht7
         ic/aKAjTU+oGl9cnLGAUGJNVbZtCWOrn3T6Yjn9urVLbuARWMhwAKGPdPhP+Qs67XDYh
         mgMnHLLQIIs7XW6W+fPNuP+y1CiKhY4GnokUwNW+llbZj01BG5W5PEOWjk32vSWuuQOl
         EPtw2ISuQhuma8JYz8Oqi7HRk7zkxJaQkSaQzBD/e3DYjcMpL8kr8Q4roHHaYKg89G8C
         qL2tKrkikxgmmTGDX5F4APhCYiPRZVe47aXA3byMHRO3cx2u6JsdOBeVfRwKzv5MZ//1
         +Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=VOsUxzriqvcMA/Rt5IeN8OaKmN9LG1Y/kx/IenwWFjpN0yOWAVQM5zRtzmdGr35Aah
         xaIH+Fu3uQMmWkAquWWAxir3sKXKPIRTwABlXzy91i91NSGpXAnI5/bcOqlwX0vo5zQp
         e4SIzMqBML3kdT20xVrf9O/zKYkTlzY6t54hccXCogMUqc1+HiMCHKktb7mX/g8nt4ux
         7TbwH9uV9JJ1INpMshwfo+r8qAPuokhSfacwjDADNwoRTx0yecP9wVabhjeBzuXKJUfN
         RQilbGyv9Re4t/iJzYzLYvxwBGIWJTxg8owjaHxcdMj3ikjsIfJe3b86guAp4cZ7Zjax
         QnGw==
X-Gm-Message-State: AOAM5310Nr7adeArTLAxphK4GuJ8mp1CpAdFHz12an93pwSTfHjPrmx6
        Z8alyskAE7eJBwVrTS1A2SpfNwzNQ7RB6Q==
X-Google-Smtp-Source: ABdhPJwnuy2Hle+FbWPJ+65edNgwFb56SDLKD8JH7gKIYhEi8Q4jZAAu1NPE1Wv/nSiQZuWwCNMFqA==
X-Received: by 2002:aca:4d14:: with SMTP id a20mr1789519oib.46.1604069260878;
        Fri, 30 Oct 2020 07:47:40 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:40 -0700 (PDT)
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
Subject: [PATCH v10 15/15] arm: dts: sunxi: h3/h5: Add I2S2 node
Date:   Fri, 30 Oct 2020 15:46:48 +0100
Message-Id: <20201030144648.397824-16-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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

