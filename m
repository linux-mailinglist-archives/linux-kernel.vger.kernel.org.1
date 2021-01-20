Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912AB2FCFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbhATMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:11:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:55295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731544AbhATLiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611142616;
        bh=TfsKMmfCS6hUsi+ELxrDF9ONPAZSrITaCLKQesH2eds=;
        h=X-UI-Sender-Class:From:Subject:Date:Cc:To;
        b=cy5YCZ+V0M+BC90L8VUKPmy3qshIUbcD/T9rlNmPGxTDfARwcQrI9k+MFMUq36tQ/
         nBRGdGLnmEDyW+ssPBXOTeT4ssTL2D551VitoOZkug9hzG5zwAr5VD8PZ6AX7wWvlD
         jU9Im6ZTTGueQsCMxEZwY8hwwkaj5qw5el3Mcixk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1l1e5x3pxG-003xMQ; Wed, 20
 Jan 2021 12:36:56 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: [PATCH 2/3] arm64: kernel: Add a WFI hook.
Message-Id: <DEFE042E-A4E0-4BBF-ACCD-CA960E4451A7@caramail.com>
Date:   Wed, 20 Jan 2021 12:36:55 +0100
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:YQwZ4VjCCi1L8rJGcbkX5VUuw9Y3iNAMG/BESg3Vepb5mGSS09y
 mV7hnZOxFc0efByqcMHtfuT3KtSqHBEv9+gCEbQcuCIzHletK5KG7dqTbeM4mDGv/vL26F8
 9yzTk3ZeBzyfc2JTQFziYTXv8vikoCKHeYyMB/sgM/CDqXaS1+Ek/FGAtAXbY+T2V/Pb9dr
 N1Y5W7MDp266ICLpQfjrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsF8zO/Sv94=:Euoys7ZJzixTLxmHmmGkjZ
 T7f0QvzMwlejIimQIQqMHVqfGjNMMn2qmGlvQQedvfXTMkyzhXXJ0uJBKZg38M0ejC0h9tG0i
 Mr6qAwqdu/ykEXbPuDHweE92JSArl3P11BX8fpcO/vP/I78jf9ks+KQzg9+fdel/dBSNpt/mj
 QqDtZ4o+zfL3NUWlKezGSQ96ItMFOOJtFP+XzqOWXt99mpFyDzGk2Wc+SSS2lfAsDoVU8KEES
 0T9WZQg7JswhhNgf9L+cKCRWTgRZ7C5Pb455iX5xGfWhlAbegbZBNK4JEBWWKK5cAjmbR/7Oq
 Br9RyympkrwcqLOjhWtmoQBH3VFlQruuD80fnDuPfXw1+n7jclnOZc/UhXPpwuKj9wwxrz0YF
 axxpgOATlYYn8u3Y1bDd/g/q9wxm0KVGcs0m21kbhaLUzoov6goaFDJC/MwMc8WEgwqJhsbRO
 0WyjWmh0kPU7oDbuY1stOw0DVE4F8inH9oIQF+i0x2P2DqCQpRXE7cs7Zx9TYiPvpPTuYzzsn
 9nNDjmwVVVemDwdNO6TUth+0uApTQy97CjCEuGPg7O1v/UXAUgMyIEftfR09jRuhqSVoaePMF
 pdMJdHEjP8Iih6klLM7iPfV19yXZyDTHodEbqjOr4X9u/bNq3qUcGnwsMiz1zEfzM6mfgoHzI
 yqPUTSU/ZSC1Vfzj26Yewm+xt0YnSypa/MLDUNbxB7s64DQ50fSox6pKeVakEtSYTUjzRbNBA
 UG/bex0v4P8otx2iwh8Ux4klPkWR9IgBMXjAiC6QDeeIpo+NRX/d653jluD7YU8z2ZbUJP2P4
 LVj/2riV3fXJYu8FyFjKhw3j+afH+J4TN/cmGWiDQeu2p8DbV/AYs1XW68orGK7/IXtQP3HA9
 50+rkNXnnhyngcaYdSHJm4s8UhHqq6ZnLUMXRvTpc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

WFI drops register state on Apple Silicon for SMP systems.

This hook will be used for a hardware workaround in the
Apple CPU start driver.

Signed-off-by: Stan Skowronek <stan@corellium.com>
---
 arch/arm64/include/asm/cpu_ops.h |  2 ++
 arch/arm64/kernel/cpu_ops.c      |  6 ++++++
 arch/arm64/kernel/process.c      | 11 +++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h =
b/arch/arm64/include/asm/cpu_ops.h
index e95c4df83911..4be0fc5bcaf9 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -23,6 +23,7 @@
  * @cpu_boot:	Boots a cpu into the kernel.
  * @cpu_postboot: Optionally, perform any post-boot cleanup or =
necessary
  *		synchronisation. Called from the cpu being booted.
+ * @cpu_wfi:    Optionally, replace calls to WFI in default idle with =
this.
  * @cpu_can_disable: Determines whether a CPU can be disabled based on
  *		mechanism-specific information.
  * @cpu_disable: Prepares a cpu to die. May fail for some =
mechanism-specific
@@ -43,6 +44,7 @@ struct cpu_operations {
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int);
 	void		(*cpu_postboot)(void);
+	void		(*cpu_wfi)(void);
 #ifdef CONFIG_HOTPLUG_CPU
 	bool		(*cpu_can_disable)(unsigned int cpu);
 	int		(*cpu_disable)(unsigned int cpu);
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index e133011f64b5..6979fc4490b2 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -19,12 +19,18 @@ extern const struct cpu_operations =
smp_spin_table_ops;
 extern const struct cpu_operations acpi_parking_protocol_ops;
 #endif
 extern const struct cpu_operations cpu_psci_ops;
+#ifdef CONFIG_ARCH_APPLE
+extern const struct cpu_operations cpu_apple_start_ops;
+#endif
=20
 static const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
=20
 static const struct cpu_operations *const dt_supported_cpu_ops[] =
__initconst =3D {
 	&smp_spin_table_ops,
 	&cpu_psci_ops,
+#ifdef CONFIG_ARCH_APPLE
+	&cpu_apple_start_ops,
+#endif
 	NULL,
 };
=20
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 34ec400288d0..611c639e20be 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -57,6 +57,7 @@
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
+#include <asm/cpu_ops.h>
=20
 #if defined(CONFIG_STACKPROTECTOR) && =
!defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode reboot_mode, =
const char *cmd);
=20
 static void noinstr __cpu_do_idle(void)
 {
-	dsb(sy);
-	wfi();
+	const struct cpu_operations *ops =3D =
get_cpu_ops(task_cpu(current));
+
+	if (ops->cpu_wfi) {
+		ops->cpu_wfi();
+	} else {
+		dsb(sy);
+		wfi();
+	}
 }
=20
 static void noinstr __cpu_do_idle_irqprio(void)
--=20
2.29.2


