Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25B823EADF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgHGJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgHGJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:48:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD94C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:48:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so647509pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpgEOhtDJgg+JHNnGT0zB8AHGVroP0sa6vGC4+WgrY0=;
        b=ZJhlgW2q36OOGZfDH+aVuJIJqLtDiPY1IJ+JNpipBmkcUcKzKRt6W4wJ9BloVTvOI7
         S/gMa9lcyz/lfgdM6Jsrjt9JdqHC+rH2sgidwu+hyAKgQEU7JKmKxS/opbT5jYDum0Qt
         x9ikHjOy3sAPQTU304WZPw/t3AWt0PNOmc5vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpgEOhtDJgg+JHNnGT0zB8AHGVroP0sa6vGC4+WgrY0=;
        b=HZEJ/Es/arZvVm1ZpneqwzDj7b30GZDb0JslvJjVr4fxmvwxWzh9C1HCMpFKHpE+3d
         wlW7SaHI2vckdGLvHDFalw6Ag+AEYBAEjfB46xXIe8A18BqhkW027abL+bXIN0R70WjY
         VRkEeIk2Ku3bEDNPa01Kpfk0ax48K9ZHrdZO7liCzhh9yCXS3vfwWxw2GaKR6rI6xS4I
         jl4ZJ4MJrpijPFdMoTCZSYRxUPg1CuipfEN9aGqXTK6T1XlM6uh3335bQB62FF0kn8uH
         x6ydmcTvkHfffStfEQvEt1yjJRckf5DPvxjIgv/rY+H4+KKAiu63EJC9R3Cw9MXOqoNm
         eflQ==
X-Gm-Message-State: AOAM531XVS17ZcmOaQCioGSD2voCELGg8XwjKtwQFv6LYJD6X3i5Ktku
        n730e0pQt33XiSUnp5um92ieKQ==
X-Google-Smtp-Source: ABdhPJyg5UtwKC7zV3jZtggtU8N93mFESleKSGSjH8oAPMxRiMaRKLJZ6mf65Li05MZ3czJpw5k4/A==
X-Received: by 2002:a17:90a:2110:: with SMTP id a16mr12756782pje.104.1596793728986;
        Fri, 07 Aug 2020 02:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:6097:2d32:26bb:64fe])
        by smtp.gmail.com with ESMTPSA id d65sm11412112pfc.97.2020.08.07.02.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:48:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 3/4] arm64: dts: rockchip: Add Radxa ROCK Pi 4B support
Date:   Fri,  7 Aug 2020 15:18:25 +0530
Message-Id: <20200807094826.12019-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807094826.12019-1-jagan@amarulasolutions.com>
References: <20200807094826.12019-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RockPI 4B has AP6256 Wifi/BT, so enable them in 4B dts
instead of enable in common dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3:
- none
Changes for v2:
- update commit message
- add radxa,rockpi4b

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 23 ----------
 .../boot/dts/rockchip/rk3399-rock-pi-4b.dts   | 42 +++++++++++++++++++
 3 files changed, 43 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 42f9e1861461..8832d05c2571 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index e163f438f836..678a336010bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -584,17 +584,6 @@ &sdio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
-		interrupt-names = "host-wake";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_host_wake_l>;
-	};
 };
 
 &sdmmc {
@@ -663,18 +652,6 @@ u2phy1_host: host-port {
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
-		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-	};
 };
 
 &uart2 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
new file mode 100644
index 000000000000..f0055ce2fda0
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4B";
+	compatible = "radxa,rockpi4b", "radxa,rockpi4", "rockchip,rk3399";
+};
+
+&sdio0 {
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
+};
-- 
2.25.1

