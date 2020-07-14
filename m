Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1841F21E9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGNHQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:16:59 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33108 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgGNHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:16:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4140823|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00610941-0.000377616-0.993513;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I1TQA9r_1594711010;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1TQA9r_1594711010)
          by smtp.aliyun-inc.com(10.147.41.187);
          Tue, 14 Jul 2020 15:16:55 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 11/16] dt-bindings: irq: sun7i-nmi: fix dt-binding for a80 nmi
Date:   Tue, 14 Jul 2020 15:16:43 +0800
Message-Id: <fd01db758d09de8e4f3db740387eb94c56cef9dd.1594708864.git.frank@allwinnertech.com>
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

There is no one use "allwinner,sun9i-a80-sc-nmi". The A80 uses
"allwinner,sun9i-a80-nmi".

Let's fix it.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 7cd6b8bacfa0..d8fe2d9a307b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -29,7 +29,7 @@ properties:
       - items:
           - const: allwinner,sun8i-a83t-r-intc
           - const: allwinner,sun6i-a31-r-intc
-      - const: allwinner,sun9i-a80-sc-nmi
+      - const: allwinner,sun9i-a80-nmi
       - items:
           - const: allwinner,sun50i-a64-r-intc
           - const: allwinner,sun6i-a31-r-intc
-- 
2.24.0

