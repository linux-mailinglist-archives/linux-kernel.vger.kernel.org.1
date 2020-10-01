Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05AF280499
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgJARId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6525820897;
        Thu,  1 Oct 2020 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572111;
        bh=r+kMN5PSATSP/0niWCrmpeLPsHK0Yqeoc5bNuZNqWQc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wrSLrhJwwdD21CqDOFv8NeVDlZ6sZyiUgE60VHomVo8flarPxd/q1CDApy4cMM1EX
         +d74U1ZRAEG9aKXbQepGJ15ide0KUOJki1IJX2btkkvaI+g3WEUX/nevkSx8QyEXhl
         bBLvcNO1B1G+R80QlDZy+3PpWOu/j+rqV2np7FxU=
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
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] dt-bindings: arm: fsl: document i.MX6Q boards
Date:   Thu,  1 Oct 2020 19:07:49 +0200
Message-Id: <20201001170759.9592-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6Q based boards.
The Toradex and the Armadeus boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 83 +++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fc3a837d7dba..c11064d3ee85 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -191,29 +191,85 @@ properties:
       - description: i.MX6Q based Boards
         items:
           - enum:
-              - armadeus,imx6q-apf6       # APF6 (Quad/Dual) SoM
-              - armadeus,imx6q-apf6dev    # APF6 (Quad/Dual) SoM on APF6Dev board
+              - auvidea,h100              # Auvidea H100
+              - boundary,imx6q-nitrogen6_max
+              - boundary,imx6q-nitrogen6_som2
+              - boundary,imx6q-nitrogen6x
+              - compulab,cm-fx6           # CompuLab CM-FX6
+              - dmo,imx6q-edmqmx6         # Data Modul eDM-QMX6 Board
+              - embest,imx6q-marsboard    # Embest MarS Board i.MX6Dual
               - emtrion,emcon-mx6         # emCON-MX6D or emCON-MX6Q SoM
               - emtrion,emcon-mx6-avari   # emCON-MX6D or emCON-MX6Q SoM on Avari Base
+              - engicam,imx6-icore        # Engicam i.CoreM6 Starter Kit
+              - engicam,imx6-icore-rqs    # Engicam i.CoreM6 RQS Starter Kit
               - fsl,imx6q-arm2
               - fsl,imx6q-sabreauto
               - fsl,imx6q-sabrelite
               - fsl,imx6q-sabresd
+              - karo,imx6q-tx6q           # Ka-Ro electronics TX6Q Modules
+              - kiebackpeter,imx6q-tpc    # K+P i.MX6 Quad TPC Board
               - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
+              - kosagi,imx6q-novena       # Kosagi Novena Dual/Quad
               - logicpd,imx6q-logicpd
+              - lwn,display5              # Liebherr Display5 i.MX6 Quad Board
+              - lwn,mccmon6               # Liebherr Monitor6 i.MX6 Quad Board
+              - nutsboard,imx6q-pistachio # NutsBoard i.MX6 Quad Pistachio
+              - microsys,sbc6x            # MicroSys sbc6x board
+              - poslab,imx6q-savageboard  # Poslab SavageBoard Quad
               - prt,prti6q                # Protonic PRTI6Q board
               - prt,prtwd2                # Protonic WD2 board
+              - rex,imx6q-rex-pro         # Rex Pro i.MX6 Quad Board
+              - solidrun,cubox-i/q        # SolidRun Cubox-i Dual/Quad
+              - solidrun,hummingboard/q
+              - solidrun,hummingboard2/q
+              - tbs,imx6q-tbs2910         # TBS2910 Matrix ARM mini PC
               - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
               - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
               - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
               - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
-              - toradex,apalis_imx6q            # Apalis iMX6 Module
-              - toradex,apalis_imx6q-eval       # Apalis iMX6 Module on Apalis Evaluation Board
-              - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
-              - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
+              - toradex,apalis_imx6q      # Apalis iMX6 Module
+              - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
+              - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
+              - zealz,imx6q-gk802         # Zealz GK802
+              - zii,imx6q-zii-rdu2        # ZII RDU2 Board
+          - const: fsl,imx6q
+
+      - description: i.MX6Q Advantech DMS-BA16 Boards
+        items:
+          - enum:
+              - advantech,imx6q-dms-ba16  # Advantech DMS-BA16
+              - ge,imx6q-b450v3           # General Electric B450v3
+              - ge,imx6q-b650v3           # General Electric B650v3
+              - ge,imx6q-b850v3           # General Electric B850v3
+          - const: advantech,imx6q-ba16
+          - const: fsl,imx6q
+
+      - description: i.MX6Q Armadeus APF6 Boards
+        items:
+          - const: armadeus,imx6q-apf6dev
+          - const: armadeus,imx6q-apf6
+          - const: fsl,imx6q
+
+      - description: i.MX6Q CompuLab Utilite Pro Board
+        items:
+          - const: compulab,utilite-pro
+          - const: compulab,cm-fx6
+          - const: fsl,imx6q
+
+      - description: i.MX6Q DFI FS700-M60-6QD Board
+        items:
+          - const: dfi,fs700-m60-6qd
+          - const: dfi,fs700e-m60
+          - const: fsl,imx6q
+
+      - description: i.MX6Q DHCOM Premium Developer Kit Board
+        items:
+          - const: dh,imx6q-dhcom-pdk2
+          - const: dh,imx6q-dhcom-som
           - const: fsl,imx6q
 
       - description: i.MX6Q Gateworks Ventana Boards
@@ -252,6 +308,21 @@ properties:
           - const: phytec,imx6q-pfla02    # PHYTEC phyFLEX-i.MX6 Quad
           - const: fsl,imx6q
 
+      - description: i.MX6Q Boards with Toradex Apalis iMX6Q/D Module
+        items:
+          - enum:
+              - toradex,apalis_imx6q-ixora  # Apalis iMX6Q/D Module on Ixora Carrier Board
+              - toradex,apalis_imx6q-eval   # Apalis iMX6Q/D Module on Apalis Evaluation Board
+          - const: toradex,apalis_imx6q
+          - const: fsl,imx6q
+
+      - description: i.MX6Q Toradex Apalis iMX6Q/D Module on Ixora Carrier Board V1.1
+        items:
+          - const: toradex,apalis_imx6q-ixora-v1.1
+          - const: toradex,apalis_imx6q-ixora
+          - const: toradex,apalis_imx6q
+          - const: fsl,imx6q
+
       - description: i.MX6QP based Boards
         items:
           - enum:
-- 
2.17.1

