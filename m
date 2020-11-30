Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC25A2C84D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK3NMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgK3NMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:44 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A19C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:20 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r20so1303545pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4b6Mz+meeIOWiwdpvVizNGtENxtsbORSHHjjSCrlas=;
        b=NOERfF7egowMV6omqbGCYcnTmO++yhypJfIN0zzFCBLOwPjW5dSmvG0jSgPxeAESWL
         9acj1SCmIXtpuCB2Z1uvcFa6v6k8VO8nec0r6OsyQX4L1rUrsewKlJ9uuqivdPfvvo5v
         MCSexCFH5DnPtbgd0TfpUvYMix7Q0BxgQoAjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4b6Mz+meeIOWiwdpvVizNGtENxtsbORSHHjjSCrlas=;
        b=MMBBYJkboq0rIpIlhUKWsPKJ+XYYqn9dfoIesxT4Y6kQdvJ7D+IjNA5gaTk4UIZgh7
         QOg/uU/G4/dR3RbGs4mpFiQTfTEc1NelaHAMiTYWPooRi0utzYDA0ShsGyKGl30YgMFn
         Ujle0zvK/s8uIuCoMXFIC9tmNzX8uEcSm9XxsAFADNgOI8LURz/NdNZoSZv4QJfjGn62
         xR26CyTa6cLwxEn3VXWXmyjQUS+A5dNHMoX3EMwnqD4a25cjq/bVha+bd7eW2asGLGAI
         ODGi69ivDLg2gO2UT3ZyVVznYrzXHEQuc2krz4gMffPslDirbDxdMI2lVlbOqWkDAH4c
         Vu9w==
X-Gm-Message-State: AOAM533xlXKMAVQ6LVAP/UUYahb8ZcsqCWuuzOJ2hDKL0DXPkNaFSEQa
        Y66j1pWUcvcptJ+dOJmw7ClMBA==
X-Google-Smtp-Source: ABdhPJytNtiSFjUBa/8hP6fMqYnvCTlKseq0Z9MVhm7I5h2NQTR5XgRtzFuTCSl6si+IwlkEQh6IOw==
X-Received: by 2002:a17:90a:940c:: with SMTP id r12mr25793348pjo.201.1606741879985;
        Mon, 30 Nov 2020 05:11:19 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:11:19 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 9/9] ARM: mstar: SMP support
Date:   Mon, 30 Nov 2020 22:10:47 +0900
Message-Id: <20201130131047.2648960-10-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP support for MStar/Sigmastar chips that have a second core
like those in the infinity2m family.

So far only single and dual core chips have been found so this does
the bare minimum to boot the second core. From what I can tell not having
the "holding pen" code to handle multiple cores is fine if there is only
one core the will get booted. This might need to be reconsidered if chips
with more cores turn up.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/mach-mstar/mstarv7.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-mstar/mstarv7.c b/arch/arm/mach-mstar/mstarv7.c
index 1aa748fa006e..23fe47a8f1a5 100644
--- a/arch/arm/mach-mstar/mstarv7.c
+++ b/arch/arm/mach-mstar/mstarv7.c
@@ -31,6 +31,13 @@
 #define MSTARV7_L3BRIDGE_FLUSH_TRIGGER	BIT(0)
 #define MSTARV7_L3BRIDGE_STATUS_DONE	BIT(12)
 
+#ifdef CONFIG_SMP
+#define MSTARV7_CPU1_BOOT_ADDR_HIGH	0x4c
+#define MSTARV7_CPU1_BOOT_ADDR_LOW	0x50
+#define MSTARV7_CPU1_UNLOCK		0x58
+#define MSTARV7_CPU1_UNLOCK_MAGIC	0xbabe
+#endif
+
 static void __iomem *l3bridge;
 
 static const char * const mstarv7_board_dt_compat[] __initconst = {
@@ -63,6 +70,46 @@ static void mstarv7_mb(void)
 	}
 }
 
+#ifdef CONFIG_SMP
+static int mstarv7_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	struct device_node *np;
+	u32 bootaddr = (u32) __pa_symbol(secondary_startup_arm);
+	void __iomem *smpctrl = 0;
+
+	/*
+	 * right now we don't know how to boot anything except
+	 * cpu 1.
+	 */
+	if (cpu != 1)
+		return -EINVAL;
+
+	np = of_find_compatible_node(NULL, NULL, "mstar,smpctrl");
+	smpctrl = of_iomap(np, 0);
+
+	if (!smpctrl)
+		return -ENODEV;
+
+	/* set the boot address for the second cpu */
+	writew(bootaddr & 0xffff, smpctrl + MSTARV7_CPU1_BOOT_ADDR_LOW);
+	writew((bootaddr >> 16) & 0xffff, smpctrl + MSTARV7_CPU1_BOOT_ADDR_HIGH);
+
+	/* unlock the second cpu */
+	writew(MSTARV7_CPU1_UNLOCK_MAGIC, smpctrl + MSTARV7_CPU1_UNLOCK);
+
+	/* and away we go...*/
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	iounmap(smpctrl);
+
+	return 0;
+}
+
+struct smp_operations __initdata mstarv7_smp_ops  = {
+	.smp_boot_secondary = mstarv7_boot_secondary,
+};
+#endif
+
 static void __init mstarv7_init(void)
 {
 	struct device_node *np;
@@ -78,4 +125,7 @@ static void __init mstarv7_init(void)
 DT_MACHINE_START(MSTARV7_DT, "MStar/Sigmastar Armv7 (Device Tree)")
 	.dt_compat	= mstarv7_board_dt_compat,
 	.init_machine	= mstarv7_init,
+#ifdef CONFIG_SMP
+	.smp		= smp_ops(mstarv7_smp_ops),
+#endif
 MACHINE_END
-- 
2.29.2

