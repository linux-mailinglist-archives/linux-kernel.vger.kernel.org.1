Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763FF2E8F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 01:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhADA2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 19:28:39 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52231 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbhADA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:28:39 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 84098E0002;
        Mon,  4 Jan 2021 00:27:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vladimir Zapolskiy <vz@mleia.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] ARM: lpc32xx: debug: add low-level debug support on hsuart
Date:   Mon,  4 Jan 2021 01:27:50 +0100
Message-Id: <20210104002750.1631337-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpc32xx has UARTs that are not 8250 compatible. Add support for low
level debugging on those high speed UARTs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - rebased on v5.11-rc1

 arch/arm/Kconfig.debug                  | 18 +++++++++++++++---
 arch/arm/include/debug/lpc32xx_hsuart.S | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/lpc32xx_hsuart.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4ff04201a8cc..081800b030f8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -523,7 +523,16 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on NXP LPC32xx based platforms.
+		  on NXP LPC32xx based platforms using an INS16Cx50 compatible
+		  UART.
+
+	config DEBUG_LPC32XX_HSUART
+		bool "Kernel low-level debugging messages via NXP LPC32xx High Speed  UART"
+		depends on ARCH_LPC32XX
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on NXP LPC32xx based platforms using an high speed (14-clock)
+		  UART.
 
 	config DEBUG_MESON_UARTAO
 		bool "Kernel low-level debugging via Meson6 UARTAO"
@@ -1602,6 +1611,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SX_UART || \
 				 DEBUG_IMX6UL_UART || \
 				 DEBUG_IMX7D_UART
+	default "debug/lpc32xx_hsuart.S" if DEBUG_LPC32XX_HSUART
 	default "debug/msm.S" if DEBUG_QCOM_UARTDM
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/renesas-scif.S" if DEBUG_R7S72100_SCIF2
@@ -1686,6 +1696,7 @@ config DEBUG_UART_PHYS
 	default 0x40010000 if STM32MP1_DEBUG_UART
 	default 0x40011000 if STM32F4_DEBUG_UART || STM32F7_DEBUG_UART || \
 				STM32H7_DEBUG_UART
+	default 0x40014000 if DEBUG_LPC32XX_HSUART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
@@ -1781,7 +1792,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART || DEBUG_STM32_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1805,6 +1816,7 @@ config DEBUG_UART_VIRT
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
+	default 0xf4014000 if DEBUG_LPC32XX_HSUART
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
 	default 0xf6200000 if DEBUG_PXA_UART1
@@ -1891,7 +1903,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART || DEBUG_STM32_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/lpc32xx_hsuart.S b/arch/arm/include/debug/lpc32xx_hsuart.S
new file mode 100644
index 000000000000..7f54bc2cc250
--- /dev/null
+++ b/arch/arm/include/debug/lpc32xx_hsuart.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define LPC_HSU_TX		(0x0)
+#define LPC_HSU_LEVEL		(0x4)
+#define LPC_HSU_LEVEL_TX	0xFF00
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #(LPC_HSU_TX)]
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
+
+	.macro	busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #(LPC_HSU_LEVEL)]
+	ands	\rd, \rd, LPC_HSU_LEVEL_TX
+	bne	1001b
+	.endm
+
-- 
2.29.2

