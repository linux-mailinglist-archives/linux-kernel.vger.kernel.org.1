Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97E279AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgIZQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgIZQ2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:28:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F8621D7F;
        Sat, 26 Sep 2020 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137731;
        bh=tLYHsIQz0kyEg4rNxWurZvdqXp6hQKoJuMtBYM6Cn28=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EnSR3cBWi7acD1IQnSIYFzBhKOhlL9AwlnfGnD5L4mpvtWUIvOfh9nnho4iMO2g0p
         O0FiTL2sEr6aR38OLVkegsStDrMuaC3pwToNo8qJ6ZEB+/5LY9QwK9969HSO5OsPvP
         9UyzCUewpUZQE7B3x5StOOq8EHnCwL0rp7i6MT/k=
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
Subject: [PATCH 08/14] dt-bindings: arm: fsl: document i.MX53 boards
Date:   Sat, 26 Sep 2020 18:28:05 +0200
Message-Id: <20200926162811.5335-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX53 based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b6e5691ddbd1..812e8d8babd8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -164,7 +164,16 @@ properties:
               - fsl,imx53-evk
               - fsl,imx53-qsb
               - fsl,imx53-smd
+              - ge,imx53-cpuvo                # General Electric CS ONE
+              - inversepath,imx53-usbarmory   # Inverse Path USB armory
               - menlo,m53menlo
+              - voipac,imx53-dmm-668          # Voipac i.MX53 X53-DMM-668
+          - const: fsl,imx53
+
+      - description: i.MX53 based TQ MBa53 Board
+        items:
+          - const: tq,mba53
+          - const: tq,tqma53
           - const: fsl,imx53
 
       - description: i.MX6Q based Boards
-- 
2.17.1

