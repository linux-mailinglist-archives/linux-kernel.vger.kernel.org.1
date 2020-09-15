Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2823926A12E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIOIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:43:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgIOInm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:43:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70B9E5729C63E5573513;
        Tue, 15 Sep 2020 16:43:40 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 16:43:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Jianguo Chen" <chenjianguo3@huawei.com>
Subject: [PATCH v4 1/4] genirq: define an empty function set_handle_irq() if !GENERIC_IRQ_MULTI_HANDLER
Date:   Tue, 15 Sep 2020 16:43:02 +0800
Message-ID: <20200915084305.3085-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200915084305.3085-1-thunder.leizhen@huawei.com>
References: <20200915084305.3085-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid compilation error if an irqchip driver references the function
set_handle_irq() but may not select GENERIC_IRQ_MULTI_HANDLER on some
systems.

For example, the Synopsys DesignWare APB interrupt controller
(dw_apb_ictl) is used as the secondary interrupt controller on arc, csky,
arm64, and most arm32 SoCs, and it's also used as the primary interrupt
controller on Hisilicon SD5203 (an arm32 SoC). The latter need to use
set_handle_irq() to register the top-level IRQ handler, but this multi
irq handler registration mechanism is not implemented on arc system.

The input parameter "handle_irq" maybe defined as static and only
set_handle_irq() references it. This will trigger "defined but not used"
warning. So add "(void)handle_irq" to suppress it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4dfee35b397..0848a2aaa9b40b1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1252,6 +1252,8 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#else
+#define set_handle_irq(handle_irq)	do { (void)handle_irq; } while (0)
 #endif
 
 #endif /* _LINUX_IRQ_H */
-- 
1.8.3


