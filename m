Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CC3015C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbhAWOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:19:17 -0500
Received: from aposti.net ([89.234.176.197]:32836 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAWOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:19:15 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] dt-bindings/phy: ingenic: Add compatibles for JZ4760(B) SoCs
Date:   Sat, 23 Jan 2021 14:18:24 +0000
Message-Id: <20210123141825.15481-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible strings,
and make the ingenic,jz4770-phy compatible string require
ingenic,jz4760-phy as a fallback, since both work the same, and the
JZ4760 SoC is older.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Fix indentation

 .../bindings/phy/ingenic,phy-usb.yaml         | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
index 0fd93d71fe5a..d59c697ed81e 100644
--- a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
+++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
@@ -15,13 +15,19 @@ properties:
     pattern: '^usb-phy@.*'
 
   compatible:
-    enum:
-      - ingenic,jz4770-phy
-      - ingenic,jz4775-phy
-      - ingenic,jz4780-phy
-      - ingenic,x1000-phy
-      - ingenic,x1830-phy
-      - ingenic,x2000-phy
+    oneOf:
+      - enum:
+          - ingenic,jz4760-phy
+          - ingenic,jz4775-phy
+          - ingenic,jz4780-phy
+          - ingenic,x1000-phy
+          - ingenic,x1830-phy
+          - ingenic,x2000-phy
+      - items:
+          - enum:
+              - ingenic,jz4760b-phy
+              - ingenic,jz4770-phy
+          - const: ingenic,jz4760-phy
 
   reg:
     maxItems: 1
@@ -48,7 +54,7 @@ examples:
   - |
     #include <dt-bindings/clock/jz4770-cgu.h>
     otg_phy: usb-phy@3c {
-      compatible = "ingenic,jz4770-phy";
+      compatible = "ingenic,jz4770-phy", "ingenic,jz4760-phy";
       reg = <0x3c 0x10>;
 
       vcc-supply = <&vcc>;
-- 
2.29.2

