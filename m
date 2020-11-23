Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B62C1664
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgKWUR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:17:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2130 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733206AbgKWURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:17:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d80001>; Mon, 23 Nov 2020 12:17:28 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:22 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:21 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
Date:   Mon, 23 Nov 2020 12:17:23 -0800
Message-ID: <1606162645-22326-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162648; bh=HuoDnHcnGhEevhf1Zh/7gdjVQApYfl/WHCoySUA+VnE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=SA4t3Q7JCHtrQp4YzKIBDBPjjJyWdGfYwF0yD+B6co/GZ7KAqALhkl3EiYHlYdQEB
         EPxMNZvbuZtMdUEGD9whFDtljTJaIv9A6qWDR9onlSorSmiPKoY9YTcE9k1nmAfE+i
         a3IbOiM4T3j70CHkK0bk82GVRUPVj0PcMmExTui/4d0PZYnjQ/OmCx6vNKEcwCXBdm
         Qh5JynvFhCxb8kP245gnRjflO7pJcnW7JRzwg/OI10++LL5ouav4S9d2N6T95E2uZj
         dsfdeyc/f+zJ2xCy4YbzzJVqomv7QeGOU4oMtMGbTwalvqXkLp7QfFtFh78jMHupZ3
         O4qUUePh20V0w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt-bindings documentation for Tegra186 AHCI
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
index 3c15aea..a75e9a8 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -16,6 +16,7 @@ properties:
       - nvidia,tegra124-ahci
       - nvidia,tegra132-ahci
       - nvidia,tegra210-ahci
+      - nvidia,tegra186-ahci
 
   reg:
     minItems: 2
@@ -37,14 +38,31 @@ properties:
     maxItems: 2
 
   reset-names:
+    minItems: 2
     items:
       - const: sata
       - const: sata-cold
       - const: sata-oob
 
   resets:
+    minItems: 2
     maxItems: 3
 
+  iommus:
+    maxItems: 1
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  interconnects:
+    maxItems: 2
+
+  power-domains:
+    items:
+      - description: SAX power-domain
+
   phy-names:
     items:
       - const: sata-0
@@ -114,6 +132,26 @@ allOf:
         resets:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-ahci
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reset-names:
+          maxItems: 2
+        resets:
+          maxItems: 2
+      required:
+        - iommus
+        - interconnect-names
+        - interconnects
+        - power-domains
+
 additionalProperties: true
 
 examples:
-- 
2.7.4

