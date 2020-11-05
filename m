Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F106B2A8662
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgKESsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKESsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:48:20 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A904C2151B;
        Thu,  5 Nov 2020 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604602099;
        bh=ICg+iCR0wUOZVAgLdPZp8iVd/wpqyXT19G/UJudFrA0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DwGPp3ay3QQpHaDqQks4vK2H7k5u7R8072rww5WxPCLY5w675ToMLXAsFFDatS2uq
         NWI9UuWRoc0uBpF4q6F50gthfcmV7tVhREVZe2sxLrLTYcFLZKrLlO3vQ0ylmyc4zf
         74gM16ftAIZnYEykAXi/jShmzLe+jwYm3626fTT0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: document SolidRun LX2160A boards
Date:   Thu,  5 Nov 2020 19:48:08 +0100
Message-Id: <20201105184808.216384-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105184808.216384-1-krzk@kernel.org>
References: <20201105184808.216384-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for SolidRun LX2160A based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 325fee3c1900..fcbb30a786a1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -896,6 +896,14 @@ properties:
               - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
+      - description: SolidRun LX2160A based Boards
+        items:
+          - enum:
+              - solidrun,clearfog-cx
+              - solidrun,honeycomb
+          - const: solidrun,lx2160a-cex7
+          - const: fsl,lx2160a
+
       - description: S32V234 based Boards
         items:
           - enum:
-- 
2.25.1

