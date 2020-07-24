Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A575A22BE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXG44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 02:56:56 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37978 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgGXG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:56:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7691872|0.5418288;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0554704-0.000987751-0.943542;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.I6q4pv-_1595573805;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6q4pv-_1595573805)
          by smtp.aliyun-inc.com(10.147.43.230);
          Fri, 24 Jul 2020 14:56:51 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mripard@kernel.org, wens@csie.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/16] dt-bindings: clk: sunxi-ccu: add compatible string for A100 CCU and R-CCU
Date:   Fri, 24 Jul 2020 14:56:08 +0800
Message-Id: <5791b0a39e7ca2f1c11d3bade9ebeb7fece31230.1595572867.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
References: <cover.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

This patch adds binding to a100's ccu clock and r-ccu clock.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 4d382128b711..3b45344ed758 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -36,6 +36,8 @@ properties:
       - allwinner,sun9i-a80-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
+      - allwinner,sun50i-a100-ccu
+      - allwinner,sun50i-a100-r-ccu
       - allwinner,sun50i-h5-ccu
       - allwinner,sun50i-h6-ccu
       - allwinner,sun50i-h6-r-ccu
@@ -78,6 +80,7 @@ if:
         - allwinner,sun8i-a83t-r-ccu
         - allwinner,sun8i-h3-r-ccu
         - allwinner,sun50i-a64-r-ccu
+        - allwinner,sun50i-a100-r-ccu
         - allwinner,sun50i-h6-r-ccu
 
 then:
@@ -94,7 +97,9 @@ else:
   if:
     properties:
       compatible:
-        const: allwinner,sun50i-h6-ccu
+        enum:
+          - allwinner,sun50i-a100-ccu
+          - allwinner,sun50i-h6-ccu
 
   then:
     properties:
-- 
2.24.0

