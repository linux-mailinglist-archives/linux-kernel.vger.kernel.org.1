Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A72E2287
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgLWWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:43:38 -0500
Received: from lists.gateworks.com ([108.161.130.12]:40155 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLWWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:43:38 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1ksCeW-0007gP-6T; Wed, 23 Dec 2020 22:30:40 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add binding for Gateworks boards with IMX8MM
Date:   Wed, 23 Dec 2020 14:23:15 -0800
Message-Id: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Gateworks Venice Development kit boards with
IMX8MM System on Module.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1ca9dfa..705c6e8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -405,6 +405,9 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
+              - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
+              - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
-- 
2.7.4

