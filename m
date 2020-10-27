Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5429C775
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828542AbgJ0Sch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37492 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828434AbgJ0ScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so3053550wrm.4;
        Tue, 27 Oct 2020 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=VTOeIPc21SPDfrYYYmM4tXIGoNyCzGTE5YvPQ1ZxpCZrtRHKzyp7qaHleRwvHCQZBN
         OUMoABB8d66NAw4xhyJUDC1JR9d539NmmbQpncNXa7/8o8HRjGlfjMAE56Fh7GgH3it4
         ac5TamvvQT05upVyw7s4kaQlWMzWNFqwQ1rTbX2E4OY0/pGITpCYCsauMFgQ+FvZcXlp
         ZMeWyYu4pn1ivcmU7kBj2fhPr1+OxB1l8YxiE87/lz960eue7IxKntRCb0EjFV3zCfxh
         TvvjglS9aMRx7ai6Vn7o4u55OU/EjMu6gvWDC5OL0zhoIbjo1Y/ZKWVLJ15PITC1QU6v
         3u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=Nl0v3hgJnFiTsrQaXKBPrsWh3lpdTIOwj+GyIB8YTzbC3LD03TYNUeI96wfut+Y8P9
         C2Nh93c8nP8i7n/Ynah+o1RltcsDIRJwXq+fLpJUmSHc9SUizWOqlxAv3+rne1uwRAfB
         WSZKCbIWY/sF/6sTgRPt4NIRozsjGnd9S58w2b8Ks4lRuQwtnHWtrv/s/mjAGn17gNyB
         1tvDax8SoF0sTIK22ufYT+0+alJZr9MjemuaYYXAsLE7ATma2pnWmNPAuctLsk515ki3
         uKlnsj50hBa5wYjZJ0KEoNn1o/Sgebri9pTnDEMxasVqTsxYvfb9ynvVYcktcZh6fEPu
         OknA==
X-Gm-Message-State: AOAM530m++cEQCBIlFM7uw30KsQIKR1CJdl58IPIIFOeqAB5ilqxQQSQ
        6qwhZ9ORoeCoTtJexT71HaA=
X-Google-Smtp-Source: ABdhPJw8Wn6ERQSJ1vafvTcwkql50kuQIxHbMuKXVvBOYEtVy4RF0vMwn0Tq6O32lBxiusXzyxdh7Q==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr4196893wrx.290.1603823524580;
        Tue, 27 Oct 2020 11:32:04 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:03 -0700 (PDT)
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
Subject: [PATCH v9 11/14] arm64: dts: allwinner: a64: Add I2S2 node
Date:   Tue, 27 Oct 2020 19:31:46 +0100
Message-Id: <20201027183149.145165-12-peron.clem@gmail.com>
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

