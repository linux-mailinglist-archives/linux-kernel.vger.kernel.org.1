Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00CE2F414C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbhAMBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:42:28 -0500
Received: from foss.arm.com ([217.140.110.172]:56512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAMBm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:42:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B881063;
        Tue, 12 Jan 2021 17:41:41 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 193653F70D;
        Tue, 12 Jan 2021 17:41:35 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jia He <justin.he@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 1/2] arm64/cpuinfo: Move init_cpu_features() ahead of setup.c::early_fixmap_init()
Date:   Wed, 13 Jan 2021 09:40:46 +0800
Message-Id: <20210113014047.14371-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113014047.14371-1-justin.he@arm.com>
References: <20210113014047.14371-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move init_cpu_features() ahead of setup_arch()->early_fixmap_init(), which
is the preparation work for checking the condition to assign
arm64_use_ng_mappings as cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0).

Besides, jump_label_init() is also moved ahead because
cpus_have_const_cap() depends on static key enable api.

Percpu helpers should be avoided in cpuinfo_store_boot_cpu() before percpu
init at main.c::setup_per_cpu_areas()

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/include/asm/cpu.h |  1 +
 arch/arm64/kernel/cpuinfo.c  | 13 ++++++++++---
 arch/arm64/kernel/setup.c    | 14 +++++++++-----
 arch/arm64/kernel/smp.c      |  3 +--
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 7faae6ff3ab4..59f36f5e3c04 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -63,6 +63,7 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 
 void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
+void __init save_boot_cpuinfo_data(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info);
 void update_cpu_features(int cpu, struct cpuinfo_arm64 *info,
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 77605aec25fe..f8de5b8bae20 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -413,9 +413,16 @@ void cpuinfo_store_cpu(void)
 
 void __init cpuinfo_store_boot_cpu(void)
 {
-	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
-	__cpuinfo_store_cpu(info);
+	__cpuinfo_store_cpu(&boot_cpu_data);
 
-	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
 }
+
+void __init save_boot_cpuinfo_data(void)
+{
+	struct cpuinfo_arm64 *info;
+
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	info = &per_cpu(cpu_data, 0);
+	*info = boot_cpu_data;
+}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 1a57a76e1cc2..e078ab068f3b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -297,16 +297,20 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	arm64_use_ng_mappings = kaslr_requires_kpti();
 
-	early_fixmap_init();
-	early_ioremap_init();
-
-	setup_machine_fdt(__fdt_pointer);
-
 	/*
 	 * Initialise the static keys early as they may be enabled by the
 	 * cpufeature code and early parameters.
 	 */
 	jump_label_init();
+
+	/* Init the cpu feature codes for boot cpu */
+	cpuinfo_store_boot_cpu();
+
+	early_fixmap_init();
+	early_ioremap_init();
+
+	setup_machine_fdt(__fdt_pointer);
+
 	parse_early_param();
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2499b895efea..3df1f5b1da0b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -449,8 +449,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-	cpuinfo_store_boot_cpu();
+	save_boot_cpuinfo_data();
 
 	/*
 	 * We now know enough about the boot CPU to apply the
-- 
2.17.1

