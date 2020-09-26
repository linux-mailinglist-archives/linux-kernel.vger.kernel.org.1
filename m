Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2220D279AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgIZQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbgIZQ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:02 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0A321D7F;
        Sat, 26 Sep 2020 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137741;
        bh=npNVEV7Z5OxfyQwo6I/VC9OyYxs+9LqftC3JxK7FS60=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U+27kWpCT4zrBEN9wPo2s1h+CwHw5prpJ8Pq/jCF6RxzC9y2hbJaOaaEucA+fU8V5
         ErLaNbL0w2Fv/aqXAeyMN8wlvyHCnuP/lCmzpR/6dWAz9n1GGzHG2CEHbU+aOgod5I
         edYzKgVs2BwWBlZbtuFkegU44gAD/5l+upKLatnE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/14] dt-bindings: arm: fsl: document i.MX6DL boards
Date:   Sat, 26 Sep 2020 18:28:07 +0200
Message-Id: <20200926162811.5335-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6DL based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d9c430bfe37e..24c79cecd815 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -257,16 +257,25 @@ properties:
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
+              - solidrun,hummingboard/dl
               - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
               - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
               - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
@@ -277,12 +286,26 @@ properties:
               - toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
               - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri Evaluation Board V3
               - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6 Module V1.1 on Colibri Evaluation Board V3
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
-- 
2.17.1

