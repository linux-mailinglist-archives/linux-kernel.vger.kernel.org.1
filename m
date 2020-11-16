Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD02B45AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgKPOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:19:51 -0500
Received: from out28-193.mail.aliyun.com ([115.124.28.193]:53073 "EHLO
        out28-193.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgKPOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:19:51 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7611277|0.8395645;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0296191-0.00170077-0.96868;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.IxS0Otf_1605536372;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IxS0Otf_1605536372)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 16 Nov 2020 22:19:46 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        kishon@ti.com, vkoul@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v9 2/3] dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
Date:   Mon, 16 Nov 2020 22:19:05 +0800
Message-Id: <20201116141906.11758-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
References: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Ingenic USB PHY bindings from Documentation/devicetree/bindings/usb
to Documentation/devicetree/bindings/phy, and add bindings for JZ4775 SoC
and X2000 SoC.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v8:
    New patch.
    
    v8->v9:
    Correct the path errors in "ingenic,phy-usb.yaml" and "ingenic,cgu.yaml".

 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml              | 2 +-
 .../{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml}         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 5dd7ea8a78e4..c65b9458c0b6 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -92,7 +92,7 @@ required:
 
 patternProperties:
   "^usb-phy@[a-f0-9]+$":
-    allOf: [ $ref: "../usb/ingenic,jz4770-phy.yaml#" ]
+    allOf: [ $ref: "../phy/ingenic,phy-usb.yaml#" ]
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
similarity index 89%
rename from Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
rename to Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
index 2d61166ea5cf..0fd93d71fe5a 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/usb/ingenic,jz4770-phy.yaml#
+$id: http://devicetree.org/schemas/phy/ingenic,phy-usb.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Ingenic SoCs USB PHY devicetree bindings
@@ -17,9 +17,11 @@ properties:
   compatible:
     enum:
       - ingenic,jz4770-phy
+      - ingenic,jz4775-phy
       - ingenic,jz4780-phy
       - ingenic,x1000-phy
       - ingenic,x1830-phy
+      - ingenic,x2000-phy
 
   reg:
     maxItems: 1
-- 
2.11.0

