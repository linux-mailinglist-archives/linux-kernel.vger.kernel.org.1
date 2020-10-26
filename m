Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B212997FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgJZUch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:32:37 -0400
Received: from foss.arm.com ([217.140.110.172]:51632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbgJZUc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:32:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7E31424;
        Mon, 26 Oct 2020 13:32:26 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1BC3F7BB;
        Mon, 26 Oct 2020 13:32:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v3 4/4] dt-bindings: arm: add support for SCMI Regulators
Date:   Mon, 26 Oct 2020 20:31:48 +0000
Message-Id: <20201026203148.47416-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026203148.47416-1-cristian.marussi@arm.com>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings to support regulators based on SCMI Voltage
Domain Protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- avoid awkard examples based on _cpu/_gpu regulators
v1 --> v2
- removed any reference to negative voltages
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..0cef83a60f03 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -62,6 +62,28 @@ Required properties:
  - #power-domain-cells : Should be 1. Contains the device or the power
 			 domain ID value used by SCMI commands.
 
+Regulator bindings for the SCMI Regulator based on SCMI Message Protocol
+------------------------------------------------------------
+
+An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
+and should be always positioned as a root regulator.
+It does not support any current operation.
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
+ - all of the other standard regulator bindings as in [6]: note that, since
+   the SCMI Protocol itself aims in fact to hide away many of the operational
+   capabilities usually exposed by the properties of a standard regulator,
+   most of the usual regulator bindings could have just no effect in the
+   context of this SCMI regulator.
+
 Sensor bindings for the sensors based on SCMI Message Protocol
 --------------------------------------------------------------
 SCMI provides an API to access the various sensors on the SoC.
@@ -105,6 +127,7 @@ Required sub-node properties:
 [3] Documentation/devicetree/bindings/thermal/thermal*.yaml
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
+[6] Documentation/devicetree/bindings/regulator/regulator.yaml
 
 Example:
 
@@ -169,6 +192,25 @@ firmware {
 			reg = <0x16>;
 			#reset-cells = <1>;
 		};
+
+		scmi_voltage: protocol@17 {
+			reg = <0x17>;
+
+			regulators {
+				regulator_devX: regulator_scmi_devX@0 {
+					reg = <0x0>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator_devY: regulator_scmi_devY@9 {
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

