Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC12804A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgJARJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:09:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8781A20B1F;
        Thu,  1 Oct 2020 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572146;
        bh=4JBLH4A2eu8qyVXhGw1PCZfwp/HspA60MEWcKjKyNX8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oSm70NCCYFaLKMghGxAea+67Re1NWj8jl8hqgWMZ9ieJjDlVGJfu2sNBoRCQhMB/T
         ZAmYlwZFl8qpVvQMxmoDPidIWu8Q4J2u7yrcrl7q7DAALzEWfDit60QFy/eeqQiMDL
         w6OmRbuDUNYn3c/p1hEaH/Caj/dJ6701Qi5Ign1M=
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
Subject: [PATCH 09/12] dt-bindings: arm: fsl: document i.MX7D boards
Date:   Thu,  1 Oct 2020 19:07:56 +0200
Message-Id: <20201001170759.9592-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX7D based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a465227df725..bcff376a851e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -594,6 +594,8 @@ properties:
       - description: i.MX7D based Boards
         items:
           - enum:
+              - boundary,imx7d-nitrogen7
+              - compulab,cl-som-imx7      # CompuLab CL-SOM-iMX7
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
@@ -626,6 +628,22 @@ properties:
           - const: compulab,cl-som-imx7
           - const: fsl,imx7d
 
+      - description: i.MX7D Boards with Toradex Colibri i.MX7D Module
+        items:
+          - enum:
+              - toradex,colibri-imx7d-aster   # Module on Aster Carrier Board
+              - toradex,colibri-imx7d-eval-v3 # Module on Colibri Evaluation Board V3
+          - const: toradex,colibri-imx7d
+          - const: fsl,imx7d
+
+      - description: i.MX7D Boards with Toradex Colibri i.MX7D eMMC Module
+        items:
+          - enum:
+              - toradex,colibri-imx7d-emmc-aster    # Module on Aster Carrier Board
+              - toradex,colibri-imx7d-emmc-eval-v3  # Module on Colibri Evaluation Board V3
+          - const: toradex,colibri-imx7d-emmc
+          - const: fsl,imx7d
+
       - description: i.MX7ULP based Boards
         items:
           - enum:
-- 
2.17.1

