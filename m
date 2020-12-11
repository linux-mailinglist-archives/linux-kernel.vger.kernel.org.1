Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5510F2D6D51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394844AbgLKBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:22:26 -0500
Received: from foss.arm.com ([217.140.110.172]:49796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394750AbgLKBVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:21:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 929EC1477;
        Thu, 10 Dec 2020 17:20:13 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A993F66B;
        Thu, 10 Dec 2020 17:20:11 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 08/21] dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
Date:   Fri, 11 Dec 2020 01:19:21 +0000
Message-Id: <20201211011934.6171-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201211011934.6171-1-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add binding for A100's and H616's mmc and emmc controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index e82c9a07b6fb..e75b3a8ba816 100644
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
@@ -47,6 +49,12 @@ properties:
       - items:
           - const: allwinner,sun50i-h6-mmc
           - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun50i-h616-emmc
+          - const: allwinner,sun50i-a100-emmc
+      - items:
+          - const: allwinner,sun50i-h616-mmc
+          - const: allwinner,sun50i-a100-mmc
 
   reg:
     maxItems: 1
-- 
2.17.5

