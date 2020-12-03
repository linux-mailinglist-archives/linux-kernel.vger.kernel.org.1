Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C42CE261
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgLCXJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgLCXJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:09:16 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: ti-emif-sram: only build for ARMv7
Date:   Fri,  4 Dec 2020 00:08:14 +0100
Message-Id: <20201203230832.1481767-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver can be compile-tested on all ARM machines, but
causes a failure when built for ARMv7-M:

arm-linux-gnueabi-ld: error: drivers/memory/ti-emif-sram-pm.o: conflicting architecture profiles A/M

Limit the target machines to configurations that have ARMv7 enabled.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index eebd2ddcd860..3ea6913df176 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -128,7 +128,7 @@ config OMAP_GPMC_DEBUG
 
 config TI_EMIF_SRAM
 	tristate "Texas Instruments EMIF SRAM driver"
-	depends on SOC_AM33XX || SOC_AM43XX || (ARM && COMPILE_TEST)
+	depends on SOC_AM33XX || SOC_AM43XX || (ARM && CPU_V7 && COMPILE_TEST)
 	depends on SRAM
 	help
 	  This driver is for the EMIF module available on Texas Instruments
-- 
2.27.0

