Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9D279ADB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgIZQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgIZQ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A49C21527;
        Sat, 26 Sep 2020 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137737;
        bh=AMylb6ybE8mIvNAOcF2k/5j4mkhVz+YGOxbcXmYlmsc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IN7/OqmewM1ZNIoeswBuLjlETC0vvwTYZWnDQnDJryhB/LxF83TmpqHWIJPArG35y
         cu7dL3X7kW5FHCXBTJfq/715yqZuzmoBVIqjYj6PR3yTjBG64Dl0xy7n4riKAMPEy3
         5b66N7SIypQbnq6IYJv557BZ/PS4GrbNTAp1bsGo=
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
Subject: [PATCH 09/14] dt-bindings: arm: fsl: document VF boards
Date:   Sat, 26 Sep 2020 18:28:06 +0200
Message-Id: <20200926162811.5335-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for VF500 and VF600 based boards.
The Toradex Colibri Evaluation Boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 812e8d8babd8..d9c430bfe37e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -559,10 +559,26 @@ properties:
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
+          - const: toradex,vf600-colibri_vf61-on-eval
+          - const: toradex,vf600-colibri_vf61
+          - const: fsl,vf600
 
       - description: ZII's VF610 based Boards
         items:
-- 
2.17.1

