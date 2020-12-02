Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089E2CB434
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLBFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:06:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbgLBFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:06:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B252u3Z057456;
        Wed, 2 Dec 2020 00:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fcoKQZzrrtzCXl52v7m0fmytR/wyFqh0R98h2qaqPC8=;
 b=s178eYMsQu/k5ctIHk3WcQn67l+aWDSqFGO1MMq5tOoMYSwup7dhJBfMN4WesJI1A01q
 FarCR3KfNmRazdrREojQN66TQz9cFTH8efaQfQaU1TAVNdCn2ryenB7I0tvZolJUoDHw
 jMwkMgXLXnDqjO6PvTk/FMd3FPkvOTQ5ye2/vNDG7ZQLnN+jyh6sNYKAwdU7bec9BMjR
 ftKOVlZqY+5vzHD8Im7eOgaKxsK6SATSGmLL3AL3Cl2Rz43Sk0UIDaqM9nOiKfdBPMdX
 QoIegJREO5b+QfCH54hEswIA1l5G85hWrLyOQZahgWmFmQueQyUREaIJvbuQUPOnoXCa +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jabmhnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:18 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B254t77072836;
        Wed, 2 Dec 2020 00:05:18 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jabmhnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:18 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2528I1006484;
        Wed, 2 Dec 2020 05:05:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 353e683u78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:05:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B255DYC4588050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 05:05:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ECA74C04E;
        Wed,  2 Dec 2020 05:05:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13AA04C046;
        Wed,  2 Dec 2020 05:05:11 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.85.125.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 05:05:10 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 4/4] powerpc/paravirt: Use is_kvm_guest in vcpu_is_preempted
Date:   Wed,  2 Dec 2020 10:34:56 +0530
Message-Id: <20201202050456.164005-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
References: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If its a shared lpar but not a KVM guest, then see if the vCPU is
related to the calling vCPU. On PowerVM, only cores can be preempted.
So if one vCPU is a non-preempted state, we can decipher that all other
vCPUs sharing the same core are in non-preempted state.

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Phil Auld <pauld@redhat.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paravirt.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index 9362c94fe3aa..edc08f04aef7 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -10,6 +10,9 @@
 #endif
 
 #ifdef CONFIG_PPC_SPLPAR
+#include <asm/kvm_guest.h>
+#include <asm/cputhreads.h>
+
 DECLARE_STATIC_KEY_FALSE(shared_processor);
 
 static inline bool is_shared_processor(void)
@@ -74,6 +77,21 @@ static inline bool vcpu_is_preempted(int cpu)
 {
 	if (!is_shared_processor())
 		return false;
+
+#ifdef CONFIG_PPC_SPLPAR
+	if (!is_kvm_guest()) {
+		int first_cpu = cpu_first_thread_sibling(smp_processor_id());
+
+		/*
+		 * Preemption can only happen at core granularity. This CPU
+		 * is not preempted if one of the CPU of this core is not
+		 * preempted.
+		 */
+		if (cpu_first_thread_sibling(cpu) == first_cpu)
+			return false;
+	}
+#endif
+
 	if (yield_count_of(cpu) & 1)
 		return true;
 	return false;
-- 
2.18.4

