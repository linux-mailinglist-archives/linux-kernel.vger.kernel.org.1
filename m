Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C595A29EF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgJ2PP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:15:56 -0400
Received: from smtp2.axis.com ([195.60.68.18]:28898 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgJ2PPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1395; q=dns/txt; s=axis-central1;
  t=1603984553; x=1635520553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeIIJT1gCQfMsHZdJKBhBlztMLv9rHpY1PvK4SewrQo=;
  b=LYUKZsxViOKNOdhNmjU/Zy9DC9tTSMi3sb6SJnjaAEOdV21KADUNGy+M
   07B8e4+/hIq2jMqNNbny4VaWK6Lr8pCvsGts8A7zo56NfFelN38fRKIOS
   eZA1GRF5N4d+WZORDeH8BZNSxRzaieF3gQk7yalRiWTUvg6W6TDkH2prg
   ENel2B0HW639XDdCnwOQ9Hsd2lCQKM6Pv3dgjQx3B0Iy+bWErsjGYXNP3
   YO3bTOJrpSYAQP8lJfqgmpCPIZ0mp9+AIBHFgSwMbRSACGzFfZGTt5q4b
   Agw4gri8yIlNYtDR+Kp8uEGc0PckNs0y2+8yGykO2kFOrwYhdY3s1LNW1
   Q==;
IronPort-SDR: Fkscksm8bkMFMgDRNalXjfNU7UQo25DeXYYyYhKl5mfptS0CUKmX31gC76CiiL6PMe9ekkBc9S
 Z4Kh66G4zpY7sJPc7HWYSyeBeY30EutMY7+4hkRDlbuNOFxJFzz88SM2mhHl5LhPb/PfVikUyW
 PrqO3NNAZiD0Tk/wia3uMIH1UGMWvuHickdUfhOEyQTfLATRLvg7bsEUOKaGYQrQ3TNXUG56Ny
 vFPsToGJKkHEBGErVMgsAxmi4B7D5HLrp4yKhi3Z28GUjwg+bFkpALEzTAAWrOFYSm08gH2GsF
 kuE=
X-IronPort-AV: E=Sophos;i="5.77,430,1596492000"; 
   d="scan'208";a="14049651"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <support.opensource@diasemi.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] dt-bindings: regulator: Add DA9121
Date:   Thu, 29 Oct 2020 16:15:37 +0100
Message-ID: <20201029151538.23463-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029151538.23463-1-vincent.whitchurch@axis.com>
References: <20201029151538.23463-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Dialog Semiconductor DA9121 voltage regulator.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
new file mode 100644
index 000000000000..2e67cc164da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/dlg,da9121.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9121 voltage regulator
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: dlg,da9121
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      regulator@68 {
+        compatible = "dlg,da9121";
+        reg = <0x68>;
+
+        regulator-min-microvolt = <675000>;
+        regulator-max-microvolt = <825000>;
+      };
+    };
+
+...
-- 
2.28.0

