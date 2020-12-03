Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F02CCEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgLCGBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgLCGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D1C061A4F;
        Wed,  2 Dec 2020 22:00:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g185so2547057wmf.3;
        Wed, 02 Dec 2020 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxWzeifwzXJ8noPCs15h/EHSm9BBgorS6bs8r2VapUw=;
        b=nfH7OYWIw0J+z1tIfWzUQM45lxCokcLmQcieCVApZEyurRmlPJ7PsupvrSVnLrFZbJ
         ZT7cnyXmxAJ0IEhdJd5XU+Az23Y4WBFBfXx6vAKdUAgrfxTCThXIjAErYcbu9n5WExyL
         iyKWXqwYTYw6drECbFRtEfcKbkuHriRGXpg0C/YXglxG6sJrMm9ckfcVkzs4bh0CuxoX
         guNQTxCdsqmhtKJcw5bd2RYFN6mzWpzWYivSO/63AmG9XxKq0vd6S2LNgOHoAD2uFOfX
         qDt+Q2DoF2r2APwTYmWhybcjNKESaCyQV8R4tnCdFgh+hFnA6mas1k+LjaB2sWqLKZF+
         MH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxWzeifwzXJ8noPCs15h/EHSm9BBgorS6bs8r2VapUw=;
        b=nL/OYcG1IaPi/vAGNAJpRbcKmaTJCBfp7hK8pATYeAuRMDce2ml5wpn1gKBmKx5qjW
         uFYW0YPtWT44iQTtamFCQDOH7BhZ47sbVJ0MkQ6rnC3F/pSnPgbS25mymJMtOIfE91x4
         My3YHCgY8H31c/k62CCnPokVbs7X9UA7PROw6xVfawvWZo8VZSI2wTnKrLegMKqPGWN/
         YIY+TblrvOL98E0QhrBV1jo9ABGUSTR6bSEuXEeB0by12M2t4wI0mhE6GOO04qPgAnwv
         y5Uhsk2+gg9zyo0eBFxe3SCkgogrpjMkFGmW0BG7nbHY1k7Ukjr4RuS9gyAUT5NeSh2G
         vh+Q==
X-Gm-Message-State: AOAM530EfHQ/noVykMXyRaXlmP5ZAEvgm6EDN1zb1IRli1bcFiFa3eYW
        R3u+SZhPd9IVUxWg1LsYVgs=
X-Google-Smtp-Source: ABdhPJyvD8UtGxEO3hLOc/p+glcLR1EiZYUEsRp5yrqNY5N9GUyR5uNJOY+xkfutM6LnJ23Sy6YABQ==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr1400052wmo.40.1606975232264;
        Wed, 02 Dec 2020 22:00:32 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:31 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 2/7] arm64: dts: meson: add audio playback to khadas-vim
Date:   Thu,  3 Dec 2020 06:00:18 +0000
Message-Id: <20201203060023.9454-3-christianshewitt@gmail.com>
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
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 638a5992d760..7aa08f74c49b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim", "amlogic,s905x", "amlogic,meson-gxl";
@@ -63,6 +64,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-KHADAS-VIM1";
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

