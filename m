Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FB2ABF06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgKIOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:43:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47110 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbgKIOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:43:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXvsu185494;
        Mon, 9 Nov 2020 14:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=AG/YydBpJ3s3kgjgdaLfGq4NFt62dOqzraM+mBohCYk=;
 b=rQxaiNP5bjvoydgTZSciyt7jtDs3lO/67miVz3VZjctuWEGC0cZCEPQ8DpjK6OY4imNw
 mkb1lgy8fdeiI7BJtTsB7eYVL8AyUfnYblVbjGUEOZ4sMT1mVa06Ko1tChk86LN1k5F0
 gHbHKZJYh0BEcC2idxsAK2k2c5yQlThrgIt6i30BIMgO9SVe23AAH5r9tl48FUycbO1v
 M1v+Qd3AxkjIwQgCl1QWcLym+iLlm+h4mXD07bQNf7YitfXWhvoBqi59UA6qZmKKX3Q8
 BHuJf3CWDBx3Kw27ysQt0INouSWGedcqXgeiQy3rRoz2c5jGyypeJvTUDD0SV7hO7yN8 hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Eemfs174374;
        Mon, 9 Nov 2020 14:42:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5fxs1pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:56 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Egt4J018437;
        Mon, 9 Nov 2020 14:42:55 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:55 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 09/24] x86/entry: Add C version of paranoid_entry/exit
Date:   Mon,  9 Nov 2020 15:44:10 +0100
Message-Id: <20201109144425.270789-10-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paranoid_entry/exit are assembly macros. Provide C versions of
these macros (kernel_paranoid_entry() and kernel_paranoid_exit()).
The C functions are functionally equivalent to the assembly macros,
except that kernel_paranoid_entry() doesn't save registers in
pt_regs like paranoid_entry does.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c             | 157 ++++++++++++++++++++++++++++
 arch/x86/include/asm/entry-common.h |  10 ++
 2 files changed, 167 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d09b1ded5287..54d0931801e1 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -387,3 +387,160 @@ static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
 static __always_inline void restore_cr3(unsigned long cr3) {}
 
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
+/*
+ * "Paranoid" entry path from exception stack. Ensure that the CR3 and
+ * GS registers are correctly set for the kernel. Return GSBASE related
+ * information in kernel_entry_state depending on the availability of
+ * the FSGSBASE instructions:
+ *
+ * FSGSBASE	kernel_entry_state
+ *     N        swapgs=true -> SWAPGS on exit
+ *              swapgs=false -> no SWAPGS on exit
+ *
+ *     Y        gsbase=GSBASE value at entry, must be restored in
+ *              kernel_paranoid_exit()
+ *
+ * Note that per-cpu variables are accessed using the GS register,
+ * so paranoid entry code cannot access per-cpu variables before
+ * kernel_paranoid_entry() has been called.
+ */
+noinstr void kernel_paranoid_entry(struct kernel_entry_state *state)
+{
+	unsigned long gsbase;
+	unsigned int cpu;
+
+	/*
+	 * Save CR3 in the kernel entry state.  This value will be
+	 * restored, verbatim, at exit.  Needed if the paranoid entry
+	 * interrupted another entry that already switched to the user
+	 * CR3 value but has not yet returned to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
+	 */
+	state->cr3 = save_and_switch_to_kernel_cr3();
+
+	/*
+	 * Handling GSBASE depends on the availability of FSGSBASE.
+	 *
+	 * Without FSGSBASE the kernel enforces that negative GSBASE
+	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
+	 * can be made about the GSBASE value when entering from user
+	 * space.
+	 */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * Read the current GSBASE and store it in the kernel
+		 * entry state unconditionally, retrieve and set the
+		 * current CPUs kernel GSBASE. The stored value has to
+		 * be restored at exit unconditionally.
+		 *
+		 * The unconditional write to GS base below ensures that
+		 * no subsequent loads based on a mispredicted GS base
+		 * can happen, therefore no LFENCE is needed here.
+		 */
+		state->gsbase = rdgsbase();
+
+		/*
+		 * Fetch the per-CPU GSBASE value for this processor. We
+		 * normally use %gs for accessing per-CPU data, but we
+		 * are setting up %gs here and obviously can not use %gs
+		 * itself to access per-CPU data.
+		 */
+		if (IS_ENABLED(CONFIG_SMP)) {
+			/*
+			 * Load CPU from the GDT. Do not use RDPID,
+			 * because KVM loads guest's TSC_AUX on vm-entry
+			 * and may not restore the host's value until
+			 * the CPU returns to userspace. Thus the kernel
+			 * would consume a guest's TSC_AUX if an NMI
+			 * arrives while running KVM's run loop.
+			 */
+			asm_inline volatile ("lsl %[seg],%[p]"
+					     : [p] "=r" (cpu)
+					     : [seg] "r" (__CPUNODE_SEG));
+
+			cpu &= VDSO_CPUNODE_MASK;
+			gsbase = __per_cpu_offset[cpu];
+		} else {
+			gsbase = *pcpu_unit_offsets;
+		}
+
+		wrgsbase(gsbase);
+
+	} else {
+		/*
+		 * The kernel-enforced convention is a negative GSBASE
+		 * indicates a kernel value. No SWAPGS needed on entry
+		 * and exit.
+		 */
+		rdmsrl(MSR_GS_BASE, gsbase);
+		if (((long)gsbase) >= 0) {
+			swapgs();
+			/*
+			 * Do an lfence to prevent GS speculation.
+			 */
+			alternative("", "lfence",
+				    X86_FEATURE_FENCE_SWAPGS_KERNEL);
+			state->swapgs = true;
+		} else {
+			state->swapgs = false;
+		}
+	}
+}
+
+/*
+ * "Paranoid" exit path from exception stack. Restore the CR3 and
+ * GS registers are as they were on entry. This is invoked only
+ * on return from IST interrupts that came from kernel space.
+ *
+ * We may be returning to very strange contexts (e.g. very early
+ * in syscall entry), so checking for preemption here would
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ *
+ * The kernel_entry_state contains the GSBASE related information
+ * depending on the availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	kernel_entry_state
+ *     N        swapgs=true  -> SWAPGS on exit
+ *              swapgs=false -> no SWAPGS on exit
+ *
+ *     Y        gsbase=GSBASE value at entry, must be restored
+ *              unconditionally
+ *
+ * Note that per-cpu variables are accessed using the GS register,
+ * so paranoid entry code cannot access per-cpu variables after
+ * kernel_paranoid_exit() has been called.
+ */
+noinstr void kernel_paranoid_exit(struct kernel_entry_state *state)
+{
+	/*
+	 * The order of operations is important. RESTORE_CR3 requires
+	 * kernel GSBASE.
+	 *
+	 * NB to anyone to try to optimize this code: this code does
+	 * not execute at all for exceptions from user mode. Those
+	 * exceptions go through error_exit instead.
+	 */
+	restore_cr3(state->cr3);
+
+	/* With FSGSBASE enabled, unconditionally restore GSBASE */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrgsbase(state->gsbase);
+		return;
+	}
+
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
+	if (state->swapgs) {
+		/* We are returning to a context with user GSBASE */
+		swapgs_unsafe_stack();
+	}
+}
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index b05b212f5ebc..b75e9230c990 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -163,6 +163,16 @@ static inline void switch_to_kernel_cr3(void) {}
 static inline void switch_to_user_cr3(void) {}
 
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
+struct kernel_entry_state {
+	unsigned long cr3;
+	unsigned long gsbase;
+	bool swapgs;
+};
+
+void kernel_paranoid_entry(struct kernel_entry_state *state);
+void kernel_paranoid_exit(struct kernel_entry_state *state);
+
 #endif /* MODULE */
 
 #endif
-- 
2.18.4

