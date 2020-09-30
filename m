Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25427F233
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgI3TCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3TCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE1F20C09;
        Wed, 30 Sep 2020 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492522;
        bh=nPt/PvmRGIdwYxqxYpK266o3F1HRoeTE6mS8bUkIfkw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BvJnIosVXoOT/FEYjDV9VBA1c9xx125ofXJhmkgJL1+UDNl9VJdCOcCzfv7JJkLOM
         YeEH9k4pBtAOZKn5xGEMSy1Lqb5Vl4CvRy9kQOnD7gR8gRI8IPl0BdKTIG6aJtpWqS
         7YZccHnZQBeMw9LGijD1aJsFJfd7/Z/6Fr4XvnFc=
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
Subject: [PATCH v2 03/12] dt-bindings: arm: fsl: document i.MX25 and i.MX27 boards
Date:   Wed, 30 Sep 2020 21:01:34 +0200
Message-Id: <20200930190143.27032-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX25 and i.MX27 based boards
to fix dtbs_check warnings like:

  arch/arm/boot/dts/imx27-apf27dev.dt.yaml: /: compatible:
    ['armadeus,imx27-apf27dev', 'armadeus,imx27-apf27', 'fsl,imx27'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add Review
---
 .../devicetree/bindings/arm/fsl.yaml          | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1ca9dfa8ce9a..93229f9746c7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -33,16 +33,57 @@ properties:
         items:
           - enum:
               - fsl,imx25-pdk
+              - karo,imx25-tx25
           - const: fsl,imx25
 
-      - description: i.MX27 Product Development Kit
+      - description: i.MX25 Eukrea CPUIMX25 Boards
+        items:
+          - enum:
+              - eukrea,mbimxsd25-baseboard   # Eukrea MBIMXSD25
+          - const: eukrea,cpuimx25
+          - const: fsl,imx25
+
+      - description: i.MX25 Eukrea MBIMXSD25 Boards
+        items:
+          - enum:
+              - eukrea,mbimxsd25-baseboard-cmo-qvga
+              - eukrea,mbimxsd25-baseboard-dvi-svga
+              - eukrea,mbimxsd25-baseboard-dvi-vga
+          - const: eukrea,mbimxsd25-baseboard
+          - const: eukrea,cpuimx25
+          - const: fsl,imx25
+
+      - description: i.MX27 based Boards
         items:
           - enum:
               - armadeus,imx27-apf27      # APF27 SoM
-              - armadeus,imx27-apf27dev   # APF27 SoM on APF27Dev board
               - fsl,imx27-pdk
           - const: fsl,imx27
 
+      - description: i.MX27 APF27 SoM Board
+        items:
+          - const: armadeus,imx27-apf27dev
+          - const: armadeus,imx27-apf27
+          - const: fsl,imx27
+
+      - description: i.MX27 Eukrea CPUIMX27 SoM Board
+        items:
+          - const: eukrea,mbimxsd27-baseboard
+          - const: eukrea,cpuimx27
+          - const: fsl,imx27
+
+      - description: i.MX27 Phytec pca100 Board
+        items:
+          - const: phytec,imx27-pca100-rdk
+          - const: phytec,imx27-pca100
+          - const: fsl,imx27
+
+      - description: i.MX27 Phytec pcm970 Board
+        items:
+          - const: phytec,imx27-pcm970
+          - const: phytec,imx27-pcm038
+          - const: fsl,imx27
+
       - description: i.MX28 based Boards
         items:
           - enum:
-- 
2.17.1

