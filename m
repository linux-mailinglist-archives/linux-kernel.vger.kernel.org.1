Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF528AA45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgJKUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgJKUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:23:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D23C0613CE;
        Sun, 11 Oct 2020 13:23:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so12273422qtp.0;
        Sun, 11 Oct 2020 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=ju9mLKlxw3juAmmBojbjHkfWaM40AnQp8UPcKR9h96fhqKzOMqWwGnEZDID6DR3PD6
         3gBk2vYF5hAInG8yvPmtrvzRw8MuT0lrDz2FL2DR6SZEgwEP9iCafq4D4qvEbu9ldojS
         DnA4PLUF4rSo2VWOz0oYvZTA3zDqlBH2kTKiWoJeiZE/lVuyJl3AUDGcGWAd2zQHdFnU
         RJkKwEHgxhqfgIelq7/a5fbtsxW26zxGBKcq2Tf6gr195EEZ8pcjuPKN+2QRdVfvpjuP
         K19DhIDCCKBs7ovkKovNi44F1XMdot+Cod7tZcKXx50zZ7oftOgeMQl+TxAsEeoJVEO6
         xzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=maNU+i8zlUO2QqeXHNb5JK4aYZdDsvcVBNah+9+IeyBw45AhyjCWA3ffWMVOX+4tz5
         lEJRccKGNw9qdoc53ScrvUOyGavoVTx9szja+FCqqyMu4ax9XIdOKncnc0qhEac5C8JV
         R1N347kEhkkJYwUcfQVP4xcdXoTMpTCR1ji5nPFVIllZl/cAelVBJtdU1iff6s6dN9zi
         1W35AzRH+XdV02buUhWHyBoLiboviz8M216Q158OBAKtleW/na6KzprvjQD6uWn40FJa
         2SfxhzvdRN0lqOZIWmb5J0/3FAg/fzi4YQTKclMl0z9hQ4/HInoydivSxYFQFhmSof3q
         lLcw==
X-Gm-Message-State: AOAM533c8/OtEuG4KQmzOmgMe0ZkgZEzgjfz6+w/ed/Qr7QNLDm7CY9T
        10kOBJKzXUnPYvYhQ11KQhlNyOhy7VeNEQ==
X-Google-Smtp-Source: ABdhPJzAzixTgaSYROUXiXsGI/6tpDiPOrHpKW9piKnWZsPwlY75HYWNTT8pImJzm8bNjZpPZSTOqw==
X-Received: by 2002:ac8:3857:: with SMTP id r23mr7488303qtb.236.1602447781194;
        Sun, 11 Oct 2020 13:23:01 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:23:00 -0700 (PDT)
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
Subject: [PATCH v7 10/14] arm64: dts: allwinner: h6: Add I2S1 node
Date:   Sun, 11 Oct 2020 22:22:20 +0200
Message-Id: <20201011202224.47544-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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

