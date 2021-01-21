Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765D2FE465
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbhAUHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbhAUG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0D612399C;
        Thu, 21 Jan 2021 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212209;
        bh=W4ypOiLl33dIJpn7kvCRTFEgKfvNavmgd789Wd6eLNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fc1bdyG82WZZNsR4TEhObb1rY5C/F+d19D/AOwQF/2vWusyernnydNkInQn316zGc
         ycKRb8xzrh1OKsyLlsEadBOlA4YyMV5WAVbenixyGPZ5W28EzL1xBAkfll5NZmzdBE
         OhSGt6rvVXJjvO3KI9F+WadP4GyUTZdaZR8iG67jOhPKDDrit1VaPUnvwdBNk0vyPU
         ge+81Wd2qF/Q/kmq5FvQmfGP8dFhHI2CMacs8HouNbRDkukctjQ27/KkYrU8aS52pF
         bs6L8F9GpvXyhrHq7POFzk9w4uPz9qF8Bs1dRe4SOCqYnD61wQVNwz8NrjFaE6/SJr
         zvvuNbXulu+Qg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 07/29] csky: Fixup asm/cmpxchg.h with correct ordering barrier
Date:   Thu, 21 Jan 2021 14:53:27 +0800
Message-Id: <20210121065349.3188251-7-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Optimize the performance of cmpxchg by using more fine-grained
acquire/release barriers.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 arch/csky/include/asm/cmpxchg.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 89224530a0ee..dabc8e46ce7b 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -3,12 +3,12 @@
 #ifndef __ASM_CSKY_CMPXCHG_H
 #define __ASM_CSKY_CMPXCHG_H
 
-#ifdef CONFIG_CPU_HAS_LDSTEX
+#ifdef CONFIG_SMP
 #include <asm/barrier.h>
 
 extern void __bad_xchg(void);
 
-#define __xchg(new, ptr, size)					\
+#define __xchg_relaxed(new, ptr, size)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -16,7 +16,6 @@ extern void __bad_xchg(void);
 	unsigned long tmp;					\
 	switch (size) {						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	mov		%1, %2   \n"		\
@@ -25,7 +24,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (tmp)		\
 			: "r" (__new), "r"(__ptr)		\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -33,9 +31,10 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
+#define xchg_relaxed(ptr, x) \
+		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
-#define __cmpxchg(ptr, old, new, size)				\
+#define __cmpxchg_relaxed(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -44,7 +43,6 @@ extern void __bad_xchg(void);
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	cmpne		%0, %4   \n"		\
@@ -56,7 +54,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (__tmp)		\
 			: "r" (__new), "r"(__ptr), "r"(__old)	\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -64,8 +61,18 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define cmpxchg(ptr, o, n) \
-	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+#define cmpxchg_relaxed(ptr, o, n) \
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg(ptr, o, n) 					\
+({								\
+	__typeof__(*(ptr)) __ret;				\
+	__smp_release_fence();					\
+	__ret = cmpxchg_relaxed(ptr, o, n);			\
+	__smp_acquire_fence();					\
+	__ret;							\
+})
+
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.17.1

