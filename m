Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4225611E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 21:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH1TUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 15:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgH1TUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:20:48 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585882073A;
        Fri, 28 Aug 2020 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642448;
        bh=Dd93FE9oQpev+CVY2ipzNLkXaKzEf3vCB92IiF1lQ2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=VonmhDxf/JRylSInuRvDeO2JGgW/YHN1EdjvQfXOZElmu2Qtqr2/V7StFOSH9LRT1
         rmRmx0h8WuTAu/ke2we0v+40aGO2D8HPmr26gjT5A9WAIuROz78VShOOjaztrN5w7G
         VD8ARDgOTmiqVV3cegtVqlWZq4+zhoesR6GSVw/k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] dt-bindings: mtd: nand-controller: Fix matching with size-cells==1
Date:   Fri, 28 Aug 2020 21:20:34 +0200
Message-Id: <20200828192037.22897-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of Freescale/NXP GPMI device trees use size-cells==1 (even when
actually not needed except few boards).  This fixes dtbs_check warnings
like:

    arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: #size-cells:0:0: 0 was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 40fc5b0b2b8c..0879e1108837 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -34,7 +34,10 @@ properties:
     const: 1
 
   "#size-cells":
-    const: 0
+    description:
+      Depends on your controller. Put zero unless you need a mapping between CS
+      lines and dedicated memory regions.
+    enum: [0, 1]
 
   ranges: true
 
-- 
2.17.1

