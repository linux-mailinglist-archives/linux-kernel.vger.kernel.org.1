Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F22D586A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgLJKlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:41:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732890AbgLJKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:40:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BAAVaD8107870;
        Thu, 10 Dec 2020 05:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=JTXWuie3f6C1Apfb3JADi4bFeHoSs+b31jplib9P5LE=;
 b=pkgq1jvLi02c4IPG68lNnC7aKw/QylckOkcG8cvVa3gK1Z2mdWOoniNTu6CZ7s4rDbag
 HMq8dfNVYMlfskDVTR+9etOhMFqXY3jpcW38DRKQaUEKnwAPp+QH8wbfFG1OT19x+38N
 TSz7T/6/W0nPpcTnGF6+bcz3MFJEvmyUdDuYdc/J13tlhVNUciE78UyXEc3vgwKluAUp
 W1FBc2OBTM2cQawra0KiyW7vbpjnum9p79UXgTyoYO1GFv+Szosvav9e+alFzt5lcnjR
 n3ag+LngM1ZqfltsZx4fzmn1bqMDRVFPV6AdVpa0xO1OCUFj55oELSakX4aRoZ8SCs41 TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35bhc0seva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 05:39:17 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BAAYVjE120306;
        Thu, 10 Dec 2020 05:39:16 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35bhc0seuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 05:39:16 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BAAW05m025409;
        Thu, 10 Dec 2020 10:39:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3581u9reby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 10:39:15 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BAAdDMi10354972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 10:39:13 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B03DD136055;
        Thu, 10 Dec 2020 10:39:13 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1922136051;
        Thu, 10 Dec 2020 10:39:12 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.53.52])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Dec 2020 10:39:12 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 2CFEB2E35BB; Thu, 10 Dec 2020 16:09:06 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v3 5/5] powerpc/cacheinfo: Print correct cache-sibling map/list for L2 cache
Date:   Thu, 10 Dec 2020 16:08:59 +0530
Message-Id: <1607596739-32439-6-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_03:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On POWER platforms where only some groups of threads within a core
share the L2-cache (indicated by the ibm,thread-groups device-tree
property), we currently print the incorrect shared_cpu_map/list for
L2-cache in the sysfs.

This patch reports the correct shared_cpu_map/list on such platforms.

Example:
On a platform with "ibm,thread-groups" set to
                 00000001 00000002 00000004 00000000
                 00000002 00000004 00000006 00000001
                 00000003 00000005 00000007 00000002
                 00000002 00000004 00000000 00000002
                 00000004 00000006 00000001 00000003
                 00000005 00000007

This indicates that threads {0,2,4,6} in the core share the L2-cache
and threads {1,3,5,7} in the core share the L2 cache.

However, without the patch, the shared_cpu_map/list for L2 for CPUs 0,
1 is reported in the sysfs as follows:

/sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list:0-7
/sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_map:000000,000000ff

/sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_list:0-7
/sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_map:000000,000000ff

With the patch, the shared_cpu_map/list for L2 cache for CPUs 0, 1 is
correctly reported as follows:

/sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list:0,2,4,6
/sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_map:000000,00000055

/sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_list:1,3,5,7
/sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_map:000000,000000aa

This patch also defines cpu_l2_cache_mask() for !CONFIG_SMP case.
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h  |  4 ++++
 arch/powerpc/kernel/cacheinfo.c | 30 ++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 035459c..c4e2d53 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -201,6 +201,10 @@ static inline const struct cpumask *cpu_smallcore_mask(int cpu)
 	return cpumask_of(cpu);
 }
 
+static inline const struct cpumask *cpu_l2_cache_mask(int cpu)
+{
+	return cpumask_of(cpu);
+}
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 65ab9fc..6f903e9a 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -655,11 +655,27 @@ static unsigned int index_dir_to_cpu(struct cache_index_dir *index)
  * On big-core systems, each core has two groups of CPUs each of which
  * has its own L1-cache. The thread-siblings which share l1-cache with
  * @cpu can be obtained via cpu_smallcore_mask().
+ *
+ * On some big-core systems, the L2 cache is shared only between some
+ * groups of siblings. This is already parsed and encoded in
+ * cpu_l2_cache_mask().
+ *
+ * TODO: cache_lookup_or_instantiate() needs to be made aware of the
+ *       "ibm,thread-groups" property so that cache->shared_cpu_map
+ *       reflects the correct siblings on platforms that have this
+ *       device-tree property. This helper function is only a stop-gap
+ *       solution so that we report the correct siblings to the
+ *       userspace via sysfs.
  */
-static const struct cpumask *get_big_core_shared_cpu_map(int cpu, struct cache *cache)
+static const struct cpumask *get_shared_cpu_map(struct cache_index_dir *index, struct cache *cache)
 {
-	if (cache->level == 1)
-		return cpu_smallcore_mask(cpu);
+	if (has_big_cores) {
+		int cpu = index_dir_to_cpu(index);
+		if (cache->level == 1)
+			return cpu_smallcore_mask(cpu);
+		if (cache->level == 2 && thread_group_shares_l2)
+			return cpu_l2_cache_mask(cpu);
+	}
 
 	return &cache->shared_cpu_map;
 }
@@ -670,17 +686,11 @@ static const struct cpumask *get_big_core_shared_cpu_map(int cpu, struct cache *
 	struct cache_index_dir *index;
 	struct cache *cache;
 	const struct cpumask *mask;
-	int cpu;
 
 	index = kobj_to_cache_index_dir(k);
 	cache = index->cache;
 
-	if (has_big_cores) {
-		cpu = index_dir_to_cpu(index);
-		mask = get_big_core_shared_cpu_map(cpu, cache);
-	} else {
-		mask  = &cache->shared_cpu_map;
-	}
+	mask = get_shared_cpu_map(index, cache);
 
 	return cpumap_print_to_pagebuf(list, buf, mask);
 }
-- 
1.9.4

