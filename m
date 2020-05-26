Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263DD1A71A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404539AbgDNDSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 23:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404527AbgDNDR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E33Y2g101634
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:17:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b96thrg4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:17:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Apr 2020 04:17:19 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:17:15 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3Gful43319798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:16:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE5752052;
        Tue, 14 Apr 2020 03:17:46 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6559E5204E;
        Tue, 14 Apr 2020 03:17:27 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v3 01/16] powerpc/watchpoint: Rename current DAWR macros
Date:   Tue, 14 Apr 2020 08:46:44 +0530
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-4275-0000-0000-000003BF6A2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-4276-0000-0000-000038D4DAD7
Message-Id: <20200414031659.58875-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=883
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future Power architecture is introducing second DAWR. Use real
register names from ISA for current macros:
  s/SPRN_DAWR/SPRN_DAWR0/
  s/SPRN_DAWRX/SPRN_DAWRX0/

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/reg.h          |  4 ++--
 arch/powerpc/kernel/dawr.c              |  4 ++--
 arch/powerpc/kvm/book3s_hv.c            | 12 ++++++------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 18 +++++++++---------
 arch/powerpc/xmon/xmon.c                |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index da5cab038e25..156ee89fa9be 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -283,14 +283,14 @@
 #define   CTRL_CT1	0x40000000	/* thread 1 */
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
-#define SPRN_DAWR	0xB4
+#define SPRN_DAWR0	0xB4
 #define SPRN_RPR	0xBA	/* Relative Priority Register */
 #define SPRN_CIABR	0xBB
 #define   CIABR_PRIV		0x3
 #define   CIABR_PRIV_USER	1
 #define   CIABR_PRIV_SUPER	2
 #define   CIABR_PRIV_HYPER	3
-#define SPRN_DAWRX	0xBC
+#define SPRN_DAWRX0	0xBC
 #define   DAWRX_USER	__MASK(0)
 #define   DAWRX_KERNEL	__MASK(1)
 #define   DAWRX_HYP	__MASK(2)
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index cc14aa6c4a1b..e91b613bf137 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -39,8 +39,8 @@ int set_dawr(struct arch_hw_breakpoint *brk)
 	if (ppc_md.set_dawr)
 		return ppc_md.set_dawr(dawr, dawrx);
 
-	mtspr(SPRN_DAWR, dawr);
-	mtspr(SPRN_DAWRX, dawrx);
+	mtspr(SPRN_DAWR0, dawr);
+	mtspr(SPRN_DAWRX0, dawrx);
 
 	return 0;
 }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 33be4d93248a..498c57e1f5c9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3383,8 +3383,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	int trap;
 	unsigned long host_hfscr = mfspr(SPRN_HFSCR);
 	unsigned long host_ciabr = mfspr(SPRN_CIABR);
-	unsigned long host_dawr = mfspr(SPRN_DAWR);
-	unsigned long host_dawrx = mfspr(SPRN_DAWRX);
+	unsigned long host_dawr = mfspr(SPRN_DAWR0);
+	unsigned long host_dawrx = mfspr(SPRN_DAWRX0);
 	unsigned long host_psscr = mfspr(SPRN_PSSCR);
 	unsigned long host_pidr = mfspr(SPRN_PID);
 
@@ -3413,8 +3413,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_SPURR, vcpu->arch.spurr);
 
 	if (dawr_enabled()) {
-		mtspr(SPRN_DAWR, vcpu->arch.dawr);
-		mtspr(SPRN_DAWRX, vcpu->arch.dawrx);
+		mtspr(SPRN_DAWR0, vcpu->arch.dawr);
+		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx);
 	}
 	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
 	mtspr(SPRN_IC, vcpu->arch.ic);
@@ -3466,8 +3466,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
 	mtspr(SPRN_HFSCR, host_hfscr);
 	mtspr(SPRN_CIABR, host_ciabr);
-	mtspr(SPRN_DAWR, host_dawr);
-	mtspr(SPRN_DAWRX, host_dawrx);
+	mtspr(SPRN_DAWR0, host_dawr);
+	mtspr(SPRN_DAWRX0, host_dawrx);
 	mtspr(SPRN_PID, host_pidr);
 
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 780a499c7114..70de3325d0e9 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -707,8 +707,8 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_CIABR
-	mfspr	r6, SPRN_DAWR
-	mfspr	r7, SPRN_DAWRX
+	mfspr	r6, SPRN_DAWR0
+	mfspr	r7, SPRN_DAWRX0
 	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_CIABR(r1)
 	std	r6, STACK_SLOT_DAWR(r1)
@@ -803,8 +803,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	beq	1f
 	ld	r5, VCPU_DAWR(r4)
 	ld	r6, VCPU_DAWRX(r4)
-	mtspr	SPRN_DAWR, r5
-	mtspr	SPRN_DAWRX, r6
+	mtspr	SPRN_DAWR0, r5
+	mtspr	SPRN_DAWRX0, r6
 1:
 	ld	r7, VCPU_CIABR(r4)
 	ld	r8, VCPU_TAR(r4)
@@ -1766,8 +1766,8 @@ BEGIN_FTR_SECTION
 	 * If the DAWR doesn't work, it's ok to write these here as
 	 * this value should always be zero
 	*/
-	mtspr	SPRN_DAWR, r6
-	mtspr	SPRN_DAWRX, r7
+	mtspr	SPRN_DAWR0, r6
+	mtspr	SPRN_DAWRX0, r7
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_TID(r1)
@@ -2577,8 +2577,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mfmsr	r6
 	andi.	r6, r6, MSR_DR		/* in real mode? */
 	bne	4f
-	mtspr	SPRN_DAWR, r4
-	mtspr	SPRN_DAWRX, r5
+	mtspr	SPRN_DAWR0, r4
+	mtspr	SPRN_DAWRX0, r5
 4:	li	r3, 0
 	blr
 
@@ -3329,7 +3329,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_AMR, r0
 	mtspr	SPRN_IAMR, r0
 	mtspr	SPRN_CIABR, r0
-	mtspr	SPRN_DAWRX, r0
+	mtspr	SPRN_DAWRX0, r0
 
 BEGIN_MMU_FTR_SECTION
 	b	4f
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7af840c0fc93..d4dba8ea8995 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1939,7 +1939,7 @@ static void dump_207_sprs(void)
 	printf("hfscr  = %.16lx  dhdes = %.16lx rpr    = %.16lx\n",
 		mfspr(SPRN_HFSCR), mfspr(SPRN_DHDES), mfspr(SPRN_RPR));
 	printf("dawr   = %.16lx  dawrx = %.16lx ciabr  = %.16lx\n",
-		mfspr(SPRN_DAWR), mfspr(SPRN_DAWRX), mfspr(SPRN_CIABR));
+		mfspr(SPRN_DAWR0), mfspr(SPRN_DAWRX0), mfspr(SPRN_CIABR));
 #endif
 }
 
-- 
2.21.1

