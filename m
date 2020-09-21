Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1906B271F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIUJ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:57:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgIUJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:57:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9WuVT006777;
        Mon, 21 Sep 2020 05:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HFX0skN0rZR/1aGXEtBM7mhsg+LnZpihanlR7eECKUg=;
 b=blV2O1oBe6qfmal43OHHA7YS80WuQip0UNK2dMUg4C7KOas6X052qFFGkFwsg3yGxmFa
 RyMzYBZFn7338W4IacOwuSMc2KQa4Keuc7rJmIeZd+T9+jytdxVS7ucVKZuI5kQyAyd6
 WLQI1qMuArQgNLtWS9Rl48pYi1azllMygLi371fn6P29sQISxaYthekCMuSnrPLwpYXc
 3CFTbdoGxIxhyw1+9Rlr4osF4ViNxcxbZ65aLxCxR8PsW5xy6HHytGqBO5arGsXb2kgh
 t8B5a61S8O97GaztuR72s1H/lpa3zvgVaFPP87nazhVjRAbV66zfdBIGCsoEIdxGRVFB bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ps2t9ssc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9WwBc006942;
        Mon, 21 Sep 2020 05:57:20 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ps2t9srm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9qkew025526;
        Mon, 21 Sep 2020 09:57:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33n9m89vs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9vFYF27984262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:57:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0885752054;
        Mon, 21 Sep 2020 09:57:15 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B73315204E;
        Mon, 21 Sep 2020 09:57:11 +0000 (GMT)
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
Subject: [PATCH v2 03/11] powerpc/smp: Remove get_physical_package_id
Date:   Mon, 21 Sep 2020 15:26:45 +0530
Message-Id: <20200921095653.9701-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cpu_core_mask has been removed and topology_core_cpumask has
been updated to use cpu_cpu_mask, we no more need
get_physical_package_id.

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
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
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
index ec41491beca4..8c095fe237b2 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1292,26 +1292,6 @@ static inline void add_cpu_to_smallcore_masks(int cpu)
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

