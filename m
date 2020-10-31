Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED12A11EE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgJaA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 20:28:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:24067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaA1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:27:54 -0400
IronPort-SDR: +sQO6oSuBip/VdGmFdZU3x2seXo8W4Z1eU6olFfUs9JLD/hQd8VkwLHQ2mfUjrJ2n6qMzhjy3l
 y1haUTu8rYfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230318025"
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="230318025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 17:27:53 -0700
IronPort-SDR: b7U9CHw6N7v6FP8X0sV9HRf2E2PvQjXDSUQJ3CyeNGhNP8c3T87RGbtnkEAGn3hgW7fOCF+T4O
 eozkpM1+cYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="469683908"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 17:27:53 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH RFC v3 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus lock
Date:   Sat, 31 Oct 2020 00:27:12 +0000
Message-Id: <20201031002714.3649728-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201031002714.3649728-1-fenghua.yu@intel.com>
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL MSR
while #AC for split lock is enabled by split lock detection bit 29 in
TEST_CTRL MSR.

Delivery of #DB for bus lock in userspace clears DR6[11]. To avoid
confusion in identifying #DB, #DB handler sets the bit to 1 before
returning to the interrupted task.

Use the existing kernel command line option "split_lock_detect=" to handle
#DB for bus lock:

split_lock_detect=
		#AC for split lock		#DB for bus lock

off		Do nothing			Do nothing

warn		Kernel OOPs			Warn once per task and
		Warn once per task and		and continues to run.
		disable future checking 	When both features are
						supported, warn in #DB

fatal		Kernel OOPs			Send SIGBUS to user
		Send SIGBUS to user
		When both features are
		supported, fatal in #AC.

Default option is "warn".

Hardware only generates #DB for bus lock detect when CPL>0 to avoid
nested #DB from multiple bus locks while the first #DB is being handled.
So no need to handle #DB for bus lock detected in the kernel.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
RFC v3:
- Remove DR6_RESERVED change (PeterZ).

 arch/x86/include/asm/cpu.h           |  10 ++-
 arch/x86/include/asm/msr-index.h     |   1 +
 arch/x86/include/uapi/asm/debugreg.h |   1 +
 arch/x86/kernel/cpu/common.c         |   2 +-
 arch/x86/kernel/cpu/intel.c          | 114 ++++++++++++++++++++++-----
 arch/x86/kernel/traps.c              |   7 ++
 6 files changed, 113 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..e74de9fccc0b 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -41,12 +41,13 @@ unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_CPU_SUP_INTEL
-extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+extern bool handle_bus_lock(struct pt_regs *regs);
 #else
-static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
@@ -57,6 +58,11 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline bool handle_bus_lock(struct pt_regs *regs)
+{
+	return false;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d93505..62f7534e0855 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -264,6 +264,7 @@
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2) /* Bus lock detect */
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index d95d080b30e3..0007ba077c0c 100644
--- a/arch/x86/include/uapi/asm/debugreg.h
+++ b/arch/x86/include/uapi/asm/debugreg.h
@@ -24,6 +24,7 @@
 #define DR_TRAP3	(0x8)		/* db3 */
 #define DR_TRAP_BITS	(DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)
 
+#define DR_BUS_LOCK	(0x800)		/* bus_lock */
 #define DR_STEP		(0x4000)	/* single-step */
 #define DR_SWITCH	(0x8000)	/* task switch */
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..92705ac301ec 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1327,7 +1327,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
-	cpu_set_core_cap_bits(c);
+	sld_setup(c);
 
 	fpu__init_system(c);
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3ce3f14..3aa57199484b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -44,11 +44,15 @@ enum split_lock_detect_state {
 
 /*
  * Default to sld_off because most systems do not support split lock detection
- * split_lock_setup() will switch this to sld_warn on systems that support
- * split lock detect, unless there is a command line override.
+ * sld_state_setup() will switch this to sld_warn on systems that support
+ * split lock/bus lock detect, unless there is a command line override.
  */
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
 static u64 msr_test_ctrl_cache __ro_after_init;
+/* Split lock detection is enabled if it's true. */
+static bool sld;
+/* Bus lock detection is enabled if it's true. */
+static bool bld;
 
 /*
  * With a name like MSR_TEST_CTL it should go without saying, but don't touch
@@ -602,6 +606,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 }
 
 static void split_lock_init(void);
+static void bus_lock_init(void);
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
@@ -718,6 +723,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
 
+	bus_lock_init();
 	split_lock_init();
 }
 
@@ -1017,16 +1023,15 @@ static bool split_lock_verify_msr(bool on)
 	return ctrl == tmp;
 }
 
-static void __init split_lock_setup(void)
+static void __init sld_state_setup(void)
 {
 	enum split_lock_detect_state state = sld_warn;
 	char arg[20];
 	int i, ret;
 
-	if (!split_lock_verify_msr(false)) {
-		pr_info("MSR access failed: Disabled\n");
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
 				  arg, sizeof(arg));
@@ -1038,17 +1043,14 @@ static void __init split_lock_setup(void)
 			}
 		}
 	}
+	sld_state = state;
+}
 
-	switch (state) {
-	case sld_off:
-		pr_info("disabled\n");
+static void __init _split_lock_setup(void)
+{
+	if (!split_lock_verify_msr(false)) {
+		pr_info("MSR access failed: Disabled\n");
 		return;
-	case sld_warn:
-		pr_info("warning about user-space split_locks\n");
-		break;
-	case sld_fatal:
-		pr_info("sending SIGBUS on user-space split_locks\n");
-		break;
 	}
 
 	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
@@ -1058,8 +1060,11 @@ static void __init split_lock_setup(void)
 		return;
 	}
 
-	sld_state = state;
+	/* Restore the MSR to its cached value. */
+	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+	sld = true;
 }
 
 /*
@@ -1079,6 +1084,10 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
+	/* If supported, #DB for bus lock will handle warn. */
+	if (bld && sld_state == sld_warn)
+		return;
+
 	if (cpu_model_supports_sld)
 		split_lock_verify_msr(sld_state != sld_off);
 }
@@ -1115,14 +1124,41 @@ bool handle_guest_split_lock(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(handle_guest_split_lock);
 
+static void bus_lock_init(void)
+{
+	u64 val;
+
+	if (!bld)
+		return;
+
+	/* If supported, #AC for split lock will handle fatal. */
+	if (sld && sld_state == sld_fatal)
+		return;
+
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+}
+
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal)
 		return false;
 	split_lock_warn(regs->ip);
 	return true;
 }
 
+bool handle_bus_lock(struct pt_regs *regs)
+{
+	if (!bld)
+		return false;
+
+	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
+			    current->comm, current->pid, regs->ip);
+
+	return true;
+}
+
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
@@ -1162,7 +1198,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	{}
 };
 
-void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+static void __init split_lock_setup(struct cpuinfo_x86 *c)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
@@ -1189,5 +1225,45 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	}
 
 	cpu_model_supports_sld = true;
-	split_lock_setup();
+	_split_lock_setup();
+}
+
+static void sld_state_show(void)
+{
+	if (!bld && !sld)
+		return;
+
+	switch (sld_state) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+
+	case sld_warn:
+		if (bld)
+			pr_info("#DB: warning about user-space bus_locks\n");
+		else
+			pr_info("#AC: crashing the kernel about kernel split_locks and warning about user-space split_locks\n");
+		break;
+
+	case sld_fatal:
+		if (sld)
+			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
+		else
+			pr_info("#DB: sending SIGBUS on user-space bus_locks\n");
+		break;
+	}
+}
+
+static void __init bus_lock_setup(void)
+{
+	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) && sld_state != sld_off)
+		bld = true;
+}
+
+void __init sld_setup(struct cpuinfo_x86 *c)
+{
+	sld_state_setup();
+	split_lock_setup(c);
+	bus_lock_setup();
+	sld_state_show();
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..1c3442000972 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -953,6 +953,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 		goto out_irq;
 	}
 
+	/*
+	 * Handle bus lock. #DB for bus lock can only be triggered from
+	 * userspace.
+	 */
+	if (!(dr6 & DR_BUS_LOCK))
+		handle_bus_lock(regs);
+
 	/* Add the virtual_dr6 bits for signals. */
 	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
-- 
2.29.1

