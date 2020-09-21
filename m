Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EE27210A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgIUK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgIUK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A0C061755;
        Mon, 21 Sep 2020 03:27:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so12169740wrn.0;
        Mon, 21 Sep 2020 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUVIxl5BYolVip4ZPyodUNNPga8sBfd676yD0NuAt4Y=;
        b=IHedG0vW9UU+XQPNRqvk7Cb6wMYdd1thMl9pgjksErL76FaiLiwWghXnrWTf2PFPvF
         RIEodkMANh7i2aEWiNi5Xtz/+SsDEgtM9I6QLVvbFy3+qwSPnsVXwq05NmsI/e8Aoqfp
         hzLbxFNQMpW5arNozbwAC5i7ciwAsMJnngQfwWed/lDJZHru8N81RRhS5BbLzsHTgKCL
         xGxdDvmXt/FOlCdDy1gxhs3sHwvorAiIJk5JFRb+zTzDvsHEMHE2BvgewxiQR1wQnl3E
         i3IUPK49t6YPngxCUZwfr82Xv2FwkpArekDImtJURFqh4pw1a+bKmN4OEc1yTh5NsUpN
         D9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUVIxl5BYolVip4ZPyodUNNPga8sBfd676yD0NuAt4Y=;
        b=hugEOcvr4CPtC9cLidY5jDYm2u+fMsaG8eoOvBrF01hl3rYnmWULB3aJlO/BphYecM
         EB6bzh/3schPNuhaziMVfEwY2XA44XplEBDv/j5BPed0CNQhdh0iWd16Ootq884GloSH
         JQ0Y2VFi15UoTE0hjzsCBH+Z923MJJHPoq6+3QRXDxYzUazg/7hALfjueJ8KnZ4RPbot
         aUeYOPB1CUrG6Le/qB9lE4r/M8OTma+QexFIlhIZGKapWKZZpq2mMfIkM8KJz7d4qcxZ
         Qrfo4hBZr5aSXSspoBRHPOir4I+dSrTzKXHTj49HKyMHvWU038Du1CDJUYBnBTSU22hb
         n5bg==
X-Gm-Message-State: AOAM533CxYJf1SxntYlPkFVMx9NIOA8mKN4ZoYhwP7+C6WzVozvoWm5B
        OAEOpFEV8TODl7wtGXiGqMM=
X-Google-Smtp-Source: ABdhPJywGur0//dGuTvYT+x0vHWsW6qDoeNQvEl5jqNVb8ymdsdvTJ8F0ELiftzQUySC5ZdJY9VZdQ==
X-Received: by 2002:adf:f011:: with SMTP id j17mr30143476wro.276.1600684071510;
        Mon, 21 Sep 2020 03:27:51 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:50 -0700 (PDT)
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
Subject: [PATCH v4 13/22] arm64: dts: allwinner: a64: Add DAI node for HDMI
Date:   Mon, 21 Sep 2020 12:27:22 +0200
Message-Id: <20200921102731.747736-14-peron.clem@gmail.com>
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

