Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECB62CB435
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgLBFGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:06:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgLBFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:06:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B251wuv020916;
        Wed, 2 Dec 2020 00:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jvZo1+orSwcy/3xUinpH1EoNPtx25q2RAZktA8b/v/w=;
 b=BDJOAnlUY4pJZ1BCDSp2KMSBdxHZIDboKlInC5SbqQSTRBecDWsZqjBLOTlWbBKDD0lu
 8g+hPLkZn04joc7pQTXDQ+o+QWkF9HvZnNynz7nvoN/Dt5ztCCp0pFCELhyfUAMCUnlF
 hirdNybetE2SvOvVr5LcTfywqtNyr44AuR8woz/wEdkv09AoqVrSgi0AMUkv5KNtsad/
 K8GSv+xE9n6KG8VxaGSD52U5IoAxxVqBga6ZSW9UFjri/+KiaK1tNeF1U54wxYYf/HeD
 HRld2ZVGsfxHs2D2PlQPdFFnOAUeLZOF54yf86mVjGjyqhDL9GFR1Yxggt7VizYcE3xo fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35613quu5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:12 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B251vef020900;
        Wed, 2 Dec 2020 00:05:12 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35613quu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:05:12 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2540C6007636;
        Wed, 2 Dec 2020 05:05:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 353e68a05b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:05:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2558Gm9699882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 05:05:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB1A54C050;
        Wed,  2 Dec 2020 05:05:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 941CC4C044;
        Wed,  2 Dec 2020 05:05:05 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.85.125.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 05:05:05 +0000 (GMT)
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
Subject: [PATCH v2 2/4] powerpc: Rename is_kvm_guest to check_kvm_guest
Date:   Wed,  2 Dec 2020 10:34:54 +0530
Message-Id: <20201202050456.164005-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
References: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_kvm_guest() will be reused in subsequent patch in a new avatar.  Hence
rename is_kvm_guest to check_kvm_guest. No additional changes.

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
 arch/powerpc/include/asm/kvm_guest.h | 4 ++--
 arch/powerpc/include/asm/kvm_para.h  | 2 +-
 arch/powerpc/kernel/firmware.c       | 2 +-
 arch/powerpc/platforms/pseries/smp.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_guest.h b/arch/powerpc/include/asm/kvm_guest.h
index c0ace884a0e8..ba8291e02ba9 100644
--- a/arch/powerpc/include/asm/kvm_guest.h
+++ b/arch/powerpc/include/asm/kvm_guest.h
@@ -7,9 +7,9 @@
 #define __POWERPC_KVM_GUEST_H__
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_KVM_GUEST)
-bool is_kvm_guest(void);
+bool check_kvm_guest(void);
 #else
-static inline bool is_kvm_guest(void) { return false; }
+static inline bool check_kvm_guest(void) { return false; }
 #endif
 
 #endif /* __POWERPC_KVM_GUEST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index abe1b5e82547..6fba06b6cfdb 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -14,7 +14,7 @@
 
 static inline int kvm_para_available(void)
 {
-	return IS_ENABLED(CONFIG_KVM_GUEST) && is_kvm_guest();
+	return IS_ENABLED(CONFIG_KVM_GUEST) && check_kvm_guest();
 }
 
 static inline unsigned int kvm_arch_para_features(void)
diff --git a/arch/powerpc/kernel/firmware.c b/arch/powerpc/kernel/firmware.c
index 5f48e5ad24cd..0aeb6a5b1a9e 100644
--- a/arch/powerpc/kernel/firmware.c
+++ b/arch/powerpc/kernel/firmware.c
@@ -22,7 +22,7 @@ EXPORT_SYMBOL_GPL(powerpc_firmware_features);
 #endif
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_KVM_GUEST)
-bool is_kvm_guest(void)
+bool check_kvm_guest(void)
 {
 	struct device_node *hyper_node;
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index d578732c545d..c70b4be9f0a5 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -211,7 +211,7 @@ static __init void pSeries_smp_probe(void)
 	if (!cpu_has_feature(CPU_FTR_SMT))
 		return;
 
-	if (is_kvm_guest()) {
+	if (check_kvm_guest()) {
 		/*
 		 * KVM emulates doorbells by disabling FSCR[MSGP] so msgsndp
 		 * faults to the hypervisor which then reads the instruction
-- 
2.18.4

