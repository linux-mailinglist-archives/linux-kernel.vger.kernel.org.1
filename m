Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829A2F9D70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbhARLCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:02:47 -0500
Received: from comms.puri.sm ([159.203.221.185]:59698 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389126AbhARK4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:56:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D1CFBE0114;
        Mon, 18 Jan 2021 02:55:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9EQ35MVmsmc9; Mon, 18 Jan 2021 02:55:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 7/9] arm64: dts: imx8mq-librem5: set regulators boot-on
Date:   Mon, 18 Jan 2021 11:54:23 +0100
Message-Id: <20210118105425.425-8-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expect all those regulators to be turned on initially.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index bf86402cda30..06a4799b6aeb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -682,6 +682,7 @@
 				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
@@ -693,6 +694,7 @@
 				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <1000000>;
 				rohm,dvs-idle-voltage = <900000>;
@@ -703,6 +705,7 @@
 				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				rohm,dvs-run-voltage = <900000>;
 			};
 
@@ -717,6 +720,7 @@
 				regulator-name = "buck5";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -724,6 +728,7 @@
 				regulator-name = "buck6";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -731,6 +736,7 @@
 				regulator-name = "buck7";
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -738,6 +744,7 @@
 				regulator-name = "buck8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -745,6 +752,7 @@
 				regulator-name = "ldo1";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				/* leave on for snvs power button */
 				regulator-always-on;
 			};
@@ -753,6 +761,7 @@
 				regulator-name = "ldo2";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
 				/* leave on for snvs power button */
 				regulator-always-on;
 			};
@@ -761,6 +770,7 @@
 				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -768,6 +778,7 @@
 				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -784,6 +795,7 @@
 				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -792,6 +804,7 @@
 				regulator-name = "ldo7";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 		};
-- 
2.20.1

