Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA52716CC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgITSJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgITSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA6C0613CE;
        Sun, 20 Sep 2020 11:08:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so10158398wme.0;
        Sun, 20 Sep 2020 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiQXJmHs44ashMYoTEGA5ScRasCru2GgOD0BocdemjU=;
        b=B7PRL6isHznI4NCkDIHWWhpNHrY+LhmmsTC4Kos7j8Gb5TQrPrEcCqZvMV7SLXLE4B
         VpcLt6z3RDbU8weUSypJ8kf5o0VRni4900NkCwlwmpTSItgrarJ0cb3i1gOFfuhn63qS
         diEX2adifvT5ZGzgC6w2yXvcLxBjW78mRyw8xpTng24a3S8z0/Y3ojZjhekAKClwoz/I
         ikHy7Mnu3orfO1zIbMtrXtlqixC0+4TadB7tfS2WEzORoi4fruV2j8IJT0RVg95szFC9
         dieQRkqzCaaBZDzn5HPwBVkJT/9muyKmTCG1BhNb5eeNONwoEFrvLbKNQ8VHKe5+cqTD
         q6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiQXJmHs44ashMYoTEGA5ScRasCru2GgOD0BocdemjU=;
        b=HMxd3Tv+fPXH9GQZJgUmzWyu20sHflAYd4vGV5UpgFdbY52NcVJVtfSM5QJOtCdfKD
         VU+jsamP2M3zgDtkr0ius0v5LzA7K+F0uECqvYojGqWJXHGqCXwDpJ376odtm377MDSS
         uLlxl589m12Ac71WcCzLmqyjZsZaNB4ZIejoQolMTRpB9irXYwtUjggWBG6nzoddciIb
         6rrp+TuFa6U+vjf7AYMQ4Ldz4323O93SVek1LoZjjlzRyDyt5xAo/GaBJaFuZDz+d4fQ
         N10/66ZeyXUsWbDfc60/RyPP5s3l6+x21cjBc9RHOmgXneAeqD3zpi/5a7X0xbGKs1ty
         8jnQ==
X-Gm-Message-State: AOAM530kK9Z2C+z+rXDbAdMZXGtJ8L+aMiCUGv0nu5lCvkloaDOXnu7Z
        A/kEIkcAExMXuJFNKxFE+eg=
X-Google-Smtp-Source: ABdhPJyVss1kFFD6NbuSmn+YljfgPALRvl592KUINMT4YTmhgxTqI3H8r+cn+br4pP/gMfIT8A/JOw==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr25168153wmi.109.1600625304915;
        Sun, 20 Sep 2020 11:08:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:24 -0700 (PDT)
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
Subject: [PATCH v3 12/19] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Sun, 20 Sep 2020 20:07:51 +0200
Message-Id: <20200920180758.592217-13-peron.clem@gmail.com>
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

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 51cc30e84e26..ba8a84e6e993 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -1157,6 +1176,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

