Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1178B2AA446
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgKGJt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:49:28 -0500
Received: from out29-220.mail.aliyun.com ([115.124.29.220]:48053 "EHLO
        out29-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgKGJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:49:27 -0500
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6530924|-1;BR=01201311R181b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.021109-0.0118095-0.967081;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.ItlkgfC_1604742507;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.ItlkgfC_1604742507)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sat, 07 Nov 2020 17:49:22 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v8 2/3] dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
Date:   Sat,  7 Nov 2020 17:47:57 +0800
Message-Id: <20201107094758.83291-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107094758.83291-1-zhouyanjie@wanyeetech.com>
References: <20201107094758.83291-1-zhouyanjie@wanyeetech.com>
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

 .../{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml}         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
similarity index 89%
rename from Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
rename to Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
index 2d61166ea5cf..9f855984c535 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/usb/ingenic,jz4770-phy.yaml#
+$id: http://devicetree.org/schemas/usb/ingenic,phy-usb.yaml#
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

