Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2E2F1B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbhAKQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:53:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47492 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbhAKQxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:53:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DF0BS3lSXz9tySV;
        Mon, 11 Jan 2021 17:52:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dNkOVLFC7gay; Mon, 11 Jan 2021 17:52:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DF0BS2xVmz9tyST;
        Mon, 11 Jan 2021 17:52:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B78E8B79E;
        Mon, 11 Jan 2021 17:52:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JV9njlin5Dbq; Mon, 11 Jan 2021 17:52:53 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C0EA8B78E;
        Mon, 11 Jan 2021 17:52:53 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 98DA766970; Mon, 11 Jan 2021 16:52:52 +0000 (UTC)
Message-Id: <77cb8f5e668a2f6e00ea6e90d5f4f37763957b5b.1610383963.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc/vdso: fix clock_gettime_fallback for vdso32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, schwab@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Jan 2021 16:52:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@linux-m68k.org>

The second argument of __kernel_clock_gettime64 points to a struct
__kernel_timespec, with 64-bit time_t, so use the clock_gettime64 syscall
in the fallback function for the 32-bit vdso.  Similarily,
clock_getres_fallback should use the clock_getres_time64 syscall, though
it isn't yet called from the 32-bit vdso.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
[chleroy: Moved into the #ifdef CONFIG_VDSO32 block]
Fixes: d0e3fc69d00d ("powerpc/vdso: Provide __kernel_clock_gettime64() on vdso32")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 27 +++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 7a215cc5da77..3ecddd9c6302 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -102,22 +102,22 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv, struct timezone *_tz
 	return do_syscall_2(__NR_gettimeofday, (unsigned long)_tv, (unsigned long)_tz);
 }
 
+#ifdef CONFIG_VDSO32
+
+#define BUILD_VDSO32		1
+
 static __always_inline
 int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
-	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
+	return do_syscall_2(__NR_clock_gettime64, _clkid, (unsigned long)_ts);
 }
 
 static __always_inline
 int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
-	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
+	return do_syscall_2(__NR_clock_getres_time64, _clkid, (unsigned long)_ts);
 }
 
-#ifdef CONFIG_VDSO32
-
-#define BUILD_VDSO32		1
-
 static __always_inline
 int clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
@@ -129,6 +129,21 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
 	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
 }
+
+#else
+
+static __always_inline
+int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
+}
+
 #endif
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-- 
2.25.0

