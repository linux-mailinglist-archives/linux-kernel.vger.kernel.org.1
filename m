Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88B01E4C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391824AbgE0R7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 13:59:30 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:53989 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391772AbgE0R7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:59:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4376294|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0101614-0.000677406-0.989161;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.HeTcPrZ_1590602337;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeTcPrZ_1590602337)
          by smtp.aliyun-inc.com(10.147.43.95);
          Thu, 28 May 2020 01:59:19 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v12 3/7] dt-bindings: clock: Add documentation for X1830 bindings.
Date:   Thu, 28 May 2020 01:56:31 +0800
Message-Id: <20200527175635.5558-4-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the clock bindings of the X1830 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v11:
    New patch, split from [3/6] in v10.
    
    v11->v12:
    No change.

 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 0281cd1d7e1b..a952d5811823 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -25,6 +25,7 @@ select:
           - ingenic,jz4770-cgu
           - ingenic,jz4780-cgu
           - ingenic,x1000-cgu
+          - ingenic,x1830-cgu
   required:
     - compatible
 
@@ -51,6 +52,7 @@ properties:
         - ingenic,jz4770-cgu
         - ingenic,jz4780-cgu
         - ingenic,x1000-cgu
+        - ingenic,x1830-cgu
       - const: simple-mfd
     minItems: 1
 
-- 
2.11.0

