Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5202921EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 06:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgJSE1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 00:27:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14684 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbgJSE1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 00:27:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09J41RER076227;
        Mon, 19 Oct 2020 00:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MI7zyXewknhAYJHymZpcCXGuyFhihkn50b+tTV3CY7U=;
 b=ctCe2hEP8yWMdamgXBIjBcryUR9Bs22iMMNYzgaOMEcEcAEizQe1bKTPjEP6xhYlTd8v
 /jzuOScgnnEOIxEGqP25JWsn56det8Ok9R7ORh+WBtq2l7462cPNU/YjUOl1DrIy1UmQ
 qqEoxY7j7W29YHJ+mTrKKeAQw3VHYk1MXo3f6VyLwn6UpYkb2VLkcamQAqGTt0eyrXEV
 PsC6DQd6CD7+ylKdCWIZEuKWGV54yaw41VJ4gznm0zR4gOYacCPNa/yYGgUJrbUR4Osk
 HVb+17d8HBXBaUrDCpvzU/sFEwdQ9ZOoct9MvHP0TkRE0mAT7xmILu+ZIU6CNTloHgVL xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349232sxc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 00:27:32 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09J4KEXo120325;
        Mon, 19 Oct 2020 00:27:32 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349232sxbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 00:27:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09J4IpMh024453;
        Mon, 19 Oct 2020 04:27:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 347r889pbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 04:27:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09J4RS2825952754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 04:27:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D273A4055;
        Mon, 19 Oct 2020 04:27:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B4DA4053;
        Mon, 19 Oct 2020 04:27:25 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.79.221.103])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Oct 2020 04:27:25 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>
Subject: [PATCH 1/2] powerpc/smp: Remove unnecessary variable
Date:   Mon, 19 Oct 2020 09:57:15 +0530
Message-Id: <20201019042716.106234-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
References: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-18_13:2020-10-16,2020-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ab33d6dc3e9 ("powerpc/smp: Optimize update_mask_by_l2")
introduced submask_fn in update_mask_by_l2 to track the right submask.
However commit f6606cfdfbcd ("powerpc/smp: Dont assume l2-cache to be
superset of sibling") introduced sibling_mask in update_mask_by_l2 to
track the same submask. Remove sibling_mask in favour of submask_fn.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qian Cai <cai@redhat.com>
---
 arch/powerpc/kernel/smp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8d1c401f4617..a864b9b3228c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1264,18 +1264,16 @@ static bool update_mask_by_l2(int cpu)
 	cpumask_var_t mask;
 	int i;
 
+	if (has_big_cores)
+		submask_fn = cpu_smallcore_mask;
+
 	l2_cache = cpu_to_l2cache(cpu);
 	if (!l2_cache) {
-		struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
-
 		/*
 		 * If no l2cache for this CPU, assume all siblings to share
 		 * cache with this CPU.
 		 */
-		if (has_big_cores)
-			sibling_mask = cpu_smallcore_mask;
-
-		for_each_cpu(i, sibling_mask(cpu))
+		for_each_cpu(i, submask_fn(cpu))
 			set_cpus_related(cpu, i, cpu_l2_cache_mask);
 
 		return false;
@@ -1284,9 +1282,6 @@ static bool update_mask_by_l2(int cpu)
 	alloc_cpumask_var_node(&mask, GFP_KERNEL, cpu_to_node(cpu));
 	cpumask_and(mask, cpu_online_mask, cpu_cpu_mask(cpu));
 
-	if (has_big_cores)
-		submask_fn = cpu_smallcore_mask;
-
 	/* Update l2-cache mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_l2_cache_mask);
 
-- 
2.18.2

