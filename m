Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93952F97A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbhARCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:10:28 -0500
Received: from foss.arm.com ([217.140.110.172]:48110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbhARCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:10:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CF8ED1;
        Sun, 17 Jan 2021 18:09:29 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC373F719;
        Sun, 17 Jan 2021 18:09:27 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 01/21] dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
Date:   Mon, 18 Jan 2021 02:08:28 +0000
Message-Id: <20210118020848.11721-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210118020848.11721-1-andre.przywara@arm.com>
References: <20210118020848.11721-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add binding for A100's and H616's mmc and emmc controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
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

