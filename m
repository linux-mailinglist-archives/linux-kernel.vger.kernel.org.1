Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E522716B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgITSIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgITSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA5C061755;
        Sun, 20 Sep 2020 11:08:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so10434466wrn.13;
        Sun, 20 Sep 2020 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjb20+qzG//QXYZPPH3YllTlMZ4wlxmmKse+Y7AgH+E=;
        b=vEmyQvKjJaAXDUj/rxXMX+vHTZTCdfErxj7V33up2yN3JYLREihy4L0FtbdAhmEWcR
         8uYuEP9RBDhpgapbDdfN5EN3XgdkQYbBaOfNWQEUGikrm6ZCLPWK64NNns9dIPSkqVQG
         Xug3VF8VJuaXq5bu9nUlrxA/QhMKroVfaSXEcgnV2adO9YBZNTLL8x01WobILe8ILY61
         zIVm9JjGvuKNMenYaM89i0uoljF4nQIMh3V0hvYqWWmnBpXy2dWf7NmN5tbwmOjFFb39
         7dCSU7Q3up1ddGj3WiXufn4qrLY2o0gSP45MyiJdQNf9j/RmK6vElRjUOjlALkFRmevV
         B+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjb20+qzG//QXYZPPH3YllTlMZ4wlxmmKse+Y7AgH+E=;
        b=c4e03bGHVb5ZN83Hid2QZYOftagODJXZWXwMVmXk9jkDXutEVQrOY94sfLdJa2pBjy
         CMTiGEFSap6IyE8CxEjc1Hcm9wfDGkYNeK7Z1Y2qBeuwY7fmOoNAa9RdLspExPUK4XbR
         V3EwxRgKFpANkxRvSutPiIxEKbG6jSd6Mi/YNhOqRocNgsciuXMmUyCamT1oCygyxLkC
         uLi3+LJbDfF82UdetNc60tAtutX/mHWAUVsYwSSCqrqi8wE6mLY0Ugb0q5eOTYCZwX8g
         WSaDLZ2mRJK4HeQQz5Pk8jgpJxYplrWQWH85FmT33xEoIB2f+8tAvs32dQ5nccu53ioe
         P3dQ==
X-Gm-Message-State: AOAM531ReA49gWoc3MNYJ3dry0vHF6w7O3CvRF5WLUduqS2ZeDzmFEu0
        mdQKdHqS+o1yWyZKJ+nhkEU=
X-Google-Smtp-Source: ABdhPJwQLbwAbHuOnHksf+G9cX2MKV6L1THeLclz2qL1+zagG0AMM4cwPSaCppbAgaXKAR/xUNJ1jg==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr46523685wrm.136.1600625302166;
        Sun, 20 Sep 2020 11:08:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:21 -0700 (PDT)
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
Subject: [PATCH v3 10/19] arm: dts: sunxi: h3/h5: Add HDMI audio
Date:   Sun, 20 Sep 2020 20:07:49 +0200
Message-Id: <20200920180758.592217-11-peron.clem@gmail.com>
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
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3dca6d89cab9..7168e9412410 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
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
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -806,6 +825,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

