Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83727F234
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgI3TCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbgI3TCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:07 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A8320B1F;
        Wed, 30 Sep 2020 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492526;
        bh=19VM5sLAPjXG/8MAMxxTTdDoyIFXxm3o83MDvQ//eUc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Cu6dljj88C7sdNFgXtsyLUVMOJP552bD4XgzyJcVMFuRKVr4BHTmSQCqXqopOK3SA
         dCuHe6hbF6G3QAv6aJ/4crWbySt3R0iNHy5/mgFadpOczh/fGGLzb8Iq9wEkHgZplf
         kHLqHtBMcEqH8iTo0CpX1Nyo6LNma0koV8QpGamk=
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
Subject: [PATCH v2 04/12] dt-bindings: arm: fsl: document i.MX51 boards
Date:   Wed, 30 Sep 2020 21:01:35 +0200
Message-Id: <20200930190143.27032-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX51 based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add missed: zii,imx51-scu2-mezz and zii,imx51-rdu1
2. Add Ack
---
 .../devicetree/bindings/arm/fsl.yaml          | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 93229f9746c7..d34617ad4af6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -129,13 +129,33 @@ properties:
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
+              - zii,imx51-scu2-mezz
+              - zii,imx51-rdu1
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

