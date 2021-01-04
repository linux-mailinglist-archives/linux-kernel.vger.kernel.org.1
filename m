Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B412E93AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhADKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:50:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbhADKuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:50:08 -0500
Received: from zn.tnic (p200300ec2f086c001ffa80bfe662d8cb.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6c00:1ffa:80bf:e662:d8cb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85FEC1EC0328;
        Mon,  4 Jan 2021 11:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609757367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lkN29uoBdOYjwTyM5F4PVlcAPVOpujdb0ZRueOiNzcQ=;
        b=Ba6T6lDsI2DkmbhOQdPvYVhmBjLPdt8B+/tPcMuSdIUTLk4mDsypHXsZ+t6PhytogOw01A
        hFiF6kdhlwM0HvZKkrfZPuQhJS0Tkc1wsCnVyQAduCbK9QZbsD8iDJQwHBQMorQJ/Rs1dH
        H8qEeiwqjKuLcMR94QUzMLl3h7iKYX0=
Date:   Mon, 4 Jan 2021 11:49:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: PROBLEM: CPU hotplug leads to NULL pointer dereference with RAPL
 enabled on AMD 2990WX
Message-ID: <20210104104926.GC32151@zn.tnic>
References: <151f54e9-5b45-5624-681c-754224b6c263@gmx.at>
 <20210104095010.GA32151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104095010.GA32151@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 10:50:10AM +0100, Borislav Petkov wrote:
> On Mon, Jan 04, 2021 at 12:02:44AM +0100, Johnathan Smithinovic wrote:
> > CPU hotplug leads to NULL pointer dereference with RAPL enabled on AMD 2990WX
> > 
> > 
> > When hot-plugging CPUs (e.g. manually or on suspend) I get a NULL
> > pointer dereference in rapl_cpu_offline() for CPUs 16 and 24.
> > It *seems* to me that this has to do with commit
> > 700d098acec5271161606f3c0086b71695ea2ef8
> > ("x86/CPU/AMD: Save AMD NodeId as cpu_die_id").
> > When reverting said commit hotplug works again.
> 
> Yeah, known issue and I'm working on it.

I can't get my box to generate the topology config yours has so can you
run the debug patch below on your system on latest Linus tree, offline
cores (it should prevent the oops so that you can catch dmesg) and then
send me a full dmesg, private mail's fine too.

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
