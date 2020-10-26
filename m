Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3F2995D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790931AbgJZSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42779 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790874AbgJZSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:53:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id j7so13866387wrt.9;
        Mon, 26 Oct 2020 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=DIqiIhUhonx804JA3IaeN4hYc06KnnU2EF1HKTwHNUhQNo9r3vUj0GlTOnUeYYaOfp
         OwS1wS7/1Nc7Tj+8oDShX9ZS+alIoPCpa092o7cB6hNb46HA8Woik4JR2hmwEoHtyFAH
         ubCydzwQZbyED/0Q/+ZIN6a+9CWlOfyDJP+bODHkx7B2Kdk4LBro1mm4taAYttUWjBlO
         T1GFKt0B1Zzh5ENqkUeVQW6nbSJnFuvkXXPwJjfKG5qViRhNc6jpYrkCYj80JNWk9wQb
         z1Iv2Hqz7m4AGNEICuni8oOXh59dlODCdTnGTWZSuOPtWqfV1JgINpGqiL25tmrW1Eih
         ltIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=n/TwsFOwPGwZA1Isr692IiHHeO7AfqXjekq04HgYTwclZP7Z+AHBcdnWYZIaonHl/b
         1P6vfib/Laow5ulHc5y5fFLRbdz+IRiOf4/F7i9KfU8BJvPI7FW41THJJ4Yzk03Cm9Ct
         g7mN7SRuL5dGebD4+/9tRaXEPAPEczP7gSL2OcOva6cL4NzxzsVvSdcegbDTXrLy6GPT
         toirLwhMm3ZXQ7HjwZwAhQmpTvS1I9Lcsa0ZMaUqOXs3BdYMDgTdSoyzwzNyhW7WqumT
         AB0nSVcvxIhFsbINvwlqxcPgVj4Zb4DV+sW+hfvmKLigpf/67Y8G53YJgVpeqdR9YNfE
         TynQ==
X-Gm-Message-State: AOAM531gC6xd4umn4HWOBixD3iOH2WitN2hbRtw8COIZC4qHHP0atTyt
        FgW6KgH8U0xUV2rEs0/w4Zs=
X-Google-Smtp-Source: ABdhPJzt15q0t0XPBPjQPAJ/s6VmWe12hX+3q3e0QEM0Az41sDuRv5NLGwZwVlcatelVl1YVh6kC9w==
X-Received: by 2002:adf:b787:: with SMTP id s7mr20510174wre.390.1603738379048;
        Mon, 26 Oct 2020 11:52:59 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:58 -0700 (PDT)
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
Subject: [PATCH v8 14/14] arm: dts: sunxi: h3/h5: Add I2S2 node
Date:   Mon, 26 Oct 2020 19:52:39 +0100
Message-Id: <20201026185239.379417-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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

