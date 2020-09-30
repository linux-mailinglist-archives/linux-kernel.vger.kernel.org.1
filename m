Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4573727F246
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgI3TCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbgI3TCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E192084C;
        Wed, 30 Sep 2020 19:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492557;
        bh=Z3L3Yuq/V60a2ljIUVaReww1HR355+ZvppGm8GE7ytE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kSH3dcGhjai0MWCWZyN97TkzSZgcs8HB+86aDp1zp97u4wVF7XymPExGqntY+LiWo
         of+nG+CJsbVTV+ZrdYYMDzgQ21moE/TmNyRV8XZtTG6S3c9ETRBbLn+4m6zIDclkol
         sNfz7GLsY6duV+b6ZkIkF7VXocJZxWSqLJ9dZaqY=
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
Subject: [PATCH v2 12/12] dt-bindings: arm: fsl: document i.MX6Q boards
Date:   Wed, 30 Sep 2020 21:01:43 +0200
Message-Id: <20200930190143.27032-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6Q based boards.
The Toradex Boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 56 +++++++++++++++++--
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fc3a837d7dba..0e4da88b81af 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -191,29 +191,58 @@ properties:
       - description: i.MX6Q based Boards
         items:
           - enum:
-              - armadeus,imx6q-apf6       # APF6 (Quad/Dual) SoM
-              - armadeus,imx6q-apf6dev    # APF6 (Quad/Dual) SoM on APF6Dev board
+              - auvidea,h100              # Auvidea H100
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
               - logicpd,imx6q-logicpd
               - prt,prti6q                # Protonic PRTI6Q board
               - prt,prtwd2                # Protonic WD2 board
+              - solidrun,cubox-i/q        # SolidRun Cubox-i Dual/Quad
+              - solidrun,hummingboard/q
+              - solidrun,hummingboard2/q
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
+              - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - zealz,imx6q-gk802         # Zealz GK802
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
+      - description: i.MX6Q DFI FS700-M60-6QD Board
+        items:
+          - const: dfi,fs700-m60-6qd
+          - const: dfi,fs700e-m60
           - const: fsl,imx6q
 
       - description: i.MX6Q Gateworks Ventana Boards
@@ -252,6 +281,21 @@ properties:
           - const: phytec,imx6q-pfla02    # PHYTEC phyFLEX-i.MX6 Quad
           - const: fsl,imx6q
 
+      - description: i.MX6Q Toradex Apalis iMX6Q/D Module Boards
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

