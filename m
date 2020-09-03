Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E125CB47
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgICUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgICUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894BEC061265;
        Thu,  3 Sep 2020 13:30:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so4619323wrn.0;
        Thu, 03 Sep 2020 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQf32lRefYlvWpNqVHDN0Q4olqQ7nkdPDH05d5Mwk20=;
        b=mNB7LFuLunsa59ryEWxxPyempqYxfpwPFhvUy2WMjgyrvy+hAVWipxmu70QL6d0l5L
         5U0RC71ib7EWr2tCGMvXAL73SjOOJgsvX7ZwiKaPtXmgmS/AT/8bZr5OyFVX5jlzpANp
         v6GbgeFbYfMDLT2RYz4PSMIcx9l8spVWX8QWgvKXF77emPd+rjdvAIXpeQIojnuFlnQF
         T8w3IJow0iwOPLTa8vhnvuodhrZyfAVtcrb/hdW3MrX7nS6AuUuGp4+GSnyv4fxBDxHe
         8FKou8Pjy7PLpNCJ7OPPbBdLjvBC4xWGXgX4S4CprZdrYF2vQWVo2DWKd8ViHemZIINr
         JGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQf32lRefYlvWpNqVHDN0Q4olqQ7nkdPDH05d5Mwk20=;
        b=r17xeFZbUTh8qynxzT66WGdX7Arb2Gk0AtLlNqQD7ohhx1kBnsM+cqVcPooSaA5Xky
         7L7UyA7mFjWGhwg3PleeN0qT7aXD8Vsko1SdKEz3oObyqN3LjVeYTuO7pNQS2O04X9sA
         eLC6KaeS+sQGrlIOWm9+S56z7WeZRBqveFfRwtGFCCg0U0F+yJl2C85DzaLjaMfXt6Cw
         7qYQGnOQlXKydXu7mlj11ABXRMzfowfKxhaBwlR3d3VpH+uLUAmRRf6bGGCS9Id3P12E
         ZDiNolqQgQVqRwiUPOiUgta0+T+ACqXApl3MWjNfIaJiG3XkaaVLm5MkWO8CzSSDPdQu
         Smbw==
X-Gm-Message-State: AOAM5313QiLZZ8m7sFudI+TCmy+c+96uHDzYWONSB0IAn3DYqnuu08w2
        IeGrlNSugZDtYWA9k7yQ+7M=
X-Google-Smtp-Source: ABdhPJwV/D5vEOt7HiGayfYHGwvmD+WzmO5fqpG1aehEipiDZFdrGd3VaUCsTXMp0iDFlDyazWYq2Q==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr4159015wrm.422.1599165057172;
        Thu, 03 Sep 2020 13:30:57 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 12/20] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date:   Thu,  3 Sep 2020 22:30:26 +0200
Message-Id: <20200903203034.1057334-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8dfbcd144072..bcf808459edf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -845,6 +845,20 @@ i2s1: i2s@1c22400 {
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

