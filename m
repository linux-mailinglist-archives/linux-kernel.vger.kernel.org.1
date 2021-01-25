Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A123036EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbhAZG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:58:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729853AbhAYPgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:36:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AE81715;
        Mon, 25 Jan 2021 07:19:03 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5B73F68F;
        Mon, 25 Jan 2021 07:19:01 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 04/21] dt-bindings: mfd: axp20x: Add AXP305 compatible (plus optional IRQ)
Date:   Mon, 25 Jan 2021 15:17:54 +0000
Message-Id: <20210125151811.11871-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210125151811.11871-1-andre.przywara@arm.com>
References: <20210125151811.11871-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP305 PMIC used in AXP805 seems to be fully compatible to the
AXP805 PMIC, so add the proper chain of compatible strings.

Also at least on one board (Orangepi Zero2) there is no interrupt line
connected to the CPU, so make the "interrupts" property optional.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 4991a6415796..4fd748101e3c 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -26,10 +26,10 @@ Required properties:
     * "x-powers,axp803"
     * "x-powers,axp806"
     * "x-powers,axp805", "x-powers,axp806"
+    * "x-powers,axp803", "x-powers,axp805", "x-powers,axp806"
     * "x-powers,axp809"
     * "x-powers,axp813"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
-- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
 - interrupt-controller: The PMIC has its own internal IRQs
 - #interrupt-cells: Should be set to 1
 
@@ -43,6 +43,7 @@ more information:
 			AXP20x/LDO3: software-based implementation
 
 Optional properties:
+- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
 		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
 		      AXP22X/8XX: range: 1800-4050, Default: 3   MHz
-- 
2.17.5

