Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38661279EAC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgI0G06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:26:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730259AbgI0G0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:26:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5B6EC350B4D75A769FF;
        Sun, 27 Sep 2020 14:26:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 06/21] ARM: debug: add UART early console support for SD5203
Date:   Sun, 27 Sep 2020 14:21:14 +0800
Message-ID: <20200927062129.4573-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200927062129.4573-1-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add support of early console for SD5203.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/Kconfig.debug | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 80000a66a4e3549..d27a7764c3bfb46 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1086,6 +1086,14 @@ choice
 		  on SA-11x0 UART ports. The kernel will check for the first
 		  enabled UART in a sequence 3-1-2.
 
+	config DEBUG_SD5203_UART
+		bool "Hisilicon SD5203 Debug UART"
+		depends on ARCH_SD5203
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SD5203 UART.
+
 	config DEBUG_SOCFPGA_UART0
 		depends on ARCH_SOCFPGA
 		bool "Use SOCFPGA UART0 for low-level debug"
@@ -1639,6 +1647,7 @@ config DEBUG_UART_PHYS
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
 	default 0x16000000 if DEBUG_INTEGRATOR
+	default 0x1600d000 if DEBUG_SD5203_UART
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x18000400 if DEBUG_BCM_HR2
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
@@ -1841,7 +1850,7 @@ config DEBUG_UART_VIRT
 	default 0xfec60000 if DEBUG_SIRFPRIMA2_UART1
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
-	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
+	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_SD5203_UART
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
-- 
1.8.3


