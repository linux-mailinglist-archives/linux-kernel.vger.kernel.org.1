Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45EE27F23A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgI3TCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3TCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5520020BED;
        Wed, 30 Sep 2020 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492530;
        bh=3EqRYwDjVTDcemChwzs32mfm3PckU9Ue4tSc7JJH+DU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cP5/N4QFfymhdNO1bzrIJTMC44vcJkYtX4um8TGUZILfV0wo4axhRV+ezXc+58AHv
         CNAs+f9xJg1k6ISOUzB7b/uX3NYMALyG7/+SxQK/bwdxnyN6KtJ7AzDXj/AvwvWCgi
         6fm1+eDJ+vlsYydRV63O5hbhF4llibX+De9mVDEY=
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
Subject: [PATCH v2 05/12] dt-bindings: arm: fsl: document i.MX53 boards
Date:   Wed, 30 Sep 2020 21:01:36 +0200
Message-Id: <20200930190143.27032-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and adjust the compatibles for i.MX53 based boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add missed: fsl,imx53-qsrb, karo,tx53, kiebackpeter,imx53-ddc,
kiebackpeter,imx53-hsc, aries,imx53-m53evk and denx,imx53-m53evk
2. Add Review (assuming changes are not significant so keep the review).
---
 .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d34617ad4af6..e96af40bf22d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -165,8 +165,27 @@ properties:
               - fsl,imx53-ard
               - fsl,imx53-evk
               - fsl,imx53-qsb
+              - fsl,imx53-qsrb                # Freescale i.MX53 Quick Start-R Board
               - fsl,imx53-smd
+              - ge,imx53-cpuvo                # General Electric CS ONE
+              - inversepath,imx53-usbarmory   # Inverse Path USB armory
+              - karo,tx53                     # Ka-Ro electronics TX53 module
+              - kiebackpeter,imx53-ddc        # K+P imx53 DDC
+              - kiebackpeter,imx53-hsc        # K+P imx53 HSC
               - menlo,m53menlo
+              - voipac,imx53-dmm-668          # Voipac i.MX53 X53-DMM-668
+          - const: fsl,imx53
+
+      - description: i.MX53 based Aries/DENX M53EVK Board
+        items:
+          - const: aries,imx53-m53evk
+          - const: denx,imx53-m53evk
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

