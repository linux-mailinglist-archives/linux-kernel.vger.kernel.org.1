Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3928152F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbgJBOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbgJBOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:32:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D59C0613E2;
        Fri,  2 Oct 2020 07:32:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so2049467wrl.12;
        Fri, 02 Oct 2020 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DR+MN9yI45B0CbPas30C2sDxsoxmrDbz6ZTE82Yi1YU=;
        b=hA7YHt1VQf+I7mQTtL0IMemPkyrBpn14q39F9bkrXqgKjm6GF39cFze3zg/0sFyNRn
         SI1nL8BwioMNZhxPA9RBuIqWwLOXwpO8qjhw0fb7QkRu1b5TwOdyArOnZS51FvHKreOd
         qM7ylsMUE6Y8NJGjpPoMv5vS9BVdvLrm6FazfxWlJDZRJwTCRDQzAdfX11hFfb8KZVBe
         zs9G+uT4vqlBU2gRXljx63OZrYq0DIpqfhEcLYipci73WKwzovV9soeHOoujpjnqBR2C
         4ghq/CTJJCvN/pTD4YQHJzGYhjssztqvtu00CexQQcdWWzxIgdUJW4I1IXR91H0ekfAL
         Vb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DR+MN9yI45B0CbPas30C2sDxsoxmrDbz6ZTE82Yi1YU=;
        b=jlrs9a9e1OoOzR+EFHIPfjc0ur/rSAf/io8eiS9pL1NyEhcaQlMXjXmj6oqZJvAMct
         C82jgUHfqss/rIkc6m8WQ+4INvHscj+cz0vJvPKbo4ItPL4Bqd4RUZ83CD1MgbKkPhns
         Tznk0L+ToSeJiN6KKgWvNm+YcmOIUBXhmuZHNxCSARCNP06L+LXvXcE/hsswi6ca8Dc1
         OS+H+py5Du/hjEf/L6A93JjSV6Stppr6sX/IYyeOzYPk0KaurCeldFYoEtZ6FtyBMkWc
         1ec84s7u+4QBiyGQq1oF/S/vfe6rByEk51q//o7i6KALmci2Fl6iozIGMyKwJha5ESgt
         bv2w==
X-Gm-Message-State: AOAM531lqaiMSThG3cHczA0jrSGi65bY+4CYLbSzB3lbtoDEpNC4hhaI
        4fY9Y0EuxL0/H1pezy4j6/g=
X-Google-Smtp-Source: ABdhPJzDRzc53W8EhYqCtpUVtGfSgBpzhIfazEvaTgRcMzr6Q/f+pHsYad3LwQes9oZBszHy/BCs3A==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr3398904wrq.365.1601649121861;
        Fri, 02 Oct 2020 07:32:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:32:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 07/10] arm64: dts: meson: add audio playback to p212-s905x dtsi
Date:   Fri,  2 Oct 2020 14:31:38 +0000
Message-Id: <20201002143141.14870-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 05cb2f5e5c36..40776d42bf8e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -11,6 +11,7 @@
 /* Common DTSI for devices which are based on the P212 reference board. */
 
 #include "meson-gxl-s905x.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	aliases {
@@ -85,6 +86,45 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-S905X-P212";
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
 
 &ethmac {
-- 
2.17.1

