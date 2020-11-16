Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32F2B3CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgKPGUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKPGUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BB2C0613CF;
        Sun, 15 Nov 2020 22:20:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r17so17408985wrw.1;
        Sun, 15 Nov 2020 22:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=oVwJCEoUO0cPE+bysHQys/P8gwJ4OSvwnJA4An072DSCY4iXPFcNH5wtV9UTVXxE6l
         DzKKbcQJrtAZrekquPHe3ihM4nKjwo2rGZ+sRj8zdhS7wJG66dfd8n26n3q0cEkgeMxr
         1cOJO64BQb2ClGanobW+xcd9G31OkyGekoMhJTt9aQWPIQQFTr4/loTS2OLKJo18nrjw
         jev2rgn+vK0yVGjEJOvcYHt4gMf41pnjydlpVz+yG8nKFYgeuDs/3FCTQ/TMwt1A7lOT
         4/xmPVhyydXRAAMEPOLvsLbEZIf71WZtEecDMbbyymOk0/kKesGkg5t1YhosoXy6M3UI
         de6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=fplFYory79ya+ye2ur45+bS4UBmXquJHtZMdJkY/dWG7RcYgDnsPmtXcD77A0vwUHl
         /hkrJX7ruAEepkY3qAoF7M3rz+mXXfII529hPFLnBgFFrpBG/SRhpyTIVfC45PqxVKk9
         LtKcYhg4Ew2xS73PYAQs8+Vf+Lj8NS0O5LoC/ROJo8eE8dJbXAI0EejzryxBUww0i/k2
         aHmCk4vH+CYCLQV75lcE4+dMbbApt5pPBrYNoZVqvwUdrtY5XMqbF6PN4cgZ6i03891b
         61czTNIWdrnsfOH2naoWKbKYjb0/njvGXZuiBEgfWGNqZPbCIknER1fzi3oo9OP5UYMX
         QhHg==
X-Gm-Message-State: AOAM5311qs6v2fslBqfZBJFgxs25t+chVdyug0+MJry6/D7a37RzNba0
        apas8/iMrJK8lYonC9vJLvA=
X-Google-Smtp-Source: ABdhPJw3LqdgZebMeTfGoydpX1BZ+cu0qP7A/4FSFPeRA62GMGxV73zIG8beWWh+IHU5qZo4UVAf4g==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr16793905wrv.145.1605507643792;
        Sun, 15 Nov 2020 22:20:43 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:43 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 4/7] arm64: dts: meson: add audio playback to nanopi-k2
Date:   Mon, 16 Nov 2020 06:20:28 +0000
Message-Id: <20201116062031.11233-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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

