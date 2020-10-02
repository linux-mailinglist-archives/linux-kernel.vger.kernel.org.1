Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0728152B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgJBObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbgJBObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46AC0613D0;
        Fri,  2 Oct 2020 07:31:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2051925wrn.13;
        Fri, 02 Oct 2020 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=EUAtA80UQvGNQ1xuv489KMoHytHnOyynUzzXh4vFWyfNE6vryCNvSPb6JE38dse+ty
         Owh/rlSQHrpE0vJycQQ+QDzCO8fG1uONM6imaKPYv63KmwBDNIhatYiEPGNNAIU3jZGz
         i1TeJ0r/WW/kDo8ChFo19yQ7MSTbS3FnKkBfXh4hFobaaI3ZL/93eODs3bWXCRbTrxLK
         HAxfnu3O9NzWEwp9yaGiyRcmzC2ZAvpwUCGGnnmygy/otUm7UntLxRroQ+tAENGsmvli
         oMzZKouaZzWTGXn8LJAAb6dbMEDMe8Z56rWOCdcWk8NFzZHM9JLTgDist40BLDjKIXlV
         cnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=kkDFTVzAb6jQ2isGoj1ot6ZB5GZAqolgHY7a+gAnUOzhzfE32VwIy8danXn65v8Juv
         MOOfjFUSNTsPNkNtq+AUFjy66F7EmEewZVh/7nmV7SL0EKtutUW0cXuFMVMfC/dFaaXF
         toB1PBtMQRG7MNgLXqjiVnCJSGojvbgDLqOKlmN0aHbn4XF95LCScL+UQa0goMACC4vH
         km3EFGaKsEJZe9HYAIgS/f8v9DNzESsbHIEyL36rqSCtH42+Iowvk3xr/NxWigyNMjuL
         eOwNMGk3IPns6T6kgDdcO0DVi05SNOnUmxMnhHTfZkqioW57ooLzvNjRvzOhWeWt70Wk
         DCcA==
X-Gm-Message-State: AOAM530CWO22d9MxyUuQeEubGLvuSsLXfQv71DPqGp4CqZiWQ3cbd/+W
        1pzja8w6V0iMVjTeD4ZbAquN/HM0Eek=
X-Google-Smtp-Source: ABdhPJzZyEF2XAzBOv8Q+l28V5KehUzLh6WUUtuevsVRxVzF68N3vnbNHOGFmHT4k6vXTbyc1hxBCQ==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr3672712wrm.392.1601649110552;
        Fri, 02 Oct 2020 07:31:50 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:50 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 02/10] arm64: dts: meson: add audio playback to khadas-vim2
Date:   Fri,  2 Oct 2020 14:31:33 +0000
Message-Id: <20201002143141.14870-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c70..d4734220443c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -7,9 +7,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxm.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
@@ -145,6 +145,45 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-KHADAS-VIM2";
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
@@ -154,7 +193,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-
 &cpu_cooling_maps {
 	map0 {
 		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
-- 
2.17.1

