Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB172A083D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJ3Ord (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgJ3Or3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFDFC0613D2;
        Fri, 30 Oct 2020 07:47:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m22so5765738ots.4;
        Fri, 30 Oct 2020 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=NgX1FlX5YkyHohpOSQ2l9OML3jroD7MZvSCFKsqgsoG7fO5zdOLRWBbP++Pmt27xis
         ugOsJObZ4nCGDZ5ef+lgJJka6u0Y3baTlLSNlx8UnOQCfOznmJnEkZOJxMi9xImoy2li
         wHXErFRIA4kpRLraXBUbPIVT8OnNLJZZTMihLaPW9QcbYRNA6YFOEuhUSftV0N52l1ht
         W6nNcbhf+AQjCdDWOxNmxYH4ltln9u4ssE9RP9kYr/B8pBx8KmYmbx+P73go6KFo4WGd
         0sldLajjud0wG1MMsqLiyhWkevIlThuoX+eImNK3l/DxMwsYb7PzyUNf4sTFkWvWEV/O
         X+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=CdLCLiCvcdTybS1r06n3XU9GNUCAteM375y0teb8dseYyiZooC9/+eG+FkGw3gVW2C
         c2tE5RsiLAQzlaLK3roeKN7AkbXZNG5ouygNfzHq4HvQ/vhRt0nnE6ZhWzUSf8+fCQca
         AcolS8pqYg1Fd+OFqQMvBybOOYSg5vqOGC+cgvw53w1pliRepx8vdkDVm568hABMaq7z
         mI1R1qJPFuf/Hemu1go5/AvCq0oEvhQtMH+gOdCE3oWBKcSG2/4ft5u5X9qxNsa8cudS
         dyF7IvTNoxZocuLm/w+56wfja0IkHpa3SlNFoijZjVBj1uhGSW+fDeTmKklUTEqTRsrA
         Qffw==
X-Gm-Message-State: AOAM533OTBr7cz2Exu+/1jwqxHvxk3fQoV5VkbiLdnMZ4yXDjQotmhse
        MrUYYHv+rDDZdmghEtmtODQ=
X-Google-Smtp-Source: ABdhPJx3MWI3HyQs3AtAuz2YanJIJ4mGqrfUrBvH2doCOj6pGUPRyX84UJrWnFLA58Nis8V1qpR9OQ==
X-Received: by 2002:a9d:5d2:: with SMTP id 76mr1786858otd.99.1604069249008;
        Fri, 30 Oct 2020 07:47:29 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:28 -0700 (PDT)
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
Subject: [PATCH v10 11/15] arm64: dts: allwinner: h6: Add I2S1 node
Date:   Fri, 30 Oct 2020 15:46:44 +0100
Message-Id: <20201030144648.397824-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add Allwinner H6 I2S1 node connected to HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 28c77d6872f6..d915aeb13297 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -609,6 +609,19 @@ mdio: mdio {
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
-- 
2.25.1

