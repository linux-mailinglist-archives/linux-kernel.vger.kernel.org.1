Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E32F4461
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAMGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbhAMGIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFBC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so584929pfm.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSKByOICSjVjMjVCfEoqfBGplgqPjsRqiLT7P6WrDrg=;
        b=RlArDCzItkrBIPLsdNv2i0v1cNbze3bGswglgjIYL7SvzaTuP5TY8xE171Oy955lzr
         4Ksnd4Qcs5Hcln29F2c4O9yvJtXPsK8bW/fb+9Q9pKBF3xOiTxnevDrlhQL9D5N7f2ZY
         pEAEys4j3cDxyVRr3wUSCqYdybKusqS33UTGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSKByOICSjVjMjVCfEoqfBGplgqPjsRqiLT7P6WrDrg=;
        b=N7B1qV3bzV2Lwh1yNmatnErM/WXeE9kGSehnUL9keq0Hg7QxYU3S70+gmpKGMoCN+l
         Ca71QmQNQDc4JriCopDXMG5O3CWjCt8mwoISucIF9xa3yTv17pdFY6BePg+GuDn26wKk
         fppUBzwntlSb1SIpR9y9mdTMSWjY5iu+RhkuMTckOZlY7XABd/SSW6GgJnSn2g8aTuV1
         C0/sZD6iz1v0RrewwJuTGtBaOhlUp/heN1DNMwEQAeyypgrUL33oqlW7ymFCHY4CGzhS
         2iHG+6bhcockpGrKGlUGbG3Mrg7We2kNcdFEFlRDNEFb9fKBodgOpZu7FlDf3qI8ZF78
         tLuQ==
X-Gm-Message-State: AOAM533DNCsNmHWliCT579i6/6fhy+PPz+wReCOyWs/m141V6mr+wOEn
        AbsxmbcE4SeUXrzaMznhf5i+dQ==
X-Google-Smtp-Source: ABdhPJw62x/4MOjjGie1CHKrWtjV3n/t7fvqc9N7HS8aviE2ERZezMtrgnfsP+yxaZVpFKrr5NnoLw==
X-Received: by 2002:a63:d303:: with SMTP id b3mr611858pgg.113.1610518065250;
        Tue, 12 Jan 2021 22:07:45 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id y21sm1263556pfr.90.2021.01.12.22.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:07:44 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v10 2/4] arm64: dts: mt8183: Add node for the Mali GPU
Date:   Wed, 13 Jan 2021 14:07:01 +0800
Message-Id: <20210113140546.v10.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113060703.3122661-1-drinkcat@chromium.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic GPU node for mt8183.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
The binding we use with out-of-tree Mali drivers includes more
clocks, this is used for devfreq: the out-of-tree driver switches
clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
switches clk_mux back to clk_main_parent:
(see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
clocks =
        <&topckgen CLK_TOP_MFGPLL_CK>,
        <&topckgen CLK_TOP_MUX_MFG>,
        <&clk26m>,
        <&mfgcfg CLK_MFG_BG3D>;
clock-names =
        "clk_main_parent",
        "clk_mux",
        "clk_sub_parent",
        "subsys_mfg_cg";
(based on discussions, this probably belongs in the clock core)

This only matters for devfreq, that is disabled anyway as we don't
have platform-specific code to handle >1 supplies.

(no changes since v6)

Changes in v6:
 - Add gpu regulators to kukui dtsi as well.
 - Power domains are now attached to spm, not scpsys
 - Drop R-B.

Changes in v5:
 - Rename "2d" power domain to "core2" (keep R-B again).

Changes in v4:
 - Add power-domain-names to describe the 3 domains.
   (kept Alyssa's reviewed-by as the change is minor)

Changes in v3:
 - No changes

Changes in v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   6 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   6 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index cba2d8933e79..0a8c2fad8e16 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -42,6 +42,12 @@ &auxadc {
 	status = "okay";
 };
 
+&gpu {
+	supply-names = "mali", "sram";
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c_pins_0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf2ad1294dd3..00d8e112cab9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -249,6 +249,12 @@ &cpu7 {
 	proc-supply = <&mt6358_vproc11_reg>;
 };
 
+&gpu {
+	supply-names = "mali", "sram";
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b782a4769e7..5430e05e18a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -964,6 +964,111 @@ mfgcfg: syscon@13000000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@13040000 {
+			compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
+			reg = <0 0x13040000 0 0x4000>;
+			interrupts =
+				<GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
+
+			power-domains =
+				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
+				<&spm MT8183_POWER_DOMAIN_MFG_CORE1>,
+				<&spm MT8183_POWER_DOMAIN_MFG_2D>;
+			power-domain-names = "core0", "core1", "core2";
+
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+
+		gpu_opp_table: opp_table0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <625000>, <850000>;
+			};
+
+			opp-320000000 {
+				opp-hz = /bits/ 64 <320000000>;
+				opp-microvolt = <631250>, <850000>;
+			};
+
+			opp-340000000 {
+				opp-hz = /bits/ 64 <340000000>;
+				opp-microvolt = <637500>, <850000>;
+			};
+
+			opp-360000000 {
+				opp-hz = /bits/ 64 <360000000>;
+				opp-microvolt = <643750>, <850000>;
+			};
+
+			opp-380000000 {
+				opp-hz = /bits/ 64 <380000000>;
+				opp-microvolt = <650000>, <850000>;
+			};
+
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <656250>, <850000>;
+			};
+
+			opp-420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <662500>, <850000>;
+			};
+
+			opp-460000000 {
+				opp-hz = /bits/ 64 <460000000>;
+				opp-microvolt = <675000>, <850000>;
+			};
+
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <687500>, <850000>;
+			};
+
+			opp-540000000 {
+				opp-hz = /bits/ 64 <540000000>;
+				opp-microvolt = <700000>, <850000>;
+			};
+
+			opp-580000000 {
+				opp-hz = /bits/ 64 <580000000>;
+				opp-microvolt = <712500>, <850000>;
+			};
+
+			opp-620000000 {
+				opp-hz = /bits/ 64 <620000000>;
+				opp-microvolt = <725000>, <850000>;
+			};
+
+			opp-653000000 {
+				opp-hz = /bits/ 64 <653000000>;
+				opp-microvolt = <743750>, <850000>;
+			};
+
+			opp-698000000 {
+				opp-hz = /bits/ 64 <698000000>;
+				opp-microvolt = <768750>, <868750>;
+			};
+
+			opp-743000000 {
+				opp-hz = /bits/ 64 <743000000>;
+				opp-microvolt = <793750>, <893750>;
+			};
+
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <825000>, <925000>;
+			};
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8183-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

