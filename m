Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8222E711
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgG0H4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 03:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgG0H4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:56:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R7Wklx108170;
        Mon, 27 Jul 2020 03:56:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hsqht565-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 03:56:34 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R7XgfG111152;
        Mon, 27 Jul 2020 03:56:34 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hsqht555-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 03:56:34 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R7sxKL013936;
        Mon, 27 Jul 2020 07:56:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32gcqk16cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 07:56:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R7uTvH31195308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 07:56:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C328AE045;
        Mon, 27 Jul 2020 07:56:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E759AE04D;
        Mon, 27 Jul 2020 07:56:26 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.199.36.96])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 07:56:26 +0000 (GMT)
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
Subject: [PATCH 3/7] powerpc/smp: Remove get_physical_package_id
Date:   Mon, 27 Jul 2020 13:25:28 +0530
Message-Id: <20200727075532.30058-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727075532.30058-1-srikar@linux.vnet.ibm.com>
References: <20200727075532.30058-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_04:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cpu_core_mask has been removed and topology_core_cpumask has
been updated to use cpu_cpu_mask, we no more need
get_physical_package_id.

Please note get_physical_package_id is an exported symbol. However
it was introduced recently and probably no users outside kernel.

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
 arch/powerpc/include/asm/topology.h |  5 -----
 arch/powerpc/kernel/smp.c           | 20 --------------------
 2 files changed, 25 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index e0f232533c9d..e45219f74be0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -114,12 +114,7 @@ static inline int cpu_to_coregroup_id(int cpu)
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
 
-#ifdef CONFIG_PPC_SPLPAR
-int get_physical_package_id(int cpu);
-#define topology_physical_package_id(cpu)	(get_physical_package_id(cpu))
-#else
 #define topology_physical_package_id(cpu)	(cpu_to_chip_id(cpu))
-#endif
 
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(cpu_cpu_mask(cpu))
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8c28e1b4957b..d476098fc25c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1283,26 +1283,6 @@ static inline void add_cpu_to_smallcore_masks(int cpu)
 	}
 }
 
-int get_physical_package_id(int cpu)
-{
-	int pkg_id = cpu_to_chip_id(cpu);
-
-	/*
-	 * If the platform is PowerNV or Guest on KVM, ibm,chip-id is
-	 * defined. Hence we would return the chip-id as the result of
-	 * get_physical_package_id.
-	 */
-	if (pkg_id == -1 && firmware_has_feature(FW_FEATURE_LPAR) &&
-	    IS_ENABLED(CONFIG_PPC_SPLPAR)) {
-		struct device_node *np = of_get_cpu_node(cpu, NULL);
-		pkg_id = of_node_to_nid(np);
-		of_node_put(np);
-	}
-
-	return pkg_id;
-}
-EXPORT_SYMBOL_GPL(get_physical_package_id);
-
 static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
-- 
2.17.1

