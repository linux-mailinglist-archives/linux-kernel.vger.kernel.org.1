Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A33627569D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:52:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48522 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgIWKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:52:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqMYe128222;
        Wed, 23 Sep 2020 05:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858342;
        bh=4PDq1GtAI42NJBwLDhQyAvPMP0khSiaIrEXQ5pWOExE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qkzq/oGYfZdkLtvdZ8RrBiA7HrHQmFCZVRXzA5h7+ZChnQFopRCDSH9DK5bT6LNgY
         6lJ8fgW3vwXFJCQ+3ENkON5ggdpDBEBiuk6VobkDlmfoKwzmCHO3ZmxfZALtpkViVx
         4gyFAQrCBbm8IY6y46an3aSPC3lhIFYxN/KbqBDM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqMOM086245;
        Wed, 23 Sep 2020 05:52:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:22 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qj059762;
        Wed, 23 Sep 2020 05:52:18 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 2/6] dt-bindings: mmc: sdhci-am654: Add documentation for input tap delay
Date:   Wed, 23 Sep 2020 16:22:02 +0530
Message-ID: <20200923105206.7988-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for input tap delay bindings.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.yaml  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index c222e057eca9..ac79f3adf20b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -114,6 +114,46 @@ properties:
     minimum: 0
     maximum: 0xf
 
+  # PHY input tap delays:
+  # Used to delay the data valid window and align it to the sampling clock for
+  # modes that don't support tuning
+
+  ti,itap-del-sel-legacy:
+    description: Input tap delay for SD/MMC legacy timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
+  ti,itap-del-sel-mmc-hs:
+    description: Input tap delay for MMC high speed timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
+  ti,itap-del-sel-sd-hs:
+    description: Input tap delay for SD high speed timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
+  ti,itap-del-sel-sdr12:
+    description: Input tap delay for SD UHS SDR12 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
+  ti,itap-del-sel-sdr25:
+    description: Input tap delay for SD UHS SDR25 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
+  ti,itap-del-sel-ddr52:
+    description: Input tap delay for MMC DDR52 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
   ti,trm-icp:
     description: DLL trim select
     $ref: "/schemas/types.yaml#/definitions/uint32"
@@ -170,6 +210,9 @@ examples:
             ti,otap-del-sel-ddr52 = <0x5>;
             ti,otap-del-sel-hs200 = <0x5>;
             ti,otap-del-sel-hs400 = <0x0>;
+            ti,itap-del-sel-legacy = <0x10>;
+            ti,itap-del-sel-mmc-hs = <0xa>;
+            ti,itap-del-sel-ddr52 = <0x3>;
             ti,trm-icp = <0x8>;
         };
     };
-- 
2.17.1

