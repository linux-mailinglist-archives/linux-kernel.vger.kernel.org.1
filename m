Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AA1B2CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgDUQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729268AbgDUQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA3C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so4482374wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FeSfq0SbFRvsjsae2dqUFLAosEvVfnKGKDeV866Vd0=;
        b=joKEWWbecQFTGp49IdUG7AVVPBsl5IGLoYWVU3epHWQrjH3uwn4E5xuirg0zYfDd9p
         qhFW5/Gj51pBAGFHoX3zaXQ1SPx4XoDq7KJ8lF7YgyEvBSdKZlBlA7k+C1hQeR4ICifq
         2Zu1rRRr0QRl6aC6fY1pY96/hHL5UP6yHh5ExYcO5FcFQvTAxXVu72uqi+ixLpIyrFyR
         nXh+8HOi8q4xq5KOQLTJe4jOWSaDk/HJ9omjJ9W9UayDpAf2S2mDoieQTxys5nhCJUyS
         64KAeZm5A7g26tYosbyYgEnIVNNegXO+2wtt91H1YSYKY5nD0CDQkV+OsgTnce29XvNc
         nRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FeSfq0SbFRvsjsae2dqUFLAosEvVfnKGKDeV866Vd0=;
        b=BSyuQY+GBeOI4gSU5H9CiwsI0UHq5Gu7NW/bJG7dFEjOhK6bt9Q6BkVw3BDPDEI8lW
         M7X5zP00G9nIx6hin/QLlxxDGXuAVJ5DsMaLnGd+76niY9dEFRI/KgQpj+9OKaenqgKb
         t09uRdlkea++D7GLldioDrVm8dg/nEyAMtyoAxoWIJxKOUwzr6X3OVrT61JjDXxTG/Ou
         1UCqWBheP6fll8SxYhVHZrUgE8rM+RDDXF02T9el5b2VnTR1DNT8n2auMjvw5Q1NE2oN
         bZQgkxkdCT0h+pnYC/sJLUdZTGtWdictZ78Cskt34UcNkuS/sTT9gdjuakez9HscKQnq
         IlgQ==
X-Gm-Message-State: AGi0Pub2EvUZQji3ngLpKoiFsh7atgn37Zxd4og+8yqh1ffOEKQKEYU5
        zmeVq0Z+TcAkE2aCYCdsB8LEDQ==
X-Google-Smtp-Source: APiQypKXTtJbQhO+15cTo6RFP4JjXspUh3zBUvgNI+9LCngm2igxTtUgqbu8jjjG5I6HtgtzrMeMfQ==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr5871123wmc.67.1587487185355;
        Tue, 21 Apr 2020 09:39:45 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 33sm4578513wrp.5.2020.04.21.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: meson: libretech-ac: add initial audio playback support
Date:   Tue, 21 Apr 2020 18:39:34 +0200
Message-Id: <20200421163935.775935-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421163935.775935-1-jbrunet@baylibre.com>
References: <20200421163935.775935-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 4d5949496596..3f35331c1652 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 #include "meson-gxl-s905x.dtsi"
 
@@ -105,6 +106,45 @@ vddio_boot: regulator-vddio_boot {
 		vin-supply = <&vcc_3v3>;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-LIBRETECH-S805X-AC";
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
2.25.2

