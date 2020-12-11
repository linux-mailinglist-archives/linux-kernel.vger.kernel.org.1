Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D832D6D73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgLKBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:24:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394783AbgLKBWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:22:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74C31570;
        Thu, 10 Dec 2020 17:20:43 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41693F66B;
        Thu, 10 Dec 2020 17:20:41 -0800 (PST)
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
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: [PATCH v2 20/21] dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
Date:   Fri, 11 Dec 2020 01:19:33 +0000
Message-Id: <20201211011934.6171-21-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201211011934.6171-1-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index cab8e1b6417b..5f8b5c896e66 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -894,4 +894,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
-- 
2.17.5

