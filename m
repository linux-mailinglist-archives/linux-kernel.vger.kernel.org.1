Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ABD2FF54F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbhAUUCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbhAUUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:00:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LfHiI0g+23eIMuog6udJcNrMXTyASbXeGSbiAk6THh8=; b=ha374QsaNijUYdbYHPh9Fm2H1W
        t10Fx30xIcOCxAZ7w7o0txNGVVsbjbWqq5BfYOX1HnwCUNhSEh0eZPVC8x8Z04X78tlYcuGky2xTa
        6lhz0MsNEArqFyrCpW1oFXs+AnismeFfalstnpnOTYRMMx4Ua4Kn9YdH37QSYZqyiz0I418wXdRi2
        gDd+Ne1HIMk8A6EBOfFqNXnInTgVKhmL8hfE1XT/qieP80t4HAdG341ZuqApItJzYY5n/x65pPHUO
        CtJzf7uLTL1EPvQb1fdqIDDa4suUkpxsbp0CuENKJFKhRFlQxUpIPaFIlL0iySO29rplpf72jq065
        bZ1PIwWQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2g6w-00HSm0-7I; Thu, 21 Jan 2021 19:59:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2g6v-000BCe-Qq; Thu, 21 Jan 2021 19:59:17 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, shenkai <shenkai8@huawei.com>,
        "Schander, Johanna Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: [PATCH] x86/apic/x2apic: Fix parallel handling of cluster_mask
Date:   Thu, 21 Jan 2021 19:59:17 +0000
Message-Id: <20210121195917.43021-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <877do65og8.fsf@nanos.tec.linutronix.de>
References: <877do65og8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

For each CPU being brought up, the alloc_clustermask() function
allocates a new struct cluster_mask just in case it's needed. Then the
target CPU actually runs, and in init_x2apic_ldr() it either uses a
cluster_mask from a previous CPU in the same cluster, or consumes the
"spare" one and sets the global pointer to NULL.

That isn't going to parallelise stunningly well.

Ditch the global variable, let alloc_clustermask() install the struct
*directly* in the per_cpu data for the CPU being brought up. As an
optimisation, actually make it do so for *all* present CPUs in the same
cluster, which means only one iteration over for_each_present_cpu()
instead of doing so repeatedly, once for each CPU.

This was a harmless "bug" while CPU bringup wasn't actually happening in
parallel. It's about to become less harmless...

Fixes: 023a611748fd5 ("x86/apic/x2apic: Simplify cluster management")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/apic/x2apic_cluster.c | 82 ++++++++++++++++-----------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b0889c48a2ac..ee5a9a438780 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -18,7 +18,6 @@ struct cluster_mask {
 static DEFINE_PER_CPU(u32, x86_cpu_to_logical_apicid);
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
 static DEFINE_PER_CPU(struct cluster_mask *, cluster_masks);
-static struct cluster_mask *cluster_hotplug_mask;
 
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
@@ -98,54 +97,71 @@ static u32 x2apic_calc_apicid(unsigned int cpu)
 static void init_x2apic_ldr(void)
 {
 	struct cluster_mask *cmsk = this_cpu_read(cluster_masks);
-	u32 cluster, apicid = apic_read(APIC_LDR);
-	unsigned int cpu;
 
-	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
+	BUG_ON(!cmsk);
 
-	if (cmsk)
-		goto update;
-
-	cluster = apicid >> 16;
-	for_each_online_cpu(cpu) {
-		cmsk = per_cpu(cluster_masks, cpu);
-		/* Matching cluster found. Link and update it. */
-		if (cmsk && cmsk->clusterid == cluster)
-			goto update;
-	}
-	cmsk = cluster_hotplug_mask;
-	cmsk->clusterid = cluster;
-	cluster_hotplug_mask = NULL;
-update:
-	this_cpu_write(cluster_masks, cmsk);
 	cpumask_set_cpu(smp_processor_id(), &cmsk->mask);
 }
 
-static int alloc_clustermask(unsigned int cpu, int node)
+static int alloc_clustermask(unsigned int cpu, u32 cluster, int node)
 {
+	struct cluster_mask *cmsk = NULL;
+	unsigned int cpu_i;
+	u32 apicid;
+
 	if (per_cpu(cluster_masks, cpu))
 		return 0;
-	/*
-	 * If a hotplug spare mask exists, check whether it's on the right
-	 * node. If not, free it and allocate a new one.
+
+	/* For the hotplug case, don't always allocate a new one */
+	for_each_present_cpu(cpu_i) {
+		apicid = apic->cpu_present_to_apicid(cpu_i);
+		if (apicid != BAD_APICID && apicid >> 4 == cluster) {
+			cmsk = per_cpu(cluster_masks, cpu_i);
+			if (cmsk)
+				break;
+		}
+	}
+	if (!cmsk) {
+		cmsk = kzalloc_node(sizeof(*cmsk), GFP_KERNEL, node);
+	}
+	if (!cmsk)
+		return -ENOMEM;
+
+	cmsk->node = node;
+	cmsk->clusterid = cluster;
+
+	per_cpu(cluster_masks, cpu) = cmsk;
+
+        /*
+	 * As an optimisation during boot, set the cluster_mask for *all*
+	 * present CPUs at once, to prevent *each* of them having to iterate
+	 * over the others to find the existing cluster_mask.
 	 */
-	if (cluster_hotplug_mask) {
-		if (cluster_hotplug_mask->node == node)
-			return 0;
-		kfree(cluster_hotplug_mask);
+	if (system_state < SYSTEM_RUNNING) {
+		for_each_present_cpu(cpu) {
+			u32 apicid = apic->cpu_present_to_apicid(cpu);
+			if (apicid != BAD_APICID && apicid >> 4 == cluster) {
+				struct cluster_mask **cpu_cmsk = &per_cpu(cluster_masks, cpu);
+				if (*cpu_cmsk)
+					BUG_ON(*cpu_cmsk != cmsk);
+				else
+					*cpu_cmsk = cmsk;
+			}
+		}
 	}
 
-	cluster_hotplug_mask = kzalloc_node(sizeof(*cluster_hotplug_mask),
-					    GFP_KERNEL, node);
-	if (!cluster_hotplug_mask)
-		return -ENOMEM;
-	cluster_hotplug_mask->node = node;
 	return 0;
 }
 
 static int x2apic_prepare_cpu(unsigned int cpu)
 {
-	if (alloc_clustermask(cpu, cpu_to_node(cpu)) < 0)
+	u32 phys_apicid = apic->cpu_present_to_apicid(cpu);
+	u32 cluster = phys_apicid >> 4;
+	u32 logical_apicid = (cluster << 16) | (1 << (phys_apicid & 0xf));
+
+	per_cpu(x86_cpu_to_logical_apicid, cpu) = logical_apicid;
+
+	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
 		return -ENOMEM;
 	if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
 		return -ENOMEM;
-- 
2.29.2

