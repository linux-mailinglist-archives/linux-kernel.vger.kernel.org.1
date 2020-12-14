Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB32D9EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440737AbgLNSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:12:41 -0500
Received: from 108.78.124.78.rev.sfr.net ([78.124.78.108]:38296 "EHLO
        legeek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439865AbgLNSMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:12:09 -0500
X-Greylist: delayed 1009 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 13:12:08 EST
From:   sylvain.bertrand@legeek.net
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] unlock patched C gccs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mutt-Fcc: =mail
message-id: <48937guecrhuc8g89g8gqjk89jqkgrcg98g@freedom>
Date:   Mon, 14 Dec 2020 17:51:36 +0000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylvain BERTRAND <sylvain.bertrand@legeek.net>

unlock the usage of patched gccs with proper warnings and fix the
blocking usage of c11 _Generic by using builtins available on
much more C and CXX gccs

Signed-off-by: Sylvain BERTRAND <sylvain.bertrand@legeek.net>
---
 tested on mainline 2c85ebc57b3e1817b6ce1a6b703928e113a90442 building
    a running kernel.
 include/linux/compiler-gcc.h: unlock blocking macros with warnings.
 include/linux/compiler_types.h: use a __generic() wrapper macro
    with common builtins instead of c11 _Generic. 
 include/linux/seqlock.h use the: __generic() macro instead of c11
    _Generic.
 Makefile: benign blocking gcc option.

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -10,9 +10,30 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
+#if GCC_VERSION < 40800
+#define GCC_C
+/* comment out/patch out to acknowledge the following warning message */
+# warning you need to patch gcc:
+# warning "gcc 4.7.x would need:"
+# warning "https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145"
+# warning "https://gcc.gnu.org/legacy-ml/gcc-patches/2012-04/msg00452.html"
+#elif GCC_VERSION < 40900
 /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
-#if GCC_VERSION < 40900
-# error Sorry, your version of GCC is too old - please use 4.9 or newer.
+# error Sorry, your version of GCC misses some bug fixes and features - please use 4.9 or patch your GCC.
+#else
+#define GCC_CXX
+#endif
+
+/* help prevent planned obsolescence due to the use of recent c11 _Generic */
+#if GCC_VERSION >= 40900
+#define __generic(expr, t, yes, no)                                     \
+        _Generic(expr, t: yes, default: no)
+#elif GCC_VERSION >= 30100
+#define __generic(expr, t, yes, no)                                     \
+        __builtin_choose_expr(                                          \
+            __builtin_types_compatible_p(__typeof(expr), t), yes, no)
+#else
+# error your gcc compiler cannot support the __generic macro
 #endif
 
 /*
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -254,23 +254,19 @@
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
-/*
- * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
- * is not type-compatible with 'signed char', and we define a separate case.
- */
-#define __scalar_type_to_expr_cases(type)				\
-		unsigned type:	(unsigned type)0,			\
-		signed type:	(signed type)0
-
 #define __unqual_scalar_typeof(x) typeof(				\
-		_Generic((x),						\
-			 char:	(char)0,				\
-			 __scalar_type_to_expr_cases(char),		\
-			 __scalar_type_to_expr_cases(short),		\
-			 __scalar_type_to_expr_cases(int),		\
-			 __scalar_type_to_expr_cases(long),		\
-			 __scalar_type_to_expr_cases(long long),	\
-			 default: (x)))
+	__generic((x), char, (char)0,					\
+	__generic((x), unsigned char, (unsigned char)0,			\
+	__generic((x), signed char, (unsigned char)0,			\
+	__generic((x), unsigned short, (unsigned short)0,		\
+	__generic((x), signed short, (signed short)0,			\
+	__generic((x), unsigned int, (unsigned int)0,			\
+	__generic((x), signed int, (signed int)0,			\
+	__generic((x), unsigned long, (unsigned long)0,			\
+	__generic((x), signed long, (signed long)0,			\
+	__generic((x), unsigned long long, (unsigned long long)0,	\
+	__generic((x), signed long long, (signed long long)0,		\
+	(x)))))))))))))
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -296,17 +296,20 @@
 #define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
-#define __seqprop_case(s, lockname, prop)				\
-	seqcount_##lockname##_t: __seqprop_##lockname##_##prop((void *)(s))
-
-#define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqprop_##prop((void *)(s)),		\
-	__seqprop_case((s),	raw_spinlock,	prop),			\
-	__seqprop_case((s),	spinlock,	prop),			\
-	__seqprop_case((s),	rwlock,		prop),			\
-	__seqprop_case((s),	mutex,		prop),			\
-	__seqprop_case((s),	ww_mutex,	prop))
-
+#define __seqprop(s, prop) 						\
+	__generic(*(s), seqcount_t, __seqprop_##prop((void *)(s)),	\
+	__generic(*(s), seqcount_raw_spinlock_t,			\
+			__seqprop_raw_spinlock_##prop((void *)(s)),	\
+	__generic(*(s), seqcount_spinlock_t,				\
+			__seqprop_spinlock_##prop((void *)(s)),		\
+	__generic(*(s), seqcount_rwlock_t,				\
+			__seqprop_rwlock_##prop((void *)(s)),		\
+	__generic(*(s), seqcount_mutex_t,				\
+			__seqprop_mutex_##prop((void *)(s)),		\
+	__generic(*(s), seqcount_ww_mutex_t,				\
+			__seqprop_ww_mutex_##prop((void *)(s)),		\
+	panic("seqlock:__seqprop:unsupported type")))))))
+	
 #define __seqcount_ptr(s)		__seqprop(s, ptr)
 #define __seqcount_sequence(s)		__seqprop(s, sequence)
 #define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
--- a/Makefile
+++ b/Makefile
@@ -936,9 +936,6 @@
 # conserve stack if available
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
-# Prohibit date/time macros, which would make the build non-deterministic
-KBUILD_CFLAGS   += -Werror=date-time
-
 # enforce correct pointer usage
 KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 

