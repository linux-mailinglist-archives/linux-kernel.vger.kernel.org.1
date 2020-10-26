Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28822995DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790946AbgJZSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50590 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790531AbgJZSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 13so12723231wmf.0;
        Mon, 26 Oct 2020 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=WlXgi3ymiC/Ubo/PzKwduzc4BIThfTVXjlRLU4CHZSknn92zErmgO84jYxWUTyYyCL
         YpSvJ1XB2cYCyWzRrpdXYjdiMMprVs9FCJEXzR+p43kkMa8G16C2Pvu+OXyxdMwoqRLL
         EX4+mlJqVx92boQCiTBE+aSCk3k0k/eoyEh7kRn00cVnvdgGhZC/cb8uUYdLcmDjJ3wA
         54kjh2qL863imX1xYwi/ZFXB4+kLiufojw1o8LdLKOD0/+MKmIfHyqJ7ZcdV0rbKtVNh
         f9dRRMwYxBJXg8yaIXWjJwIJpnbAUQlCnpm5qXwRaV4trcvTcDHUHXE5oBUy8Jf3XXp/
         qZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=bpLvcVzTNyz4PY2bBSl1ysh/YSX93Mw++Dp1tyIAFpQxKEt/yWjCBwd7w/jUaJ82L1
         9SU/w3+mNle9875D6gTFn+R2S8aOYuZnw6rzBlFi6RTGvQ9BeLucI92pYw07EkH/Ym4A
         01j5WPDpSBLE4L0VFLfxkfXDhLKpRSUjnsExL32vCMbDn8FqY2UsSZT47tVEv5Vo3K9B
         lR+K6eDZZSCRoSsw0dwzMH7GLgkUVi3ylFo4v1HoWp+RC9bVNJRHp073lTvUJueMHuJ0
         G4bjGufXYWd5qvVP876mTJiXllXny4/opezRHvG1YDUN+M0vWu/s2AWoC2J/rycxHlMa
         Lpbw==
X-Gm-Message-State: AOAM532uigwuPLz1uUMguhys6gs1yZkWRDsXhweB3PvcporUAgUqcuUg
        +FDm3klgCdydXOGbIwOFdeM=
X-Google-Smtp-Source: ABdhPJyN4CjTNG4J5Ml9NRNFEcWr332Wcn8VdYW4a5pi8ZXoEXVceEdrWEj8A0jVkbJ6B+hg437e6Q==
X-Received: by 2002:a1c:48c3:: with SMTP id v186mr18754491wma.16.1603738375499;
        Mon, 26 Oct 2020 11:52:55 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:54 -0700 (PDT)
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
Subject: [PATCH v8 11/14] arm64: dts: allwinner: a64: Add I2S2 node
Date:   Mon, 26 Oct 2020 19:52:36 +0100
Message-Id: <20201026185239.379417-12-peron.clem@gmail.com>
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

