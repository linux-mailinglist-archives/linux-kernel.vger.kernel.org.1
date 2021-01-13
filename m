Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632452F47BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhAMJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:41:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhAMJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:41:28 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DG2Ts1Kjxzj6cM;
        Wed, 13 Jan 2021 17:39:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 13 Jan 2021 17:40:38 +0800
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
Subject: [PATCH v4 0/3] ARM: Add support for Hisilicon Kunpeng L3 cache controller
Date:   Wed, 13 Jan 2021 17:39:39 +0800
Message-ID: <20210113093942.809-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 --> v4:
Rename the compatible string from "hisilicon,l3cache" to "hisilicon,kunpeng-l3cache".
Then adjust the file name, configuration option name, and description accordingly.

v2 --> v3:
Add Hisilicon L3 cache controller driver and its document. That's: patch 2-3.

v1 --> v2:
Discard the middle-tier functions and do silent narrowing cast in the outcache
hook functions. For example:
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;


v1:
Do cast phys_addr_t to unsigned long by adding a middle-tier function.
For example:
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void __l2c220_inv_range(unsigned long start, unsigned long end)
 {
 	...
 }
+static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
+{
+  __l2c220_inv_range(start, end);
+}

Zhen Lei (3):
  ARM: LPAE: Use phys_addr_t instead of unsigned long in outercache
    hooks
  dt-bindings: arm: hisilicon: Add binding for Kunpeng L3 cache
    controller
  ARM: Add support for Hisilicon Kunpeng L3 cache controller

 .../arm/hisilicon/kunpeng-l3cache.yaml        |  37 +++++
 arch/arm/include/asm/outercache.h             |   6 +-
 arch/arm/mm/Kconfig                           |  10 ++
 arch/arm/mm/Makefile                          |   1 +
 arch/arm/mm/cache-feroceon-l2.c               |  15 +-
 arch/arm/mm/cache-kunpeng-l3.c                | 153 ++++++++++++++++++
 arch/arm/mm/cache-kunpeng-l3.h                |  30 ++++
 arch/arm/mm/cache-l2x0.c                      |  50 ++++--
 arch/arm/mm/cache-tauros2.c                   |  15 +-
 arch/arm/mm/cache-uniphier.c                  |   6 +-
 arch/arm/mm/cache-xsc3l2.c                    |  12 +-
 11 files changed, 306 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml
 create mode 100644 arch/arm/mm/cache-kunpeng-l3.c
 create mode 100644 arch/arm/mm/cache-kunpeng-l3.h

-- 
2.26.0.106.g9fadedd


