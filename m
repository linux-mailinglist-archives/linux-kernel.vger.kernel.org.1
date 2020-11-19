Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061812B9B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKSTLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:11:34 -0500
Received: from foss.arm.com ([217.140.110.172]:37970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgKSTLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:11:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CD71396;
        Thu, 19 Nov 2020 11:11:33 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639AD3F70D;
        Thu, 19 Nov 2020 11:11:31 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v6 4/5] dt-bindings: arm: add support for SCMI Regulators
Date:   Thu, 19 Nov 2020 19:10:50 +0000
Message-Id: <20201119191051.46363-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings to support regulators based on SCMI Voltage
Domain Protocol.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- added list of supported Regulator bindings.
v2 --> v3
- avoid awkard examples based on _cpu/_gpu regulators
v1 --> v2
- removed any reference to negative voltages
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..6e011ca97079 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -62,6 +62,29 @@ Required properties:
  - #power-domain-cells : Should be 1. Contains the device or the power
 			 domain ID value used by SCMI commands.
 
+Regulator bindings for the SCMI Regulator based on SCMI Message Protocol
+------------------------------------------------------------
+An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
+and should be always positioned as a root regulator.
+It does not support any current operation.
+
+SCMI Regulators are grouped under a 'regulators' node which in turn is a child
+of the SCMI Voltage protocol node inside the desired SCMI instance node.
+
+This binding uses the common regulator binding[6] but, due to SCMI abstractions,
+supports only a subset of its properties as specified below amongst Optional
+properties.
+
+Required properties:
+ - reg : shall identify an existent SCMI Voltage Domain.
+
+Optional properties:
+ - regulator-name
+ - regulator-min-microvolt / regulator-max-microvolt
+ - regulator-always-on / regulator-boot-on
+ - regulator-max-step-microvolt
+ - regulator-coupled-with / regulator-coupled-max-spread
+
 Sensor bindings for the sensors based on SCMI Message Protocol
 --------------------------------------------------------------
 SCMI provides an API to access the various sensors on the SoC.
@@ -105,6 +128,7 @@ Required sub-node properties:
 [3] Documentation/devicetree/bindings/thermal/thermal*.yaml
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
+[6] Documentation/devicetree/bindings/regulator/regulator.yaml
 
 Example:
 
@@ -169,6 +193,25 @@ firmware {
 			reg = <0x16>;
 			#reset-cells = <1>;
 		};
+
+		scmi_voltage: protocol@17 {
+			reg = <0x17>;
+
+			regulators {
+				regulator_devX: regulator@0 {
+					reg = <0x0>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator_devY: regulator@9 {
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

