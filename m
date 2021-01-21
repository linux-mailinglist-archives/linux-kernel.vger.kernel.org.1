Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623C02FE43E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAUHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbhAUHUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:20:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DB312399C;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=ym77ocWKV10S+hX38ZBtUuhXsAT7fhTK688EHVretXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnzzLw3xmqCJTlnZoagjTZD6qXfpDn0T41gVlqVhE1m0QJiqExQ+h6XJ9hWia3ghh
         KzhLnHvXlUlsfbIqXEgK1Apo6eAqUF7NGoBLGmBZg7GtCHNUXSwIwMeF0+nyzh94Ff
         jAEiqh0XEPK0R47wvXTnrnTkInU3cUZDaUZSiYVR9Bvdj4myIorZTeRenCFk8lLfIW
         D4yByO+/BSklSX2JwS/BUmO2zd85H0Hul+DyJhkCXDIDSjPgRTh9d1PyfKwtPzwFFU
         TnJ2NWrw+Y+LK13q5XOJoEuGjuiXw/lsl8FPMte4YAMwFTiWDj+E+GEuhvEVfjmt/R
         Q2FRzAfDqz9ng==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004Bry-B5; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/21] staging: hikey9xx: hisilicon,hi6421-spmi-pmic.yaml: simplify props
Date:   Thu, 21 Jan 2021 08:18:04 +0100
Message-Id: <2c2d09e332afa6539e5e80d69b23622941fd3d3e.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all regulator-specific properties got moved to be part of the
driver, remove them from the DT spec.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 106 +++++++-----------
 1 file changed, 40 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 80e74c261e05..f385146d2bd1 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -55,47 +55,6 @@ properties:
 
         $ref: "/schemas/regulator/regulator.yaml#"
 
-        properties:
-          reg:
-            description: Enable register.
-
-          '#address-cells':
-            const: 1
-
-          '#size-cells':
-            const: 0
-
-          vsel-reg:
-            description: Voltage selector register.
-
-          enable-mask:
-            description: Bitmask used to enable the regulator.
-
-          voltage-table:
-            description: Table with the selector items for the voltage regulator.
-            minItems: 2
-            maxItems: 16
-
-          off-on-delay-us:
-            description: Time required for changing state to enabled in microseconds.
-
-          startup-delay-us:
-            description: Startup time in microseconds.
-
-          idle-mode-mask:
-            description: Bitmask used to put the regulator on idle mode.
-
-          eco-microamp:
-            description: Maximum current while on idle mode.
-
-        required:
-          - reg
-          - vsel-reg
-          - enable-mask
-          - voltage-table
-          - off-on-delay-us
-          - startup-delay-us
-
 required:
   - compatible
   - reg
@@ -117,43 +76,58 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        ldo3: ldo3@16 {
-          reg = <0x16>;
-          vsel-reg = <0x51>;
-
+        ldo3: LDO3 {
           regulator-name = "ldo3";
           regulator-min-microvolt = <1500000>;
           regulator-max-microvolt = <2000000>;
           regulator-boot-on;
-
-          enable-mask = <0x01>;
-
-          voltage-table = <1500000>, <1550000>, <1600000>, <1650000>,
-                          <1700000>, <1725000>, <1750000>, <1775000>,
-                          <1800000>, <1825000>, <1850000>, <1875000>,
-                          <1900000>, <1925000>, <1950000>, <2000000>;
-          off-on-delay-us = <20000>;
-          startup-delay-us = <120>;
         };
 
-        ldo4: ldo4@17 { /* 40 PIN */
-          reg = <0x17>;
-          vsel-reg = <0x52>;
-
+        ldo4: LDO4 {
           regulator-name = "ldo4";
           regulator-min-microvolt = <1725000>;
           regulator-max-microvolt = <1900000>;
           regulator-boot-on;
+        };
 
-          enable-mask = <0x01>;
-          idle-mode-mask = <0x10>;
-          eco-microamp = <10000>;
+        ldo9: LDO9 {
+          regulator-name = "ldo9";
+          regulator-min-microvolt = <1750000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
 
-          hi6421-vsel = <0x52 0x07>;
-          voltage-table = <1725000>, <1750000>, <1775000>, <1800000>,
-                          <1825000>, <1850000>, <1875000>, <1900000>;
-          off-on-delay-us = <20000>;
-          startup-delay-us = <120>;
+        ldo15: LDO15 {
+          regulator-name = "ldo15";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-always-on;
+        };
+
+        ldo16: LDO16 {
+          regulator-name = "ldo16";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-boot-on;
+        };
+
+        ldo17: LDO17 {
+          regulator-name = "ldo17";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+        };
+
+        ldo33: LDO33 {
+          regulator-name = "ldo33";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
+
+        ldo34: LDO34 {
+          regulator-name = "ldo34";
+          regulator-min-microvolt = <2600000>;
+          regulator-max-microvolt = <3300000>;
         };
       };
     };
-- 
2.29.2

