Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288072AABE3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKHPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:25:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKHPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:24:59 -0500
Date:   Sun, 08 Nov 2020 15:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604849096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2W4BQx/tWl4hjG+grKu3TWcRhhmxjnzkcE9SFKEBgB4=;
        b=pEjSeDVKN9nanUIaiWyQ16Z3ZzvXzCUWBISoOq5BbHLAMTooTT/foSrhQOpaHqThnZLvBZ
        AMgbN/9Y8lw4s0zBxbY8jTwDU9uFB6uYpGwkhU6NgAIbNhJqK6mYH1Qv5tH6YdRGwyAsvH
        1SzQAppUmD+32i4v/JlhMD25R69TCueKWMWxj+wUS9SQejBLaLbpHSj3+UOAfyu9yF3b5x
        ZFZhtWRim4hIkWmCfy4j1OzDgW9XTu/fBjN8t2k1FDtXv16y8aOGgAzsSm4J3WkHhSboQC
        m7IfTycSiVbjIir1G93IeY4bNtFpNN9kABqkXWjwMmU801VP1lSrE3hSkB40bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604849096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2W4BQx/tWl4hjG+grKu3TWcRhhmxjnzkcE9SFKEBgB4=;
        b=id/lpY2oMWAyM89CcUlc6AvEVNWStE0ruGtgOuYUuhWdiuTzZXbbMM/mImEuK2+E98JS86
        v8QToZ4rdl1XfLDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.10-rc3
References: <160484899473.4262.9790266201913163807.tglx@nanos>
Message-ID: <160484899954.4262.10408036488222363252.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-08

up to:  801284f97378: x86/platform/uv: Recognize UV5 hubless system identifier


A set of x86 fixes:

 - Use SYM_FUNC_START_WEAK in the mem* ASM functions instead of a
   combination of .weak and SYM_FUNC_START_LOCAL which makes LLVMs
   integrated assembler upset.

 - Correct the mitigation selection logic which prevented the related prctl
   to work correctly.

 - Make the UV5 hubless system work correctly by fixing up the malformed
   table entries and adding the missing ones.

Thanks,

	tglx

------------------>
Anand K Mistry (1):
      x86/speculation: Allow IBPB to be conditionally enabled on CPUs with always-on STIBP

Fangrui Song (1):
      x86/lib: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_64.S

Mike Travis (3):
      x86/platform/uv: Fix missing OEM_TABLE_ID
      x86/platform/uv: Remove spaces from OEM IDs
      x86/platform/uv: Recognize UV5 hubless system identifier


 arch/x86/kernel/apic/x2apic_uv_x.c | 23 +++++++++++++----
 arch/x86/kernel/cpu/bugs.c         | 51 ++++++++++++++++++++++++--------------
 arch/x86/lib/memcpy_64.S           |  4 +--
 arch/x86/lib/memmove_64.S          |  4 +--
 arch/x86/lib/memset_64.S           |  4 +--
 5 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233cee0b5..3115caa7d7d0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -290,6 +290,9 @@ static void __init uv_stringify(int len, char *to, char *from)
 {
 	/* Relies on 'to' being NULL chars so result will be NULL terminated */
 	strncpy(to, from, len-1);
+
+	/* Trim trailing spaces */
+	(void)strim(to);
 }
 
 /* Find UV arch type entry in UVsystab */
@@ -366,7 +369,7 @@ static int __init early_get_arch_type(void)
 	return ret;
 }
 
-static int __init uv_set_system_type(char *_oem_id)
+static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 {
 	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
@@ -386,13 +389,23 @@ static int __init uv_set_system_type(char *_oem_id)
 			/* (Not hubless), not a UV */
 			return 0;
 
+		/* Is UV hubless system */
+		uv_hubless_system = 0x01;
+
+		/* UV5 Hubless */
+		if (strncmp(uv_archtype, "NSGI5", 5) == 0)
+			uv_hubless_system |= 0x20;
+
 		/* UV4 Hubless: CH */
-		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
-			uv_hubless_system = 0x11;
+		else if (strncmp(uv_archtype, "NSGI4", 5) == 0)
+			uv_hubless_system |= 0x10;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
 		else
-			uv_hubless_system = 0x9;
+			uv_hubless_system |= 0x8;
+
+		/* Copy APIC type */
+		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
@@ -456,7 +469,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	uv_cpu_info->p_uv_hub_info = &uv_hub_info_node0;
 
 	/* If not UV, return. */
-	if (likely(uv_set_system_type(_oem_id) == 0))
+	if (uv_set_system_type(_oem_id, _oem_table_id) == 0)
 		return 0;
 
 	/* Save and Decode OEM Table ID */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db463f96..581fb7223ad0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1254,6 +1254,14 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static bool is_spec_ib_user_controlled(void)
+{
+	return spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
+		spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP;
+}
+
 static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
@@ -1261,16 +1269,26 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return 0;
+
 		/*
-		 * Indirect branch speculation is always disabled in strict
-		 * mode. It can neither be enabled if it was force-disabled
-		 * by a  previous prctl call.
+		 * With strict mode for both IBPB and STIBP, the instruction
+		 * code paths avoid checking this task flag and instead,
+		 * unconditionally run the instruction. However, STIBP and IBPB
+		 * are independent and either can be set to conditionally
+		 * enabled regardless of the mode of the other.
+		 *
+		 * If either is set to conditional, allow the task flag to be
+		 * updated, unless it was force-disabled by a previous prctl
+		 * call. Currently, this is possible on an AMD CPU which has the
+		 * feature X86_FEATURE_AMD_STIBP_ALWAYS_ON. In this case, if the
+		 * kernel is booted with 'spectre_v2_user=seccomp', then
+		 * spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP and
+		 * spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED.
 		 */
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		if (!is_spec_ib_user_controlled() ||
 		    task_spec_ib_force_disable(task))
 			return -EPERM;
+
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
 		break;
@@ -1283,10 +1301,10 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+
+		if (!is_spec_ib_user_controlled())
 			return 0;
+
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
@@ -1351,20 +1369,17 @@ static int ib_prctl_get(struct task_struct *task)
 	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 	    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 		return PR_SPEC_ENABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
-		return PR_SPEC_DISABLE;
-	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
-	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
+	else if (is_spec_ib_user_controlled()) {
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ib_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	} else
+	} else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		return PR_SPEC_DISABLE;
+	else
 		return PR_SPEC_NOT_AFFECTED;
 }
 
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 037faac46b0c..1e299ac73c86 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -16,8 +16,6 @@
  * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
  */
 
-.weak memcpy
-
 /*
  * memcpy - Copy a memory block.
  *
@@ -30,7 +28,7 @@
  * rax original destination
  */
 SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_LOCAL(memcpy)
+SYM_FUNC_START_WEAK(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 7ff00ea64e4f..41902fe8b859 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -24,9 +24,7 @@
  * Output:
  * rax: dest
  */
-.weak memmove
-
-SYM_FUNC_START_ALIAS(memmove)
+SYM_FUNC_START_WEAK(memmove)
 SYM_FUNC_START(__memmove)
 
 	mov %rdi, %rax
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9ff15ee404a4..0bfd26e4ca9e 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -6,8 +6,6 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
-.weak memset
-
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -19,7 +17,7 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_ALIAS(memset)
+SYM_FUNC_START_WEAK(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended

