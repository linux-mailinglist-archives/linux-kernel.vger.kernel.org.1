Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787242A0843
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgJ3Orl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgJ3Ord (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82439C0613D2;
        Fri, 30 Oct 2020 07:47:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m22so5765888ots.4;
        Fri, 30 Oct 2020 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=WdNk/maSnufv6lQD7+3w9GrNmVH8iqqH5NfjsMjqXFEqtE8foZTWoQarE2o3+RpUXi
         68PwhvvpVuVuQWFelQ2c9UgVyPW5sSX1DZaJQ+ZtnJCAMCHxoX3a01eYd5MQnZ9qOCWX
         Ve+njlu4hPHKuHEY5VCpfTZngbcrTOaalrZDGXq934csEyvbyhFmKeobV0OVLtirgXIY
         WKo2pR9TFOUp64lkAS8fKPbMgtrbXrdeFqBo5rKgH4aAVVmJhhztVZjdwiieCoyoQvko
         BXYdFir0vCRVZmLdKDlc7FLVKMKk1+q8ulkSN/S9Rk4G2YvYB7S5AAfnY0rRvO4OsyMO
         ACSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=L6FktjNLV8UgdewxJEKLt/8yszLqVMsdReViKPuRSPofFipEiJrRX+N+PW2Wb7QGq0
         XiPrUDVwnU9DcOIhSQqifiAOAi4BgMXL9p/mQo0DEYXv4IRSQvuJI5rQdy6Dn7TffSmi
         M0fXSdZ6swqzPtSt5yEZNb46q6Z4YKKGGoFyfnYwa6I9T9Dt/O18eBcYBcZBgmJlChNP
         4ehBW3PTGLkQfJvtpj27blSdgAvCBvn04Lyv8kGL4IWGAkhWSLrboosd6bae2ZOJ7575
         kEfnxMCbDDr50NKQpejQ9ws0q2Bjajk/pephYQmLhxzx8plXOOlxcJ+AJ+0C0etbtoXb
         zcJg==
X-Gm-Message-State: AOAM531RFQge+J45obkwessn/rUkPs6c8TgqGd0TFJLSrBeW991JXNHS
        Lom8WIDaamH+2JWMWCm2mT4=
X-Google-Smtp-Source: ABdhPJwdhY99fmpkW+U8mY6UuxGKLEsNDlligIDXRDSrvMAxcuSKIvAwSX2olqwkokvqL/0Y+3Ns0Q==
X-Received: by 2002:a9d:51d1:: with SMTP id d17mr1949640oth.81.1604069251888;
        Fri, 30 Oct 2020 07:47:31 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:31 -0700 (PDT)
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
Subject: [PATCH v10 12/15] arm64: dts: allwinner: a64: Add I2S2 node
Date:   Fri, 30 Oct 2020 15:46:45 +0100
Message-Id: <20201030144648.397824-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
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

