Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373A429368F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgJTIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbgJTIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:15:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:15:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so731413pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0YK1nIJBsgxv091uhUt5L5xJDje4QWnCuA8VHo/g6Ws=;
        b=d9okPnmVupD8rHYX6my6F/j3umo/o0OO9rRFa4oiHLKL/DoZPlX6Jc4H3qeLzD07W9
         0viq01r9kXB3IdCeD4Fo7I5kKPOqcifApQp6iwjHTqS1JwaU4Nuigth5McHAvSyo0vOl
         FesOigOE0+h60fR+Rgf15cpHIQSz+G8K9VVprBnvrwiZjoBpmuydBnlEc0NWb90OGPKF
         lXEsXsVBaC5Ecb6e4RfFsURGwwv4d6QpJOidvz2lhCWbdrt/QJ8xUQC40MPZKFKT0gsA
         q8tQlZaYi+xvY53R09/WQzpfmb/dK+WREDZEynoPaC5RCIhgOopSncpwpSJvLtAn8Awb
         4RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0YK1nIJBsgxv091uhUt5L5xJDje4QWnCuA8VHo/g6Ws=;
        b=e9o/2pggWSqVem+FuYiz8wCjSbUuqwKG/pMUAuUrBbnwZE7lxc/AWHhMDHObezvzpy
         ziGO058XDhO1C7MavuK0yfNakOLgSuV4yiI6MccCGU1zrRITwGrkIy7TkRvoGY7VOXgd
         9qDmRy/tI91VP1ja+t6CbhtUQB5c96yuGnGBmVkL33I6QSCVRBNLrYRX4A/6rRWiTjsC
         KDWwWehht8In7tWR2G1+0C7A0nMx7smmVjtoKVVhn9/yhyaBQ+kMuNQVpkGcCYhyIDl1
         XpxQJtyLBsT23b2E4/pVRT+Faq2uYdvd/0HL1wkqfvVPfPswUX6xkLL4+SQsKfZZMjSo
         owNQ==
X-Gm-Message-State: AOAM533DgTXfcJ++4cD3kdPd4hJJLL8Cl/sP5sfuFLoKfQBKbDOVq9mJ
        Qhati0KSFN0OGjvRBjz0pp0Xig==
X-Google-Smtp-Source: ABdhPJyNnf/J1CMd098Z6cldYbES/3Y2js3zSfEtw19ryATUSICWvCM7yJWzqhIypQvgLJOUU8PwoQ==
X-Received: by 2002:a63:e441:: with SMTP id i1mr1739816pgk.221.1603181737880;
        Tue, 20 Oct 2020 01:15:37 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id f21sm1351469pfn.173.2020.10.20.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 01:15:37 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/sifive-plic: Fix broken irq_set_affinity() callback
Date:   Tue, 20 Oct 2020 16:15:32 +0800
Message-Id: <20201020081532.2377-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will always enable the interrupt after calling plic_set_affinity()
however it should set to it previous setting. Staying disabled or enabled.

This patch can also fix this pwm hang issue in Unleashed board.

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

Fixes: bb0fed1c60cc ("irqchip/sifive-plic: Switch to fasteoi flow")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index eaa3e9fe54e9..4048657ece0a 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -151,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
 		return -EINVAL;
 
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.28.0

