Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE52716D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgITSJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgITSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEDCC061755;
        Sun, 20 Sep 2020 11:08:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so9971066wme.0;
        Sun, 20 Sep 2020 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=UA/bNOBvqES4EMfHn2jBa9EyeU0LlGxVDZSMK5WGe8KvOZHQ9K5OsXk2ZMtz4JROMQ
         DLiSNh8tjROvD/XOTJSfJsywKG0IYVV8mgL24nwPT25AUpXiQO9KMv8wDuArzm5Wz0Wi
         aZWiLuI0Gz0KTdsNfRx7FQEN0mqdlX5mb5njBgYKsYihfcUNbYp2Dz6zCSwJ0crY0z0o
         Evq5G9IuAIZWTqiBApruFWOdgAgDW/AzaSfvqOsxGcle/jQX3q8mij/VlHU8NEwAVhrO
         bY7hnW2XpgZKQNne6H8APjP+xKgVdd2cEdcgjvZjyB5Xdv5cjKY+HjX4RZ7fX5LSWrS9
         SvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=VQda8IMJdwSZcVZ7c7R2lvd+h6w+V6F6veMQeCzDITIpN9VgxqJqIZVv1/s0QCVL0w
         +Se1UpmOFKvC0/dRCt5m5o0s4vPNzI18bJNURqMifBJ9/COZbHqcJPhbsPRue7jvE6wy
         z6l73hlE4xgFvbQ7vYDm70QKUIfY5RRJ1iOagPiVSOBHiV6lsF4AtO5mn4tl5WvlH2MJ
         //qNwt3CetiuaqEdl4Ibl4+mUSLPOu0k17JgHIJSkEi9iDObj5QeDjoYnDu/Z6txpA00
         LjaaWs7qUKjZElE0bw3aL77NWRPVaORLhd4IUxZsUp1V2jvf1OMEp2/+sqKgR4hvipT/
         ixHw==
X-Gm-Message-State: AOAM533FzbniOSEPf1scXmGxN0Gr73LWFOA0LZt9YfiHfAXvZr9f6MjQ
        //3JwqVuIFi5NYx9DE76tKc=
X-Google-Smtp-Source: ABdhPJwBZG9fnJ/nzYth4dqCC9qkwA/eO62i803OIxJpJjI7Roty7Cf7p6PqCCuvyBuyGUi/lpTkRg==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr27212181wmb.171.1600625300928;
        Sun, 20 Sep 2020 11:08:20 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:20 -0700 (PDT)
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
Subject: [PATCH v3 09/19] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date:   Sun, 20 Sep 2020 20:07:48 +0200
Message-Id: <20200920180758.592217-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..3dca6d89cab9 100644
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
+			dmas = <&dma 27>, <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

