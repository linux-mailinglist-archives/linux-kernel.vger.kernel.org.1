Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC92720F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIUK1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1DFC0613D4;
        Mon, 21 Sep 2020 03:27:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so12040828wmj.5;
        Mon, 21 Sep 2020 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=cjoOunCbxfCsZrnr8q13EjVFjpa8QPlF72/+TVBQ41JAsi3GulSL2W8KOiUjbGMUEt
         kHK3ESOm6IgP4rx7O7GhZ1hsZ4sZeV1s3Xd1pzyxP3DkEm9p9kbmS1gQEpo5fAnszG5X
         bfpKmzlo++rpwdGNnBTG9npDJ91gqPl2OD3v3oY8MfF7XmK+NdSbHCl9VaOFOjOkohAD
         ZnRVdJYQvhU1yyn6n16C56lWyKCUQXlaA7k7sweLlg07r3hKss6EV7ykeFfYoYdrpvkL
         KbGzv2iJp3IgTj1nCuQ6lYyD+Bio42VQFGS2fpdjOSyreHEY6W/lfn54ou03pfneQew9
         JtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enpKzUiBmoSBJ4eITLO8PaawwyRhwbwKqDOCyrD6nZM=;
        b=GUy3+lsnuOnIp1tVDN6juT7Ays9KKifU4Zq/QBjzIJ2FgjHmqlvuxGBDcBK5vTjtLA
         pPfsz6o+B70io+LCa4sN0lqEIoqRt4MemPDE1MoiniyUTfdMSFfzioWo6o0OnnYbRkGZ
         MJvbmVNr6Pyus0At9Sj6Vj1H5pPUHISjMnxZoPrWQjrjGtPtHPLqCbNKi3uyUjAozsI3
         QCMRWts4d26YkfUKvEahaZwUNpGdjxTgvtseGz2zWRl19V/tXl2VeZHTtx6GdmXUkb3t
         Y8hfIvyypyXnEo80WnHt9IPGz7roqqx63WxXSggI1pW9NCkI/3/XrRmjbJKN+X/CJsNy
         Tl5w==
X-Gm-Message-State: AOAM532eJw/CjXgu1MVzqaOFKyy/WQ5rzAQEMYZynIRJtwzwuWFS1cNT
        pfY9ZS1bZRgQx4Cl4y+CrPs=
X-Google-Smtp-Source: ABdhPJx2PSrk+As/ort/HK8PkUGoNOih3A4NMpX+w71lYU7pO8aA7piuuwkjxsnL7bkwa/d6nopflQ==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr8081528wmj.123.1600684069140;
        Mon, 21 Sep 2020 03:27:49 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:48 -0700 (PDT)
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
Subject: [PATCH v4 11/22] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date:   Mon, 21 Sep 2020 12:27:20 +0200
Message-Id: <20200921102731.747736-12-peron.clem@gmail.com>
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

