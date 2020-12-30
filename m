Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC182E7705
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 09:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL3Iag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 03:30:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3Iag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 03:30:36 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5PZn1Fwlzj12C;
        Wed, 30 Dec 2020 16:29:05 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 16:29:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] ARM: LPAE: use phys_addr_t instead of unsigned long in outercache hooks
Date:   Wed, 30 Dec 2020 16:28:04 +0800
Message-ID: <20201230082805.1428-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


Zhen Lei (1):
  ARM: LPAE: use phys_addr_t instead of unsigned long in outercache
    hooks

 arch/arm/include/asm/outercache.h |  6 ++--
 arch/arm/mm/cache-feroceon-l2.c   | 15 ++++++++--
 arch/arm/mm/cache-l2x0.c          | 50 ++++++++++++++++++++++---------
 arch/arm/mm/cache-tauros2.c       | 15 ++++++++--
 arch/arm/mm/cache-uniphier.c      |  6 ++--
 arch/arm/mm/cache-xsc3l2.c        | 12 ++++++--
 6 files changed, 75 insertions(+), 29 deletions(-)

-- 
2.26.0.106.g9fadedd


