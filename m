Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA43F29E2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbgJ2Chy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404545AbgJ2Chq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:37:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB9BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:37:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so1118318pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BJM60PKaoEKj00yNY+zacUHj7sixX+JrHufabOqrIM=;
        b=LVDiaDb7DqbpKD1Pmlk5RxehD/gQit+lY8i95m/E2twOa1WzIC/CtYY09vh+hUbvqx
         Q9fjGzTerOmg9h583YjWmq0DVGTSm7eAdFqktip14MD4rSIvjcdzGSFkXnhB5+IG5OAK
         ofWzSiHneNymFpbAMRrby4PTWKPOd1xzxopvCq7wanOMcH5tpM7Zat17ChGIareyNMy9
         Bew82f+hNhHp21jXD/unV2kB0SkLdut1qvLM6eb6WCBZ68jtFrNQXcLZz8ueIfBWFmm3
         RYzOLRcUqny4fxaTJAEVHS/7cLEuRgouG4hYR7i2ihyIxBimZUQrkKfSuCdZ57+PWRA3
         qhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BJM60PKaoEKj00yNY+zacUHj7sixX+JrHufabOqrIM=;
        b=p4taov/cIwKu7DJWTg0d6tSQn45oYcEHkSjgyoyrh0regoDMbSXEhLYvZjlTHmujpV
         n6SSEnnUmBg/WuGpgxxsuFndl21MJmOVrrZc06CX6hKke9Rs2TP8VT+pYUVwtNSLHbf5
         Vp2P4aX9caUYYbSe9456wf6rOl4fkwNuqLdMNkI1tCRtWYbL1OaEwgH748W9DDl4cnWx
         0Ir5O3qYvP0oSMN9QHK4aZCnz7dDId0qYgUHc4Q0EedN2ucawZjHNsYOMEtQSsuu44NZ
         U6jShioyexEN7RWJ5LpJUF/8qD5XFNpkX1oq1Yil5lkm/Z1plLBDmWf0y5I90MWX8c9g
         IIUA==
X-Gm-Message-State: AOAM530hFGOg6KTPi0C3MwtTEyqJPpHFBCBDqcTiAlOS2DtxfPPMzBPs
        cmykxSpfG4t6+z3rzaGZHZjZMQ==
X-Google-Smtp-Source: ABdhPJxcHklV3nxy/AFIGb3+KF+AnR/snc5d+2hO0JSkM2y4CVGmn6OHasonAgvQZizKx8zTnvarxg==
X-Received: by 2002:a63:ca52:: with SMTP id o18mr2111302pgi.422.1603939065984;
        Wed, 28 Oct 2020 19:37:45 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id bx24sm718945pjb.20.2020.10.28.19.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:37:45 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, anup@brainfault.org,
        atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [RFC PATCH] irqchip/sifive-plic: Fix getting wrong chip_data when interrupt is hierarchy
Date:   Thu, 29 Oct 2020 10:37:38 +0800
Message-Id: <20201029023738.127472-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This oops is caused by a wrong chip_data and it is because plic_irq_unmask
uses irq_get_chip_data(irq_data->irq) to get the chip_data. However it may
get another irq_data with the same irq_data->irq if it is hierarchy.

In this case, it will get irq_data of sifive_gpio_irqchip instead of
plic_chip so that it will get a wrong chip_data and then the wrong lmask
of it to cause this oops.

To fix this issue, we can use irq_data_get_irq_chip_data(irq_data) to get
the correct chip_data of plic_chip.

(gdb) p d
$11 = (struct irq_data *) 0xffffffe1f695f620
(gdb) p *d
$9 = {
  mask = 0,
  irq = 57,
  hwirq = 6,
  common = 0xffffffe1f695f600,
  chip = 0xffffffe0018b5630 <sifive_gpio_irqchip>,
  domain = 0xffffffe1f692c400,
  parent_data = 0xffffffe1f68482c0,
  chip_data = 0xffffffe1f564a820
}

(gdb) p d
$6 = (struct irq_data *) 0xffffffe1f68482c0
(gdb) p *d
$7 = {
  mask = 0,
  irq = 57,
  hwirq = 29,
  common = 0xffffffe1f695f600,
  chip = 0xffffffe0018b5070 <plic_chip>,
  domain = 0xffffffe1f6635e00,
  parent_data = 0x0,
  chip_data = 0xffffffe1f660f1a0
}

[    3.030165] ------------[ cut here ]------------
[    3.034614] WARNING: CPU: 1 PID: 1 at drivers/irqchip/irq-sifive-plic.c:125 plic_irq_unmask+0xc4/0x114
[    3.043887] Modules linked in:
[    3.046932] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0 #1
[    3.052748] epc: ffffffe000588e90 ra : ffffffe000588e88 sp : ffffffe1f6753940
[    3.059869]  gp : ffffffe001978f48 tp : ffffffe1f6748000 t0 : ffffffe001995cb0
[    3.067080]  t1 : ffffffe001995be8 t2 : 73616d61202c343a s0 : ffffffe1f67539a0
[    3.074288]  s1 : ffffffe1f4968140 a0 : 00000000000000b2 a1 : 0000000000000000
[    3.081497]  a2 : 00000000000000c2 a3 : 0000000000000000 a4 : 381c5a89432fe900
[    3.088707]  a5 : 0000000000000004 a6 : 0000000000000000 a7 : 00000000000001aa
[    3.095916]  s2 : ffffffe1f5901020 s3 : ffffffe00197a0a8 s4 : ffffffe001978b0c
[    3.103125]  s5 : ffffffe00197a1f0 s6 : 0000000000000008 s7 : ffffffe1f4983c9c
[    3.110335]  s8 : ffffffe1f4983c68 s9 : ffffffe1f4983c00 s10: ffffffe00000117c
[    3.117544]  s11: 0000000000000000 t3 : 0000000000000007 t4 : 0000000000000000
[    3.124753]  t5 : 66666666663a6b73 t6 : ffffffe001988479
[    3.130052] status: 0000000200000100 badaddr: ffffffe001978b0c cause: 0000000000000003
[    3.137959] ---[ end trace dbc1129f842ecba3 ]---

Fixes: f1ad1133b18f ("irqchip/sifive-plic: Add support for multiple PLICs")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 4048657ece0a..6f432d2a5ceb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -99,7 +99,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
@@ -115,7 +115,7 @@ static void plic_irq_unmask(struct irq_data *d)
 {
 	struct cpumask amask;
 	unsigned int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
 	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
@@ -127,7 +127,7 @@ static void plic_irq_unmask(struct irq_data *d)
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	plic_irq_toggle(&priv->lmask, d, 0);
 }
@@ -138,7 +138,7 @@ static int plic_set_affinity(struct irq_data *d,
 {
 	unsigned int cpu;
 	struct cpumask amask;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, mask_val);
 
-- 
2.28.0

