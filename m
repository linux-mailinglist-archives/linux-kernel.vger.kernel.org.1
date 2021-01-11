Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851442F197E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbhAKPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:20:02 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55242 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbhAKPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:20:01 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DDy651Fmqz1qskT;
        Mon, 11 Jan 2021 16:18:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DDy646j31z1tYWW;
        Mon, 11 Jan 2021 16:18:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id S1jEDPKn3m5i; Mon, 11 Jan 2021 16:18:51 +0100 (CET)
X-Auth-Info: +4ZBp6oP5UHBQbz30gRFNPVk3E+f0nOqHIQmb61qUoCy/249mUINCdfQGZyGGjep
Received: from igel.home (ppp-46-244-179-249.dynamic.mnet-online.de [46.244.179.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 11 Jan 2021 16:18:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 666492C352E; Mon, 11 Jan 2021 16:18:51 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: fix clock_gettime_fallback for vdso32
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
X-Yow:  Yow!  Did something bad happen or am I in a drive-in movie??
Date:   Mon, 11 Jan 2021 16:18:51 +0100
Message-ID: <87eeirsdr8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument of __kernel_clock_gettime64 points to a struct
__kernel_timespec, with 64-bit time_t, so use the clock_gettime64 syscall
in the fallback function for the 32-bit vdso.  Similarily,
clock_getres_fallback should use the clock_getres_time64 syscall, though
it isn't yet called from the 32-bit vdso.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 81671aa365b3..a26c12df2c9a 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -106,13 +106,21 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv, struct timezone *_tz
 static __always_inline
 int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
+#ifndef __powerpc64__
+	return do_syscall_2(__NR_clock_gettime64, _clkid, (unsigned long)_ts);
+#else
 	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
+#endif
 }
 
 static __always_inline
 int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
+#ifndef __powerpc64__
+	return do_syscall_2(__NR_clock_getres_time64, _clkid, (unsigned long)_ts);
+#else
 	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
+#endif
 }
 
 #ifdef CONFIG_VDSO32
-- 
2.30.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
