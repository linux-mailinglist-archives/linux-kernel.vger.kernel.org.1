Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3825E26E514
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIQTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQS4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:56:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5EE2072E;
        Thu, 17 Sep 2020 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368978;
        bh=QLslx8xvvSMNFycKvt7rpkZkIApidu/M/FjbCmdxbuY=;
        h=From:To:Cc:Subject:Date:From;
        b=RbAcquTnuuVSgyR6J1mtPr+msxUvPOTriJ3k4t3fz1Ni/uU7XY4JRhK9NOwzSvrbD
         wajnMmCSBuoyt8sY3DmjMEAWHGVDzXAQiMwOP5MY43xB8gHv0V92tlrlP0bmdUnsaF
         CWdsuj70VRSC1UwfXmvXVFBPJ2GBHUd8XyN1cKEE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: correct interrupt flags in examples
Date:   Thu, 17 Sep 2020 20:56:13 +0200
Message-Id: <20200917185613.5905-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> # for BD70528
Acked-by: Tim Harvey <tharvey@gateworks.com> # for gateworks-gsc.yaml
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add acks
---
 Documentation/devicetree/bindings/mfd/act8945a.txt          | 2 +-
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3 ++-
 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
index e6f168db6c72..5ca75d888b4a 100644
--- a/Documentation/devicetree/bindings/mfd/act8945a.txt
+++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
@@ -71,7 +71,7 @@ Example:
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 			interrupt-parent = <&pioA>;
-			interrupts = <45 GPIO_ACTIVE_LOW>;
+			interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
 
 			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
 			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 9b6eb50606e8..e541eb0d02ed 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -147,6 +147,7 @@ required:
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -155,7 +156,7 @@ examples:
             compatible = "gw,gsc";
             reg = <0x20>;
             interrupt-parent = <&gpio1>;
-            interrupts = <4 GPIO_ACTIVE_LOW>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
             #interrupt-cells = <1>;
             #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
index c3c02ce73cde..386eec06cf08 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -39,7 +39,7 @@ pmic: pmic@4b {
 	compatible = "rohm,bd70528";
 	reg = <0x4b>;
 	interrupt-parent = <&gpio1>;
-	interrupts = <29 GPIO_ACTIVE_LOW>;
+	interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 	clocks = <&osc 0>;
 	#clock-cells = <0>;
 	clock-output-names = "bd70528-32k-out";
-- 
2.17.1

