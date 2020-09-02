Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F025A490
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 06:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgIBEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 00:30:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgIBEac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:30:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08240ikZ183636;
        Wed, 2 Sep 2020 00:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QaYqs1Hf3/awX19+Da+YyaNhCv38xWdIFN9cOazJHCM=;
 b=iUmj0c3zHHp8F2tglvumBKUS3G80/fc/s270IxDYv2vxGnE/b/Y2kL4kTPs7I7pcGYwL
 SObAx0v9BFgYiwxNx4IuDrfQNHAQi2kj4zuD25FVQmXrWzTzEu/ok2ohICKazN8ZZix3
 SG0/fZDG9xBk+HfwU1Ca5UW7BVGSKE/10ERgArYAgA3bE43ShD6z909abp8C3zzmoIMZ
 NMjmhbnoI209644w72fTCC46w82Ko3d8+vR8X/qR2U+5O30nGHaZ06NV02l92M1Bhc/k
 NE2zzZ1DoV+c6lHDEBbQK+5xwDqxGkIeF+Pcxwtn+N/xwcE2Ax6/BbwwdGTg/saZJlfi AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33a39xhcmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08242M1R188682;
        Wed, 2 Sep 2020 00:30:10 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33a39xhckd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:10 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0824QukA022771;
        Wed, 2 Sep 2020 04:30:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 337en82kmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:30:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0824U6nh23003624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 04:30:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 259BBA4065;
        Wed,  2 Sep 2020 04:30:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B855A405F;
        Wed,  2 Sep 2020 04:30:03 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 04:30:03 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] powerpc/watchpoint: Fix exception handling for CONFIG_HAVE_HW_BREAKPOINT=N
Date:   Wed,  2 Sep 2020 09:59:42 +0530
Message-Id: <20200902042945.129369-6-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=972 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc, ptrace watchpoint works in one-shot mode. i.e. kernel
disables event every time it fires and user has to re-enable it.
Also, in case of ptrace watchpoint, kernel notifies ptrace user
before executing instruction.

With CONFIG_HAVE_HW_BREAKPOINT=N, kernel is missing to disable
ptrace event and thus it's causing infinite loop of exceptions.
This is especially harmful when user watches on a data which is
also read/written by kernel, eg syscall parameters. In such case,
infinite exceptions happens in kernel mode which causes soft-lockup.

Fixes: 9422de3e953d ("powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers")
Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h  |  3 ++
 arch/powerpc/kernel/process.c             | 48 +++++++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  4 +-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 81872c420476..abebfbee5b1c 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -18,6 +18,7 @@ struct arch_hw_breakpoint {
 	u16		type;
 	u16		len; /* length of the target data symbol */
 	u16		hw_len; /* length programmed in hw */
+	u8		flags;
 };
 
 /* Note: Don't change the first 6 bits below as they are in the same order
@@ -37,6 +38,8 @@ struct arch_hw_breakpoint {
 #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
 				 HW_BRK_TYPE_HYP)
 
+#define HW_BRK_FLAG_DISABLED	0x1
+
 /* Minimum granularity */
 #ifdef CONFIG_PPC_8xx
 #define HW_BREAKPOINT_SIZE  0x4
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 016bd831908e..160fbbf41d40 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -636,6 +636,44 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 				    (void __user *)address);
 }
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
+
+static void do_break_handler(struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint *info;
+	struct ppc_inst instr = ppc_inst(0);
+	int type = 0;
+	int size = 0;
+	unsigned long ea;
+	int i;
+
+	/*
+	 * If underneath hw supports only one watchpoint, we know it
+	 * caused exception. 8xx also falls into this category.
+	 */
+	if (nr_wp_slots() == 1) {
+		__set_breakpoint(0, &null_brk);
+		current->thread.hw_brk[0] = null_brk;
+		current->thread.hw_brk[0].flags |= HW_BRK_FLAG_DISABLED;
+		return;
+	}
+
+	/* Otherwise findout which DAWR caused exception and disable it. */
+	wp_get_instr_detail(regs, &instr, &type, &size, &ea);
+
+	for (i = 0; i < nr_wp_slots(); i++) {
+		info = &current->thread.hw_brk[i];
+		if (!info->address)
+			continue;
+
+		if (wp_check_constraints(regs, instr, ea, type, size, info)) {
+			__set_breakpoint(i, &null_brk);
+			current->thread.hw_brk[i] = null_brk;
+			current->thread.hw_brk[i].flags |= HW_BRK_FLAG_DISABLED;
+		}
+	}
+}
+
 void do_break (struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code)
 {
@@ -647,6 +685,16 @@ void do_break (struct pt_regs *regs, unsigned long address,
 	if (debugger_break_match(regs))
 		return;
 
+	/*
+	 * We reach here only when watchpoint exception is generated by ptrace
+	 * event (or hw is buggy!). Now if CONFIG_HAVE_HW_BREAKPOINT is set,
+	 * watchpoint is already handled by hw_breakpoint_handler() so we don't
+	 * have to do anything. But when CONFIG_HAVE_HW_BREAKPOINT is not set,
+	 * we need to manually handle the watchpoint here.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
+		do_break_handler(regs);
+
 	/* Deliver the signal to userspace */
 	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address);
 }
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 57a0ab822334..c9122ed91340 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -286,11 +286,13 @@ long ppc_del_hwdebug(struct task_struct *child, long data)
 	}
 	return ret;
 #else /* CONFIG_HAVE_HW_BREAKPOINT */
-	if (child->thread.hw_brk[data - 1].address == 0)
+	if (!(child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED) &&
+	    child->thread.hw_brk[data - 1].address == 0)
 		return -ENOENT;
 
 	child->thread.hw_brk[data - 1].address = 0;
 	child->thread.hw_brk[data - 1].type = 0;
+	child->thread.hw_brk[data - 1].flags = 0;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	return 0;
-- 
2.26.2

