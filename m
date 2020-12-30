Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134F72E7A40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgL3PSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgL3PSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:18:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5985120773;
        Wed, 30 Dec 2020 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609341489;
        bh=iUEidfuhIDpSjXj991cAIXmCEpGL0FL7QOA0p5DLXjs=;
        h=From:To:Cc:Subject:Date:From;
        b=ulxhLOPcqTOxnJ1rihdlb61hHTawrBF+xmqrBQXF7ctm7g0vYui3djsr7BvV8Ic97
         OWqJQi3CouXnp3fcFf3f2+cCsIP004sd8zMMfRxJgNn+j9+5/5lME7BZx80z5dIjq6
         Bmvt0ANDFB4NXUZxKfcVkvDKT94RiMdxrvx+Fggfxzv9mvBN9p8zSBpvqTcHP4j92k
         yYqn1W7x2/m6mIMWERrcz74sAN1FoBlfyGbd819xFgJvjNc6TStzf0Apk2eABWRU7b
         AC3nhwuNP/BV6XI4nWhHIFhjBgVbawyvcbz/+zusHv91JJqJigzSTN3F2Ld8niXxYk
         IRdc5IfSsE+Yw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: fix imx8m dependencies
Date:   Wed, 30 Dec 2020 16:17:51 +0100
Message-Id: <20201230151804.3862447-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Selecting ARM_GIC_V3 on non-CP15 processors leads to build failures
like

arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R3_EL1':
arch/arm/include/asm/arch_gicv3.h:36:40: error: 'c12' undeclared (first use in this function)
   36 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
      |                                        ^~~

Add a dependency to only enable the gic driver when building for
at an ARMv7 target, which is the closes approximation to the ARMv8
processor that is actually in this chip.

Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a9370f4aacca..05812f8ae734 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -13,7 +13,7 @@ config SOC_IMX8M
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
 	select SOC_BUS
-	select ARM_GIC_V3 if ARCH_MXC
+	select ARM_GIC_V3 if ARCH_MXC && ARCH_MULTI_V7
 	help
 	  If you say yes here you get support for the NXP i.MX8M family
 	  support, it will provide the SoC info like SoC family,
-- 
2.29.2

