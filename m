Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4B2EBD14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbhAFLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:21:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE95C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 03:21:05 -0800 (PST)
Received: from zn.tnic (p200300ec2f096900a40cd61b64ba6652.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:6900:a40c:d61b:64ba:6652])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 205AE1EC04A6;
        Wed,  6 Jan 2021 12:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609932064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UvD3Eph1wrWeDWE0TLul7NAvzuEshpM5KPsy2KUjQcY=;
        b=aVqNVTZYK8fcRRO2Zh4xCuWUMd894cBBAhk1+xFLhFQ7cEiBKFmCFkMMKoVeEyLYbfRXZD
        Uhw50w0XAJ2Jl76aoQ3sVVbnGNY5EM2hf7/WLFKsttp2NJuRnHSCGDt8psLSxSc2Yr+dWC
        ruvY39FiW5tBdWMweMaufjTZVBhAsiE=
Date:   Wed, 6 Jan 2021 12:21:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rafael Kitover <rkitover@gmail.com>,
        Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Cc:     X86 ML <x86@kernel.org>, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kim Phillips <kim.phillips@amd.com>
Subject: Re: [RFC PATCH] x86/cpu: Do not check c->initialized in
 topology_phys_to_logical_die()
Message-ID: <20210106112106.GE5729@zn.tnic>
References: <20210105113414.3277-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105113414.3277-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 12:34:14PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> During boot, identify_secondary_cpu() calls at some point
> validate_apic_and_package_id() which calls topology_update_die_map() to
> update/verify the physical to logical DIE map of the CPUs on the system.

Ok, I believe Yazen has a better solution for the issue.

Johnathan, Rafael, can you guys run the below patch on your systems, try
offlining cores, etc. After that please send full dmesg, offlist is fine
too, to check.

Thx.

---
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7dbbeaacd995..19563faa58ae 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -139,10 +139,13 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
+static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu, bool dbg)
 {
 	unsigned int dieid = topology_logical_die_id(cpu);
 
+	if (dbg)
+		pr_info("%s: CPU%d, dieid: %d\n", __func__, cpu, dieid);
+
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
@@ -360,7 +363,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
+	pmu = cpu_to_rapl_pmu(event->cpu, false);
 	if (!pmu)
 		return -EINVAL;
 	event->cpu = pmu->cpu;
@@ -543,13 +546,16 @@ static struct perf_msr amd_rapl_msrs[PERF_RAPL_MAX] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu, true);
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
 	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
 		return 0;
 
+	if (WARN_ON(!pmu))
+		return -1;
+
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
 	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
@@ -565,7 +571,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu, true);
 	int target;
 
 	if (!pmu) {
@@ -682,6 +688,8 @@ static int __init init_rapl_pmus(void)
 	int maxdie = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
+	pr_info("%s: maxdie: %d\n", __func__, maxdie);
+
 	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
 	rapl_pmus = kzalloc(size, GFP_KERNEL);
 	if (!rapl_pmus)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f8ca66f3d861..347a956f71ca 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -542,12 +542,12 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		u32 ecx;
 
 		ecx = cpuid_ecx(0x8000001e);
-		nodes_per_socket = ((ecx >> 8) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
 	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		nodes_per_socket = ((value >> 3) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ca66af96a54..20343682aace 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -319,6 +319,11 @@ int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
+		pr_info("%s: init: %d, cpu %d, cur_cpu: %d, cpu_die_id: %d, die_id: %d, "
+			"phys_proc_id: %d, proc_id: %d, logical_die_id: %d\n",
+			__func__, c->initialized, cpu, cur_cpu, c->cpu_die_id, die_id,
+			c->phys_proc_id, proc_id, c->logical_die_id);
+
 		if (c->initialized && c->cpu_die_id == die_id &&
 		    c->phys_proc_id == proc_id)
 			return c->logical_die_id;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
