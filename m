Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26C2CCEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgLCGBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgLCGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C1C061A52;
        Wed,  2 Dec 2020 22:00:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r3so630308wrt.2;
        Wed, 02 Dec 2020 22:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6xywWA0Bg+0Yb66SGd8bpy5ReZjATNnwobMf9jnUk0=;
        b=txM2XXYv+owk/t9tGZPgZb5z+KXtTKNy9WLyz4ek8IXqPi719LgMaQE42ITTlwr199
         Mq+uTy3TOa0Y6nQnzhCNcXLAgNxVdTwZfqx84XO/d8kMTxAoOcF6g4OROqWUbB9jp0mC
         I1x+WNlMcYFed6KGp+Xavln2XueFo5WK5HXPK+QZj7/8aNbWXfSGDj1em/QOSqdBPYba
         0xzM+htnHeA+6Q64eLyYWtg+ZRMOsjr2oyWQY65JTIcMsFxXJP7iOKVAOMkZFSUOBDbk
         vmg5mnSrclfvSiNQ/eT12Pwz1/LsXnAg2SmtTHFJ0dCefUEzNm0MFTQV/jM/xnY+ned4
         suGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6xywWA0Bg+0Yb66SGd8bpy5ReZjATNnwobMf9jnUk0=;
        b=QSCNdq5DASmWL0Ln8NnF5pJvPtYsaI4odSW90R1/JOWVCGXgiAHh0g9xg16rbmHSXa
         5zVNJJLoLXMProGQIhz9ZC278M4jXzmRc3conIubQxPQyDm0uQJHCFPBD9P3KVjpBxyy
         /Q5ZBHGsaNzI4exT8gJoatHrNO3gK1vmdF35gLbnxYlTrY2OYu0fRABeuSn1AJlcab3X
         473J9/2CrMv/Vzffq7BDi6pGKWrX8vTD/SI7IR37jEKiEfqrNcptup6IN86kwQOn1bc4
         fSimB/G/loNixWjYuGqAyC1huMTY5bIHxiD54p0dpJN9c4riRcqKfbhem+3zMis6Ei+2
         XCug==
X-Gm-Message-State: AOAM533/3lOiYtumQWjDzn/aME6ytMlgWA0+xW+w39QCVnNO+dSvZQwg
        mV5j93u0qR3jLp+yIeT3bws=
X-Google-Smtp-Source: ABdhPJyw9t2B/075IWN9syQsHo2Mci4h69VZm4AOiLICb2Jz/0++4DbImVQOULxhNLZGWx2hN6B0GQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr1736698wrp.51.1606975236662;
        Wed, 02 Dec 2020 22:00:36 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 4/7] arm64: dts: meson: add audio playback to nanopi-k2
Date:   Thu,  3 Dec 2020 06:00:20 +0000
Message-Id: <20201203060023.9454-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203060023.9454-1-christianshewitt@gmail.com>
References: <20201203060023.9454-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7be3e354093b..8e5df00b06a2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -7,6 +7,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
@@ -130,6 +131,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NANOPI-K2";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
-- 
2.17.1

