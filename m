Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE22F448B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhAMG3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:29:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB1C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:28:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y8so500408plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7V7mkIm5GVfs9j4oSAoW4YEhPzX9sV7NqtlWsRJcP4g=;
        b=YPfRgekDFzXsDeLSpv6VWJ5Hynq+4zVtn9K8qTzmRCqmi+rMZBb1lm0GHIiyq/Fdrk
         JXuZnDFnfmWdv9ckKziBU51kBoJBQeJy1C48XPoKjXb2uCyDN8U9mvfhnYNtWrUe4Nuw
         yJS10PUaND9hwc2xHCZNf3gux5IarDuDrC5Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7V7mkIm5GVfs9j4oSAoW4YEhPzX9sV7NqtlWsRJcP4g=;
        b=fOWZ7l08Y2YTew8/d2Z6QMsFDyapA/c/4anRmHv1XqqsbG4Y+i4chsw/SGZeWhGqS/
         tZjR+3+1N3FGPtzqYLwOI04x8DOSRwv7wNQmvxXS/QWb/qKQ8OUiuaOFDqDh2ZZXaOOu
         tdtO+CcyjgQlLnAY26yYgZ+K+/xVEtmsGWMu1buu7m0UINs69vsC0U6Ar6Ej9N3ri6It
         sitw2VjWWN4skz3ZVkxeS8c/sSgPLxM9f0gAu8w8xpRD/4mu/mn8hfEJhJwFgINZVKeT
         krKKtEUg1cTZRyRrf/ygZM8ztYf+iKGTcS53CheoDlXbyW3zlwW9k+r6Y1f8rwskZxp0
         PCpw==
X-Gm-Message-State: AOAM532B6IcdvrPrWPbo2RAebJ2nDGKqhHrj3FdFiP1+29jjVWHf0AoT
        4gvF+J9ebtGgfXqQFx6tLDLq2kkChTCEEA==
X-Google-Smtp-Source: ABdhPJyMK/Rd+1yNPiUnAIdOyIjhW7oHubC50XzAO75mm/HZoO572CWxNC5Que1TGnJWB8NwQQAZ1A==
X-Received: by 2002:a17:902:c583:b029:da:b32c:cf9f with SMTP id p3-20020a170902c583b02900dab32ccf9fmr649091plx.44.1610519321917;
        Tue, 12 Jan 2021 22:28:41 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id d36sm1117473pgm.77.2021.01.12.22.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:28:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: mt8183: config dsi node
Date:   Wed, 13 Jan 2021 14:28:33 +0800
Message-Id: <20210113062834.4043956-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config dsi node for mt8183 kukui. Set panel and ports.

Several kukui boards share the same panel property and only compatible
is different. So compatible will be set in board dts for comparison
convenience.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
---
 .../mediatek/mt8183-kukui-krane-sku176.dts    |  5 +++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 37 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
index 47113e275cb52..721d16f9c3b4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
@@ -16,3 +16,8 @@ / {
 	model = "MediaTek krane sku176 board";
 	compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
 };
+
+&panel {
+        status = "okay";
+        compatible = "boe,tv101wum-nl6";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf2ad1294dd30..c5f41b94f154e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -249,6 +249,35 @@ &cpu7 {
 	proc-supply = <&mt6358_vproc11_reg>;
 };
 
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	panel: panel@0 {
+		/* compatible will be set in board dts */
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_pins_default>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	ports {
+		port {
+			dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
@@ -547,6 +576,14 @@ pins_clk {
 		};
 	};
 
+	panel_pins_default: panel_pins_default {
+		panel_reset {
+			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
 	pwm0_pin_default: pwm0_pin_default {
 		pins1 {
 			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

