Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE85270E6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgISONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 10:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 10:13:47 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE4D2085B;
        Sat, 19 Sep 2020 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524827;
        bh=8wAw0Q365W7tsmcBMClDmjAwWiPQu9hbx67W53TmY4M=;
        h=From:To:Cc:Subject:Date:From;
        b=SjdNaCRBoD65sHqiWenIGm3StGBa0mWgFeq3pNSQhd+9fUnYENVpaNPQCXjw/tje5
         B/71stHiFa31PSxJp9J/UaWT5V29pcg9dFBfctumegzlrgGmseo0cuHYS3E6N0PWvE
         r0TiJ2gVxao/oKXuEV9CSEDkbxYiQECouPWVNiVg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MN
Date:   Sat, 19 Sep 2020 16:13:30 +0200
Message-Id: <20200919141332.5095-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite Symphony evaluation kit board with
VAR-SOM-MX8MN System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 37cef8653541..8a8284715baf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -363,6 +363,12 @@ properties:
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
 
+      - description: Variscite VAR-SOM-MX8MN based boards
+        items:
+          - const: variscite,var-som-mx8mn-symphony
+          - const: variscite,var-som-mx8mn
+          - const: fsl,imx8mn
+
       - description: i.MX8MP based Boards
         items:
           - enum:
-- 
2.17.1

