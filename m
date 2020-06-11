Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E661F6E20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFKTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:46:53 -0400
Received: from smtp87.ord1d.emailsrvr.com ([184.106.54.87]:42208 "EHLO
        smtp87.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725824AbgFKTqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1591904812;
        bh=fkPaV7M6/VR8E4HluhwiC1X0SoV9G641oTubBTo3jzU=;
        h=From:To:Subject:Date:From;
        b=RJNTuzXCF+cnUHbP1SvA9HoTvKMcA70I0uHF7A1KlnLcsyEEgVCn4h37Ag7vM9rON
         TwCmVeDiGHSJiswMYHDl+92UtBIC4JVYjK30idxr7ZvXLh8+Lbelk9/O0soPbeOfpu
         qN6SyzE3lCsSH1ce6WMpjDm6uCzcuM7iub3G1g70=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp19.relay.ord1d.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id D5B81603CB;
        Thu, 11 Jun 2020 15:46:50 -0400 (EDT)
X-Sender-Id: dpreed@deepplum.com
Received: from gyre.localnet ([UNAVAILABLE]. [209.6.10.161])
        (using TLSv1.2 with cipher AES256-GCM-SHA384)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 11 Jun 2020 15:46:51 -0400
From:   "David P. Reed" <dpreed@deepplum.com>
Cc:     "\ 'Sean Christopherson" <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "LKML \ '" <linux-kernel@vger.kernel.org>,
        "David P. Reed" <dpreed@deepplum.com>
Subject: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
Date:   Thu, 11 Jun 2020 15:45:54 -0400
Message-Id: <20200611194553.2246-1-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CALCETrWw3WKLx1k94NfH1jJm-XLid_G-zy8jz_Afdf3KkWjquw@mail.gmail.com>
References: <CALCETrWw3WKLx1k94NfH1jJm-XLid_G-zy8jz_Afdf3KkWjquw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: f4ed8bcc-a2ff-4c63-91e4-853d2878d60b-1-1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF is
done on all CPUS, to allow the INIT IPI to function, since
INIT is suppressed when CPUs are in VMX root operation.
Problem is that  VMXOFF will causes undefined operation fault when CPU not
in VMX operation, that is, VMXON has not been executed yet, or VMXOFF
has been execute but VMX still enabled. Patch makes the reboot
work more reliably by masking the exception on VMXOFF in the
crash/panic/reboot path, which uses cpu_emergency_vmxoff().
Can happen with KVM due to a race, but that race is rare today.
Problem discovered doing out-of-tree x-visor development that uses VMX
in a novel way for kernel performance analysis.
The logic in reboot.c is also corrected, since the point of forcing
the processor out of VMX root operation is to allow the INIT signal
to be unmasked. See Intel SDM section on differences between VMX Root
operation and normal operation. Thus every CPU must be forced out of
VMX operation. Since the CPU may hang rather if INIT fails than restart,
a manual hardware "reset" is the only way out of this state in a
lights-out datacenter (well, if there is a BMC, it can issue a
hardware RESET to the chip).
Style errors in original file fixed, at request of Randy Dunlap:
eliminate '/**' in non-kernel-doc comments.

Fixes: 208067 <https://bugzilla.kernel.org/show_bug.cgi?id=208067>
Reported-by: David P. Reed <dpreed@deepplum.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: David P. Reed <dpreed@deepplum.com>
---
 arch/x86/include/asm/virtext.h | 40 ++++++++++++++++++++++++----------
 arch/x86/kernel/reboot.c       | 13 +++--------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 9aad0e0876fb..ed22c1983da8 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -30,15 +30,15 @@ static inline int cpu_has_vmx(void)
 }
 
 
-/** Disable VMX on the current CPU
+/* Disable VMX on the current CPU
  *
- * vmxoff causes a undefined-opcode exception if vmxon was not run
- * on the CPU previously. Only call this function if you know VMX
- * is enabled.
+ * vmxoff causes an undefined-opcode exception if vmxon was not run
+ * on the CPU previously. Only call this function directly if you know VMX
+ * is enabled *and* CPU is in VMX root operation.
  */
 static inline void cpu_vmxoff(void)
 {
-	asm volatile ("vmxoff");
+	asm volatile ("vmxoff" ::: "cc", "memory"); /* clears all flags on success */
 	cr4_clear_bits(X86_CR4_VMXE);
 }
 
@@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/** Disable VMX if it is enabled on the current CPU
- *
- * You shouldn't call this if cpu_has_vmx() returns 0.
+/*
+ * Safely disable VMX root operation if active
+ * Note that if CPU is not in VMX root operation this
+ * VMXOFF will fault an undefined operation fault,
+ * so use the exception masking facility to handle that RARE
+ * case.
+ * You shouldn't call this directly if cpu_has_vmx() returns 0
+ */
+static inline void cpu_vmxoff_safe(void)
+{
+       asm volatile("1:vmxoff\n\t" /* clears all flags on success */
+		    "2:\n\t"
+                    _ASM_EXTABLE(1b, 2b)
+                    ::: "cc",  "memory");
+       cr4_clear_bits(X86_CR4_VMXE);
+}
+
+/*
+ * Force disable VMX if it is enabled on the current CPU,
+ * when it is unknown whether CPU is in VMX operation.
  */
 static inline void __cpu_emergency_vmxoff(void)
 {
-	if (cpu_vmx_enabled())
-		cpu_vmxoff();
+	if (!cpu_vmx_enabled())
+		return;
+	cpu_vmxoff_safe();
 }
 
-/** Disable VMX if it is supported and enabled on the current CPU
+/* Force disable VMX if it is supported on current CPU
  */
 static inline void cpu_emergency_vmxoff(void)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index e040ba6be27b..b0e6b106a67e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -540,21 +540,14 @@ static void emergency_vmx_disable_all(void)
 	 *
 	 * For safety, we will avoid running the nmi_shootdown_cpus()
 	 * stuff unnecessarily, but we don't have a way to check
-	 * if other CPUs have VMX enabled. So we will call it only if the
-	 * CPU we are running on has VMX enabled.
-	 *
-	 * We will miss cases where VMX is not enabled on all CPUs. This
-	 * shouldn't do much harm because KVM always enable VMX on all
-	 * CPUs anyway. But we can miss it on the small window where KVM
-	 * is still enabling VMX.
+	 * if other CPUs have VMX enabled.
 	 */
-	if (cpu_has_vmx() && cpu_vmx_enabled()) {
+	if (cpu_has_vmx()) {
 		/* Disable VMX on this CPU. */
-		cpu_vmxoff();
+		cpu_emergency_vmxoff();
 
 		/* Halt and disable VMX on the other CPUs */
 		nmi_shootdown_cpus(vmxoff_nmi);
-
 	}
 }
 
-- 
2.26.2

