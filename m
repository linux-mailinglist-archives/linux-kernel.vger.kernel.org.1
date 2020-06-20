Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013D820392A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgFVO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:26:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgFVO0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68BD4C1E2;
        Mon, 22 Jun 2020 14:26:30 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: arm: realtek: Convert comments to descriptions
Date:   Sun, 21 Jun 2020 01:32:25 +0200
Message-Id: <20200620233227.31585-2-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620233227.31585-1-afaerber@suse.de>
References: <20200620233227.31585-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn the SoC-level comments into description properties.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4: New
 
 .../devicetree/bindings/arm/realtek.yaml      | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index 845f9c76d6f7..0b388016bbcd 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -14,21 +14,21 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      # RTD1195 SoC based boards
-      - items:
+      - description: RTD1195 SoC based boards
+        items:
           - enum:
               - mele,x1000 # MeLE X1000
               - realtek,horseradish # Realtek Horseradish EVB
           - const: realtek,rtd1195
 
-      # RTD1293 SoC based boards
-      - items:
+      - description: RTD1293 SoC based boards
+        items:
           - enum:
               - synology,ds418j # Synology DiskStation DS418j
           - const: realtek,rtd1293
 
-      # RTD1295 SoC based boards
-      - items:
+      - description: RTD1295 SoC based boards
+        items:
           - enum:
               - mele,v9 # MeLE V9
               - probox2,ava # ProBox2 AVA
@@ -36,21 +36,21 @@ properties:
               - zidoo,x9s # Zidoo X9S
           - const: realtek,rtd1295
 
-      # RTD1296 SoC based boards
-      - items:
+      - description: RTD1296 SoC based boards
+        items:
           - enum:
               - synology,ds418 # Synology DiskStation DS418
           - const: realtek,rtd1296
 
-      # RTD1395 SoC based boards
-      - items:
+      - description: RTD1395 SoC based boards
+        items:
           - enum:
               - bananapi,bpi-m4 # Banana Pi BPI-M4
               - realtek,lion-skin # Realtek Lion Skin EVB
           - const: realtek,rtd1395
 
-      # RTD1619 SoC based boards
-      - items:
+      - description: RTD1619 SoC based boards
+        items:
           - enum:
               - realtek,mjolnir # Realtek Mjolnir EVB
           - const: realtek,rtd1619
-- 
2.26.2

