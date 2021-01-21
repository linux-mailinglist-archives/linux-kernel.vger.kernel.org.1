Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114AA2FE37E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhAUHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbhAUHAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C76CC239FD;
        Thu, 21 Jan 2021 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212264;
        bh=YrytQCV1YoO38kVk+ZHoqrIH/Rv/zuluJDs9Pv96bXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kq3rXvNFUxr4XL7BDOwWgaQxVsqNbuNkUwzXACezHNP5XVQzLt58l9mZ4gu/xHDOt
         X0HBNmE6IIEx+N8luD7T01OrNV45BOkjhGwlN0HnpakGAn0NnubiD594sCoMQGw4gt
         J2FZhqhBabFHu6ub+nUQi9N40zESMiMdyL7+r3dV4gHOkLYJ5uTm0O/+0cHibOVa3/
         MwEKurdY+UCjeSNgkLis+XgrGY2atC4CUThca28xtTRQZZg+NKJ+aFnnf1xt+iKkYY
         r7/PLwmVNqqyxmgeWLtdeC8WzmnNxmxNVwgWfHJgSHsIBE3yNrqEe4cg5GCq+tdwnv
         enAFZZfu2TF5g==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 27/29] csky: Add VDSO with GENERIC_GETTIMEOFDAY, GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO
Date:   Thu, 21 Jan 2021 14:53:47 +0800
Message-Id: <20210121065349.3188251-27-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

It could help to reduce the latency of the time-related functions
in user space.

We have referenced arm's and riscv's implementation for the patch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                         |   4 +
 arch/csky/abiv1/inc/abi/regdef.h          |   5 +
 arch/csky/abiv2/inc/abi/regdef.h          |   5 +
 arch/csky/include/asm/clocksource.h       |   8 ++
 arch/csky/include/asm/vdso.h              |   2 +
 arch/csky/include/asm/vdso/clocksource.h  |   9 ++
 arch/csky/include/asm/vdso/gettimeofday.h | 114 ++++++++++++++++++++++
 arch/csky/include/asm/vdso/processor.h    |  12 +++
 arch/csky/include/asm/vdso/vsyscall.h     |  22 +++++
 arch/csky/kernel/perf_event.c             |   2 +-
 arch/csky/kernel/vdso.c                   |   4 +
 arch/csky/kernel/vdso/Makefile            |   9 +-
 arch/csky/kernel/vdso/vdso.lds.S          |   4 +
 arch/csky/kernel/vdso/vgettimeofday.c     |  28 ++++++
 14 files changed, 225 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/clocksource.h
 create mode 100644 arch/csky/include/asm/vdso/clocksource.h
 create mode 100644 arch/csky/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/csky/include/asm/vdso/processor.h
 create mode 100644 arch/csky/include/asm/vdso/vsyscall.h
 create mode 100644 arch/csky/kernel/vdso/vgettimeofday.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 7f1721101ea0..34e91224adc3 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -35,6 +35,9 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_32
+	select GENERIC_GETTIMEOFDAY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
@@ -46,6 +49,7 @@ config CSKY
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_GENERIC_VDSO
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 104707fbdcc1..d555b6c440dd 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -4,7 +4,12 @@
 #ifndef __ASM_CSKY_REGDEF_H
 #define __ASM_CSKY_REGDEF_H
 
+#ifdef __ASSEMBLY__
 #define syscallid	r1
+#else
+#define syscallid	"r1"
+#endif
+
 #define regs_syscallid(regs) regs->regs[9]
 #define regs_fp(regs) regs->regs[2]
 
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index d7328bbc1ce7..b8441b032c54 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -4,7 +4,12 @@
 #ifndef __ASM_CSKY_REGDEF_H
 #define __ASM_CSKY_REGDEF_H
 
+#ifdef __ASSEMBLY__
 #define syscallid	r7
+#else
+#define syscallid	"r7"
+#endif
+
 #define regs_syscallid(regs) regs->regs[3]
 #define regs_fp(regs) regs->regs[4]
 
diff --git a/arch/csky/include/asm/clocksource.h b/arch/csky/include/asm/clocksource.h
new file mode 100644
index 000000000000..54da0e49efa1
--- /dev/null
+++ b/arch/csky/include/asm/clocksource.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_CSKY_CLOCKSOURCE_H
+#define __ASM_VDSO_CSKY_CLOCKSOURCE_H
+
+#include <asm/vdso/clocksource.h>
+
+#endif
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index 12c5d638e784..eb5142f9c564 100644
--- a/arch/csky/include/asm/vdso.h
+++ b/arch/csky/include/asm/vdso.h
@@ -5,8 +5,10 @@
 
 #include <linux/types.h>
 
+#ifndef GENERIC_TIME_VSYSCALL
 struct vdso_data {
 };
+#endif
 
 /*
  * The VDSO symbols are mapped into Linux so we can just use regular symbol
diff --git a/arch/csky/include/asm/vdso/clocksource.h b/arch/csky/include/asm/vdso/clocksource.h
new file mode 100644
index 000000000000..dfca7b4724b7
--- /dev/null
+++ b/arch/csky/include/asm/vdso/clocksource.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_CSKY_CLOCKSOURCE_H
+#define __ASM_VDSO_CSKY_CLOCKSOURCE_H
+
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_ARCHTIMER
+
+#endif /* __ASM_VDSO_CSKY_CLOCKSOURCE_H */
diff --git a/arch/csky/include/asm/vdso/gettimeofday.h b/arch/csky/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..6c4f1446944f
--- /dev/null
+++ b/arch/csky/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_CSKY_GETTIMEOFDAY_H
+#define __ASM_VDSO_CSKY_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/barrier.h>
+#include <asm/unistd.h>
+#include <abi/regdef.h>
+#include <uapi/linux/time.h>
+
+#define VDSO_HAS_CLOCK_GETRES	1
+
+static __always_inline
+int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			  struct timezone *_tz)
+{
+	register struct __kernel_old_timeval *tv asm("a0") = _tv;
+	register struct timezone *tz asm("a1") = _tz;
+	register long ret asm("a0");
+	register long nr asm(syscallid) = __NR_gettimeofday;
+
+	asm volatile ("trap 0\n"
+		      : "=r" (ret)
+		      : "r"(tv), "r"(tz), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm(syscallid) = __NR_clock_gettime64;
+
+	asm volatile ("trap 0\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+
+static __always_inline
+long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm(syscallid) = __NR_clock_gettime;
+
+	asm volatile ("trap 0\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm(syscallid) = __NR_clock_getres_time64;
+
+	asm volatile ("trap 0\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+
+static __always_inline
+int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm(syscallid) = __NR_clock_getres;
+
+	asm volatile ("trap 0\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+
+uint64_t csky_pmu_read_cc(void);
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
+{
+#ifdef CONFIG_CSKY_PMU_V1
+	return csky_pmu_read_cc();
+#else
+	return 0;
+#endif
+}
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return _vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_CSKY_GETTIMEOFDAY_H */
diff --git a/arch/csky/include/asm/vdso/processor.h b/arch/csky/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..39a6b561d0cc
--- /dev/null
+++ b/arch/csky/include/asm/vdso/processor.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_VDSO_CSKY_PROCESSOR_H
+#define __ASM_VDSO_CSKY_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#define cpu_relax()	barrier()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_CSKY_PROCESSOR_H */
diff --git a/arch/csky/include/asm/vdso/vsyscall.h b/arch/csky/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..c276211a7c4d
--- /dev/null
+++ b/arch/csky/include/asm/vdso/vsyscall.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_CSKY_VSYSCALL_H
+#define __ASM_VDSO_CSKY_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <vdso/datapage.h>
+
+extern struct vdso_data *vdso_data;
+
+static __always_inline struct vdso_data *__csky_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __csky_get_k_vdso_data
+
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_CSKY_VSYSCALL_H */
diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 55d5a5379483..e5f18420ce64 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -87,7 +87,7 @@ static int csky_pmu_irq;
 })
 
 /* cycle counter */
-static uint64_t csky_pmu_read_cc(void)
+uint64_t csky_pmu_read_cc(void)
 {
 	uint32_t lo, hi, tmp;
 	uint64_t result;
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 839523920843..16c20d64d165 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -8,7 +8,11 @@
 #include <linux/slab.h>
 
 #include <asm/page.h>
+#ifdef GENERIC_TIME_VSYSCALL
+#include <vdso/datapage.h>
+#else
 #include <asm/vdso.h>
+#endif
 
 extern char vdso_start[], vdso_end[];
 
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 13ac549c6587..0b6909f10667 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -6,12 +6,17 @@ ARCH_REL_TYPE_ABS := R_CKCORE_ADDR32|R_CKCORE_JUMP_SLOT
 include $(srctree)/lib/vdso/Makefile
 
 # Symbols present in the vdso
-vdso-syms  = rt_sigreturn
+vdso-syms  += rt_sigreturn
+vdso-syms  += vgettimeofday
 
 # Files to link into the vdso
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
-ccflags-y := -fno-stack-protector
+ifneq ($(c-gettimeofday-y),)
+	CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
+endif
+
+ccflags-y := -fno-stack-protector -DBUILD_VDSO32
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-dummy.o
diff --git a/arch/csky/kernel/vdso/vdso.lds.S b/arch/csky/kernel/vdso/vdso.lds.S
index 8d226252d439..590a6c79fff7 100644
--- a/arch/csky/kernel/vdso/vdso.lds.S
+++ b/arch/csky/kernel/vdso/vdso.lds.S
@@ -49,6 +49,10 @@ VERSION
 	LINUX_5.10 {
 	global:
 		__vdso_rt_sigreturn;
+		__vdso_clock_gettime;
+		__vdso_clock_gettime64;
+		__vdso_gettimeofday;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/csky/kernel/vdso/vgettimeofday.c b/arch/csky/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..da491832c098
--- /dev/null
+++ b/arch/csky/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __vdso_clock_gettime(clockid_t clock,
+			 struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
-- 
2.17.1

