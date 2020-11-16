Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F9B2B3CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgKPGUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF5C0613CF;
        Sun, 15 Nov 2020 22:20:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 23so17345887wrc.8;
        Sun, 15 Nov 2020 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYiWLdXKkzPeHdrQPfgrV2RjQ9E5+nTOH1ppXyWYIkY=;
        b=HTG5fnT3HJe751cxn7ehGB/SWGvCNm86fAMak0bPBh6vbmDlFLMgoNFp0USjV+3uUD
         CZxpIBv2h51wgul+lSCw9fxbjrRAcy4gn7EiBZQ9ZW4H1IsIvf8w5iaPkOOpgfMsXF9I
         QsfPTnCFNG0PL97HsI9VR99h+WzAOjjFIDJbBwDCk7AJibY4Ou54ImjN5adXo6r42DCG
         xqAjL7V/O7WZAy4hVDeaFLuu4QYsZHFLXxXGAqjPENRiiOwBSCPGM+ELI8KvoTQxURNV
         ULkJb/onDyi0VkcqsP+NyJxyXp0jtkhPctSerkON2EPBhk0bRViagYzz0NCwe5WEiBaQ
         2/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYiWLdXKkzPeHdrQPfgrV2RjQ9E5+nTOH1ppXyWYIkY=;
        b=gMcDtddvdca7bb5iitezDieBjSIubNfT/iUkIumenSeHiR+afaZuz+E9jNzluCRu+y
         z5nUAucVis9kMvkUY9StJEgeb1lYPjE9XiygAe66nFJm35Ij6L9aU/2f0iW70hnLrfI4
         OsVesJmkK6YZ1AWzGU82AI96j64qyj4seOy+tLvmldYAM1esVMa5Ht3TJK6HW6jRWfkD
         0iQsQqoEOyCfTihCHlbPH6BzktBLN8rynjtqbUD6keULoHibPvRBEF25M1KPUP2laNvl
         bX5ln49q3B3bIR3lCt3q1bWJBUommh+xXJVf9Ui9H2BD1YCn9CpiGn80/7oA0HNA8sGy
         7HGg==
X-Gm-Message-State: AOAM531iQwfU06YFMxYE2gzYpYoGAQYwn3h/s+OEUp6mCfQeVJKkYkVn
        6OMdYKBd1kYn3daTFQ52YCs=
X-Google-Smtp-Source: ABdhPJxLfaHICNguiyOYcs7944lNnn8viM5jjfq3HveUvEWUl73g5UbldCOK1lDXxH11Va6cR/8dJg==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr17004655wrq.236.1605507639509;
        Sun, 15 Nov 2020 22:20:39 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:39 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 2/7] arm64: dts: meson: add audio playback to khadas-vim
Date:   Mon, 16 Nov 2020 06:20:26 +0000
Message-Id: <20201116062031.11233-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116062031.11233-1-christianshewitt@gmail.com>
References: <20201116062031.11233-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 8bcdffdf55d0..de5361f20cd6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -5,9 +5,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim", "amlogic,s905x", "amlogic,meson-gxl";
@@ -63,6 +63,45 @@
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

