Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC72804A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgJARIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DB520B1F;
        Thu,  1 Oct 2020 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572131;
        bh=cvsOlgRsiZWtW58jx5CyW9exX7pMEJFt0ck33UGvT04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1ZvPaSsw/Pb5pnrAm+AxDKSH1kcIcSMpaBiINJDun81J6IfqogoNVuPWCeZidsRJQ
         fuEKRQbhVo/l4RLaH3VuDfBtx240l+unQpJJrhtOnWmMgS84spWoObd3uHdPLGsgj4
         I1u/JsyTRmD8EBTGK665wfq/zlP6+Wl0BXm4Kq38=
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
Subject: [PATCH 06/12] dt-bindings: arm: fsl: document i.MX6UL boards
Date:   Thu,  1 Oct 2020 19:07:53 +0200
Message-Id: <20201001170759.9592-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6UL based boards.
The Armadeus boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7120e3a34339..e5e45dd7194d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -479,9 +479,10 @@ properties:
       - description: i.MX6UL based Boards
         items:
           - enum:
-              - armadeus,imx6ul-opos6ul    # OPOS6UL (i.MX6UL) SoM
-              - armadeus,imx6ul-opos6uldev # OPOS6UL (i.MX6UL) SoM on OPOS6ULDev board
+              - engicam,imx6ul-geam       # Engicam GEAM6UL Starter Kit
+              - engicam,imx6ul-isiot      # Engicam Is.IoT MX6UL eMMC/NAND Starter kit
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - karo,imx6ul-tx6ul         # Ka-Ro electronics TXUL-0010 Module
               - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
               - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
               - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
@@ -489,6 +490,26 @@ properties:
               - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
           - const: fsl,imx6ul
 
+      - description: i.MX6UL Armadeus Systems OPOS6UL SoM Board
+        items:
+          - const: armadeus,imx6ul-opos6uldev   # OPOS6UL (i.MX6UL) SoM on OPOS6ULDev board
+          - const: armadeus,imx6ul-opos6ul      # OPOS6UL (i.MX6UL) SoM
+          - const: fsl,imx6ul
+
+      - description: i.MX6UL Digi International ConnectCore 6UL Boards
+        items:
+          - enum:
+              - digi,ccimx6ulsbcexpress   # Digi International ConnectCore 6UL SBC Express
+              - digi,ccimx6ulsbcpro       # Digi International ConnectCore 6UL SBC Pro
+          - const: digi,ccimx6ulsom
+          - const: fsl,imx6ul
+
+      - description: i.MX6UL Grinn liteBoard
+        items:
+          - const: grinn,imx6ul-liteboard
+          - const: grinn,imx6ul-litesom
+          - const: fsl,imx6ul
+
       - description: i.MX6UL PHYTEC phyBOARD-Segin
         items:
           - enum:
-- 
2.17.1

