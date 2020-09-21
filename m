Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01282271F77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIUJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:58:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbgIUJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:58:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9Y9ws123029;
        Mon, 21 Sep 2020 05:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ykOukTqACz4VzIlBuetNbQGhBCwjejpgR06T+kjHtqE=;
 b=R6zV/YpISm7B8oR/KaSt+hTxtIfwuuUu9YMZ93kqN5K4kkIcf8BvxyvIy12E870dUgb1
 tbYbHQ1rbnuLdtGsm3Y8XmVhh3PcH7NZQEWF3P6mGjJZkNrEGlA0kRnpnQ6W5genBT0J
 ImCFocRbKR4TO0xNEyOAMhJbvHnfJtE+vmfyK+pbVFNwHvXbAsrMVZsUtdpXbxXjAbok
 zZL2LWA5wcdAVu3GQ19xrytoDC9fvJx9nUGd+pvgGiUfNdMM+uw3jqQ9UXLUUs9bjq83
 buvbjFIMyGpb3R36W+f8otxP05wQtRmUbK5X6jPfS0phduRM5NNBYBT7KACNjZk96JSc UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psbr14pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:52 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9YKB9123551;
        Mon, 21 Sep 2020 05:57:51 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33psbr14ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:51 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9vnds012127;
        Mon, 21 Sep 2020 09:57:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33n98gswsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9uCCQ29688064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0171D52052;
        Mon, 21 Sep 2020 09:57:47 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 894B752050;
        Mon, 21 Sep 2020 09:57:38 +0000 (GMT)
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
Subject: [PATCH v2 10/11] powerpc/smp: Move coregroup mask updation to a new function
Date:   Mon, 21 Sep 2020 15:26:52 +0530
Message-Id: <20200921095653.9701-11-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the logic for updating the coregroup mask of a CPU to its own
function. This will help in reworking the updation of coregroup mask in
subsequent patch.

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
 arch/powerpc/kernel/smp.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 17e90c2414af..b48ae4e306d3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1337,6 +1337,23 @@ static inline void add_cpu_to_smallcore_masks(int cpu)
 	}
 }
 
+static void update_coregroup_mask(int cpu)
+{
+	int first_thread = cpu_first_thread_sibling(cpu);
+	int coregroup_id = cpu_to_coregroup_id(cpu);
+	int i;
+
+	cpumask_set_cpu(cpu, cpu_coregroup_mask(cpu));
+	for_each_cpu_and(i, cpu_online_mask, cpu_cpu_mask(cpu)) {
+		int fcpu = cpu_first_thread_sibling(i);
+
+		if (fcpu == first_thread)
+			set_cpus_related(cpu, i, cpu_coregroup_mask);
+		else if (coregroup_id == cpu_to_coregroup_id(i))
+			set_cpus_related(cpu, i, cpu_coregroup_mask);
+	}
+}
+
 static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
@@ -1355,19 +1372,8 @@ static void add_cpu_to_masks(int cpu)
 	add_cpu_to_smallcore_masks(cpu);
 	update_mask_by_l2(cpu);
 
-	if (has_coregroup_support()) {
-		int coregroup_id = cpu_to_coregroup_id(cpu);
-
-		cpumask_set_cpu(cpu, cpu_coregroup_mask(cpu));
-		for_each_cpu_and(i, cpu_online_mask, cpu_cpu_mask(cpu)) {
-			int fcpu = cpu_first_thread_sibling(i);
-
-			if (fcpu == first_thread)
-				set_cpus_related(cpu, i, cpu_coregroup_mask);
-			else if (coregroup_id == cpu_to_coregroup_id(i))
-				set_cpus_related(cpu, i, cpu_coregroup_mask);
-		}
-	}
+	if (has_coregroup_support())
+		update_coregroup_mask(cpu);
 }
 
 /* Activate a secondary processor. */
-- 
2.17.1

