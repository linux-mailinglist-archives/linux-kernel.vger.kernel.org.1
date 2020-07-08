Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF32182E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGHI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 04:56:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:18942 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGHI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:56:24 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Jul 2020 17:56:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id CC8A360060;
        Wed,  8 Jul 2020 17:56:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 Jul 2020 17:56:22 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 99C111A0507;
        Wed,  8 Jul 2020 17:56:22 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] arm64: dts: uniphier: Add missing clock-names and reset-names to pcie-phy
Date:   Wed,  8 Jul 2020 17:56:18 +0900
Message-Id: <1594198578-29238-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds missing clock-names and reset-names to pcie-phy node according to
Documentation/devicetree/bindings/phy/socionext,uniphier-pcie.yaml.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index f4a56b2..a87b8a6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -936,7 +936,9 @@
 			compatible = "socionext,uniphier-ld20-pcie-phy";
 			reg = <0x66038000 0x4000>;
 			#phy-cells = <0>;
+			clock-names = "link";
 			clocks = <&sys_clk 24>;
+			reset-names = "link";
 			resets = <&sys_rst 24>;
 			socionext,syscon = <&soc_glue>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 72f1688..0e52dadf 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -833,7 +833,9 @@
 			compatible = "socionext,uniphier-pxs3-pcie-phy";
 			reg = <0x66038000 0x4000>;
 			#phy-cells = <0>;
+			clock-names = "link";
 			clocks = <&sys_clk 24>;
+			reset-names = "link";
 			resets = <&sys_rst 24>;
 			socionext,syscon = <&soc_glue>;
 		};
-- 
2.7.4

