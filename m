Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE52824B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgJCOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgJCOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB0C0613A5;
        Sat,  3 Oct 2020 07:20:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so4853496wru.6;
        Sat, 03 Oct 2020 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=eb+99JrHGu7CStzvPmgJqEYGTTZr65cO4Rme1m1HQrkX3eP6OtamKbnFjU+KfRPHJY
         Pvfj3aCfPq6q5B+/Tuo8Qapq+fBT63gBHs53Apw2QTf5MCSE2nVCI2jYbNlbBeEUqUNY
         7HaUW/fi23P1cY8u+VjlhE639i4pnXPXN3RRi2Kt1E/luZpQTMQ/sYLlBsSi/bxmSFTZ
         AxquGIS9jRNjME0IW5jsGuNfCAlre8OTLCkRidbu7qqacligrG0Ra46NLSwuoBC8eUkv
         a7HdaK8uXNhzdBUm2pZ4cCs19AeKizkdrXkpkhNJaPGBaqWldUu98JC4EKATsUAhdNrR
         hZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=GAnhxw5NVTe5CY33Nw0VPOn+wNWI9S94fEuLKxU9rDcn9+zjQDz0kp+Hk9ErnfG1FE
         eWvbxZPMJPyJrzp/+aFkCSQg9lJK7Bzl0ZnHS2C9r0GW3C9HeWa8Rtu+EYypTQbyBZ1D
         M106UlTmWgDuvWRMgy1K3zJ/drKFlO+cR1Uf2YRdTyEdCp7QNO6J+Lebrz8wvGRUS1xU
         g8L+Bt9vpX0h7sBTiXjSIHMyt+iGdt1KvUzPI41IsFRoSRrlQsyQvoEATMSNKMga3EXb
         m6drK+A0hW/Bz34F7YwKUrCxnTGbyhwnJxJgOYU5aeiQm7/4fI/nvU5ZuHnRgJvtcuii
         ORAw==
X-Gm-Message-State: AOAM531JXvIIkLVPX1siCAfnZzua8zgGMOlIM4auOCUZ1+aqZmRKbhuI
        cxanYcraYcZvWqFZMmGSE+k=
X-Google-Smtp-Source: ABdhPJxkOEi3rerfibud96xE0Nh1JET90gjU8tEtkYMpwM1s02F5+a8gjfBtZ2G9gGt1rIZhLWL8tw==
X-Received: by 2002:a05:6000:12cf:: with SMTP id l15mr8237746wrx.312.1601734817786;
        Sat, 03 Oct 2020 07:20:17 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:16 -0700 (PDT)
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
Subject: [PATCH v6 11/14] arm64: dts: allwinner: a64: Add I2S2 node
Date:   Sat,  3 Oct 2020 16:19:47 +0200
Message-Id: <20201003141950.455829-12-peron.clem@gmail.com>
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

Add the I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..51cc30e84e26 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -846,6 +846,20 @@ i2s1: i2s@1c22400 {
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
-- 
2.25.1

