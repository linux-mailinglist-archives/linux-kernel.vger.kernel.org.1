Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC42804A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbgJARJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:09:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FF820897;
        Thu,  1 Oct 2020 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572142;
        bh=NUQShe+JVuVG8WQjOfubLE6RM0DQLaH0T9ItkkC1s/s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X7D83DRSTyC6sreNx5b/M9BbRlT+zIpMtYT1wfOocEAFJCQRh8QCB6lHB43V111sq
         cqYD8suCzJ75vDXMtPqHkBugwTGbxB9kGXj8HhCOa05xgMf8+2f8li0xBW0MjfkyUo
         1BzZi8yRQFZG1Mn2zvMeLe1ZI1v0wvHY731fS+N4=
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
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/12] dt-bindings: arm: fsl: document i.MX7S boards
Date:   Thu,  1 Oct 2020 19:07:55 +0200
Message-Id: <20201001170759.9592-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX7S based boards.
The Toradex boards use multiple compatibles.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2d74f02ee341..a465227df725 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -579,10 +579,16 @@ properties:
       - description: i.MX7S based Boards
         items:
           - enum:
-              - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
-              - toradex,colibri-imx7s-aster     # Colibri iMX7 Solo Module on Aster Carrier Board
-              - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on Colibri Evaluation Board V3
               - tq,imx7s-mba7             # i.MX7S TQ MBa7 with TQMa7S SoM
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
 
       - description: i.MX7D based Boards
-- 
2.17.1

