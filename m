Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D832716CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgITSJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgITSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FBC061755;
        Sun, 20 Sep 2020 11:08:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so10328399wmj.5;
        Sun, 20 Sep 2020 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUVIxl5BYolVip4ZPyodUNNPga8sBfd676yD0NuAt4Y=;
        b=I1O2Oz5vJ5hmtMequ/rmJD9dirDkFPgLdWTPNvMmsquGFxkPmoTk8I211PP7GODFCv
         LQiRgIZKOpRnOIAXHInA9B7LPMOYhbG5KUFYFZoYx+pA904iithKgcYUY3+R8s+Ai4Ku
         DWhFx9NEGKdRw4z3JygFvPSRW9Sy29b03sf/VRwbkFF2aZhbAtNHPGThtv0Fb0DLFUwJ
         4ZhKT1WmfPZA17mdu2PDVbhkp6gbE7paKmLX7d/PS2jA7ydvV8VdQgU0B24X2efNEU3B
         DsjMHV3h9XVPbEgV0UmWeHYLrrUn+hGepoKa/vitylfLkVPE2LI/kIfDORLDuyAMXpza
         Q3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUVIxl5BYolVip4ZPyodUNNPga8sBfd676yD0NuAt4Y=;
        b=fuwHssPBrjIcW+00g0/3ApcyLmk4rJDLAfcy5MoKbjB5ecYwJGiCZHW8xajBi5hMrz
         16CkGZZ5tN4SdJHNXtTUEMpr6Xax0R2/rYUeidvgU/YltUSuqOcaJrCcnssalsEXfCDW
         +KJX40v67uNSPlK3IuvhMjm1zp88MjhEwxX0irt0qjVTv6ql9ZVCH8pmbkMlsusulQKH
         mGl+UrrVdIKlj4UEZa3LSGIugcCyc+zUCU5xxuz/4E9ZKagOg6VEX0pTxZAL5l+Q0U+p
         mylHN8YtLByw6rEwwaYhNXF7QPcCHtXyCricoFPRunHlv/GsoyMXvzGYuopiCuoZ7G8k
         IpTA==
X-Gm-Message-State: AOAM532OpuftL/j1ivdND6AOUorWHtEJsop6ldNIRsAdrYYPpQiY4a86
        aks7Hp01kglWYCCw2mAkBYI=
X-Google-Smtp-Source: ABdhPJwujdcabqh3m3yBLIvG1kcB7Nia28nCy0y1YHr4Ak0EWDYkczw2aBUWc8DKtkiuy7WRmkyh+A==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr25736377wmf.82.1600625303592;
        Sun, 20 Sep 2020 11:08:23 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:22 -0700 (PDT)
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
Subject: [PATCH v3 11/19] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date:   Sun, 20 Sep 2020 20:07:50 +0200
Message-Id: <20200920180758.592217-12-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..51cc30e84e26 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -846,6 +846,20 @@ i2s1: i2s@1c22400 {
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

