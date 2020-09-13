Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634E2681F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgIMX5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:57:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:50540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgIMX5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:57:17 -0400
IronPort-SDR: zLVvwKHLQMNtVNDN+l6opvEo9lvEwPfIT7BxGhfrNFV7RFNUNYIz9Hjlg2ajGSVpJKmhios7d7
 g0QMUWqPzo6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146746560"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="146746560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 16:57:16 -0700
IronPort-SDR: IvDbWx6RZ5jQqGrBavqPuyGuqJId4JA/rBL/KjgLW3tl0RJG9g8Ugqws1tioCvkQfIma0dhojH
 aoFIKzG3uKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="305973473"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2020 16:57:14 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v9 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
Date:   Mon, 14 Sep 2020 07:55:21 +0800
Message-Id: <20200913235522.4316-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay eMMC PHY.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/phy/intel,lgm-emmc-phy.yaml        | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index 77bb5309918e..edd9d70a672a 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -23,7 +23,9 @@ description: |+
 
 properties:
   compatible:
-    const: intel,lgm-emmc-phy
+    oneOf:
+      - const: intel,lgm-emmc-phy
+      - const: intel,keembay-emmc-phy
 
   "#phy-cells":
     const: 0
@@ -34,6 +36,10 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    items:
+      - const: emmcclk
+
 required:
   - "#phy-cells"
   - compatible
@@ -57,4 +63,13 @@ examples:
         #phy-cells = <0>;
       };
     };
+
+  - |
+    phy@20290000 {
+          compatible = "intel,keembay-emmc-phy";
+          reg = <0x20290000 0x54>;
+          clocks = <&emmc>;
+          clock-names = "emmcclk";
+          #phy-cells = <0>;
+    };
 ...
-- 
2.17.1

