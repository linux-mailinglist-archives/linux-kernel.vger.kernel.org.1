Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654D23E0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgHFSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbgHFSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45B522D3E;
        Thu,  6 Aug 2020 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738149;
        bh=p2adxRzepEbIsLQnxW34looRrw9LWsLu4tmaRjq+7iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcaczOFFmsp8VscB4RMRsZcUMJ3Z9GGnvUERUz4wHqpgjT1ohnI5xUO58LjaXZubK
         XtjlA67UwEUfBH27ZKthnNxsFPkkgEQbTIPoFRm1pwSeQk9Lgi69cKBZtdQDngiuzr
         PsTRrHbU6fm17mWaxBr7oHpYsiM6ZNn/fQRs/wSY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 13/41] ARM: samsung: move CONFIG_DEBUG_S3C_UART to Kconfig.debug
Date:   Thu,  6 Aug 2020 20:20:30 +0200
Message-Id: <20200806182059.2431-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Before we can separate plat-samsung from the individual platforms,
this one has to get moved to a place where it remains accessible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/Kconfig.debug        | 10 ++++++++++
 arch/arm/plat-samsung/Kconfig |  8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 80000a66a4e3..7c34cf5c4a5b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1497,6 +1497,16 @@ config DEBUG_S3C64XX_UART
 config DEBUG_S5PV210_UART
 	bool
 
+config DEBUG_S3C_UART
+	depends on DEBUG_S3C2410_UART || DEBUG_S3C24XX_UART || \
+		   DEBUG_S3C64XX_UART ||  DEBUG_S5PV210_UART || \
+		   DEBUG_EXYNOS_UART
+	int
+	default "0" if DEBUG_S3C_UART0
+	default "1" if DEBUG_S3C_UART1
+	default "2" if DEBUG_S3C_UART2
+	default "3" if DEBUG_S3C_UART3
+
 config DEBUG_OMAP2PLUS_UART
 	bool
 	depends on ARCH_OMAP2PLUS
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 3aca01067b3c..c3d18b0aad75 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -290,13 +290,5 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
-config DEBUG_S3C_UART
-	depends on PLAT_SAMSUNG
-	int
-	default "0" if DEBUG_S3C_UART0
-	default "1" if DEBUG_S3C_UART1
-	default "2" if DEBUG_S3C_UART2
-	default "3" if DEBUG_S3C_UART3
-
 endmenu
 endif
-- 
2.17.1

