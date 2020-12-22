Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B767E2E0586
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLVE7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:59:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40060 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgLVE7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:59:14 -0500
X-UUID: 68aa42c75e9448d5bf8bb0c881120ccf-20201222
X-UUID: 68aa42c75e9448d5bf8bb0c881120ccf-20201222
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 327110763; Tue, 22 Dec 2020 12:58:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 12:58:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 12:58:21 +0800
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>
Subject: [PATCH] arm64: dts: mt8192: Add cpu-idle-states
Date:   Tue, 22 Dec 2020 12:58:20 +0800
Message-ID: <20201222045820.26355-1-jamesjj.liao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add idle states for cpu-off and cluster-off.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

This patch bases on v5.10 and [1], adds idle-states for MT8192 CPUs.

[1] https://lore.kernel.org/linux-arm-kernel/20201030092207.26488-2-seiya.wang@mediatek.com/

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index e12e024de122..c7f2ec9ea4f1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -39,6 +39,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -49,6 +50,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -59,6 +61,7 @@
 			reg = <0x200>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -69,6 +72,7 @@
 			reg = <0x300>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -79,6 +83,7 @@
 			reg = <0x400>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
+			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -89,6 +94,7 @@
 			reg = <0x500>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
+			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -99,6 +105,7 @@
 			reg = <0x600>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
+			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -109,6 +116,7 @@
 			reg = <0x700>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
+			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -158,6 +166,42 @@
 		l3_0: l3-cache {
 			compatible = "cache";
 		};
+
+		idle-states {
+			entry-method = "arm,psci";
+			cpuoff_l: cpuoff_l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010001>;
+				local-timer-stop;
+				entry-latency-us = <55>;
+				exit-latency-us = <140>;
+				min-residency-us = <780>;
+			};
+			cpuoff_b: cpuoff_b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010001>;
+				local-timer-stop;
+				entry-latency-us = <35>;
+				exit-latency-us = <145>;
+				min-residency-us = <720>;
+			};
+			clusteroff_l: clusteroff_l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010002>;
+				local-timer-stop;
+				entry-latency-us = <60>;
+				exit-latency-us = <155>;
+				min-residency-us = <860>;
+			};
+			clusteroff_b: clusteroff_b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010002>;
+				local-timer-stop;
+				entry-latency-us = <40>;
+				exit-latency-us = <155>;
+				min-residency-us = <780>;
+			};
+		};
 	};
 
 	pmu-a55 {
-- 
2.18.0

