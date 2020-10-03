Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1D2824A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJCOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJCOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0346C0613E9;
        Sat,  3 Oct 2020 07:20:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so4854366wrt.3;
        Sat, 03 Oct 2020 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=QbnDnbKuixu6q5WyYnA4aShqmYlGyjnYIe2anSkuDl6X0h6rSgI2HEr5wUfz6dmUzs
         VB7ezPQ7eFX1nTSx+Wyvsl3nhugcgcf8yj70WEpx6oM5AmF8FfHSCccVHB/JXuh/l5oU
         vwXfIf7cmJSWO4A4osK7bXWuNN0lv7aAowum/fZa4MPThW5JrvBho9n3XTYKWFNeH6IO
         o5Qdcru8tpq2Jumy6QR+MVf8P4VA1lR9uDaL/2QZjgV0lPLHQRxsjz+7bQVFwX79x8CT
         xi7xe7ajAPsfHOxarmSzTVzPWkIWEX9456ckSg4GrjJkqqiCs+a6mXa3EEzOzPSITO4C
         TNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=d6ll9tVGHr3wOqG3H1IM5MYPmr15hKucgYvp3zyDaL0FHLAZZw4++iQqLGmVxQYmSQ
         FthnT+gGf+gkQTh3RG0AA5ZlfeRkSP9zfH1m9b3dSfwW4lBcynGak63zmrpOnrF84rLu
         aqGUM64rPLLF5IMcWB6/OM8u6WCuz0Zog6Xw+Anit8P2CQzHE5cIj+w0ZnEJnSduVsqo
         yh8VtWgzrWRMR0Dbd4/QjM+nfEFlNvBdY1/pDzfEJndxAVirNu2T0DiAFo748yVfQM9H
         HQR+RDw8PqGARURivkZXCIZ5VsyffI00aBeYgeaYNbSCe20sMzKrTF30IFKbeP5xDxBc
         5qbQ==
X-Gm-Message-State: AOAM533ga/FDyK3tQwvJu+cKzv0xD6DkdHElGjLjM2TjqosA6CnhMEBr
        xqkOB1WBYNXUt4Y95TozXrE=
X-Google-Smtp-Source: ABdhPJxeZxLJQyv+qgFt7P5H6KtMamGl4sOhvsmUtqfEUIQYwioHjh7BaCffwCnhf07YpOT3TSd1gA==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr2301612wru.318.1601734815508;
        Sat, 03 Oct 2020 07:20:15 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:14 -0700 (PDT)
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
Subject: [PATCH v6 10/14] arm64: dts: allwinner: h6: Add I2S1 node
Date:   Sat,  3 Oct 2020 16:19:46 +0200
Message-Id: <20201003141950.455829-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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

