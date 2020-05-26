Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1571BEF44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD3Efn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 00:35:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgD3Efl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:35:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U4Wmrf143898;
        Thu, 30 Apr 2020 00:35:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9qgrbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:35:19 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03U4ZJpW007223;
        Thu, 30 Apr 2020 00:35:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9qgraw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:35:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4OjxG008374;
        Thu, 30 Apr 2020 04:35:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5srrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:35:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4ZDYv62128356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:35:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A457E4203F;
        Thu, 30 Apr 2020 04:35:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 366F242041;
        Thu, 30 Apr 2020 04:35:10 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 04:35:09 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v4 12/16] powerpc/watchpoint: Use builtin ALIGN*() macros
Date:   Thu, 30 Apr 2020 10:04:13 +0530
Message-Id: <20200430043417.30948-13-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200430043417.30948-1-ravi.bangoria@linux.ibm.com>
References: <20200430043417.30948-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we calculate hw aligned start and end addresses manually.
Replace them with builtin ALIGN_DOWN() and ALIGN() macros.

So far end_addr was inclusive but this patch makes it exclusive (by
avoiding -1) for better readability.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h  |  5 +++--
 arch/powerpc/kernel/hw_breakpoint.c       | 12 ++++++------
 arch/powerpc/kernel/process.c             |  8 ++++----
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index d472b2eb757e..add5aa076919 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -34,10 +34,11 @@ struct arch_hw_breakpoint {
 #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
 				 HW_BRK_TYPE_HYP)
 
+/* Minimum granularity */
 #ifdef CONFIG_PPC_8xx
-#define HW_BREAKPOINT_ALIGN 0x3
+#define HW_BREAKPOINT_SIZE  0x4
 #else
-#define HW_BREAKPOINT_ALIGN 0x7
+#define HW_BREAKPOINT_SIZE  0x8
 #endif
 
 #define DABR_MAX_LEN	8
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 319a761b7412..ab0dd22fed5f 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -145,10 +145,10 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
  *    <---8 bytes--->
  *
  * In this case, we should configure hw as:
- *   start_addr = address & ~HW_BREAKPOINT_ALIGN
+ *   start_addr = address & ~(HW_BREAKPOINT_SIZE - 1)
  *   len = 16 bytes
  *
- * @start_addr and @end_addr are inclusive.
+ * @start_addr is inclusive but @end_addr is exclusive.
  */
 static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
 {
@@ -156,14 +156,14 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
 	u16 hw_len;
 	unsigned long start_addr, end_addr;
 
-	start_addr = hw->address & ~HW_BREAKPOINT_ALIGN;
-	end_addr = (hw->address + hw->len - 1) | HW_BREAKPOINT_ALIGN;
-	hw_len = end_addr - start_addr + 1;
+	start_addr = ALIGN_DOWN(hw->address, HW_BREAKPOINT_SIZE);
+	end_addr = ALIGN(hw->address + hw->len, HW_BREAKPOINT_SIZE);
+	hw_len = end_addr - start_addr;
 
 	if (dawr_enabled()) {
 		max_len = DAWR_MAX_LEN;
 		/* DAWR region can't cross 512 bytes boundary */
-		if ((start_addr >> 9) != (end_addr >> 9))
+		if (ALIGN(start_addr, SZ_512M) != ALIGN(end_addr - 1, SZ_512M))
 			return -EINVAL;
 	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
 		/* 8xx can setup a range without limitation */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 41a59a37383b..dcf9c5b4ac59 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -800,12 +800,12 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
 			       LCTRL1_CRWF_RW;
 	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
-	unsigned long start_addr = brk->address & ~HW_BREAKPOINT_ALIGN;
-	unsigned long end_addr = (brk->address + brk->len - 1) | HW_BREAKPOINT_ALIGN;
+	unsigned long start_addr = ALIGN_DOWN(brk->address, HW_BREAKPOINT_SIZE);
+	unsigned long end_addr = ALIGN(brk->address + brk->len, HW_BREAKPOINT_SIZE);
 
 	if (start_addr == 0)
 		lctrl2 |= LCTRL2_LW0LA_F;
-	else if (end_addr == ~0U)
+	else if (end_addr == 0)
 		lctrl2 |= LCTRL2_LW0LA_E;
 	else
 		lctrl2 |= LCTRL2_LW0LA_EandF;
@@ -821,7 +821,7 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 		lctrl1 |= LCTRL1_CRWE_WO | LCTRL1_CRWF_WO;
 
 	mtspr(SPRN_CMPE, start_addr - 1);
-	mtspr(SPRN_CMPF, end_addr + 1);
+	mtspr(SPRN_CMPF, end_addr);
 	mtspr(SPRN_LCTRL1, lctrl1);
 	mtspr(SPRN_LCTRL2, lctrl2);
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 08cb8c1b504c..697c7e4b5877 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -216,7 +216,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
-	brk.address = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+	brk.address = ALIGN_DOWN(bp_info->addr, HW_BREAKPOINT_SIZE);
 	brk.type = HW_BRK_TYPE_TRANSLATE;
 	brk.len = DABR_MAX_LEN;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
-- 
2.21.1

