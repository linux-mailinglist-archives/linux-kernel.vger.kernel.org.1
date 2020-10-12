Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480CD28B92E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbgJLN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390658AbgJLN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:57:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:57:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so13576436pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiICVFIqX41C7SKKJnsrNtmwYTBihguSi/hha1GihbA=;
        b=M7guIMGXYX7w3kC+X3d/oZD+d5yoyYsqQPVuy5XK1UcpCYjQFQdOne/GanDOXnvHs4
         kpdST8zBo6hfAT452TviGrVNlVIgzKX2t+ctXvi6/jOJLw9VxNbEwKX3rd2KYDZ6ViSK
         KO3DjlrvnoriUgoaljupo/mFwZ8HQXZZzAfX/P5OVRIHCpXZ1ZGgdG31YkShSk+iVoEp
         OWoFOkSG/EREpSt3Ox8SjNeCUD99XaCqT/JIGr2OaTsPsasxEeyqWjpH4V5tsXSA8lrJ
         x7ebSgMtb+dRixsUyI2Jj4D8SKSwETmPrBrY++eV2oZOTSeNua/5wRTUE1HWVlWS/2hm
         DAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiICVFIqX41C7SKKJnsrNtmwYTBihguSi/hha1GihbA=;
        b=BnIgiuRo7m/0eW1nUJnSYm0J5uhP5VE14tPeGJWyX9XPhICpQ+UnjnObQj6dvPBJkB
         jOu4i4Y1xo/FTUX6aaRmt4EwtVLp9QKXqu16kweGuZa0MktVEgmREfV7VDkf4KtP+JWZ
         9cGMWCVmGtq0qP+Eqs3tHl3yUVZEWzUl3htjpHFbfj7kxVxDnZ9u7Hlda9XBeFdsJz3l
         +h9ZRQnjKceGLOIEiFKTqzRZK37nS47l32DR6bVrvEQnang4my2Sibuwr3+ZGIu8Z4pz
         RcKM69j+ArOPwQ6Zd9GjsIqBTWyeuA4O4oDxmdvGx+D1f6MFasR+YzlLFiYklwa2wufJ
         AGUQ==
X-Gm-Message-State: AOAM531pIQNHKGVGVFXigCSOq4ljPTsaOhlAyi+G48fsCSiJ07BP3tLJ
        8eQT23Mzf4xhl8Xk54wDwFLIZA==
X-Google-Smtp-Source: ABdhPJx/YXjwmC3lsPfXUB0HuPWyxGgOxdVizxfDuUlT+AzybzSCHmrav3+r4MJ6Bz2FEZN6fpbQCw==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr20003855pjf.233.1602511054990;
        Mon, 12 Oct 2020 06:57:34 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm20019316pjv.2.2020.10.12.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:57:34 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] irqchip/sifive-plic: Enable or disable interrupt based on its previous setting
Date:   Mon, 12 Oct 2020 21:57:23 +0800
Message-Id: <20201012135724.110579-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will always enable the interrupt after calling plic_set_affinity()
however it should set to its previous setting. Staying disabled or enabled.

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
 drivers/irqchip/irq-sifive-plic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index eaa3e9fe54e9..4cc8a2657a6d 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -137,6 +137,7 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
+	bool enable;
 	struct cpumask amask;
 	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
@@ -150,8 +151,10 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
+	enable = !irqd_irq_disabled(d);
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	/* Keep its original setting. */
+	plic_irq_toggle(cpumask_of(cpu), d, enable);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.28.0

