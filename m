Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B92720F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIUK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgIUK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E2AC0613CF;
        Mon, 21 Sep 2020 03:27:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so12118969wrl.12;
        Mon, 21 Sep 2020 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiQXJmHs44ashMYoTEGA5ScRasCru2GgOD0BocdemjU=;
        b=WLk0wH/mK4n85uc1VRHFLjUPKgONu5TaQ+ibzedASzLy4lCff679/K22sn8956Qe4Q
         qW3qVKkGajGEoVXdszvfzFW4ECWXL8S8PBIH0dtEgNXM9k+vw74VDHTg7ubOP9F6jt7f
         ioDmaB57m3B7XTIMWDeinzUAlpYjr11OxJykny/trLbrTawrodt5SkvQauMbaemkgkUv
         oiICnrsW3qMf5cJrIslte8VzP+jaUHfx5K7sh+jk9JeFmUdcUznyeq/6hkXDH2ZXf6as
         A7jYlTINa8ZOU5uJbZ/GCsmR2RIeWl1aCZY/jXpej4FYx4eV80+IJdONfGLC9ZO52ypT
         p5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiQXJmHs44ashMYoTEGA5ScRasCru2GgOD0BocdemjU=;
        b=Y+Wm4nKoIAzIODamiVGDyCdMY8/CuBIOTGHvbAoTtI8nmAu8HUFcaUBePQW0tCYUQ8
         v213s61KBVRqCI+2jbhIeG8zBvpAOpbTiwgPqMNs2QoDGuEHca4DdSuuC0G1JRW5rgKa
         FmTJcYC5eDL97NIovPpCg3/+kOqtZfPDu4rGXxtjq6vMh5z3lnrSyQ824cne+TYVqQu1
         uWBgqS+qVrG44kdm3JWdE6pGNOqyHDcIZIZfdxCo8KoFVz7LrKOJEm/CbwjTVHbV6F4h
         NPKd9ZgeZgo+xpkjAd8EoyJSBS1hHscuxHhmndEiyPJPzSFRtUmvbbY3w8u4DBMhRFt3
         F4Zw==
X-Gm-Message-State: AOAM532wtBpOFeal9mT146moHCpefvFLwvhqNdtPpz1aiqXY/PKLTUXX
        RK9aWnb2JAv/IRiof46T1ss=
X-Google-Smtp-Source: ABdhPJzv+NI5Nm0iOLW49x1D1Pz942Tv8qfyBpUYUxr2rRgNqqKnd7n2Vcsar/Ee1uEXqkAV7fVG+A==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr51098543wrp.310.1600684072722;
        Mon, 21 Sep 2020 03:27:52 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:51 -0700 (PDT)
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
Subject: [PATCH v4 14/22] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Mon, 21 Sep 2020 12:27:23 +0200
Message-Id: <20200921102731.747736-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

