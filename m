Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA7429C778
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828549AbgJ0Scn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828433AbgJ0ScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id y12so3033450wrp.6;
        Tue, 27 Oct 2020 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=k9Flst7tFAAjG9ubHEoElAgNXZSrbI98UQtantRFcTAA3sl83J1YqJaS455+rKDUdz
         OFUrdcShLvdVTrTYjjCp5hgaZQCBj5jW9D/v53Nj2gkOe8KQx5ZYs+tTO8cxov4FpCbP
         oLKCYMpaLD/PYF2103hjp6CzKjKn/mPncKNOkqS/i9oeN48eGXotxwgyHFVGS4TDKq+d
         8hNAKg7sYzJZ/9WJArhfx9wYLXIvR/XA/swpPKFqkSOMGmh4MTkH2dyyG0GZ++zP8VPG
         3k/XdlAF1esngVbZEYrcYA1JqwHYrTKjgU4i15uziev6iA7wRhgMgdVP7VsyQs34PNrh
         H2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=Q7qHM7OivynPBzU0sS31iT5gRq54AQ+r0Iz1tPnvjGI1JqC6rNPW4tHfHAzTFz9Xqg
         dk3mK3258DsqT/fyHmVSq9NYfePkn/MA9wJw6qnQjg7TMmbCOxYGK1WqICUjnPIn8ydl
         Hy7QIBL9AwlYKwuz8lcWq/t5Lh4oc6/4lbBG8i9GQ3nadfCNYCim0K68jZJtaO/RI0ni
         g9WsN7Hy4u/nchPR2zo8fzy7DE4vuGIojWgS/D2cVy4I1o5GB2kEgAcELZ5cVBoasAcE
         1TvnO5CzcVqqjLQ5zSwY9twCQeqWtSX+mMV3JQk2Spv5uoXM/7ob/9+6ywCP8qgMVX8I
         Cksg==
X-Gm-Message-State: AOAM532yxV77DWZi2CopPkyVvHCDRa4Cam7zQubcZV/+YsO4Guc8WdDr
        Nvg+05WuCdqPgxQl0CqpobLRPj4VQwmlrA==
X-Google-Smtp-Source: ABdhPJyXTU2eBEU1X7yNh+0GRV2R4fs016UXcklgs1IGMsryGK5lYkJlyJsQU30Om0dELzxdpENPgw==
X-Received: by 2002:adf:8362:: with SMTP id 89mr4535667wrd.280.1603823523303;
        Tue, 27 Oct 2020 11:32:03 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:02 -0700 (PDT)
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
Subject: [PATCH v9 10/14] arm64: dts: allwinner: h6: Add I2S1 node
Date:   Tue, 27 Oct 2020 19:31:45 +0100
Message-Id: <20201027183149.145165-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

