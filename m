Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260E82B3CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKPGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E3C0613CF;
        Sun, 15 Nov 2020 22:20:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o15so17371658wru.6;
        Sun, 15 Nov 2020 22:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=W+mB1NlC2H1+vj/gVQqlYXnEWkHgsAO24vZIi9pz20IpYaV3YDCnVnm52SEtMu74ga
         0prdFzLY4GzBCBdbhMTseqWN4nD1oc+NI9ivyc1E/v70v6AALE0oduJpAwXpyLQ65x/H
         ANSimfsx1NIZZhGDXF679gmF39FrgbbjFaCh/CjL0rNkmTAf6ydFE+9+0/QI43rpv/Xd
         9yLu07nVfpJYPcaB1T9nqTj5Wd+gSAB0R3HFIbY2q34nEO9CSZ+DO/3tYy24Q6rxn5aO
         VsAZV3pbjAREiN6UXD192tyiOXQS9pVU4lsEEcJNc+fT1FrNYtlZKpH6VCAELG492UJV
         R/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=l0UeuB+bjF1uoTvQoqxLIXTxrvsj5NHEX0nwmkdmj0yE1pwYnoaeIhlAguc4v4kfPX
         9hVcicSreKgrzjVYQ/jAE0R+je6gF2FRhK3Q1N6m4ioqhCkWdS9IHGRIKCizgjJ0EXrl
         hFMjpXX5NqVNvBjjsZA5lsHJRlm6Vx+NXb/+gHK5mzRKtIyBMWK1HUDZi1ovUDsGeyG0
         YRWlLskrVZtVt5iRv0lL/81Sc8cGITMf+eZkBnlh+USeFLcg87qJVbJQEJRpTy01Ols8
         FY+xakr0WsDkle+U2esPXP0/sF1Auj6BxRsPr1GDfoEWB4wM1NrPVfZDWF22pShdXUuJ
         greQ==
X-Gm-Message-State: AOAM532OpWYoBBJjmQ6SrO0A7w1XUnCXmSRVNoi7EX2g5hzzbA4JHi2X
        CL4O2Aq3p4U4IaTRNnIaY03gMaeBSyQ=
X-Google-Smtp-Source: ABdhPJw1jWE/jLVlMkHw4VsyWrjjt8pDzvDYLQhanqj63agvp4cq96/BakhhffvQIMqt0u063QVVUA==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr17467481wrn.208.1605507637390;
        Sun, 15 Nov 2020 22:20:37 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 1/7] arm64: dts: meson: add audio playback to a95x
Date:   Mon, 16 Nov 2020 06:20:25 +0000
Message-Id: <20201116062031.11233-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 67d901ed2fa3..b5b11cb9f393 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -10,6 +10,7 @@
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
@@ -139,6 +140,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NEXBOX-A95X";
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
 
 &cvbs_vdac_port {
-- 
2.17.1

