Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1028427C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 00:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgJEW0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 18:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbgJEW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 18:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894B1113E;
        Mon,  5 Oct 2020 15:26:42 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106A03F70D;
        Mon,  5 Oct 2020 15:26:40 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, cristian.marussi@arm.com
Subject: [PATCH 4/4] dt-bindings: arm: add support for SCMI Regulators
Date:   Mon,  5 Oct 2020 23:26:23 +0100
Message-Id: <20201005222623.1123-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005222623.1123-1-cristian.marussi@arm.com>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings to support regulators based on SCMI Voltage
Domain Protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..c6a008737631 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -62,6 +62,30 @@ Required properties:
  - #power-domain-cells : Should be 1. Contains the device or the power
 			 domain ID value used by SCMI commands.
 
+Regulator bindings for the SCMI Regulator based on SCMI Message Protocol
+------------------------------------------------------------
+
+An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
+and should be always positioned as a root regulator.
+It does not support negative voltages nor any current operation.
+
+This binding uses the common regulator binding[6].
+
+SCMI Regulators are grouped under a 'regulators' node which in turn is a child
+of the SCMI Voltage protocol node inside the desired SCMI instance node.
+
+Required properties:
+ - reg : shall identify an existent SCMI Voltage Domain.
+
+Optional properties:
+ - regulator-min-microvolt: when defined should be non-negative.
+ - regulator-max-microvolt: when defined should be non-negative.
+ - all of the other standard regulator bindings as in [6]: note that, since
+   the SCMI Protocol itself aims in fact to hide away many of the operational
+   capabilities usually exposed by the properties of a standard regulator,
+   most of the usual regulator bindings could have just no effect in the
+   context of this SCMI regulator.
+
 Sensor bindings for the sensors based on SCMI Message Protocol
 --------------------------------------------------------------
 SCMI provides an API to access the various sensors on the SoC.
@@ -105,6 +129,7 @@ Required sub-node properties:
 [3] Documentation/devicetree/bindings/thermal/thermal*.yaml
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
+[6] Documentation/devicetree/bindings/regulator/regulator.yaml
 
 Example:
 
@@ -169,6 +194,25 @@ firmware {
 			reg = <0x16>;
 			#reset-cells = <1>;
 		};
+
+		scmi_voltage: protocol@17 {
+			reg = <0x17>;
+
+			regulators {
+				regulator_cpu: regulator_scmi_cpu@0 {
+					reg = <0x0>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator_gpu: regulator_scmi_gpu@9 {
+					reg = <0x9>;
+					regulator-min-microvolt = <500000>;
+					regulator-max-microvolt = <4200000>;
+				};
+
+				...
+			};
+		};
 	};
 };
 
-- 
2.17.1

