Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB72B3D04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKPGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgKPGUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B4C0613D2;
        Sun, 15 Nov 2020 22:20:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so17383305wrx.5;
        Sun, 15 Nov 2020 22:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=HxZLwRsL9L3clU/gWk0Q9ZInhSslRrsA3tfRAZPyQtD9eDKYPLlgBIS2bTqeZmqYqb
         uT5GZrmkK9M6Itn+7tOyMtiqZKSfXYHC/XbiW3c9doJhHlrf4LD/6+7Dr3QUTpXoicNF
         CLbo7/Mp9lNnC841ZwXezHm0M11uK0hrfFynPB/1ONz3kK2dtyP7SLUJ6HrQBbceh2cA
         zIUydObcGuEFBYCAfH1AOOv9z1FAtSN/NYKs8wdU9UkP+OvTrfosFH+8Q8xbKr3AGf/W
         qRc+862chJCB9r/dghsQ6H61/jdNXFHdKBVgLmxRfrcYdgA/CZj9Od06wJuzHLGt2BJu
         M9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=ElGMVv7oATHSnr3Xz7GLpiA/Z4As9BlW8N5dwNl0Yrig6iCFw3w9NsB+udeQJrNcdK
         Clzrfc6qGyoqCJTFX5GlDGldPeBje+E2UINaz5a6qMOBJwaA+yoVXvSirLAHJlAjrRjS
         pHKwBlXs9NOkjnMApPkwpSrY3KPtd9XrAlOXTInREoL0vfsMryvSeJslnxfaFiqCjxq/
         T1laUIXaJAiJAuJn3dTUcYeCM/gBRZjg49fLc1SEkoK7aFbqip3DhBQPV/AMgIPOobRh
         UOYGzCLAdoveK5/Hn2HE7Tl9oggeNHj6kpc1TX8yW/oti8z/gn0BgGBQEBrLEGsUoIVY
         NigA==
X-Gm-Message-State: AOAM532S4FnOUcCgCHD4V1dUui6gSRfkqynyTjTPPjmN1UC5tysLHMv4
        wqOrFVV5a4m2YuzuPTrYnkA=
X-Google-Smtp-Source: ABdhPJxWY5DjtO0AcBcOkDH5D624IlsLS+3TwQg7ls2RUOyHEZm1AaMxIVyQh8Y4+yULr/0oNbXAwA==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr17452650wrt.68.1605507645868;
        Sun, 15 Nov 2020 22:20:45 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:45 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 5/7] arm64: dts: meson: add audio playback to odroid-c2
Date:   Mon, 16 Nov 2020 06:20:29 +0000
Message-Id: <20201116062031.11233-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 70fcfb7b0683..9d8c919c6e19 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -9,6 +9,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
@@ -172,6 +173,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-ODROID-C2";
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

