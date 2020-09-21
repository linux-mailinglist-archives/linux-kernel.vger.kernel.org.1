Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86256271F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIUJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:57:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgIUJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:57:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9XtrJ073628;
        Mon, 21 Sep 2020 05:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=78m92cDc+wL6vnHHyW2ofVXiLPSmxb5qI7CqbB9rH/g=;
 b=HoomHV+cL7uUREWFF9dL6QnZ5RQ4W8GoTLIY7cqXde/I2BeQZuct2Msi0sALTM/GQSYM
 ij+0Zqrufmb/lsrgGOJRl0QOQsykO1br09DNBncJaINeL602xCf0tt+7ZrGN6K2Vu3x2
 xQ1O7OkGnv2sEjAorM4EAiGIZgMNtoE6fCUAEDkHpnQDEtCXqGe5oWm89Ds92gxykf4H
 ZOPY/VniI7DoT88dfJ6XsN0bii0fkjmyWTThpKEfdfovUVWbEg1CddJnKpj/r1uqRzAb
 MmHSWVqSaEWHpBs+l8pBrbHLH3/RsWzkpZaZPcpBBIlsJ30t0l9bHSIPFS4nyFY3Rn6c Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psbth56k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:28 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9a6iQ083671;
        Mon, 21 Sep 2020 05:57:28 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psbth55f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9qHDf001834;
        Mon, 21 Sep 2020 09:57:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 33p1f3rgde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9vMYn22348056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:57:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37DCC52057;
        Mon, 21 Sep 2020 09:57:22 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3306652050;
        Mon, 21 Sep 2020 09:57:19 +0000 (GMT)
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
Subject: [PATCH v2 05/11] powerpc/smp: Limit CPUs traversed to within a node.
Date:   Mon, 21 Sep 2020 15:26:47 +0530
Message-Id: <20200921095653.9701-6-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the arch specific topology cpumasks are within a node/DIE.
However when setting these per CPU cpumasks, system traverses through
all the online CPUs. This is redundant.

Reduce the traversal to only CPUs that are online in the node to which
the CPU belongs to.

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
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2e61a81aad88..c860c4950c9f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1241,7 +1241,7 @@ static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 	}
 
 	cpumask_set_cpu(cpu, mask_fn(cpu));
-	for_each_cpu(i, cpu_online_mask) {
+	for_each_cpu_and(i, cpu_online_mask, cpu_cpu_mask(cpu)) {
 		/*
 		 * when updating the marks the current CPU has not been marked
 		 * online, but we need to update the cache masks
-- 
2.17.1

