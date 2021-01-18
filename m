Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226D92F97B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbhARCMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:12:30 -0500
Received: from foss.arm.com ([217.140.110.172]:48700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbhARCLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:11:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DCD1474;
        Sun, 17 Jan 2021 18:10:00 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25C033F719;
        Sun, 17 Jan 2021 18:09:58 -0800 (PST)
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
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 14/21] dt-bindings: usb: Add H616 compatible string
Date:   Mon, 18 Jan 2021 02:08:41 +0000
Message-Id: <20210118020848.11721-15-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210118020848.11721-1-andre.przywara@arm.com>
References: <20210118020848.11721-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H616 has four PHYs as the H3, along with their respective clock
gates and resets, so the property description is identical.

However the PHYs itself need some special bits, so we need a new
compatible string for it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
index 60c344585276..f6f2dcb6dc1e 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
@@ -15,7 +15,9 @@ properties:
     const: 1
 
   compatible:
-    const: allwinner,sun8i-h3-usb-phy
+    oneOf:
+      - const: allwinner,sun8i-h3-usb-phy
+      - const: allwinner,sun50i-h616-usb-phy
 
   reg:
     items:
-- 
2.17.5

