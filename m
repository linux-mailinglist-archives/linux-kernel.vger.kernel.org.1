Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A907F1A4EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgDKJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 05:12:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgDKJMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:12:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B69CEA19C96744CC15E2;
        Sat, 11 Apr 2020 17:11:59 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 11 Apr 2020 17:10:51 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        Nianyao Tang <tangnianyao@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Disallow setting affinity for virtual SGIs
Date:   Sat, 11 Apr 2020 17:10:32 +0800
Message-ID: <20200411091032.661-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a guest on the GICv4.1-implemented board, we will get the
following warning:

[   59.062120] genirq: irq_chip GICv4.1-sgi did not update eff. affinity mask of irq 46

It may be caused by irqbalance (or other userspace tools) which tries to
change the affinity of virtual SGIs on the host. One way to "fix" it is
to update the effective_affinity value in irq_set_affinity callback. But
as the comment above says, "There is no notion of affinity for virtual
SGIs, at least not on the host", doing so only makes things confusing.

Given the vSGIs are private to the specified vPE, changing the affinity
on host is actually meaningless and achieves nothing. Let's just forbid
it.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

Hi Marc,

This just restores the behavior of your v5 [*]. I wonder that what's the
reason to change it to 'return IRQ_SET_MASK_OK' in v6? What I've missed
here?

[*] https://lore.kernel.org/kvm/20200304203330.4967-9-maz@kernel.org/

Thanks.

 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 54d142ccc63a..101c3e52c769 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4033,9 +4033,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
 	/*
 	 * There is no notion of affinity for virtual SGIs, at least
 	 * not on the host (since they can only be targetting a vPE).
-	 * Tell the kernel we've done whatever it asked for.
 	 */
-	return IRQ_SET_MASK_OK;
+	return -EINVAL;
 }
 
 static int its_sgi_set_irqchip_state(struct irq_data *d,
-- 
2.19.1


