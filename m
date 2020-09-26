Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75D7279AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgIZQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgIZQ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409092177B;
        Sat, 26 Sep 2020 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137726;
        bh=EECOVOYjkAToN1DTlVY0od4/Spwba+0zKLHAjFZToMQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UIqiAL7aZSsTHMcuhICNlaRY+fMtiPvwOfVS7u1IpGgIDqqMDUbdAjaz8su8Vhs7I
         +V37khxHojfpf0bZj0XnHWmaH3BL+nCvivpqiyHzz3JVPGJMprTkM5onR8jrogLv+7
         4w6Aa9SscRk30qMxZZGg8n0ChDxae1qhwq1vARJc=
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
Subject: [PATCH 07/14] dt-bindings: arm: fsl: document i.MX51 boards
Date:   Sat, 26 Sep 2020 18:28:04 +0200
Message-Id: <20200926162811.5335-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX51 based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 93229f9746c7..b6e5691ddbd1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -129,13 +129,31 @@ properties:
               - kobo,aura
           - const: fsl,imx50
 
-      - description: i.MX51 Babbage Board
+      - description: i.MX51 based Boards
         items:
           - enum:
-              - armadeus,imx51-apf51    # APF51 SoM
-              - armadeus,imx51-apf51dev # APF51 SoM on APF51Dev board
+              - armadeus,imx51-apf51      # Armadeus Systems APF51 module
               - fsl,imx51-babbage
               - technologic,imx51-ts4800
+              - zii,imx51-scu3-esb
+          - const: fsl,imx51
+
+      - description: i.MX51 based Armadeus Systems APF51Dev Board
+        items:
+          - const: armadeus,imx51-apf51dev
+          - const: armadeus,imx51-apf51
+          - const: fsl,imx51
+
+      - description: i.MX51 based Digi ConnectCore CC(W)-MX51 JSK Board
+        items:
+          - const: digi,connectcore-ccxmx51-jsk
+          - const: digi,connectcore-ccxmx51-som
+          - const: fsl,imx51
+
+      - description: i.MX51 based Eukrea CPUIMX51 Board
+        items:
+          - const: eukrea,mbimxsd51
+          - const: eukrea,cpuimx51
           - const: fsl,imx51
 
       - description: i.MX53 based Boards
-- 
2.17.1

