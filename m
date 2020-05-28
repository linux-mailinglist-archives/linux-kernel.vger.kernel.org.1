Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844F1E6CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407407AbgE1UtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407392AbgE1UtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:49:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85373C08C5C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:49:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x14so800715wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NI5oITF3sur5up7exzC9ZwtSgcG5SfGWcxVBeWbrEk=;
        b=YIYCtIqHdfGvz+bp/GYBuOno2ziXPiDMbn/A2C6efWe0GlUnF3/yB6gC75n4H+TEJH
         axNE8iiu3suwzy791TcLkaM4wUDEz1LOGM7dmc+v/zsdWR4YPaRQdPYdidQ14Q0cdOxP
         fXRBtTCDtBGuK4Hz7vv1O2xtn3SbCUSZfJcLtNobdcb5vlK8fsK582Glx9sw1PjrSXTR
         YDYGjlBK0VSYqTIIsOM3qTh0NIJloBX0drnL2sMfJiDfa5HaxmaZk099HsR5ykIuDl3t
         3r/xBUa6SkAi9773WuXIXGpr3oja8O5oAoZrkzgZ5PLRP563+zeipN3A+Dzb4T3LCOPO
         V3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NI5oITF3sur5up7exzC9ZwtSgcG5SfGWcxVBeWbrEk=;
        b=r8LoM9EnqdGQhaWSGlLIttBJwTYk2YEzr0zyQMUgUuvdQEd4fRl2n+siG0nIdtarXN
         wIpExRd6RKF4xwMQBN6TDeSQPgmx4mmXboJmYN/lt4v0ItUdIzkoVb+iXLQj5gEvRBAu
         swGQwjGoatbVdAggEapuDml0aVXmjKSJB4mR6iYny0cDF2QplwwFJEAucReQn7RZKa4U
         VIcjQnL56k3bDOk1oiuhXQzlk/f85wmnFPUI+X4I5FwHBE8gxYzsE3EsHNcgHXsSvCGb
         GTuXUPTaefY/IsnKfEwC3r0V+zxbLZXw7pWT9QGazQjqpt32/tmqdde3TwOxIeFdYZei
         vfXw==
X-Gm-Message-State: AOAM530hljy2bb8fLwRn+TDSt6dX8prW8gJnSVh1GaFKvT3KmvoYzEHv
        Mjjt68har7MxEDnvIGLFxXbhki4li40=
X-Google-Smtp-Source: ABdhPJz/iGMq6FoO6oFdT/+8B+caaHgzgf4nNbD2c5b9TxzV8Ex09SkSVsjO3fDnHZCj/9mURqHdFA==
X-Received: by 2002:adf:f790:: with SMTP id q16mr5260464wrp.399.1590698939287;
        Thu, 28 May 2020 13:48:59 -0700 (PDT)
Received: from localhost.lan (mob-2-41-210-190.net.vodafone.it. [2.41.210.190])
        by smtp.gmail.com with ESMTPSA id a15sm7632782wra.86.2020.05.28.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:48:58 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH 2/2] ARM: dts: orange-pi-zero-plus2: add leds configuration
Date:   Thu, 28 May 2020 22:47:12 +0200
Message-Id: <20200528204712.552964-2-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528204712.552964-1-diego.rondini@kynetics.com>
References: <20200528204712.552964-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwr and status leds configuration and turn on pwr led by default for Orange
Pi Zero Plus 2 (both H3 and H5 variants).

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
---
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts    | 16 ++++++++++++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
index 4376767699a47..4cd0ac706bd2c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -82,6 +82,22 @@ wifi_pwrseq: wifi_pwrseq {
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr_led {
+			label = "orangepi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "orangepi:red:status";
+			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
 };
 
 &de {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index d8192a7483e9e..517d53e1b0ff1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -42,6 +42,22 @@ wifi_pwrseq: wifi_pwrseq {
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr_led {
+			label = "orangepi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "orangepi:red:status";
+			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
 };
 
 &de {
-- 
2.25.4

