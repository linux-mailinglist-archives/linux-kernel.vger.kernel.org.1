Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB98928049B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgJARIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:08:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502DE208B6;
        Thu,  1 Oct 2020 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572117;
        bh=wyVPHDH0foxV8ce8zBwqDujDO6iSy6eKWM+KpXdXJZA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PxYyOokc++Z9IVG0H9qJzCL+8wSpm9YLuptgCuwt80GIVPUaq6wFo4+f6Iq+IROE4
         EEbdcjMFS66J1yW113eBLXQMBhtRswVmmuJRdReR++qbS8wlfju18heooOfFdHD8u7
         BXlTVuLzpyie/wpy/S7cFAixmV16BI9EISewx0KU=
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
Subject: [PATCH 03/12] dt-bindings: arm: fsl: document i.MX6QP boards
Date:   Thu,  1 Oct 2020 19:07:50 +0200
Message-Id: <20201001170759.9592-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX6QP based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c11064d3ee85..c7bae70e0663 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -326,8 +326,13 @@ properties:
       - description: i.MX6QP based Boards
         items:
           - enum:
+              - boundary,imx6qp-nitrogen6_max
+              - boundary,imx6qp-nitrogen6_som2
               - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
               - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
+              - karo,imx6qp-tx6qp         # Ka-Ro electronics TX6QP-8037 Module
+              - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
+              - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
           - const: fsl,imx6qp
 
       - description: i.MX6QP PHYTEC phyBOARD-Mira
-- 
2.17.1

