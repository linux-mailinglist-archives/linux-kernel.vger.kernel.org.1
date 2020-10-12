Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFD28B928
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbgJLN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389346AbgJLN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:57:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC83C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:57:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so10954482pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q1wnaKsyvuMXKi7fs7oMuZr+hnbrwNWLrapTgOtuEpI=;
        b=PRqy1JmsF7Ra7sTdljtU/xin9hXipV61CkD/nqQc6hDlDCA7GvAf36G0+7uYOydo5M
         19MTH/xehhZrNd2VhYOgfcuqfBxRHheycm+SujUnxGkm5IKmqfM/Kmv3THohngzKhIZZ
         3uuBCxUgzHOT3MmLtA7U5hZSKMDQJ7LF0ak0KbkoGxJTU1yrQ7bm5UJAIBWp2LpMs/XL
         zVkCVRFVzmFRMeMhlmzeliZt3N084OARRHRP0m+b9YiJKIlb2+8AzGtztVkAqmiK1c1C
         uJ80aXUPOK8hynccbr1SSBjtKNKYiruZ7lQnLO+MWvXGawDcPQEfOQxT/PoSt8bfHEdE
         GvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1wnaKsyvuMXKi7fs7oMuZr+hnbrwNWLrapTgOtuEpI=;
        b=TIDdMTkcM84ZfrQdqcMat4qxWyr0R9aJ6Sha49U+8J0PH1nWIvyaMR3ClB0eMf9I3a
         KzpUkU8N5Tdoshn4EzcZ0zSypwwCRaRf0FEevbhsK4vLL8VMSpD86LowOic9pYv4NnML
         t2mDckzvkZbscjw0k8Y+WAab6E8kLaY9HfSwt9xrHY84WR7iuv0G44ULcLfzoBc2GAxf
         FDuAFlTvUFR3H6cxlDrILApuWM4cWWuwRkPn9Qjz3ryx+Hl9m64mAav7XQ6c+xCU3ap3
         vB75pdUq+JG5+LNNZ/TzbLf31O6AzYBVMJKmWElespAmoq+8sBA+kjBUEjuLIPEOj7dy
         fjng==
X-Gm-Message-State: AOAM532tn8CT2TwahnTar3vYQ3irQHc/mjXv1YAqVW1PQq/Hw/ByGG1M
        98jFv1amqVPAQLGcWdnvxrz/Ag==
X-Google-Smtp-Source: ABdhPJzcrHQeZk4zgWWyuluZxje2uj0PyWtM6YbdgCeVVIsUCbXBIgZTTXg9ohn70dPUcgnAubNMuA==
X-Received: by 2002:a63:470a:: with SMTP id u10mr4433502pga.48.1602511062540;
        Mon, 12 Oct 2020 06:57:42 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm20019316pjv.2.2020.10.12.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:57:42 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] irqchip/sifive-plic: Fix the interrupt was enabled accidentally issue.
Date:   Mon, 12 Oct 2020 21:57:24 +0800
Message-Id: <20201012135724.110579-2-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012135724.110579-1-greentime.hu@sifive.com>
References: <20201012135724.110579-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2ca0b460bbcb ("genirq/affinity: Make affinity setting if activated opt-in"),
it added irqd_affinity_on_activate() checking in the function
irq_set_affinity_deactivated() so it will return false here.
In that case, it will call irq_try_set_affinity() -> plic_irq_toggle()
which will enable the interrupt to cause the CPU hang.

	if (irq_set_affinity_deactivated())
		return 0;
	...
	irq_try_set_affinity(data, mask, force);

[  919.015783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  919.020922] rcu:     0-...0: (0 ticks this GP)
idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=105807
[  919.030295]  (detected by 1, t=225825 jiffies, g=1561, q=3496)
[  919.036109] Task dump for CPU 0:
[  919.039321] kworker/0:1     R  running task        0    30      2 0x00000008
[  919.046359] Workqueue: events set_brightness_delayed
[  919.051302] Call Trace:
[  919.053738] [<ffffffe000930d92>] __schedule+0x194/0x4de
[  982.035783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  982.040923] rcu:     0-...0: (0 ticks this GP)
idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=113325
[  982.050294]  (detected by 1, t=241580 jiffies, g=1561, q=3509)
[  982.056108] Task dump for CPU 0:
[  982.059321] kworker/0:1     R  running task        0    30      2 0x00000008
[  982.066359] Workqueue: events set_brightness_delayed
[  982.071302] Call Trace:
[  982.073739] [<ffffffe000930d92>] __schedule+0x194/0x4de
[..]

After applying this patch, the CPU hang issue can be fixed.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 4cc8a2657a6d..8a673d9cff69 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -183,10 +183,14 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
 	struct plic_priv *priv = d->host_data;
+	struct irq_data *irqd;
 
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
+	irqd = irq_get_irq_data(irq);
+	irqd_set_single_target(irqd);
+	irqd_set_affinity_on_activate(irqd);
 	irq_set_affinity(irq, &priv->lmask);
 	return 0;
 }
-- 
2.28.0

