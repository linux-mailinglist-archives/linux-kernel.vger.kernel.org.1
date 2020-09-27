Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36749279ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgI0G2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:28:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730372AbgI0G06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:26:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEC84D0412295B5696DD;
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
Subject: [PATCH v3 05/21] ARM: hisi: add support for SD5203 SoC
Date:   Sun, 27 Sep 2020 14:21:13 +0800
Message-ID: <20200927062129.4573-6-thunder.leizhen@huawei.com>
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

Enable support for the Hisilicon SD5203 SoC. The core is ARM926EJ-S.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/mach-hisi/Kconfig | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 3b010fe7c0e9b48..2e980f834a6aa1b 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARCH_HISI
 	bool "Hisilicon SoC Support"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
 	select ARM_AMBA
-	select ARM_GIC
+	select ARM_GIC if ARCH_MULTI_V7
 	select ARM_TIMER_SP804
 	select POWER_RESET
 	select POWER_RESET_HISI
@@ -15,6 +15,7 @@ menu "Hisilicon platform type"
 
 config ARCH_HI3xxx
 	bool "Hisilicon Hi36xx family"
+	depends on ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -25,6 +26,7 @@ config ARCH_HI3xxx
 
 config ARCH_HIP01
 	bool "Hisilicon HIP01 family"
+	depends on ARCH_MULTI_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GLOBAL_TIMER
@@ -33,6 +35,7 @@ config ARCH_HIP01
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family"
+	depends on ARCH_MULTI_V7
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
@@ -43,6 +46,7 @@ config ARCH_HIP04
 
 config ARCH_HIX5HD2
 	bool "Hisilicon X5HD2 family"
+	depends on ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -50,6 +54,14 @@ config ARCH_HIX5HD2
 	select PINCTRL_SINGLE
 	help
 	  Support for Hisilicon HIX5HD2 SoC family
+
+config ARCH_SD5203
+	bool "Hisilicon SD5203 family"
+	depends on ARCH_MULTI_V5
+	select DW_APB_ICTL
+	help
+	  Support for Hisilicon SD5203 SoC family
+
 endmenu
 
 endif
-- 
1.8.3


