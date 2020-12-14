Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE62DA1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503274AbgLNU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:27:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503184AbgLNU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:16 -0500
Date:   Mon, 14 Dec 2020 20:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YXNDukbn53Bfc/KJllLo5hFFxFmyIqh2K+vMNnq9Lvw=;
        b=jToHDfdkOK3YUmpgvUxeJdCTTtA/GFFBInotmGUjp8YGT17INXg544kOJ5gtpU4tSDuvpS
        lig+0E6BMyMlnWVVziGUsc5gu0wYX4ulEyyFz864oZ+CPVXUoQK48SlmVBsRwEwcn6RmQV
        6VE7CX9YZx7kUxndWEUmtWM8LiJnvTyF75X2A5ur3bys6FffQxfwyEWAK1j20AwBSLMh/L
        iaVCRAcCzlZHzReyFJEGO02BNyIAHkeW9H3NCbH8kqRo8gRLWYJHd+eZ2HpVtP3OsX9MBA
        JsyhSe50lA8rIfNxRmbA/lpN3cfqhNn3jCwNCkrdGtvKHYLY7G8lbil9BXYYiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YXNDukbn53Bfc/KJllLo5hFFxFmyIqh2K+vMNnq9Lvw=;
        b=J0xBYxQiDSXUa8S0E9Fm5YibJxw1Xdl6Deyd9+MqS3PB0sr8x8tH+cPj0ZOQzzoB+ch460
        IjOJjCcUuJYxQvAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/kprobes for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733667.10793.7109332068482192551.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/kprobes branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-12-14

up to:  a70a04b3844f: locking/atomics: Regenerate the atomics-check SHA1's


perf/kprobes updates:

 - Make kretprobes lockless to avoid the rp->lock performance and potential
   lock ordering issues.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      locking/atomics: Regenerate the atomics-check SHA1's

Peter Zijlstra (5):
      llist: Add nonatomic __llist_add() and __llist_dell_all()
      kprobes: Remove kretprobe hash
      asm-generic/atomic: Add try_cmpxchg() fallbacks
      freelist: Implement lockless freelist
      kprobes: Replace rp->free_instance with freelist


 arch/x86/include/asm/atomic.h             |   2 +-
 arch/x86/include/asm/atomic64_64.h        |   2 +-
 arch/x86/include/asm/cmpxchg.h            |   2 +-
 include/asm-generic/atomic-instrumented.h | 216 ++++++++++++--------
 include/linux/atomic-arch-fallback.h      |  90 ++++++++-
 include/linux/atomic-fallback.h           |  90 ++++++++-
 include/linux/freelist.h                  | 129 ++++++++++++
 include/linux/kprobes.h                   |  25 ++-
 include/linux/llist.h                     |  23 +++
 include/linux/sched.h                     |   4 +
 kernel/fork.c                             |   4 +
 kernel/kprobes.c                          | 314 +++++++++---------------------
 kernel/trace/trace_kprobe.c               |   3 +-
 scripts/atomic/gen-atomic-fallback.sh     |  63 +++++-
 scripts/atomic/gen-atomic-instrumented.sh |  29 ++-
 scripts/atomic/gen-atomics.sh             |   0
 16 files changed, 646 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/freelist.h
 mode change 100644 => 100755 scripts/atomic/gen-atomics.sh

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b6cac6e9bb70..f732741ad7c7 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -199,7 +199,7 @@ static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 809bd010a751..7886d0578fc9 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -187,7 +187,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a8bfac131256..4d4ec5cbdc51 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,7 +221,7 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
-#define try_cmpxchg(ptr, pold, new) 					\
+#define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
 /*
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index cd223b68b69d..888b6cfeed91 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1642,148 +1642,192 @@ atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #if !defined(arch_xchg_relaxed) || defined(arch_xchg)
-#define xchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg(__ai_ptr, __VA_ARGS__);				\
+#define xchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_acquire)
-#define xchg_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
+#define xchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_release)
-#define xchg_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
+#define xchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_relaxed)
-#define xchg_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define xchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
-#define cmpxchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_acquire)
-#define cmpxchg_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_release)
-#define cmpxchg_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_relaxed)
-#define cmpxchg_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
-#define cmpxchg64(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_acquire)
-#define cmpxchg64_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_release)
-#define cmpxchg64_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_relaxed)
-#define cmpxchg64_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
-#define cmpxchg_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
+#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
+#define try_cmpxchg(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_acquire)
+#define try_cmpxchg_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_release)
+#define try_cmpxchg_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_relaxed)
+#define try_cmpxchg_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#define cmpxchg_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
 
-#define cmpxchg64_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
-#define sync_cmpxchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
+#define sync_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
-#define cmpxchg_double(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
-	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_double(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
 
 
-#define cmpxchg_double_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
-	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_double_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 9d5e6a315fb1335d02f0ccd3655a91c3dafcc63e
+// 4bec382e44520f4d8267e42620054db26a659ea3
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
index bcb6aa27cfa6..a3dba31df01e 100644
--- a/include/linux/atomic-arch-fallback.h
+++ b/include/linux/atomic-arch-fallback.h
@@ -9,9 +9,9 @@
 #include <linux/compiler.h>
 
 #ifndef arch_xchg_relaxed
-#define arch_xchg_relaxed		arch_xchg
-#define arch_xchg_acquire		arch_xchg
-#define arch_xchg_release		arch_xchg
+#define arch_xchg_acquire arch_xchg
+#define arch_xchg_release arch_xchg
+#define arch_xchg_relaxed arch_xchg
 #else /* arch_xchg_relaxed */
 
 #ifndef arch_xchg_acquire
@@ -32,9 +32,9 @@
 #endif /* arch_xchg_relaxed */
 
 #ifndef arch_cmpxchg_relaxed
-#define arch_cmpxchg_relaxed		arch_cmpxchg
-#define arch_cmpxchg_acquire		arch_cmpxchg
-#define arch_cmpxchg_release		arch_cmpxchg
+#define arch_cmpxchg_acquire arch_cmpxchg
+#define arch_cmpxchg_release arch_cmpxchg
+#define arch_cmpxchg_relaxed arch_cmpxchg
 #else /* arch_cmpxchg_relaxed */
 
 #ifndef arch_cmpxchg_acquire
@@ -55,9 +55,9 @@
 #endif /* arch_cmpxchg_relaxed */
 
 #ifndef arch_cmpxchg64_relaxed
-#define arch_cmpxchg64_relaxed		arch_cmpxchg64
-#define arch_cmpxchg64_acquire		arch_cmpxchg64
-#define arch_cmpxchg64_release		arch_cmpxchg64
+#define arch_cmpxchg64_acquire arch_cmpxchg64
+#define arch_cmpxchg64_release arch_cmpxchg64
+#define arch_cmpxchg64_relaxed arch_cmpxchg64
 #else /* arch_cmpxchg64_relaxed */
 
 #ifndef arch_cmpxchg64_acquire
@@ -77,6 +77,76 @@
 
 #endif /* arch_cmpxchg64_relaxed */
 
+#ifndef arch_try_cmpxchg_relaxed
+#ifdef arch_try_cmpxchg
+#define arch_try_cmpxchg_acquire arch_try_cmpxchg
+#define arch_try_cmpxchg_release arch_try_cmpxchg
+#define arch_try_cmpxchg_relaxed arch_try_cmpxchg
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_acquire */
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_release */
+
+#ifndef arch_try_cmpxchg_relaxed
+#define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_relaxed */
+
+#else /* arch_try_cmpxchg_relaxed */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(...) \
+	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(...) \
+	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg_relaxed */
+
 #ifndef arch_atomic_read_acquire
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
@@ -2288,4 +2358,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 90cd26cfd69d2250303d654955a0cc12620fb91b
+// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index fd525c71d676..2a3f55d98be9 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -9,9 +9,9 @@
 #include <linux/compiler.h>
 
 #ifndef xchg_relaxed
-#define xchg_relaxed		xchg
-#define xchg_acquire		xchg
-#define xchg_release		xchg
+#define xchg_acquire xchg
+#define xchg_release xchg
+#define xchg_relaxed xchg
 #else /* xchg_relaxed */
 
 #ifndef xchg_acquire
@@ -32,9 +32,9 @@
 #endif /* xchg_relaxed */
 
 #ifndef cmpxchg_relaxed
-#define cmpxchg_relaxed		cmpxchg
-#define cmpxchg_acquire		cmpxchg
-#define cmpxchg_release		cmpxchg
+#define cmpxchg_acquire cmpxchg
+#define cmpxchg_release cmpxchg
+#define cmpxchg_relaxed cmpxchg
 #else /* cmpxchg_relaxed */
 
 #ifndef cmpxchg_acquire
@@ -55,9 +55,9 @@
 #endif /* cmpxchg_relaxed */
 
 #ifndef cmpxchg64_relaxed
-#define cmpxchg64_relaxed		cmpxchg64
-#define cmpxchg64_acquire		cmpxchg64
-#define cmpxchg64_release		cmpxchg64
+#define cmpxchg64_acquire cmpxchg64
+#define cmpxchg64_release cmpxchg64
+#define cmpxchg64_relaxed cmpxchg64
 #else /* cmpxchg64_relaxed */
 
 #ifndef cmpxchg64_acquire
@@ -77,6 +77,76 @@
 
 #endif /* cmpxchg64_relaxed */
 
+#ifndef try_cmpxchg_relaxed
+#ifdef try_cmpxchg
+#define try_cmpxchg_acquire try_cmpxchg
+#define try_cmpxchg_release try_cmpxchg
+#define try_cmpxchg_relaxed try_cmpxchg
+#endif /* try_cmpxchg */
+
+#ifndef try_cmpxchg
+#define try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg */
+
+#ifndef try_cmpxchg_acquire
+#define try_cmpxchg_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_acquire */
+
+#ifndef try_cmpxchg_release
+#define try_cmpxchg_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_release */
+
+#ifndef try_cmpxchg_relaxed
+#define try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_relaxed */
+
+#else /* try_cmpxchg_relaxed */
+
+#ifndef try_cmpxchg_acquire
+#define try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef try_cmpxchg_release
+#define try_cmpxchg_release(...) \
+	__atomic_op_release(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef try_cmpxchg
+#define try_cmpxchg(...) \
+	__atomic_op_fence(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* try_cmpxchg_relaxed */
+
 #define arch_atomic_read atomic_read
 #define arch_atomic_read_acquire atomic_read_acquire
 
@@ -2522,4 +2592,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 9d95b56f98d82a2a26c7b79ccdd0c47572d50a6f
+// d78e6c293c661c15188f0ec05bce45188c8d5892
diff --git a/include/linux/freelist.h b/include/linux/freelist.h
new file mode 100644
index 000000000000..fc1842b96469
--- /dev/null
+++ b/include/linux/freelist.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef FREELIST_H
+#define FREELIST_H
+
+#include <linux/atomic.h>
+
+/*
+ * Copyright: cameron@moodycamel.com
+ *
+ * A simple CAS-based lock-free free list. Not the fastest thing in the world
+ * under heavy contention, but simple and correct (assuming nodes are never
+ * freed until after the free list is destroyed), and fairly speedy under low
+ * contention.
+ *
+ * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ */
+
+struct freelist_node {
+	atomic_t		refs;
+	struct freelist_node	*next;
+};
+
+struct freelist_head {
+	struct freelist_node	*head;
+};
+
+#define REFS_ON_FREELIST 0x80000000
+#define REFS_MASK	 0x7FFFFFFF
+
+static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * Since the refcount is zero, and nobody can increase it once it's
+	 * zero (except us, and we run only one copy of this method per node at
+	 * a time, i.e. the single thread case), then we know we can safely
+	 * change the next pointer of the node; however, once the refcount is
+	 * back above zero, then other threads could increase it (happens under
+	 * heavy contention, when the refcount goes to zero in between a load
+	 * and a refcount increment of a node in try_get, then back up to
+	 * something non-zero, then the refcount increment is done by the other
+	 * thread) -- so if the CAS to add the node to the actual list fails,
+	 * decrese the refcount and leave the add operation to the next thread
+	 * who puts the refcount back to zero (which could be us, hence the
+	 * loop).
+	 */
+	struct freelist_node *head = READ_ONCE(list->head);
+
+	for (;;) {
+		WRITE_ONCE(node->next, head);
+		atomic_set_release(&node->refs, 1);
+
+		if (!try_cmpxchg_release(&list->head, &head, node)) {
+			/*
+			 * Hmm, the add failed, but we can only try again when
+			 * the refcount goes back to zero.
+			 */
+			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
+				continue;
+		}
+		return;
+	}
+}
+
+static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * We know that the should-be-on-freelist bit is 0 at this point, so
+	 * it's safe to set it using a fetch_add.
+	 */
+	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
+		/*
+		 * Oh look! We were the last ones referencing this node, and we
+		 * know we want to add it to the free list, so let's do it!
+		 */
+		__freelist_add(node, list);
+	}
+}
+
+static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
+{
+	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
+	unsigned int refs;
+
+	while (head) {
+		prev = head;
+		refs = atomic_read(&head->refs);
+		if ((refs & REFS_MASK) == 0 ||
+		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
+			head = smp_load_acquire(&list->head);
+			continue;
+		}
+
+		/*
+		 * Good, reference count has been incremented (it wasn't at
+		 * zero), which means we can read the next and not worry about
+		 * it changing between now and the time we do the CAS.
+		 */
+		next = READ_ONCE(head->next);
+		if (try_cmpxchg_acquire(&list->head, &head, next)) {
+			/*
+			 * Yay, got the node. This means it was on the list,
+			 * which means should-be-on-freelist must be false no
+			 * matter the refcount (because nobody else knows it's
+			 * been taken off yet, it can't have been put back on).
+			 */
+			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
+
+			/*
+			 * Decrease refcount twice, once for our ref, and once
+			 * for the list's ref.
+			 */
+			atomic_fetch_add(-2, &head->refs);
+
+			return head;
+		}
+
+		/*
+		 * OK, the head must have changed on us, but we still need to decrement
+		 * the refcount we increased.
+		 */
+		refs = atomic_fetch_add(-1, &prev->refs);
+		if (refs == REFS_ON_FREELIST + 1)
+			__freelist_add(prev, list);
+	}
+
+	return NULL;
+}
+
+#endif /* FREELIST_H */
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 629abaf25681..a79404433812 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,6 +27,8 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
+#include <linux/refcount.h>
+#include <linux/freelist.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -144,6 +146,11 @@ static inline int kprobe_ftrace(struct kprobe *p)
  * ignored, due to maxactive being too low.
  *
  */
+struct kretprobe_holder {
+	struct kretprobe	*rp;
+	refcount_t		ref;
+};
+
 struct kretprobe {
 	struct kprobe kp;
 	kretprobe_handler_t handler;
@@ -151,18 +158,18 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
-	raw_spinlock_t lock;
+	struct freelist_head freelist;
+	struct kretprobe_holder *rph;
 };
 
 struct kretprobe_instance {
 	union {
-		struct hlist_node hlist;
+		struct freelist_node freelist;
 		struct rcu_head rcu;
 	};
-	struct kretprobe *rp;
+	struct llist_node llist;
+	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
-	struct task_struct *task;
 	void *fp;
 	char data[];
 };
@@ -221,6 +228,14 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 	return ret;
 }
 
+static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+		"Kretprobe is accessed from instance under preemptive context");
+
+	return READ_ONCE(ri->rph->rp);
+}
+
 #else /* CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2e9c7215882b..24f207b0190b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -197,6 +197,16 @@ static inline struct llist_node *llist_next(struct llist_node *node)
 extern bool llist_add_batch(struct llist_node *new_first,
 			    struct llist_node *new_last,
 			    struct llist_head *head);
+
+static inline bool __llist_add_batch(struct llist_node *new_first,
+				     struct llist_node *new_last,
+				     struct llist_head *head)
+{
+	new_last->next = head->first;
+	head->first = new_first;
+	return new_last->next == NULL;
+}
+
 /**
  * llist_add - add a new entry
  * @new:	new entry to be added
@@ -209,6 +219,11 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
 	return llist_add_batch(new, new, head);
 }
 
+static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
+{
+	return __llist_add_batch(new, new, head);
+}
+
 /**
  * llist_del_all - delete all entries from lock-less list
  * @head:	the head of lock-less list to delete all entries
@@ -222,6 +237,14 @@ static inline struct llist_node *llist_del_all(struct llist_head *head)
 	return xchg(&head->first, NULL);
 }
 
+static inline struct llist_node *__llist_del_all(struct llist_head *head)
+{
+	struct llist_node *first = head->first;
+
+	head->first = NULL;
+	return first;
+}
+
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
 struct llist_node *llist_reverse_order(struct llist_node *head);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..393db0690101 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1326,6 +1326,10 @@ struct task_struct {
 	struct callback_head		mce_kill_me;
 #endif
 
+#ifdef CONFIG_KRETPROBES
+	struct llist_head               kretprobe_instances;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/fork.c b/kernel/fork.c
index 32083db7a2a2..b9c289d0f4ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2187,6 +2187,10 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 
+#ifdef CONFIG_KRETPROBES
+	p->kretprobe_instances.first = NULL;
+#endif
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted that the new process's css_set can be changed
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 41fdbb7953c6..f7fb5d135930 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -36,7 +36,6 @@
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
 #include <linux/perf_event.h>
-#include <linux/static_call.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -54,7 +53,6 @@ static int kprobes_initialized;
  * - RCU hlist traversal under disabling preempt (breakpoint handlers)
  */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
-static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
 /* NOTE: change this value only with kprobe_mutex held */
 static bool kprobes_all_disarmed;
@@ -62,9 +60,6 @@ static bool kprobes_all_disarmed;
 /* This protects kprobe_table and optimizing_list */
 static DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
-static struct {
-	raw_spinlock_t lock ____cacheline_aligned_in_smp;
-} kretprobe_table_locks[KPROBE_TABLE_SIZE];
 
 kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 					unsigned int __unused)
@@ -72,11 +67,6 @@ kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
 }
 
-static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
-{
-	return &(kretprobe_table_locks[hash].lock);
-}
-
 /* Blacklist -- list of struct kprobe_blacklist_entry */
 static LIST_HEAD(kprobe_blacklist);
 
@@ -1224,76 +1214,26 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
-static void recycle_rp_inst(struct kretprobe_instance *ri)
+static void free_rp_inst_rcu(struct rcu_head *head)
 {
-	struct kretprobe *rp = ri->rp;
+	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
 
-	/* remove rp inst off the rprobe_inst_table */
-	hlist_del(&ri->hlist);
-	INIT_HLIST_NODE(&ri->hlist);
-	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
-		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
-	} else
-		kfree_rcu(ri, rcu);
+	if (refcount_dec_and_test(&ri->rph->ref))
+		kfree(ri->rph);
+	kfree(ri);
 }
-NOKPROBE_SYMBOL(recycle_rp_inst);
-
-static void kretprobe_hash_lock(struct task_struct *tsk,
-			 struct hlist_head **head, unsigned long *flags)
-__acquires(hlist_lock)
-{
-	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
+NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
-	*head = &kretprobe_inst_table[hash];
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	/*
-	 * Nested is a workaround that will soon not be needed.
-	 * There's other protections that make sure the same lock
-	 * is not taken on the same CPU that lockdep is unaware of.
-	 * Differentiate when it is taken in NMI context.
-	 */
-	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
-}
-NOKPROBE_SYMBOL(kretprobe_hash_lock);
-
-static void kretprobe_table_lock(unsigned long hash,
-				 unsigned long *flags)
-__acquires(hlist_lock)
-{
-	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	/*
-	 * Nested is a workaround that will soon not be needed.
-	 * There's other protections that make sure the same lock
-	 * is not taken on the same CPU that lockdep is unaware of.
-	 * Differentiate when it is taken in NMI context.
-	 */
-	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
-}
-NOKPROBE_SYMBOL(kretprobe_table_lock);
-
-static void kretprobe_hash_unlock(struct task_struct *tsk,
-			   unsigned long *flags)
-__releases(hlist_lock)
+static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
-	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
-
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_hash_unlock);
+	struct kretprobe *rp = get_kretprobe(ri);
 
-static void kretprobe_table_unlock(unsigned long hash,
-				   unsigned long *flags)
-__releases(hlist_lock)
-{
-	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
+	if (likely(rp)) {
+		freelist_add(&ri->freelist, &rp->freelist);
+	} else
+		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
-NOKPROBE_SYMBOL(kretprobe_table_unlock);
+NOKPROBE_SYMBOL(recycle_rp_inst);
 
 static struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
@@ -1324,24 +1264,21 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head *head;
-	struct hlist_node *tmp;
-	unsigned long hash, flags = 0;
+	struct llist_node *node;
 
+	/* Early boot, not yet initialized. */
 	if (unlikely(!kprobes_initialized))
-		/* Early boot.  kretprobe_table_locks not yet initialized. */
 		return;
 
 	kprobe_busy_begin();
 
-	hash = hash_ptr(tk, KPROBE_HASH_BITS);
-	head = &kretprobe_inst_table[hash];
-	kretprobe_table_lock(hash, &flags);
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task == tk)
-			recycle_rp_inst(ri);
+	node = __llist_del_all(&tk->kretprobe_instances);
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		recycle_rp_inst(ri);
 	}
-	kretprobe_table_unlock(hash, &flags);
 
 	kprobe_busy_end();
 }
@@ -1350,37 +1287,23 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_node *next;
+	struct freelist_node *node;
+	int count = 0;
+
+	node = rp->freelist.head;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, freelist);
+		node = node->next;
 
-	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
-		hlist_del(&ri->hlist);
 		kfree(ri);
+		count++;
 	}
-}
-
-static void cleanup_rp_inst(struct kretprobe *rp)
-{
-	unsigned long flags, hash;
-	struct kretprobe_instance *ri;
-	struct hlist_node *next;
-	struct hlist_head *head;
 
-	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
-	kprobe_busy_begin();
-	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
-		kretprobe_table_lock(hash, &flags);
-		head = &kretprobe_inst_table[hash];
-		hlist_for_each_entry_safe(ri, next, head, hlist) {
-			if (ri->rp == rp)
-				ri->rp = NULL;
-		}
-		kretprobe_table_unlock(hash, &flags);
+	if (refcount_sub_and_test(count, &rp->rph->ref)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
 	}
-	kprobe_busy_end();
-
-	free_rp_inst(rp);
 }
-NOKPROBE_SYMBOL(cleanup_rp_inst);
 
 /* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
@@ -1643,7 +1566,6 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
-	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
@@ -1942,88 +1864,56 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *trampoline_address,
 					     void *frame_pointer)
 {
-	struct kretprobe_instance *ri = NULL, *last = NULL;
-	struct hlist_head *head;
-	struct hlist_node *tmp;
-	unsigned long flags;
 	kprobe_opcode_t *correct_ret_addr = NULL;
-	bool skipped = false;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node;
+	struct kretprobe *rp;
 
-	kretprobe_hash_lock(current, &head, &flags);
+	/* Find all nodes for this frame. */
+	first = node = current->kretprobe_instances.first;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
 
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * return probes installed on them, and/or more than one
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always pushed into the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *	 function, the (chronologically) first instance's ret_addr
-	 *	 will be the real return address, and all the rest will
-	 *	 point to kretprobe_trampoline.
-	 */
-	hlist_for_each_entry(ri, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		/*
-		 * Return probes must be pushed on this hash list correct
-		 * order (same as return order) so that it can be popped
-		 * correctly. However, if we find it is pushed it incorrect
-		 * order, this means we find a function which should not be
-		 * probed, because the wrong order entry is pushed on the
-		 * path of processing other kretprobe itself.
-		 */
-		if (ri->fp != frame_pointer) {
-			if (!skipped)
-				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
-			skipped = true;
-			continue;
-		}
+		BUG_ON(ri->fp != frame_pointer);
 
-		correct_ret_addr = ri->ret_addr;
-		if (skipped)
-			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
-				ri->rp->kp.addr);
-
-		if (correct_ret_addr != trampoline_address)
+		if (ri->ret_addr != trampoline_address) {
+			correct_ret_addr = ri->ret_addr;
 			/*
 			 * This is the real return address. Any other
 			 * instances associated with this task are for
 			 * other calls deeper on the call stack
 			 */
-			break;
+			goto found;
+		}
+
+		node = node->next;
 	}
+	pr_err("Oops! Kretprobe fails to find correct return address.\n");
+	BUG_ON(1);
 
-	BUG_ON(!correct_ret_addr || (correct_ret_addr == trampoline_address));
-	last = ri;
+found:
+	/* Unlink all nodes for this frame. */
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
 
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		if (ri->fp != frame_pointer)
-			continue;
+	/* Run them..  */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		first = first->next;
 
-		if (ri->rp && ri->rp->handler) {
+		rp = get_kretprobe(ri);
+		if (rp && rp->handler) {
 			struct kprobe *prev = kprobe_running();
 
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			__this_cpu_write(current_kprobe, &rp->kp);
 			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
+			rp->handler(ri, regs);
 			__this_cpu_write(current_kprobe, prev);
 		}
 
 		recycle_rp_inst(ri);
-
-		if (ri == last)
-			break;
 	}
 
-	kretprobe_hash_unlock(current, &flags);
-
 	return (unsigned long)correct_ret_addr;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
@@ -2035,44 +1925,26 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long hash, flags = 0;
 	struct kretprobe_instance *ri;
+	struct freelist_node *fn;
 
-	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	hash = hash_ptr(current, KPROBE_HASH_BITS);
-	/*
-	 * Nested is a workaround that will soon not be needed.
-	 * There's other protections that make sure the same lock
-	 * is not taken on the same CPU that lockdep is unaware of.
-	 */
-	raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
-	if (!hlist_empty(&rp->free_instances)) {
-		ri = hlist_entry(rp->free_instances.first,
-				struct kretprobe_instance, hlist);
-		hlist_del(&ri->hlist);
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-
-		ri->rp = rp;
-		ri->task = current;
-
-		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
-			hlist_add_head(&ri->hlist, &rp->free_instances);
-			raw_spin_unlock_irqrestore(&rp->lock, flags);
-			return 0;
-		}
+	fn = freelist_try_get(&rp->freelist);
+	if (!fn) {
+		rp->nmissed++;
+		return 0;
+	}
 
-		arch_prepare_kretprobe(ri, regs);
+	ri = container_of(fn, struct kretprobe_instance, freelist);
 
-		/* XXX(hch): why is there no hlist_move_head? */
-		INIT_HLIST_NODE(&ri->hlist);
-		kretprobe_table_lock(hash, &flags);
-		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
-		kretprobe_table_unlock(hash, &flags);
-	} else {
-		rp->nmissed++;
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
+	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+		freelist_add(&ri->freelist, &rp->freelist);
+		return 0;
 	}
+
+	arch_prepare_kretprobe(ri, regs);
+
+	__llist_add(&ri->llist, &current->kretprobe_instances);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
@@ -2129,18 +2001,24 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	raw_spin_lock_init(&rp->lock);
-	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->freelist.head = NULL;
+	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
+	if (!rp->rph)
+		return -ENOMEM;
+
+	rp->rph->rp = rp;
 	for (i = 0; i < rp->maxactive; i++) {
-		inst = kmalloc(sizeof(struct kretprobe_instance) +
+		inst = kzalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
 		if (inst == NULL) {
+			refcount_set(&rp->rph->ref, i);
 			free_rp_inst(rp);
 			return -ENOMEM;
 		}
-		INIT_HLIST_NODE(&inst->hlist);
-		hlist_add_head(&inst->hlist, &rp->free_instances);
+		inst->rph = rp->rph;
+		freelist_add(&inst->freelist, &rp->freelist);
 	}
+	refcount_set(&rp->rph->ref, i);
 
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
@@ -2182,16 +2060,18 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	if (num <= 0)
 		return;
 	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
+		rps[i]->rph->rp = NULL;
+	}
 	mutex_unlock(&kprobe_mutex);
 
 	synchronize_rcu();
 	for (i = 0; i < num; i++) {
 		if (rps[i]->kp.addr) {
 			__unregister_kprobe_bottom(&rps[i]->kp);
-			cleanup_rp_inst(rps[i]);
+			free_rp_inst(rps[i]);
 		}
 	}
 }
@@ -2235,9 +2115,6 @@ static void kill_kprobe(struct kprobe *p)
 
 	lockdep_assert_held(&kprobe_mutex);
 
-	if (WARN_ON_ONCE(kprobe_gone(p)))
-		return;
-
 	p->flags |= KPROBE_FLAG_GONE;
 	if (kprobe_aggrprobe(p)) {
 		/*
@@ -2518,10 +2395,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry(p, head, hlist) {
-			if (kprobe_gone(p))
-				continue;
-
+		hlist_for_each_entry(p, head, hlist)
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2538,7 +2412,6 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				 */
 				kill_kprobe(p);
 			}
-		}
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
@@ -2583,11 +2456,8 @@ static int __init init_kprobes(void)
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
-	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);
-		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
-		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
-	}
 
 	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
 					__stop_kprobe_blacklist);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b911e9f6d9f5..97c7a7782db7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1731,7 +1731,8 @@ NOKPROBE_SYMBOL(kprobe_dispatcher);
 static int
 kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
-	struct trace_kprobe *tk = container_of(ri->rp, struct trace_kprobe, rp);
+	struct kretprobe *rp = get_kretprobe(ri);
+	struct trace_kprobe *tk = container_of(rp, struct trace_kprobe, rp);
 
 	raw_cpu_inc(*tk->nhit);
 
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 693dfa1de430..317a6cec76e1 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -144,15 +144,11 @@ gen_proto_order_variants()
 	printf "#endif /* ${basename}_relaxed */\n\n"
 }
 
-gen_xchg_fallbacks()
+gen_order_fallbacks()
 {
 	local xchg="$1"; shift
+
 cat <<EOF
-#ifndef ${xchg}_relaxed
-#define ${xchg}_relaxed		${xchg}
-#define ${xchg}_acquire		${xchg}
-#define ${xchg}_release		${xchg}
-#else /* ${xchg}_relaxed */
 
 #ifndef ${xchg}_acquire
 #define ${xchg}_acquire(...) \\
@@ -169,11 +165,62 @@ cat <<EOF
 	__atomic_op_fence(${xchg}, __VA_ARGS__)
 #endif
 
-#endif /* ${xchg}_relaxed */
+EOF
+}
+
+gen_xchg_fallbacks()
+{
+	local xchg="$1"; shift
+	printf "#ifndef ${xchg}_relaxed\n"
+
+	gen_basic_fallbacks ${xchg}
+
+	printf "#else /* ${xchg}_relaxed */\n"
+
+	gen_order_fallbacks ${xchg}
+
+	printf "#endif /* ${xchg}_relaxed */\n\n"
+}
+
+gen_try_cmpxchg_fallback()
+{
+	local order="$1"; shift;
+
+cat <<EOF
+#ifndef ${ARCH}try_cmpxchg${order}
+#define ${ARCH}try_cmpxchg${order}(_ptr, _oldp, _new) \\
+({ \\
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
+	___r = ${ARCH}cmpxchg${order}((_ptr), ___o, (_new)); \\
+	if (unlikely(___r != ___o)) \\
+		*___op = ___r; \\
+	likely(___r == ___o); \\
+})
+#endif /* ${ARCH}try_cmpxchg${order} */
 
 EOF
 }
 
+gen_try_cmpxchg_fallbacks()
+{
+	printf "#ifndef ${ARCH}try_cmpxchg_relaxed\n"
+	printf "#ifdef ${ARCH}try_cmpxchg\n"
+
+	gen_basic_fallbacks "${ARCH}try_cmpxchg"
+
+	printf "#endif /* ${ARCH}try_cmpxchg */\n\n"
+
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_try_cmpxchg_fallback "${order}"
+	done
+
+	printf "#else /* ${ARCH}try_cmpxchg_relaxed */\n"
+
+	gen_order_fallbacks "${ARCH}try_cmpxchg"
+
+	printf "#endif /* ${ARCH}try_cmpxchg_relaxed */\n\n"
+}
+
 cat << EOF
 // SPDX-License-Identifier: GPL-2.0
 
@@ -191,6 +238,8 @@ for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
+gen_try_cmpxchg_fallbacks
+
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 2b7fec7e6abc..5766ffcec7c5 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -112,14 +112,31 @@ gen_xchg()
 	local xchg="$1"; shift
 	local mult="$1"; shift
 
+	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
+
+cat <<EOF
+#define ${xchg}(ptr, oldp, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	typeof(oldp) __ai_oldp = (oldp); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
+	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
+})
+EOF
+
+	else
+
 cat <<EOF
-#define ${xchg}(ptr, ...)						\\
-({									\\
-	typeof(ptr) __ai_ptr = (ptr);					\\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
-	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
+#define ${xchg}(ptr, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
+
+	fi
 }
 
 gen_optional_xchg()
@@ -169,7 +186,7 @@ grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_optional_xchg "${xchg}" "${order}"
 	done
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
old mode 100644
new mode 100755

