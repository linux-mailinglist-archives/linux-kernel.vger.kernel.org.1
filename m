Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691913036F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbhAZG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:59:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbhAYPhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:37:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5EEF16F8;
        Mon, 25 Jan 2021 07:18:55 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72DA3F68F;
        Mon, 25 Jan 2021 07:18:53 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 01/21] dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner H616
Date:   Mon, 25 Jan 2021 15:17:51 +0000
Message-Id: <20210125151811.11871-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210125151811.11871-1-andre.przywara@arm.com>
References: <20210125151811.11871-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 3b45344ed758..b7e891803bb4 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -41,6 +41,8 @@ properties:
       - allwinner,sun50i-h5-ccu
       - allwinner,sun50i-h6-ccu
       - allwinner,sun50i-h6-r-ccu
+      - allwinner,sun50i-h616-ccu
+      - allwinner,sun50i-h616-r-ccu
       - allwinner,suniv-f1c100s-ccu
       - nextthing,gr8-ccu
 
-- 
2.17.5

