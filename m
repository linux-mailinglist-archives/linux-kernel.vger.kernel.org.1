Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7769D271F74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIUJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:58:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20722 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgIUJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:57:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9V8fN021211;
        Mon, 21 Sep 2020 05:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a1ZiEmvKQr6fxjaaIbX/HCEl2wdsNpLV7NZQTwYXrnQ=;
 b=cKs+gkzACPHQ9Eqq7Y47CRx0iDmTLiQ7UkmhpmeWVc5NN0iUWmzL6p+1J759pewL4oBi
 vekmyZitRK30huh1BQ1LS1LRrI4PjpeOSBkXZ4CzJ7Qh+sdBFMW4kHGy4zf7Fp7O8mop
 98O5n1p8VPAp4fw7xxBncvD6atkhzGTZOl3kKwCcpiWyhU/F+KMH83slPXYmiFGNp+zP
 WX3AjBA2nL/HqeSt+9JjdUi/SGt2m9zuUgfP1ClKYJ4Z5d1eZDodP+mulcRKDWyYms9g
 UQFtSwPcjhm8KJMSycyCWbfOpPP6kGynN2Vma57ztf2r97/7EiJJV11bllh2aSRyqZLF Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psavs6ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:43 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9VAJ3021380;
        Mon, 21 Sep 2020 05:57:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psavs6ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9q7OZ004716;
        Mon, 21 Sep 2020 09:57:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33payu8mt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9vcnG32702778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:57:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32FD65204E;
        Mon, 21 Sep 2020 09:57:38 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B86552050;
        Mon, 21 Sep 2020 09:57:34 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v2 09/11] powerpc/smp: Optimize update_mask_by_l2
Date:   Mon, 21 Sep 2020 15:26:51 +0530
Message-Id: <20200921095653.9701-10-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All threads of a SMT4 core can either be part of this CPU's l2-cache
mask or not related to this CPU l2-cache mask. Use this relation to
reduce the number of iterations needed to find all the CPUs that share
the same l2-cache.

Use a temporary mask to iterate through the CPUs that may share l2_cache
mask. Also instead of setting one CPU at a time into cpu_l2_cache_mask,
copy the SMT4/sub mask at one shot.

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 51 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6f866e6b12f8..17e90c2414af 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -670,6 +670,28 @@ static void set_cpus_unrelated(int i, int j,
 }
 #endif
 
+/*
+ * Extends set_cpus_related. Instead of setting one CPU at a time in
+ * dstmask, set srcmask at oneshot. dstmask should be super set of srcmask.
+ */
+static void or_cpumasks_related(int i, int j, struct cpumask *(*srcmask)(int),
+				struct cpumask *(*dstmask)(int))
+{
+	struct cpumask *mask;
+	int k;
+
+	mask = srcmask(j);
+	for_each_cpu(k, srcmask(i))
+		cpumask_or(dstmask(k), dstmask(k), mask);
+
+	if (i == j)
+		return;
+
+	mask = srcmask(i);
+	for_each_cpu(k, srcmask(j))
+		cpumask_or(dstmask(k), dstmask(k), mask);
+}
+
 /*
  * parse_thread_groups: Parses the "ibm,thread-groups" device tree
  *                      property for the CPU device node @dn and stores
@@ -1220,7 +1242,9 @@ static struct device_node *cpu_to_l2cache(int cpu)
 
 static bool update_mask_by_l2(int cpu)
 {
+	struct cpumask *(*submask_fn)(int) = cpu_sibling_mask;
 	struct device_node *l2_cache, *np;
+	cpumask_var_t mask;
 	int i;
 
 	l2_cache = cpu_to_l2cache(cpu);
@@ -1240,22 +1264,37 @@ static bool update_mask_by_l2(int cpu)
 		return false;
 	}
 
-	cpumask_set_cpu(cpu, cpu_l2_cache_mask(cpu));
-	for_each_cpu_and(i, cpu_online_mask, cpu_cpu_mask(cpu)) {
+	alloc_cpumask_var_node(&mask, GFP_KERNEL, cpu_to_node(cpu));
+	cpumask_and(mask, cpu_online_mask, cpu_cpu_mask(cpu));
+
+	if (has_big_cores)
+		submask_fn = cpu_smallcore_mask;
+
+	/* Update l2-cache mask with all the CPUs that are part of submask */
+	or_cpumasks_related(cpu, cpu, submask_fn, cpu_l2_cache_mask);
+
+	/* Skip all CPUs already part of current CPU l2-cache mask */
+	cpumask_andnot(mask, mask, cpu_l2_cache_mask(cpu));
+
+	for_each_cpu(i, mask) {
 		/*
 		 * when updating the marks the current CPU has not been marked
 		 * online, but we need to update the cache masks
 		 */
 		np = cpu_to_l2cache(i);
-		if (!np)
-			continue;
 
-		if (np == l2_cache)
-			set_cpus_related(cpu, i, cpu_l2_cache_mask);
+		/* Skip all CPUs already part of current CPU l2-cache */
+		if (np == l2_cache) {
+			or_cpumasks_related(cpu, i, submask_fn, cpu_l2_cache_mask);
+			cpumask_andnot(mask, mask, submask_fn(i));
+		} else {
+			cpumask_andnot(mask, mask, cpu_l2_cache_mask(i));
+		}
 
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
+	free_cpumask_var(mask);
 
 	return true;
 }
-- 
2.17.1

