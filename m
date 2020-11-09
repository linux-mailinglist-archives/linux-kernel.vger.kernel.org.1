Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750B2AC34F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgKISKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgKISKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:10:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g7so8906000pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/doRDnqd7SYfemjv9cY2JSDkvbAWwoc31fGT87WuQI=;
        b=LA85quk+LrPn1jIVBFNSfrEVVRrmba/7sY2cWOTM3kKQO62zUfbsBFXHvdCirkBZgr
         vmGv5ExQefGhJRF3w8Sb0sUvrArxC3C68mHIQ7S1Gd+Asot58lvsBycqqAWIWjLZSAI5
         a8yv1qLTkkoq7wVVxsESYACY4Cr5wtyCIeDZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/doRDnqd7SYfemjv9cY2JSDkvbAWwoc31fGT87WuQI=;
        b=XY8W8AMAJ3NFxzRzm3hJfcomJ8Ifyj9LkgO/3fQj9tf40BLUZyf5cWdQLLXnsINod3
         5HHa+mvoCGKJk9EImSQv/kEC36Uv8M1LN42geP2yb6tzYSYWUibDFgHalNyBszVeRs61
         EdB/fzxigHlOxlvjPlFfTBuGSsn7+zQKMTVkExt4ZqpfAgd5Swr6/uxYoyz5jbHfgurW
         uPF4D6SjLLxtfKYj77k9EYuEAqKaOE120ve76Lif5m2e//xnDb9oX7gG/65VZg7W7S8H
         +1A8RTBeWi3eYw8mrYH59HcpC6VUrlRvP58zAnAIvlhSNmcl7p8KqTkCWAouCQ7qZPR6
         vsKg==
X-Gm-Message-State: AOAM530l9R3lkgMHgh6rbBlhZFtA/j6g/Hgrewm7KH3RlCbrmUDkTJ00
        1gXW9NlKEAK+5LWKTL670q/V4Q==
X-Google-Smtp-Source: ABdhPJyKqZfB/JAW7OQ56zGLwKYIoyzxmNFSF5+jGJ63Ca7KP9lhDKulQRQbT/CqG41lNfkp0aAS9g==
X-Received: by 2002:a05:6a00:228a:b029:18b:212a:1af7 with SMTP id f10-20020a056a00228ab029018b212a1af7mr15158126pfe.55.1604945450906;
        Mon, 09 Nov 2020 10:10:50 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:10:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/9] arm64: dts: rockchip: px30-engicam-edimm2.2: Enable LVDS panel
Date:   Mon,  9 Nov 2020 23:40:10 +0530
Message-Id: <20201109181017.206834-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam PX30.Core EDIMM2.2 developement Kit has on board 10" LVDS
panel from yes-optoelectronics.

This patch adds panel enablement nodes on respective dts(i) files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/rockchip/px30-engicam-common.dtsi     |  4 ++
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   | 59 +++++++++++++++++++
 .../dts/rockchip/px30-engicam-px30-core.dtsi  |  5 ++
 3 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
index fbbdbb0a40af..8fdd7ff2fdf9 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -25,6 +25,10 @@ &gmac {
 	status = "okay";
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &sdmmc {
 	cap-sd-highspeed;
 	card-detect-delay = <800>;
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
index cb00988953e9..449b8eb6454e 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
@@ -5,3 +5,62 @@
  */
 
 #include "px30-engicam-common.dtsi"
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	panel {
+		compatible = "yes-optoelectronics,ytc700tlag-05-201c";
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+		power-supply = <&vcc3v3_lcd>;
+
+		port {
+			panel_in_lvds: endpoint {
+				remote-endpoint = <&lvds_out_panel>;
+			};
+		};
+	};
+};
+
+&display_subsystem {
+	status = "okay";
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
+/* LVDS_B(secondary) */
+&lvds {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			lvds_out_panel: endpoint {
+				remote-endpoint = <&panel_in_lvds>;
+			};
+		};
+	};
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core.dtsi
index db22f776c68f..cdacd3483600 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-px30-core.dtsi
@@ -192,6 +192,11 @@ regulator-state-mem {
 				};
 			};
 
+			vcc3v3_lcd: SWITCH_REG1 {
+				regulator-boot-on;
+				regulator-name = "vcc3v3_lcd";
+			};
+
 			vcc5v0_host: SWITCH_REG2 {
 				regulator-name = "vcc5v0_host";
 				regulator-always-on;
-- 
2.25.1

