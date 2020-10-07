Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFF2867BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgJGStq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:49:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgJGStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:49:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097IYNZ0006478;
        Wed, 7 Oct 2020 14:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QNvBhxPg6vhV+j6hUKsQLy7E/KAM2vdKIIS389ySYA4=;
 b=miDptHg6vGpoht/ujOYkq9UbmHziXD/EKX3bDNhEFHCtNSV+46fSbzgq/dyIyGcXSzfR
 NHE+poUKJfjqBE97yQGCWx+AaklD9CYQgOjgXFLyHbOpfCcKEbVTWuwcKp+sv+MFHSNQ
 IC0VefK9Ai4Yr3/OG7kwmGy6s23TEfBjj7dfmICgnkYNjr1UuXt+ePjw8sHcf8/OW7Bv
 TiwvaS5M14dgCNYJZvwFqDmgaW3snCrrDgm5Tsj9ECcrDaTupfPXwvCCS+T4t93M37Cq
 laadtBfym/R3lL3++VkOuSXAc7nRMFrerc/gepNNz7XMAmcbmy0vEUjQJLOOjFRBSH0O yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341jyp8k79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 14:49:31 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097IYQFe006830;
        Wed, 7 Oct 2020 14:49:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341jyp8k6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 14:49:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097ISHnO015776;
        Wed, 7 Oct 2020 18:38:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 33xgx8cjne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 18:38:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097IcW5O32375206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 18:38:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E50F4A4064;
        Wed,  7 Oct 2020 18:38:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88168A4067;
        Wed,  7 Oct 2020 18:38:28 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.85.90.101])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Oct 2020 18:38:28 +0000 (GMT)
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>
Subject: [PATCH v3 06/11] powerpc/smp: Stop passing mask to update_mask_by_l2
Date:   Thu,  8 Oct 2020 00:07:55 +0530
Message-Id: <20201007183800.27415-7-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007183800.27415-1-srikar@linux.vnet.ibm.com>
References: <20201007183800.27415-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_mask_by_l2 is called only once. But it passes cpu_l2_cache_mask
as parameter. Instead of passing cpu_l2_cache_mask, use it directly in
update_mask_by_l2.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
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
Cc: Qian Cai <cai@redhat.com>
---
 arch/powerpc/kernel/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c860c4950c9f..441c9c64b1e3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1218,7 +1218,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	return cache;
 }
 
-static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
+static bool update_mask_by_l2(int cpu)
 {
 	struct device_node *l2_cache, *np;
 	int i;
@@ -1240,7 +1240,7 @@ static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 		return false;
 	}
 
-	cpumask_set_cpu(cpu, mask_fn(cpu));
+	cpumask_set_cpu(cpu, cpu_l2_cache_mask(cpu));
 	for_each_cpu_and(i, cpu_online_mask, cpu_cpu_mask(cpu)) {
 		/*
 		 * when updating the marks the current CPU has not been marked
@@ -1251,7 +1251,7 @@ static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 			continue;
 
 		if (np == l2_cache)
-			set_cpus_related(cpu, i, mask_fn);
+			set_cpus_related(cpu, i, cpu_l2_cache_mask);
 
 		of_node_put(np);
 	}
@@ -1315,7 +1315,7 @@ static void add_cpu_to_masks(int cpu)
 			set_cpus_related(i, cpu, cpu_sibling_mask);
 
 	add_cpu_to_smallcore_masks(cpu);
-	update_mask_by_l2(cpu, cpu_l2_cache_mask);
+	update_mask_by_l2(cpu);
 
 	if (has_coregroup_support()) {
 		int coregroup_id = cpu_to_coregroup_id(cpu);
-- 
2.17.1

