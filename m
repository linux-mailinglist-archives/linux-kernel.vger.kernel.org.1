Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA96241D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHKPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgHKPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:39:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91AD2076C;
        Tue, 11 Aug 2020 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160368;
        bh=VmvdbQ9cWYVA92XC3xkcdIMhDtn34LN8RdKKa0ECRfw=;
        h=From:To:Subject:Date:From;
        b=oGDCJrYn2pVSlNbaLzWIuKZihkTq342auOlw8Yu7M41JBXNQ1yS+XIJuCjjdgZviI
         vJc7+Tv4gz5SGsyuH+XoNXnOsf9fkUsX5p3gG3pUQ+XQinEx7HHD5OgMnANEv4GUw7
         olCwecgbMyOCv+MbPtcQRJPr07wx/mcpeW9+cGdo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: arm: fsl: Add binding for Variscite VAR-SOM-MX8MM module
Date:   Tue, 11 Aug 2020 17:39:13 +0200
Message-Id: <20200811153916.5455-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite VAR-SOM-MX8MM System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f63895c8ce2d..d8208aa56a3d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -342,6 +342,7 @@ properties:
         items:
           - enum:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
       - description: i.MX8MN based Boards
-- 
2.17.1

