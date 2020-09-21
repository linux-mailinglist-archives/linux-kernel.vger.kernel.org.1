Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1920F271F75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIUJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:58:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgIUJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:57:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9gI53195903;
        Mon, 21 Sep 2020 05:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jY3/8bcSc8Hz+2fOLFS76yKqp+H7iSXwJ5xjVcFqISg=;
 b=NJRVTZLe8pbZczpH04tqi0GbHDZ4zAZ9GUOy2twpbqUOe3pQLLJoYqL/JswA5LnDiolO
 BazmT4NKGHcG9bXaD5hDDMPdj48N+7ABIVCKACDbyvZsTEwwQeyypGwx8XRL+OeBxiXv
 EWLg432svcIyt2PwjCiMgYtF8xSifizaEgHSG7Ff7/B6YlABEXtwtslUFMKyVvaSxaS6
 HfhAczlbqt4+jtt52kTUFX73tBlAAB18Y0F4XOuyTqcP4TZBct+WmyKlJibYOlOwjcg+
 a+cYOh4TgdNO45wXnFjJZDnS3dJBoMVW7xZxC7YpwufvuIcSqJVw6Ht1yRjnvabCUh3/ UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33pss58cv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:39 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L9h8Mt001970;
        Mon, 21 Sep 2020 05:57:39 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33pss58cuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 05:57:38 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L9rQYM023582;
        Mon, 21 Sep 2020 09:57:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 33n98gryvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:57:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08L9vYWF27066644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:57:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AA8F5204E;
        Mon, 21 Sep 2020 09:57:34 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.192.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8CE7D52052;
        Mon, 21 Sep 2020 09:57:30 +0000 (GMT)
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
Subject: [PATCH v2 08/11] powerpc/smp: Check for duplicate topologies and consolidate
Date:   Mon, 21 Sep 2020 15:26:50 +0530
Message-Id: <20200921095653.9701-9-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CACHE and COREGROUP domains are now part of default topology. However on
systems that don't support CACHE or COREGROUP, these domains will
eventually be degenerated. The degeneration happens per CPU. Do note the
current fixup_topology() logic ensures that mask of a domain that is not
supported on the current platform is set to the previous domain.

Instead of waiting for the scheduler to degenerated try to consolidate
based on their masks and sd_flags. This is done just before setting
the scheduler topology.

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
 arch/powerpc/kernel/smp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index aeb219a4bf7a..6f866e6b12f8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1401,6 +1401,8 @@ int setup_profiling_timer(unsigned int multiplier)
 
 static void fixup_topology(void)
 {
+	int i;
+
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
@@ -1410,6 +1412,30 @@ static void fixup_topology(void)
 
 	if (!has_coregroup_support())
 		powerpc_topology[mc_idx].mask = powerpc_topology[cache_idx].mask;
+
+	/*
+	 * Try to consolidate topology levels here instead of
+	 * allowing scheduler to degenerate.
+	 * - Dont consolidate if masks are different.
+	 * - Dont consolidate if sd_flags exists and are different.
+	 */
+	for (i = 1; i <= die_idx; i++) {
+		if (powerpc_topology[i].mask != powerpc_topology[i - 1].mask)
+			continue;
+
+		if (powerpc_topology[i].sd_flags && powerpc_topology[i - 1].sd_flags &&
+				powerpc_topology[i].sd_flags != powerpc_topology[i - 1].sd_flags)
+			continue;
+
+		if (!powerpc_topology[i - 1].sd_flags)
+			powerpc_topology[i - 1].sd_flags = powerpc_topology[i].sd_flags;
+
+		powerpc_topology[i].mask = powerpc_topology[i + 1].mask;
+		powerpc_topology[i].sd_flags = powerpc_topology[i + 1].sd_flags;
+#ifdef CONFIG_SCHED_DEBUG
+		powerpc_topology[i].name = powerpc_topology[i + 1].name;
+#endif
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.17.1

