Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5F2F2E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbhALL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:56:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52349 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhALL4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:56:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DFTXg3rhMz9v0TQ;
        Tue, 12 Jan 2021 12:55:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Nl431QEeASfw; Tue, 12 Jan 2021 12:55:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DFTXg2mJ8z9v0TP;
        Tue, 12 Jan 2021 12:55:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BAD58B7B3;
        Tue, 12 Jan 2021 12:55:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eccwbrABb1ih; Tue, 12 Jan 2021 12:55:16 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BA048B7AB;
        Tue, 12 Jan 2021 12:55:16 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1128766993; Tue, 12 Jan 2021 11:55:15 +0000 (UTC)
Message-Id: <0c0ab0eb3cc80687c326f76ff0dd5762b8812ecc.1610452505.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3] powerpc/vdso: fix clock_gettime_fallback for vdso32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, schwab@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 12 Jan 2021 11:55:15 +0000 (UTC)
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
[chleroy: Moved into a single #ifdef __powerpc64__ block]
Fixes: d0e3fc69d00d ("powerpc/vdso: Provide __kernel_clock_gettime64() on vdso32")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 7a215cc5da77..d453e725c79f 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -102,6 +102,8 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv, struct timezone *_tz
 	return do_syscall_2(__NR_gettimeofday, (unsigned long)_tv, (unsigned long)_tz);
 }
 
+#ifdef __powerpc64__
+
 static __always_inline
 int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -114,10 +116,22 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
 }
 
-#ifdef CONFIG_VDSO32
+#else
 
 #define BUILD_VDSO32		1
 
+static __always_inline
+int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_gettime64, _clkid, (unsigned long)_ts);
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_getres_time64, _clkid, (unsigned long)_ts);
+}
+
 static __always_inline
 int clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
-- 
2.25.0

