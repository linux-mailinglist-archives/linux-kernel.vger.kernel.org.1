Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47A27F2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgI3TCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38065 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbgI3TCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4229D2084C;
        Wed, 30 Sep 2020 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492534;
        bh=M1Py9/Gso3DHX3547W9Q4e08jxv1PRRFTnSFck+jJrI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mv/nxmzc+7RBFNMMCxupzUyGjeA+37+Egsuwm2b78SvKRtBU31SYJylX0p+9N6L1+
         YbEWkacCiKHqmahyqwwD1CZuOKrftKN5jnmZRhCcGPwVwQ8DWgVHpHHQlIpelA53pS
         qdzvHx74CwGMvmlIBgTrAJucicPtEitzCZ+FFkN8=
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
Subject: [PATCH v2 06/12] dt-bindings: arm: fsl: document VF boards
Date:   Wed, 30 Sep 2020 21:01:37 +0200
Message-Id: <20200930190143.27032-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for VF500 and VF600 based boards.
The Toradex Colibri Evaluation Boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Fix VF610 Toradex compatibles.
2. Add Review (assuming changes are not significant so keep the review).
---
 .../devicetree/bindings/arm/fsl.yaml          | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e96af40bf22d..cec7818c51f9 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -571,10 +571,26 @@ properties:
               - fsl,vf600
               - fsl,vf610
               - fsl,vf610m4
-              - toradex,vf500-colibri_vf50              # Colibri VF50 Module
-              - toradex,vf500-colibri_vf50-on-eval      # Colibri VF50 Module on Colibri Evaluation Board
-              - toradex,vf610-colibri_vf61              # Colibri VF61 Module
-              - toradex,vf610-colibri_vf61-on-eval      # Colibri VF61 Module on Colibri Evaluation Board
+
+      - description: Toradex Colibri VF50 Module on Colibri Evaluation Board
+        items:
+          - const: toradex,vf500-colibri_vf50-on-eval
+          - const: toradex,vf500-colibri_vf50
+          - const: fsl,vf500
+
+      - description: VF610 based Boards
+        items:
+          - enum:
+              - lwn,bk4                   # Liebherr BK4 controller
+              - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
+              - fsl,vf610-twr             # VF610 Tower Board
+          - const: fsl,vf610
+
+      - description: Toradex Colibri VF61 Module on Colibri Evaluation Board
+        items:
+          - const: toradex,vf610-colibri_vf61-on-eval
+          - const: toradex,vf610-colibri_vf61
+          - const: fsl,vf610
 
       - description: ZII's VF610 based Boards
         items:
-- 
2.17.1

