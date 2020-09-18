Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFB26FB59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIRLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:23:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgIRLWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:22:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 191923A6D08B770DF102;
        Fri, 18 Sep 2020 19:22:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 19:22:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 1/6] genirq: define an empty function set_handle_irq() if !GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 18 Sep 2020 19:21:57 +0800
Message-ID: <20200918112202.3418-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200918112202.3418-1-thunder.leizhen@huawei.com>
References: <20200918112202.3418-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
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
 include/linux/irq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4dfee35b397..b167baef88c0b43 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1252,6 +1252,12 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#else
+#define set_handle_irq(handle_irq)		\
+	do {					\
+		(void)handle_irq;		\
+		WARN_ON(1);			\
+	} while (0)
 #endif
 
 #endif /* _LINUX_IRQ_H */
-- 
1.8.3


