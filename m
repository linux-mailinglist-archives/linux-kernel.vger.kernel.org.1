Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6A1CEABA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 04:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgELCX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 22:23:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727942AbgELCXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:23:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6C35A7F089D56802555;
        Tue, 12 May 2020 10:23:22 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 12 May 2020 10:23:15 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <jun.nie@linaro.org>, <shawnguo@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] ARM: zx: Make zx_smp_prepare_cpus static
Date:   Tue, 12 May 2020 10:29:21 +0800
Message-ID: <1589250561-106088-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/arm/mach-zx/platsmp.c:41:13: warning: symbol 'zx_smp_prepare_cpus' was not declared.

The zx_smp_prepare_cpus has only call site within platsmp.c
It should be static

Fixes: 71bc724300e6 ("ARM: zx: enable SMP and hotplug for zx296702")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 arch/arm/mach-zx/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
index d4e1d37..43a33ea 100644
--- a/arch/arm/mach-zx/platsmp.c
+++ b/arch/arm/mach-zx/platsmp.c
@@ -38,7 +38,7 @@ static void __iomem *pcu_base;
 static void __iomem *matrix_base;
 static void __iomem *scu_base;
 
-void __init zx_smp_prepare_cpus(unsigned int max_cpus)
+static void __init zx_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
 	unsigned long base = 0;
-- 
2.6.2

