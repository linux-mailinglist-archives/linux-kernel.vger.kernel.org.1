Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C221E9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGNHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:21:59 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:45287 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgGNHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:21:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4157819|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0382117-0.00440686-0.957381;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.I1TyhlI_1594711307;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1TyhlI_1594711307)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 14 Jul 2020 15:21:52 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        icenowy@aosc.io, megous@megous.com, clabbe@baylibre.com,
        georgii.staroselskii@emlid.com, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 15/16] dt-bindings: arm: sunxi: Add Allwinner A100 Perf1 Board bindings
Date:   Tue, 14 Jul 2020 15:21:39 +0800
Message-Id: <175a583c7d0c151274701fc442724e1a7a3f1ed8.1594708864.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594708863.git.frank@allwinnertech.com>
References: <cover.1594708863.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Document board compatible names for Allwinner A100 Perf1 Board.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 87817ff0cd35..dbec66c1377a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -16,6 +16,11 @@ properties:
   compatible:
     oneOf:
 
+      - description: Allwinner A100 Perf1 Board
+        items:
+          - const: allwinner,a100-perf1
+          - const: allwinner,sun50i-a100
+
       - description: Allwinner A23 Evaluation Board
         items:
           - const: allwinner,sun8i-a23-evb
-- 
2.24.0

