Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8451A1F58CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgFJQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 12:13:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39504 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgFJQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591805581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=jszjpg093lUjd7SXWU6y9l2BOYmNd24mrcTabfHoHS8=;
        b=eMxbcgxnCV3mj63RMj75DFJsk/DxIDyF+icAYFEzs+JX75A2LrHtEjgKprrZ/MAA8e8SZ2
        WU0dq3pmeBUTM8O9LChs8jaCEHGxMraPvc3vU5wWrG3rU+2PisC2NFcTarKwO5fM7fkWAQ
        ddGjltT+ZZcKPhz3AvOlmM6CUkYQ+44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-yAvxoEUTOCaz1q_IZOKaGg-1; Wed, 10 Jun 2020 12:12:53 -0400
X-MC-Unique: yAvxoEUTOCaz1q_IZOKaGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094A5805783;
        Wed, 10 Jun 2020 16:12:52 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EF56512FE;
        Wed, 10 Jun 2020 16:12:50 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: [Patch v1 1/3] lib: restricting cpumask_local_spread to only houskeeping CPUs
Date:   Wed, 10 Jun 2020 12:12:24 -0400
Message-Id: <20200610161226.424337-2-nitesh@redhat.com>
In-Reply-To: <20200610161226.424337-1-nitesh@redhat.com>
References: <20200610161226.424337-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Belits <abelits@marvell.com>

The current implementation of cpumask_local_spread() does not
respect the isolated CPUs, i.e., even if a CPU has been isolated
for Real-Time task, it will return it to the caller for pinning
of its IRQ threads. Having these unwanted IRQ threads on an
isolated CPU adds up to a latency overhead.
This patch restricts the CPUs that are returned for spreading
IRQs only to the available housekeeping CPUs.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 lib/cpumask.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb266f93..cc4311a8c079 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -205,28 +206,34 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu;
+	int cpu, m, n, hk_flags;
+	const struct cpumask *mask;
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	mask = housekeeping_cpumask(hk_flags);
+	m = cpumask_weight(mask);
 	/* Wrap: we always want a cpu. */
-	i %= num_online_cpus();
+	n = i % m;
+	while (m-- > 0) {
+		if (node == NUMA_NO_NODE) {
+			for_each_cpu(cpu, mask)
+				if (n-- == 0)
+					return cpu;
+		} else {
+			/* NUMA first. */
+			for_each_cpu_and(cpu, cpumask_of_node(node), mask)
+				if (n-- == 0)
+					return cpu;
 
-	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
-	} else {
-		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
+			for_each_cpu(cpu, mask) {
+				/* Skip NUMA nodes, done above. */
+				if (cpumask_test_cpu(cpu,
+						     cpumask_of_node(node)))
+					continue;
 
-		for_each_cpu(cpu, cpu_online_mask) {
-			/* Skip NUMA nodes, done above. */
-			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
-				continue;
-
-			if (i-- == 0)
-				return cpu;
+				if (n-- == 0)
+					return cpu;
+			}
 		}
 	}
 	BUG();
-- 
2.18.4

