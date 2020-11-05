Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77C2A8646
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbgKESpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKESpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:45:13 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18E12074B;
        Thu,  5 Nov 2020 18:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604601912;
        bh=BMrraDpqHT+fUXyVEWqxrPfHQiuT9bKRKrWa+N3Ac0U=;
        h=From:To:Subject:Date:From;
        b=YssCQTZCUu73GJFIr/YuMzQcavA8z0QcjhFWMGy2ubyNIk+n1gxpe2bCypL+vaRmF
         X2oYM6uh7rPpeEeR5rRvsqX8NOChLL8/tWZ9xFZuT23C1NUC5Dso1qQ+b5oAgl3XlZ
         2JSIjIyllllaMwoD4VdVuGsXNXS0Sl/GHwX6nqAI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ARM: dts: exynos: use hyphens in Exynos3250 node names
Date:   Thu,  5 Nov 2020 19:45:01 +0100
Message-Id: <20201105184506.215648-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hyphens instead of underscores in the Exynos3250 node names which is
expected by naming convention, multiple dtschema files and pointed out
by dtc W=2 builds.  Use also generic "ppmu" node name for PPMU nodes to
match Devicetree specification.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a1e93fb7f694..5fd6a73f2195 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -691,25 +691,25 @@ pwm: pwm@139d0000 {
 			status = "disabled";
 		};
 
-		ppmu_dmc0: ppmu_dmc0@106a0000 {
+		ppmu_dmc0: ppmu@106a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x106a0000 0x2000>;
 			status = "disabled";
 		};
 
-		ppmu_dmc1: ppmu_dmc1@106b0000 {
+		ppmu_dmc1: ppmu@106b0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x106b0000 0x2000>;
 			status = "disabled";
 		};
 
-		ppmu_cpu: ppmu_cpu@106c0000 {
+		ppmu_cpu: ppmu@106c0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x106c0000 0x2000>;
 			status = "disabled";
 		};
 
-		ppmu_rightbus: ppmu_rightbus@112a0000 {
+		ppmu_rightbus: ppmu@112a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x112a0000 0x2000>;
 			clocks = <&cmu CLK_PPMURIGHT>;
@@ -717,7 +717,7 @@ ppmu_rightbus: ppmu_rightbus@112a0000 {
 			status = "disabled";
 		};
 
-		ppmu_leftbus: ppmu_leftbus0@116a0000 {
+		ppmu_leftbus: ppmu@116a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x116a0000 0x2000>;
 			clocks = <&cmu CLK_PPMULEFT>;
@@ -725,7 +725,7 @@ ppmu_leftbus: ppmu_leftbus0@116a0000 {
 			status = "disabled";
 		};
 
-		ppmu_camif: ppmu_camif@11ac0000 {
+		ppmu_camif: ppmu@11ac0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x11ac0000 0x2000>;
 			clocks = <&cmu CLK_PPMUCAMIF>;
@@ -733,7 +733,7 @@ ppmu_camif: ppmu_camif@11ac0000 {
 			status = "disabled";
 		};
 
-		ppmu_lcd0: ppmu_lcd0@11e40000 {
+		ppmu_lcd0: ppmu@11e40000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x11e40000 0x2000>;
 			clocks = <&cmu CLK_PPMULCD0>;
@@ -741,7 +741,7 @@ ppmu_lcd0: ppmu_lcd0@11e40000 {
 			status = "disabled";
 		};
 
-		ppmu_fsys: ppmu_fsys@12630000 {
+		ppmu_fsys: ppmu@12630000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x12630000 0x2000>;
 			clocks = <&cmu CLK_PPMUFILE>;
@@ -749,7 +749,7 @@ ppmu_fsys: ppmu_fsys@12630000 {
 			status = "disabled";
 		};
 
-		ppmu_g3d: ppmu_g3d@13220000 {
+		ppmu_g3d: ppmu@13220000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x13220000 0x2000>;
 			clocks = <&cmu CLK_PPMUG3D>;
@@ -757,7 +757,7 @@ ppmu_g3d: ppmu_g3d@13220000 {
 			status = "disabled";
 		};
 
-		ppmu_mfc: ppmu_mfc@13660000 {
+		ppmu_mfc: ppmu@13660000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x13660000 0x2000>;
 			clocks = <&cmu CLK_PPMUMFC_L>;
@@ -765,7 +765,7 @@ ppmu_mfc: ppmu_mfc@13660000 {
 			status = "disabled";
 		};
 
-		bus_dmc: bus_dmc {
+		bus_dmc: bus-dmc {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu_dmc CLK_DIV_DMC>;
 			clock-names = "bus";
@@ -773,7 +773,7 @@ bus_dmc: bus_dmc {
 			status = "disabled";
 		};
 
-		bus_dmc_opp_table: opp_table1 {
+		bus_dmc_opp_table: opp-table1 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -799,7 +799,7 @@ opp-400000000 {
 			};
 		};
 
-		bus_leftbus: bus_leftbus {
+		bus_leftbus: bus-leftbus {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_GDL>;
 			clock-names = "bus";
@@ -807,7 +807,7 @@ bus_leftbus: bus_leftbus {
 			status = "disabled";
 		};
 
-		bus_rightbus: bus_rightbus {
+		bus_rightbus: bus-rightbus {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_GDR>;
 			clock-names = "bus";
@@ -815,7 +815,7 @@ bus_rightbus: bus_rightbus {
 			status = "disabled";
 		};
 
-		bus_lcd0: bus_lcd0 {
+		bus_lcd0: bus-lcd0 {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_160>;
 			clock-names = "bus";
@@ -823,7 +823,7 @@ bus_lcd0: bus_lcd0 {
 			status = "disabled";
 		};
 
-		bus_fsys: bus_fsys {
+		bus_fsys: bus-fsys {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_200>;
 			clock-names = "bus";
@@ -831,7 +831,7 @@ bus_fsys: bus_fsys {
 			status = "disabled";
 		};
 
-		bus_mcuisp: bus_mcuisp {
+		bus_mcuisp: bus-mcuisp {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
 			clock-names = "bus";
@@ -839,7 +839,7 @@ bus_mcuisp: bus_mcuisp {
 			status = "disabled";
 		};
 
-		bus_isp: bus_isp {
+		bus_isp: bus-isp {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_266>;
 			clock-names = "bus";
@@ -847,7 +847,7 @@ bus_isp: bus_isp {
 			status = "disabled";
 		};
 
-		bus_peril: bus_peril {
+		bus_peril: bus-peril {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_DIV_ACLK_100>;
 			clock-names = "bus";
@@ -855,7 +855,7 @@ bus_peril: bus_peril {
 			status = "disabled";
 		};
 
-		bus_mfc: bus_mfc {
+		bus_mfc: bus-mfc {
 			compatible = "samsung,exynos-bus";
 			clocks = <&cmu CLK_SCLK_MFC>;
 			clock-names = "bus";
@@ -863,7 +863,7 @@ bus_mfc: bus_mfc {
 			status = "disabled";
 		};
 
-		bus_leftbus_opp_table: opp_table2 {
+		bus_leftbus_opp_table: opp-table2 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -889,7 +889,7 @@ opp-200000000 {
 			};
 		};
 
-		bus_mcuisp_opp_table: opp_table3 {
+		bus_mcuisp_opp_table: opp-table3 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -910,7 +910,7 @@ opp-400000000 {
 			};
 		};
 
-		bus_isp_opp_table: opp_table4 {
+		bus_isp_opp_table: opp-table4 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
@@ -931,7 +931,7 @@ opp-300000000 {
 			};
 		};
 
-		bus_peril_opp_table: opp_table5 {
+		bus_peril_opp_table: opp-table5 {
 			compatible = "operating-points-v2";
 			opp-shared;
 
-- 
2.25.1

