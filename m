Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73D129C76F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828462AbgJ0ScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828447AbgJ0ScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so3076319wro.1;
        Tue, 27 Oct 2020 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=Pfr8LfXekgJDgiB00izNoFPMw/I37mM/7+6wMKbtWF1lt/1KKV/RroYMm5GZl4r2Jp
         fV8azX7bw3Qd0ijdnIbPmJutyYqCsY4VGXk7dT08gqDH+/k8OOPbf2/uyrXKj0QQkXOM
         plF3GQeY5fYu8wz6/EFme3X5sNC4pCbeX8AWeTcXC8Hlem2N96ZzmFbDNR1GZStQTMrF
         1fIk8lLPs3M9GPEg2AanaQG7pPVqH1YaZI/Z8F9h/n4wHdSnTxHOYO4vVIViU8HX5rVX
         np5DttlcfXurv59lB5/ePCSB8Xk/a+0F6s4e05EGKVdY2810VXH/q7Y12ShWtzlBlc/n
         jz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=U0D0CPcAujbhEZfW+ZhbYdbTkb8NarEg8oM3NmbxPWTEfNCy3wkGHHE6zXekWWyaR0
         X3Dy2k/WoX7yZVUiWLevx0XVXMK+AtVwQGvegyYn97foad4LjPvgGLjNiAwGOkPLxrYD
         136HS646HJDPjI89bREU3DIUYUBjI0VTWEMYsdIWYcW2inpQSYmTQsY/YqaG18xZklC5
         C6lWgCrusZQhmmRbUmNxJ3T5Ub00dVe6dDmJooAFKCgODUSwwVgl5TaXXky8PfaG04GN
         7QvjSci8VF0zcQ4e95rGHZsS7ua2/0XhLnAlgKz+WvFNUnZYqlhFvX2GwK+Y5BBhfiT7
         XnkQ==
X-Gm-Message-State: AOAM533faDslhnl8fcvQ4U+h9kIauOvTT6e8F0LuF0+dCdQncBaH4JPy
        kzKtP+Mqd43K5qq2/vwlrjM=
X-Google-Smtp-Source: ABdhPJwhFW4p11PRPRjqU1y0w+YYxj2DBunoDsyybko3hOVhBLWs3c5PW32LwGnLVtKSKt15uxCGYg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr1339948wre.87.1603823527910;
        Tue, 27 Oct 2020 11:32:07 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:07 -0700 (PDT)
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
Subject: [PATCH v9 14/14] arm: dts: sunxi: h3/h5: Add I2S2 node
Date:   Tue, 27 Oct 2020 19:31:49 +0100
Message-Id: <20201027183149.145165-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

