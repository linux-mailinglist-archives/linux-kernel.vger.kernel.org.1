Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBEF250921
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHXTSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXTSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:18:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35272087D;
        Mon, 24 Aug 2020 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296711;
        bh=WVP6oGGfC5rnAdSwsJYUk7a337MOLI3+hbhVgHn88+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbhfON3U0TnVrfktzvauAlbTGBDar3LN76k096yFHIna2QHqCWSjPNWR2oTv0o2rE
         5GnZEdZjF7J92hD705x5egGkq9GMApIFRtivOkFZ7tXgD8PLyD/IoRZx+CChmURPaW
         JwSgzziLCzHbezsZA5+LXf9InrgV5h9goewV7KBw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MM
Date:   Mon, 24 Aug 2020 21:18:17 +0200
Message-Id: <20200824191819.11057-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824191819.11057-1-krzk@kernel.org>
References: <20200824191819.11057-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite Symphony evaluation kit board with
VAR-SOM-MX8MM System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 39f3a3d5f524..b378297c390a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -349,6 +349,12 @@ properties:
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
+      - description: Variscite VAR-SOM-MX8MM based boards
+        items:
+          - const: variscite,var-som-mx8mm-symphony
+          - const: variscite,var-som-mx8mm
+          - const: fsl,imx8mm
+
       - description: i.MX8MN based Boards
         items:
           - enum:
-- 
2.17.1

