Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46A27F23C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgI3TCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbgI3TCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EFD20EDD;
        Wed, 30 Sep 2020 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492538;
        bh=gbz09kewMwtTMaJefpQ8k0FWcw8F+Ejm11UJ5LtfMpg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vjO6KTwJdR7Q0gMRQaSsMioeW0o7fRVW4MtrttrZ/RI+GosniWwG8Rr6Ym92PzkSq
         xeuPDVD/yHyM3FIc6/z44vncCODdF3mYHy9Dv+pXZc/nDQgsiG7U2z18uKInrcmqpy
         0drIpON26vk/jwn75ruX/FjxiBwWYl5K9DaoJqKk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/12] dt-bindings: arm: fsl: document i.MX6DL boards
Date:   Wed, 30 Sep 2020 21:01:38 +0200
Message-Id: <20200930190143.27032-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6DL based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add missed: solidrun,cubox-i/dl, solidrun,hummingboard2/dl.
2. Fix Toradex (multiple compatibles).
3. Add Review (assuming changes are not significant so keep the review).
---
 .../devicetree/bindings/arm/fsl.yaml          | 49 ++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cec7818c51f9..c90050ca3384 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -269,32 +269,53 @@ properties:
       - description: i.MX6DL based Boards
         items:
           - enum:
-              - armadeus,imx6dl-apf6      # APF6 (Solo) SoM
-              - armadeus,imx6dl-apf6dev   # APF6 (Solo) SoM on APF6Dev board
+              - boundary,imx6dl-nit6xlite     # Boundary Devices Nitrogen6 Lite
+              - boundary,imx6dl-nitrogen6x    # Boundary Devices Nitrogen6x
+              - bticino,imx6dl-mamoj      # BTicino i.MX6DL Mamoj
               - eckelmann,imx6dl-ci4x10
               - emtrion,emcon-mx6         # emCON-MX6S or emCON-MX6DL SoM
               - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
+              - engicam,imx6-icore        # Engicam i.CoreM6 Starter Kit
+              - engicam,imx6-icore-rqs    # Engicam i.CoreM6 RQS Starter Kit
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
+              - fsl,imx6dl-sabrelite      # i.MX6 DualLite SABRE Lite Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - karo,imx6dl-tx6dl         # Ka-Ro electronics TX6U Modules
               - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
+              - poslab,imx6dl-savageboard # Poslab SavageBoard Dual
               - prt,prtrvt                # Protonic RVT board
               - prt,prtvt7                # Protonic VT7 board
+              - rex,imx6dl-rex-basic      # Rex Basic i.MX6 Dual Lite Board
+              - riot,imx6s-riotboard      # RIoTboard i.MX6S
+              - solidrun,cubox-i/dl            # SolidRun Cubox-i Solo/DualLite
+              - solidrun,hummingboard/dl
+              - solidrun,hummingboard2/dl      # SolidRun HummingBoard2 Solo/DualLite
               - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
               - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
               - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
               - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico-Pi
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
-              - toradex,colibri_imx6dl          # Colibri iMX6 Module
-              - toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
-              - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri Evaluation Board V3
-              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6 Module V1.1 on Colibri Evaluation Board V3
+              - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
+              - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
               - ysoft,imx6dl-yapp4-orion  # i.MX6 DualLite Y Soft IOTA Orion board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
+      - description: i.MX6DL based Armadeus AFP6 Board
+        items:
+          - const: armadeus,imx6dl-apf6dev
+          - const: armadeus,imx6dl-apf6         # APF6 (Solo) SoM
+          - const: fsl,imx6dl
+
+      - description: i.MX6DL based DFI FS700-M60-6DL Board
+        items:
+          - const: dfi,fs700-m60-6dl
+          - const: dfi,fs700e-m60
+          - const: fsl,imx6dl
+
       - description: i.MX6DL Gateworks Ventana Boards
         items:
           - enum:
@@ -330,6 +351,22 @@ properties:
           - const: phytec,imx6dl-pfla02   # PHYTEC phyFLEX-i.MX6 Quad
           - const: fsl,imx6dl
 
+      - description: i.MX6DL Toradex Colibri iMX6 Module on Colibri
+                     Evaluation Board V3
+        items:
+          - const: toradex,colibri_imx6dl-eval-v3
+          - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
+          - const: fsl,imx6dl
+
+      - description: i.MX6DL Toradex Colibri iMX6 Module V1.1 on Colibri
+                     Evaluation Board V3
+        items:
+          - const: toradex,colibri_imx6dl-v1_1-eval-v3
+          - const: toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
+          - const: toradex,colibri_imx6dl-eval-v3
+          - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.17.1

