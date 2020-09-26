Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A7279AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgIZQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbgIZQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:43 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC6E21527;
        Sat, 26 Sep 2020 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137722;
        bh=IQcWF0LLv2wdBilZG0jo6E/zaPtRl0EpMZKTNdZAWi0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qvjzoi992fZV3DXo9/ouHhbxoKy9qWdlvF8cfibeYFcM5RJtDAQcZUUxlt3QAm/BA
         rnl2dlMc3YN1fVotSq0eRDXn0HLUFmfWlUGGVTZCsMtCfMioEBgGGVWA8Pc3f8RS4V
         vhMU2WBL+Ee54gGjq4IbPUY3DMENMqc08g6Mf1zg=
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
Subject: [PATCH 06/14] dt-bindings: arm: fsl: document i.MX25 and i.MX27 boards
Date:   Sat, 26 Sep 2020 18:28:03 +0200
Message-Id: <20200926162811.5335-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX25 and i.MX27 based boards
to fix dtbs_check warnings like:

  arch/arm/boot/dts/imx27-apf27dev.dt.yaml: /: compatible:
    ['armadeus,imx27-apf27dev', 'armadeus,imx27-apf27', 'fsl,imx27'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

