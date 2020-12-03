Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E022CCEF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgLCGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgLCGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C4C061A53;
        Wed,  2 Dec 2020 22:00:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so2582318wme.0;
        Wed, 02 Dec 2020 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zSxt96h/9Fwk+2Z2TEbldRZc+6ZVMG3i55XI3KvBZvc=;
        b=VFvg3Adxx0ksKE22uUwcKNp4cFVzM4T5QUBNmhSnxAnJLeGjsCnEdZjvpx05rqcDYt
         kJRYD3pAYdRfpw3DnMHK4fIMJdYQrx6tb3+lkWeMCZSZQTxSc3aPRrulmt6Ja4cJqYi+
         G2MqocUhvUS70aSpU7HT9jCWI5bfok2OvUN8c8IiuZogL0diSXSEBOScZeFwSVW1HWib
         2xXmDOHbZjLbRNP1KgPOqRwlRGvE+4DaUd+mOexaca2S1K7i1MLRW82hbSv1j+ipfAFg
         5tI3RAHX+PYc5Ln7F0tbgQwdM0Mt7K7E7KjAgdw+uyUo0oGsHlqIHtiUZDTUDyIxbyzz
         c/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zSxt96h/9Fwk+2Z2TEbldRZc+6ZVMG3i55XI3KvBZvc=;
        b=UKVkun6cIFGKi/03r0/B6CsZvTTHsZdVFQot0aO4yxFLR2xGo4JHmEUNI6kk8JeG//
         LG3588hyWdK0vsJdE3iAfUSYEOHqqqhbdZDXRVmQVSl/Y/bHGuG4gCRqfLanpeTSWWJQ
         XTY1AikGgdW+Ezwm+F108x/r41QU9ssjQhxheztuoK/FS3K/ItolbqqYJvII13oDfxTu
         S2PeaMRir8KBXgPWp0H/8gqDTVj3l92KSTachp18Fa84hSIei94eZYQTvUqv0ED1WNX9
         QU7LdMKL1DhyNCbYHKKxInV6cO4TXPrmEnVJKX+CBTEst+tzUJeycoxK737tG7Vl1AUh
         Q1TA==
X-Gm-Message-State: AOAM532/klUDFq9s0gWMANPceoKgwq5smxBF+SFxCVDcrkRDF5Ytl5h3
        AvnsgkDGS/LBOJ4+V9fZ7Us=
X-Google-Smtp-Source: ABdhPJzHmIjDKNbLIWfBgHU0/GqU0Mf1N1LiuXCkgkMfJTjxj6NxVrWbNX+KayAjQr2//5v7SJMYLg==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr1360920wmb.162.1606975238897;
        Wed, 02 Dec 2020 22:00:38 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:38 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 5/7] arm64: dts: meson: add audio playback to odroid-c2
Date:   Thu,  3 Dec 2020 06:00:21 +0000
Message-Id: <20201203060023.9454-6-christianshewitt@gmail.com>
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

