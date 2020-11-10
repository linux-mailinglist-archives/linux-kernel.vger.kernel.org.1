Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288132ADEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgKJSuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbgKJSuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:50:44 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015722151B;
        Tue, 10 Nov 2020 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605034244;
        bh=stpmKJ6Ghannbzs0w4nBwfvNxGGzjoMNtrfzVEYhqAA=;
        h=From:To:Cc:Subject:Date:From;
        b=NPXaaC7E3I4frwEtLwR7TOxIjhI/XsGFmhZyOHLwV7hBmqoOjBF8GhNqriuwwR1LF
         XBx7grwOvQBRQJ9EImWLYnC5ovEIUUr5Dq7StsCSMxNUe3A6c50uVFdaXdmD0SIDBy
         /c2YWADtgwdiXwAlQLk0I11E1nmpxJ3UC10563CM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: document i.MX7S boards
Date:   Tue, 10 Nov 2020 19:50:33 +0100
Message-Id: <20201110185034.37315-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX7S based boards.
The Toradex boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Rebase,
2. Add Rob's review.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e4db0f9ed664..1977a23c2c53 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -579,9 +579,15 @@ properties:
       - description: i.MX7S based Boards
         items:
           - enum:
-              - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
-              - toradex,colibri-imx7s-aster     # Colibri iMX7 Solo Module on Aster Carrier Board
-              - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on Colibri Evaluation Board V3
+              - element14,imx7s-warp      # Element14 Warp i.MX7 Board
+          - const: fsl,imx7s
+
+      - description: i.MX7S Boards with Toradex Colibri iMX7S Module
+        items:
+          - enum:
+              - toradex,colibri-imx7s-aster     # Module on Aster Carrier Board
+              - toradex,colibri-imx7s-eval-v3   # Module on Colibri Evaluation Board V3
+          - const: toradex,colibri-imx7s
           - const: fsl,imx7s
 
       - description: TQ-Systems TQMa7S SoM on MBa7x board
-- 
2.25.1

