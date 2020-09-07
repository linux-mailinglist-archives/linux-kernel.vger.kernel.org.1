Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1B25FDF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgIGQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgIGP77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:59:59 -0400
Received: from mail.kernel.org (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5840521473;
        Mon,  7 Sep 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494379;
        bh=y+HaSJ5DamzNsnw7uVNpEE+xv+fRAimb14ck/lGaCO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ds/FWSmywqBt2KxLzzGQNl/FIa09haorvqP8hvXcP8rYUjt5LPgVwlW2pNKR/UlMI
         KtO9GlYLP3kkLEFtmap/d9rh1WU2wpjRwxeORJ1dNBcMY5Pfm6s4KAnJoxVHsD+NIG
         41YHaRq8+PeLxgnydsA2vzL8rjE27Mce7A242luM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFJYP-00ATur-9d; Mon, 07 Sep 2020 17:59:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 06/11] dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
Date:   Mon,  7 Sep 2020 17:59:30 +0200
Message-Id: <8c95bb169195e9d0e4ef840fd31be8a473d80fb7.1599493845.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599493845.git.mchehab+huawei@kernel.org>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new YAML for this physical layer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 72 +++++++++++++++++++
 .../bindings/phy/phy-hi3670-usb3.txt          | 25 -------
 2 files changed, 72 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
new file mode 100644
index 000000000000..125a5d6546ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Kirin970 USB PHY
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+description: |+
+  Bindings for USB3 PHY on HiSilicon Kirin 970.
+
+properties:
+  compatible:
+    const: hisilicon,hi3670-usb-phy
+
+  "#phy-cells":
+    const: 0
+
+  hisilicon,pericrg-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control iso refclk.
+
+  hisilicon,pctrl-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control usb tcxo.
+
+  hisilicon,sctrl-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control phy deep sleep.
+
+  hisilicon,eye-diagram-param:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Eye diagram for phy.
+
+  hisilicon,tx-vboost-lvl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TX level vboost for phy.
+
+required:
+  - compatible
+  - hisilicon,pericrg-syscon
+  - hisilicon,pctrl-syscon
+  - hisilicon,sctrl-syscon
+  - hisilicon,eye-diagram-param
+  - hisilicon,tx-vboost-lvl
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      usb3_otg_bc: usb3_otg_bc@ff200000 {
+        compatible = "syscon", "simple-mfd";
+        reg = <0x0 0xff200000 0x0 0x1000>;
+
+        usb_phy {
+          compatible = "hisilicon,hi3670-usb-phy";
+          #phy-cells = <0>;
+          hisilicon,pericrg-syscon = <&crg_ctrl>;
+          hisilicon,pctrl-syscon = <&pctrl>;
+          hisilicon,sctrl-syscon = <&sctrl>;
+          hisilicon,eye-diagram-param = <0xfdfee4>;
+          hisilicon,tx-vboost-lvl = <0x5>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
deleted file mode 100644
index 2fb27cb8beaf..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Hisilicon Kirin970 usb PHY
------------------------
-
-Required properties:
-- compatible: should be "hisilicon,hi3670-usb-phy"
-- #phy-cells: must be 0
-- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
-- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
-- hisilicon,sctrl-syscon: phandle of syscon used to control phy.
-- hisilicon,usb31-misc-syscon: phandle of syscon used to control phy.
-- eye-diagram-param: parameter set for phy
-- usb3-phy-tx-vboost-lvl: parameter set for phy
-Refer to phy/phy-bindings.txt for the generic PHY binding properties
-
-Example:
-	usb_phy: usbphy {
-		compatible = "hisilicon,hi3670-usb-phy";
-		#phy-cells = <0>;
-		hisilicon,pericrg-syscon = <&crg_ctrl>;
-		hisilicon,pctrl-syscon = <&pctrl>;
-		hisilicon,sctrl-syscon = <&sctrl>;
-		hisilicon,usb31-misc-syscon = <&usb31_misc>;
-		eye-diagram-param = <0xFDFEE4>;
-		usb3-phy-tx-vboost-lvl = <0x5>;
-	};
-- 
2.26.2

