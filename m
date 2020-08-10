Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48D22400E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 04:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHJCaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 22:30:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgHJCaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:30:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CA0479A9950FC35D5C4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:30:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.157) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 10:29:52 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: [PATCH] genirq/proc: Show percpu irq affinity
Message-ID: <fcb0ae13-95b0-37d3-c1f9-44727e0f2ce8@huawei.com>
Date:   Mon, 10 Aug 2020 10:29:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "affinity=" cmdline parameter is configured, the interrupt
affinity displayed in the proc directory does not match with that of the
the percu interrupt, and the percu interrupt uses desc->percu_affinity.

So show desc->percu_affinity in show_irq_affinity() for percpu
interrupt.

Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
---
 kernel/irq/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d7bc03..b9d0fa87b4b4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -52,6 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	case AFFINITY:
 	case AFFINITY_LIST:
 		mask = desc->irq_common_data.affinity;
+		if (irqd_is_per_cpu(&desc->irq_data))
+			mask = desc->percpu_affinity;
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 		if (irqd_is_setaffinity_pending(&desc->irq_data))
 			mask = desc->pending_mask;
-- 
1.8.3.1

