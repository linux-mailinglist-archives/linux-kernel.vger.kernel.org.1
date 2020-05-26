Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9951A0987
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgDGIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 04:48:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbgDGIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:48:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0378YOIZ028781;
        Tue, 7 Apr 2020 04:48:06 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306mjdg4e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 04:48:05 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0378iarI016876;
        Tue, 7 Apr 2020 08:48:05 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 306hv64bkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 08:48:04 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0378m3vN37028306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 08:48:03 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDDF136051;
        Tue,  7 Apr 2020 08:48:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 001F413605D;
        Tue,  7 Apr 2020 08:48:02 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.79.178.96])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Apr 2020 08:48:02 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id DE1BD2E3225; Tue,  7 Apr 2020 14:17:58 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v5 1/5] powerpc: Move idle_loop_prolog()/epilog() functions to header file
Date:   Tue,  7 Apr 2020 14:17:39 +0530
Message-Id: <1586249263-14048-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently prior to entering an idle state on a Linux Guest, the
pseries cpuidle driver implement an idle_loop_prolog() and
idle_loop_epilog() functions which ensure that idle_purr is correctly
computed, and the hypervisor is informed that the CPU cycles have been
donated.

These prolog and epilog functions are also required in the default
idle call, i.e pseries_lpar_idle(). Hence move these accessor
functions to a common header file and call them from
pseries_lpar_idle(). Since the existing header files such as
asm/processor.h have enough clutter, create a new header file
asm/idle.h. Finally rename idle_loop_prolog() and idle_loop_epilog()
to pseries_idle_prolog() and pseries_idle_epilog() as they are only
relavent for on pseries guests.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/idle.h        | 31 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  7 +++++--
 drivers/cpuidle/cpuidle-pseries.c      | 36 +++++++---------------------------
 3 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 arch/powerpc/include/asm/idle.h

diff --git a/arch/powerpc/include/asm/idle.h b/arch/powerpc/include/asm/idle.h
new file mode 100644
index 0000000..32064a4c
--- /dev/null
+++ b/arch/powerpc/include/asm/idle.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_POWERPC_IDLE_H
+#define _ASM_POWERPC_IDLE_H
+#include <asm/runlatch.h>
+#include <asm/paca.h>
+
+#ifdef CONFIG_PPC_PSERIES
+static inline void pseries_idle_prolog(unsigned long *in_purr)
+{
+	ppc64_runlatch_off();
+	*in_purr = mfspr(SPRN_PURR);
+	/*
+	 * Indicate to the HV that we are idle. Now would be
+	 * a good time to find other work to dispatch.
+	 */
+	get_lppaca()->idle = 1;
+}
+
+static inline void pseries_idle_epilog(unsigned long in_purr)
+{
+	u64 wait_cycles;
+
+	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
+	wait_cycles += mfspr(SPRN_PURR) - in_purr;
+	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
+	get_lppaca()->idle = 0;
+
+	ppc64_runlatch_on();
+}
+#endif /* CONFIG_PPC_PSERIES */
+#endif
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0c8421d..2f53e6b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -68,6 +68,7 @@
 #include <asm/isa-bridge.h>
 #include <asm/security_features.h>
 #include <asm/asm-const.h>
+#include <asm/idle.h>
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
 
@@ -319,6 +320,8 @@ static int alloc_dispatch_log_kmem_cache(void)
 
 static void pseries_lpar_idle(void)
 {
+	unsigned long in_purr;
+
 	/*
 	 * Default handler to go into low thread priority and possibly
 	 * low power mode by ceding processor to hypervisor
@@ -328,7 +331,7 @@ static void pseries_lpar_idle(void)
 		return;
 
 	/* Indicate to hypervisor that we are idle. */
-	get_lppaca()->idle = 1;
+	pseries_idle_prolog(&in_purr);
 
 	/*
 	 * Yield the processor to the hypervisor.  We return if
@@ -339,7 +342,7 @@ static void pseries_lpar_idle(void)
 	 */
 	cede_processor();
 
-	get_lppaca()->idle = 0;
+	pseries_idle_epilog(in_purr);
 }
 
 /*
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..46d5e05 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -19,6 +19,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/runlatch.h>
+#include <asm/idle.h>
 #include <asm/plpar_wrappers.h>
 
 struct cpuidle_driver pseries_idle_driver = {
@@ -31,29 +32,6 @@ struct cpuidle_driver pseries_idle_driver = {
 static u64 snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
-static inline void idle_loop_prolog(unsigned long *in_purr)
-{
-	ppc64_runlatch_off();
-	*in_purr = mfspr(SPRN_PURR);
-	/*
-	 * Indicate to the HV that we are idle. Now would be
-	 * a good time to find other work to dispatch.
-	 */
-	get_lppaca()->idle = 1;
-}
-
-static inline void idle_loop_epilog(unsigned long in_purr)
-{
-	u64 wait_cycles;
-
-	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
-	wait_cycles += mfspr(SPRN_PURR) - in_purr;
-	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
-	get_lppaca()->idle = 0;
-
-	ppc64_runlatch_on();
-}
-
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -63,7 +41,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	idle_loop_prolog(&in_purr);
+	pseries_idle_prolog(&in_purr);
 	local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
 
@@ -87,7 +65,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	local_irq_disable();
 
-	idle_loop_epilog(in_purr);
+	pseries_idle_epilog(in_purr);
 
 	return index;
 }
@@ -115,7 +93,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 {
 	unsigned long in_purr;
 
-	idle_loop_prolog(&in_purr);
+	pseries_idle_prolog(&in_purr);
 	get_lppaca()->donate_dedicated_cpu = 1;
 
 	HMT_medium();
@@ -124,7 +102,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	local_irq_disable();
 	get_lppaca()->donate_dedicated_cpu = 0;
 
-	idle_loop_epilog(in_purr);
+	pseries_idle_epilog(in_purr);
 
 	return index;
 }
@@ -135,7 +113,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 {
 	unsigned long in_purr;
 
-	idle_loop_prolog(&in_purr);
+	pseries_idle_prolog(&in_purr);
 
 	/*
 	 * Yield the processor to the hypervisor.  We return if
@@ -147,7 +125,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	check_and_cede_processor();
 
 	local_irq_disable();
-	idle_loop_epilog(in_purr);
+	pseries_idle_epilog(in_purr);
 
 	return index;
 }
-- 
1.9.4

