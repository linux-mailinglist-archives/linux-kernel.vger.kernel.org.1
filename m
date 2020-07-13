Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F356821CD0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 04:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGMCRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 22:17:53 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44301 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbgGMCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:17:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3591534|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0142864-0.00190888-0.983805;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.I0soH8L_1594606665;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I0soH8L_1594606665)
          by smtp.aliyun-inc.com(10.147.42.241);
          Mon, 13 Jul 2020 10:17:49 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tiny.windzz@gmail.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v3 12/16] dt-bindings: irq: sun7i-nmi: Add binding for A100's NMI controller
Date:   Mon, 13 Jul 2020 10:17:40 +0800
Message-Id: <20200713021740.17389-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for A100's nmi controller.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 .../bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index aab74a8..b8d5bac 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -34,6 +34,9 @@ properties:
           - const: allwinner,sun50i-a64-r-intc
           - const: allwinner,sun6i-a31-r-intc
       - items:
+          - const: allwinner,sun50i-a100-nmi
+          - const: allwinner,sun9i-a80-nmi
+      - items:
           - const: allwinner,sun50i-h6-r-intc
           - const: allwinner,sun6i-a31-r-intc
 
-- 
1.9.1

