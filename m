Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9E26FC92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIRMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:33:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRMdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:33:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F0B7D1A8F554734F9AA;
        Fri, 18 Sep 2020 20:33:31 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:33:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] arm64: Fix -Wunused-function warning
Date:   Fri, 18 Sep 2020 20:33:18 +0800
Message-ID: <20200918123318.23764-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HOTPLUG_CPU is n, gcc warns:

arch/arm64/kernel/smp.c:967:13: warning: ‘ipi_teardown’ defined but not used [-Wunused-function]
 static void ipi_teardown(int cpu)
             ^~~~~~~~~~~~

Use #ifdef guard this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm64/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde2675ccc..82e75fc2c903 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -82,9 +82,9 @@ static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
 
 static void ipi_setup(int cpu);
-static void ipi_teardown(int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+static void ipi_teardown(int cpu);
 static int op_cpu_kill(unsigned int cpu);
 #else
 static inline int op_cpu_kill(unsigned int cpu)
@@ -964,6 +964,7 @@ static void ipi_setup(int cpu)
 		enable_percpu_irq(ipi_irq_base + i, 0);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void ipi_teardown(int cpu)
 {
 	int i;
@@ -974,6 +975,7 @@ static void ipi_teardown(int cpu)
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
 }
+#endif
 
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
-- 
2.17.1

