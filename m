Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD81EB40A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgFBEBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 00:01:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgFBEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:01:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0523Wd4X037303;
        Tue, 2 Jun 2020 00:01:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bgcyh7yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0523vHLV096444;
        Tue, 2 Jun 2020 00:01:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bgcyh7y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0524043J030721;
        Tue, 2 Jun 2020 04:01:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47w8dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 04:01:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05241KPd54526226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 04:01:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A164E5204F;
        Tue,  2 Jun 2020 04:01:20 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.55.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2AC305205A;
        Tue,  2 Jun 2020 04:01:16 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/dt_cpu_ftrs: Add feature for 2nd DAWR
Date:   Tue,  2 Jun 2020 09:31:01 +0530
Message-Id: <20200602040106.127693-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
References: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_03:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 cotscore=-2147483648
 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new device-tree feature for 2nd DAWR. If this feature is present,
2nd DAWR is supported, otherwise not.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/cputable.h | 7 +++++--
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index e506d429b1af..3445c86e1f6f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -214,6 +214,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_P9_TLBIE_ERAT_BUG	LONG_ASM_CONST(0x0001000000000000)
 #define CPU_FTR_P9_RADIX_PREFETCH_BUG	LONG_ASM_CONST(0x0002000000000000)
 #define CPU_FTR_ARCH_31			LONG_ASM_CONST(0x0004000000000000)
+#define CPU_FTR_DAWR1			LONG_ASM_CONST(0x0008000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -497,14 +498,16 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
 	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
-	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10)
+	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10 | \
+	     CPU_FTR_DAWR1)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | \
 	     CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | CPU_FTRS_POWER9 | \
-	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10)
+	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | CPU_FTRS_POWER10 | \
+	     CPU_FTR_DAWR1)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
 #else
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 0a41fce34165..c1c63c6724ea 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -568,6 +568,12 @@ static int __init feat_enable_mma(struct dt_cpu_feature *f)
 	return 1;
 }
 
+static int __init feat_enable_dawr1(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->cpu_features |= CPU_FTR_DAWR1;
+	return 1;
+}
+
 struct dt_cpu_feature_match {
 	const char *name;
 	int (*enable)(struct dt_cpu_feature *f);
@@ -643,6 +649,7 @@ static struct dt_cpu_feature_match __initdata
 	{"wait-v3", feat_enable, 0},
 	{"prefix-instructions", feat_enable, 0},
 	{"matrix-multiply-assist", feat_enable_mma, 0},
+	{"dawr1", feat_enable_dawr1, 0},
 };
 
 static bool __initdata using_dt_cpu_ftrs;
-- 
2.26.2

