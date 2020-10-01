Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5E2804A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbgJARI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7CA208C7;
        Thu,  1 Oct 2020 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572136;
        bh=zf2FNV5yyMbYsRyZH5JG46/IBO0/dTdeKiEcToIxcnY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AbyZe0Ggb5loo2Y7yNV5GNa7qygoOEvH6Rm5wG8ZvMmMYVlxptJdA72pd61O9+uRL
         49UHw3HAa5PyhNeMTc3Ox2JSi0YxHpxFalEI1Ct5SBzVU1Zm/O7fsq3b7oYh54ensh
         wTuKfEiuceWXG58fLL4kMAOmBSCxlCokXed8bBFk=
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
Subject: [PATCH 07/12] dt-bindings: arm: fsl: document i.MX6ULL boards
Date:   Thu,  1 Oct 2020 19:07:54 +0200
Message-Id: <20201001170759.9592-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6ULL based boards.
The Armadeus boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e5e45dd7194d..2d74f02ee341 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -541,8 +541,6 @@ properties:
       - description: i.MX6ULL based Boards
         items:
           - enum:
-              - armadeus,imx6ull-opos6ul    # OPOS6UL (i.MX6ULL) SoM
-              - armadeus,imx6ull-opos6uldev # OPOS6UL (i.MX6ULL) SoM on OPOS6ULDev board
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
               - kontron,imx6ull-n6411-som # Kontron N6411 SOM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
@@ -550,6 +548,12 @@ properties:
               - toradex,colibri-imx6ull-wifi-eval # Colibri iMX6ULL Wi-Fi / BT Module on Colibri Eval Board
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
+        items:
+          - const: armadeus,imx6ull-opos6uldev  # OPOS6UL (i.MX6ULL) SoM on OPOS6ULDev board
+          - const: armadeus,imx6ull-opos6ul     # OPOS6UL (i.MX6ULL) SoM
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL PHYTEC phyBOARD-Segin
         items:
           - enum:
-- 
2.17.1

