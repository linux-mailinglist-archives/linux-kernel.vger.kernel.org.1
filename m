Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD782BA0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKTC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:58:17 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70668C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:16 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id v21so6075619pgi.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ir+QYQ1CAfcL3SlhgU8WhF6YDpMkKzdlNHyr16xwtf8=;
        b=p+MHfL8NcM1ig3OnaW5iyOUPQCwHoq4L023gDboj7aoYhUdAdd9TqicTgAoQUdQ4QM
         D4fGAWEZakrU5IWyHz/UieaX+5vNAx1wlymR2KwonYhcynW4VZgAsZH3sZI99Pf+o5ue
         iUU+lNMCnbpYUYD7zQkCun+nze7j42Dm4WDmlU72bF304xdDhyrJA+Y+d8cDDMWylqtQ
         q9jzi796Ppa8zdTkESQW9PRPFXOyEMM8r9/CqmHWinw5C0qsVF+QlfC8dLhdhdycMxfb
         evW6qZGBsC7MRNDXhGD+v/b8KJlfRNSA/fwikaUWKK36nzjnYFbKhjDHICkUvPvlLLuo
         bNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ir+QYQ1CAfcL3SlhgU8WhF6YDpMkKzdlNHyr16xwtf8=;
        b=swGXJ//VLzLUfPOxQT/QIRSUn3zkpXAfIp0z76YasYKXw6zb9lmGddS2OsNubrjiBD
         z7SCpOTjO68BohIRH57gUd5j5VGRpr59efr0rf5JGRqUJsgBnwksGV4UmbLxeXc0KbTH
         2vuQBekLS/vI3LqcphtirlNVifHXqNc+UIOX058PCmvh35DMdAYyymMyYZLMZN1jB/oO
         hZRIOxkCWujYoTtg/jl1wm4f4DLNnhGWG6htl6YhAsMgA5yhrbv4uboDwiggZATpb3xk
         UDoiV/xE9QrF0RTbCnHDKCWYS5rigrr8awMBCILTzWWht2Uht1Vxte8/FSiMwEikS8o4
         BiFQ==
X-Gm-Message-State: AOAM5306HLcQmJBrMzckXRe+Xi5nORhHyv6+cM1an6xfgzNIRpiF/7pg
        1k8o+74bA9rsuPEYM5t5Wlg=
X-Google-Smtp-Source: ABdhPJzmUMslLyf6QKSIzNwiUtfWA/PCdCn6oFS8zoZyzByAVt4wJwrVAAFIoEZy7on+FxR2Bi1MIw==
X-Received: by 2002:a17:90a:fa04:: with SMTP id cm4mr7519731pjb.24.1605841096090;
        Thu, 19 Nov 2020 18:58:16 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id i130sm1181212pgc.7.2020.11.19.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:58:15 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/64s: Trim offlined CPUs from mm_cpumasks
Date:   Fri, 20 Nov 2020 12:57:57 +1000
Message-Id: <20201120025757.325930-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201120025757.325930-1-npiggin@gmail.com>
References: <20201120025757.325930-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When offlining a CPU, powerpc/64s does not flush TLBs, rather it just
leaves the CPU set in mm_cpumasks, so it continues to receive TLBIEs
to manage its TLBs.

However the exit_flush_lazy_tlbs() function expects that after
returning, all CPUs (except self) have flushed TLBs for that mm, in
which case TLBIEL can be used for this flush. This breaks for offline
CPUs because they don't get the IPI to flush their TLB. This can lead
to stale translations.

Fix this by clearing the CPU from mm_cpumasks, then flushing all TLBs
before going offline.

These offlined CPU bits stuck in the cpumask also prevents the cpumask
from being trimmed back to local mode, which means continual broadcast
IPIs or TLBIEs are needed for TLB flushing. This patch prevents that
situation too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h     | 12 ++++++++++++
 arch/powerpc/mm/book3s64/mmu_context.c       | 20 ++++++++++++++++++++
 arch/powerpc/platforms/powermac/smp.c        |  2 ++
 arch/powerpc/platforms/powernv/smp.c         |  3 +++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  3 +++
 5 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index e0b52940e43c..750918451dd2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -242,6 +242,18 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#define arch_clear_mm_cpumask_cpu(cpu, mm)				\
+	do {								\
+		if (cpumask_test_cpu(cpu, mm_cpumask(mm))) {		\
+			atomic_dec(&(mm)->context.active_cpus);		\
+			cpumask_clear_cpu(cpu, mm_cpumask(mm));		\
+		}							\
+	} while (0)
+
+void cleanup_cpu_mmu_context(void);
+#endif
+
 static inline int get_user_context(mm_context_t *ctx, unsigned long ea)
 {
 	int index = ea >> MAX_EA_BITS_PER_CONTEXT;
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 1c54821de7bf..0c8557220ae2 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -307,3 +308,22 @@ void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	isync();
 }
 #endif
+
+/**
+ * cleanup_cpu_mmu_context - Clean up MMU details for this CPU (newly offlined)
+ *
+ * This clears the CPU from mm_cpumask for all processes, and then flushes the
+ * local TLB to ensure TLB coherency in case the CPU is onlined again.
+ *
+ * KVM guest translations are not necessarily flushed here. If KVM started
+ * using mm_cpumask or the Linux APIs which do, this would have to be resolved.
+ */
+#ifdef CONFIG_HOTPLUG_CPU
+void cleanup_cpu_mmu_context(void)
+{
+	int cpu = smp_processor_id();
+
+	clear_tasks_mm_cpumask(cpu);
+	tlbiel_all();
+}
+#endif
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 74ebe664b016..adae2a6712e1 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -911,6 +911,8 @@ static int smp_core99_cpu_disable(void)
 
 	mpic_cpu_set_priority(0xf);
 
+	cleanup_cpu_mmu_context();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 54c4ba45c7ce..cbb67813cd5d 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -143,6 +143,9 @@ static int pnv_smp_cpu_disable(void)
 		xive_smp_disable_cpu();
 	else
 		xics_migrate_irqs_away();
+
+	cleanup_cpu_mmu_context();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f2837e33bf5d..a02012f1b04a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -90,6 +90,9 @@ static int pseries_cpu_disable(void)
 		xive_smp_disable_cpu();
 	else
 		xics_migrate_irqs_away();
+
+	cleanup_cpu_mmu_context();
+
 	return 0;
 }
 
-- 
2.23.0

