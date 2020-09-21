Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E83271F72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIUJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:57:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49890 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgIUJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:57:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9X0hw040995;
        Mon, 21 Sep 2020 05:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HVr7nnkozh/p5nufqyY2ABGiNJ8PAw0gtdgFDwq49C4=;
 b=ciJ7PysjEF3YMsKecYOqzzbo/7CKLqw04n58ZHI5QTf6g4YishLbEF/lbsmGkjsQf4Ta
 A7lrQta7EFsYa3FnafK2QnYa/DdPqVad8v/fgt0qzIyzrV2Zm/sDV9wz2UtATwBqZAjE
 bj7F7MLfJwkXolqnn7Yvldr8HdosWuKnmK/H8RsbZzf4nJtE1QHc2NztIcpfwjmC+1bo
 cvNBLdvlEe6pkC/LD2RONS/1azvoncKASEJIXmwcJKkJMunjPPwfQsBkob+hU4YAUFLp
 WljXmi948MEQiipBm54v7O6+tls5Ds08TIwnkH/yOdma2ctsTDXxVSFGrQcZ4jVxTMaK bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33pshv0spt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:36 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9sQ8x109967;
        Mon, 21 Sep 2020 05:57:35 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33pshv0snu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9ptvl007825;
        Mon, 21 Sep 2020 09:57:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 33n98gswsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9vUie29360514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:57:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3505B5205F;
        Mon, 21 Sep 2020 09:57:30 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 01ED85204E;
        Mon, 21 Sep 2020 09:57:26 +0000 (GMT)
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
Subject: [PATCH v2 07/11] powerpc/smp: Depend on cpu_l1_cache_map when adding CPUs
Date:   Mon, 21 Sep 2020 15:26:49 +0530
Message-Id: <20200921095653.9701-8-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on hotplug/hotunplug, CPU iterates through all the CPUs in
its core to find threads in its thread group. However this info is
already captured in cpu_l1_cache_map. Hence reduce iterations and
cleanup add_cpu_to_smallcore_masks function.

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
 arch/powerpc/kernel/smp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 441c9c64b1e3..aeb219a4bf7a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1285,16 +1285,15 @@ static void remove_cpu_from_masks(int cpu)
 
 static inline void add_cpu_to_smallcore_masks(int cpu)
 {
-	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
-	int i, first_thread = cpu_first_thread_sibling(cpu);
+	int i;
 
 	if (!has_big_cores)
 		return;
 
 	cpumask_set_cpu(cpu, cpu_smallcore_mask(cpu));
 
-	for (i = first_thread; i < first_thread + threads_per_core; i++) {
-		if (cpu_online(i) && cpumask_test_cpu(i, this_l1_cache_map))
+	for_each_cpu(i, per_cpu(cpu_l1_cache_map, cpu)) {
+		if (cpu_online(i))
 			set_cpus_related(i, cpu, cpu_smallcore_mask);
 	}
 }
-- 
2.17.1

