Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A42ACFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKJGp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:45:26 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:42415 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgKJGpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:45:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3935514|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.00453423-0.000349622-0.995116;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.IuotDq6_1604990718;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuotDq6_1604990718)
          by smtp.aliyun-inc.com(10.147.43.230);
          Tue, 10 Nov 2020 14:45:21 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 16/19] dt-bindings: mmc: sunxi: Add A100 compatibles
Date:   Tue, 10 Nov 2020 14:45:16 +0800
Message-Id: <1e6af41ce01eafd0d366257e5be9a0aa90bb97c8.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add binding for A100's mmc and emmc controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index e82c9a07b6fb..41821f14ecaa 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -26,6 +26,8 @@ properties:
       - const: allwinner,sun9i-a80-mmc
       - const: allwinner,sun50i-a64-emmc
       - const: allwinner,sun50i-a64-mmc
+      - const: allwinner,sun50i-a100-emmc
+      - const: allwinner,sun50i-a100-mmc
       - items:
           - const: allwinner,sun8i-a83t-mmc
           - const: allwinner,sun7i-a20-mmc
-- 
2.28.0

