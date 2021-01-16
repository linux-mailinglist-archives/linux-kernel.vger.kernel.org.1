Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89542F8AF8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbhAPDcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:32:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11547 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbhAPDcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:32:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHk7p4MCczMJqR;
        Sat, 16 Jan 2021 11:29:58 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 11:31:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 2/4] ARM: hisi: add support for Kunpeng50x SoC
Date:   Sat, 16 Jan 2021 11:27:38 +0800
Message-ID: <20210116032740.873-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210116032740.873-1-thunder.leizhen@huawei.com>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/mach-hisi/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6aa1b..c724acc5c642b97 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -55,6 +55,14 @@ config ARCH_HIX5HD2
 	help
 	  Support for Hisilicon HIX5HD2 SoC family
 
+config ARCH_KUNPENG50X
+	bool "Hisilicon Kunpeng50x family"
+	depends on ARCH_MULTI_V7
+	select ARCH_FLATMEM_ENABLE
+	select ARCH_HAS_HOLES_MEMORYMODEL if SPARSEMEM
+	help
+	  Support for Hisilicon Kunpeng506 and Kunpeng509 SoC family
+
 config ARCH_SD5203
 	bool "Hisilicon SD5203 family"
 	depends on ARCH_MULTI_V5
-- 
2.26.0.106.g9fadedd


