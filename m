Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012DA264B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIJRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 13:37:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbgIJRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599758626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVXqSXYfkUGynjiJBHvORhMYFsD9wMhL5oycPk7Ji+k=;
        b=bZWNBuQq30SHSWfPa3YYgAkwpeIMETMhaCTt9DbCTKM1ADHwwWp25jJLx7E32HwWT7RruN
        l2OMf3hPtSwp6BnXElYFiS35Cv9U5gUAfuGx8kTHEjkd30aISv4AMHXQky2v9Z+glgeqNc
        oCKcwoQ60tAUuyPvkUX0RTACdbJ9Eh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-wcJJUBfoMIub_yxSMWr0dQ-1; Thu, 10 Sep 2020 13:23:41 -0400
X-MC-Unique: wcJJUBfoMIub_yxSMWr0dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A1118B9F41;
        Thu, 10 Sep 2020 17:23:39 +0000 (UTC)
Received: from treble.redhat.com (ovpn-119-118.rdu2.redhat.com [10.10.119.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F53A60C05;
        Thu, 10 Sep 2020 17:23:32 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess speculation
Date:   Thu, 10 Sep 2020 12:22:53 -0500
Message-Id: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 uaccess code uses barrier_nospec() in various places to prevent
speculative dereferencing of user-controlled pointers (which might be
combined with further gadgets or CPU bugs to leak data).

There are some issues with the current implementation:

- The barrier_nospec() in copy_from_user() was inadvertently removed
  with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
  raw_copy_{to,from}_user()")

- copy_to_user() and friends should also have a speculation barrier,
  because a speculative write to a user-controlled address can still
  populate the cache line with the original data.

- The LFENCE in barrier_nospec() is overkill, when more lightweight user
  pointer masking can be used instead.

Remove all existing barrier_nospec() usage, and instead do user pointer
masking, throughout the x86 uaccess code.  This is similar to what arm64
is already doing with uaccess_mask_ptr().

barrier_nospec() is now unused, and can be removed.

Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v3:

- Rebased on vfs#for-next, using TASK_SIZE_MAX now that set_fs() is
  gone.  I considered just clearing the most significant bit, but that
  only works for 64-bit, so in the interest of common code I went with
  the more straightforward enforcement of the TASK_SIZE_MAX limit.

- Rename the macro to force_user_ptr(), which is more descriptive, and
  also more distinguishable from a planned future macro for sanitizing
  __user pointers on syscall entry.

 Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
 arch/x86/include/asm/barrier.h                |  3 --
 arch/x86/include/asm/checksum_32.h            |  6 ++--
 arch/x86/include/asm/futex.h                  |  5 +++
 arch/x86/include/asm/uaccess.h                | 35 ++++++++++++-------
 arch/x86/include/asm/uaccess_64.h             | 16 ++++-----
 arch/x86/lib/csum-wrappers_64.c               |  5 +--
 arch/x86/lib/getuser.S                        | 10 +++---
 arch/x86/lib/putuser.S                        |  8 +++++
 arch/x86/lib/usercopy_32.c                    |  6 ++--
 arch/x86/lib/usercopy_64.c                    |  7 ++--
 lib/iov_iter.c                                |  2 +-
 12 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..27a8adedd2b8 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -426,9 +426,9 @@ Spectre variant 1
    <spec_ref2>` to avoid any usable disclosure gadgets. However, it may
    not cover all attack vectors for Spectre variant 1.
 
-   Copy-from-user code has an LFENCE barrier to prevent the access_ok()
-   check from being mis-speculated.  The barrier is done by the
-   barrier_nospec() macro.
+   Usercopy code uses user pointer masking to prevent the access_ok()
+   check from being mis-speculated in the success path with a kernel
+   address.  The masking is done by the force_user_ptr() macro.
 
    For the swapgs variant of Spectre variant 1, LFENCE barriers are
    added to interrupt, exception and NMI entry where needed.  These
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7f828fe49797..d158ea1fa250 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,9 +48,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
-/* Prevent speculative execution past this barrier. */
-#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
-
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
 
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 17da95387997..c7ebc40c6fb9 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -49,7 +49,8 @@ static inline __wsum csum_and_copy_from_user(const void __user *src,
 	might_sleep();
 	if (!user_access_begin(src, len))
 		return 0;
-	ret = csum_partial_copy_generic((__force void *)src, dst, len);
+	ret = csum_partial_copy_generic((__force void *)force_user_ptr(src),
+					dst, len);
 	user_access_end();
 
 	return ret;
@@ -177,8 +178,7 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 	might_sleep();
 	if (!user_access_begin(dst, len))
 		return 0;
-
-	ret = csum_partial_copy_generic(src, (__force void *)dst, len);
+	ret = csum_partial_copy_generic(src, (__force void *)force_user_ptr(dst), len);
 	user_access_end();
 	return ret;
 }
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index f9c00110a69a..0cecdaa362b1 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -59,6 +59,8 @@ static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *o
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	uaddr = force_user_ptr(uaddr);
+
 	switch (op) {
 	case FUTEX_OP_SET:
 		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
@@ -94,6 +96,9 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
+
+	uaddr = force_user_ptr(uaddr);
+
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
 		"2:\n"
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index a4ceda0510ea..d35f6dc22341 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -6,6 +6,7 @@
  */
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
+#include <linux/nospec.h>
 #include <linux/string.h>
 #include <asm/asm.h>
 #include <asm/page.h>
@@ -66,12 +67,23 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
 })
 
+/*
+ * Sanitize a user pointer such that it becomes NULL if it's not a valid user
+ * pointer.  This prevents speculative dereferences of user-controlled pointers
+ * to kernel space when access_ok() speculatively returns true.  This should be
+ * done *after* access_ok(), to avoid affecting error handling behavior.
+ */
+#define force_user_ptr(ptr)						\
+	(typeof(ptr)) array_index_nospec((__force unsigned long)ptr,	\
+					 TASK_SIZE_MAX)
+
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
@@ -95,11 +107,6 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
-#define __uaccess_begin_nospec()	\
-({					\
-	stac();				\
-	barrier_nospec();		\
-})
 
 /*
  * This is the smallest unsigned integer type that can fit a value
@@ -333,7 +340,7 @@ do {									\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) __pu_val = (x);			\
-	__typeof__(ptr) __pu_ptr = (ptr);			\
+	__typeof__(ptr) __pu_ptr = force_user_ptr(ptr);	\
 	__typeof__(size) __pu_size = (size);			\
 	__uaccess_begin();					\
 	__put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);	\
@@ -347,9 +354,9 @@ __pu_label:							\
 ({									\
 	int __gu_err;							\
 	__inttype(*(ptr)) __gu_val;					\
-	__typeof__(ptr) __gu_ptr = (ptr);				\
+	__typeof__(ptr) __gu_ptr = force_user_ptr(ptr);		\
 	__typeof__(size) __gu_size = (size);				\
-	__uaccess_begin_nospec();					\
+	__uaccess_begin();						\
 	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err);	\
 	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
@@ -458,7 +465,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 	return 1;
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
@@ -467,14 +474,16 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
 
-#define unsafe_put_user(x, ptr, label)	\
-	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
+#define unsafe_put_user(x, ptr, label)						\
+	__put_user_size((__typeof__(*(ptr)))(x), force_user_ptr(ptr),		\
+			sizeof(*(ptr)), label)
 
 #define unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	int __gu_err;								\
 	__inttype(*(ptr)) __gu_val;						\
-	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err);		\
+	__get_user_size(__gu_val, force_user_ptr(ptr), sizeof(*(ptr)),	\
+			__gu_err);						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	if (unlikely(__gu_err)) goto err_label;					\
 } while (0)
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index bc10e3dc64fe..84c3a7fd1e9f 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -47,7 +47,7 @@ copy_user_generic(void *to, const void *from, unsigned len)
 }
 
 static __always_inline __must_check unsigned long
-copy_to_user_mcsafe(void *to, const void *from, unsigned len)
+copy_to_user_mcsafe(void __user *to, const void *from, size_t len)
 {
 	unsigned long ret;
 
@@ -57,7 +57,7 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
 	 * handle exceptions / faults.  memcpy_mcsafe() may fall back to
 	 * memcpy() which lacks this handling.
 	 */
-	ret = __memcpy_mcsafe(to, from, len);
+	ret = __memcpy_mcsafe((__force void *)force_user_ptr(to), from, len);
 	__uaccess_end();
 	return ret;
 }
@@ -65,20 +65,20 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
-	return copy_user_generic(dst, (__force void *)src, size);
+	return copy_user_generic(dst, (__force void *)force_user_ptr(src), size);
 }
 
 static __always_inline __must_check unsigned long
 raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 {
-	return copy_user_generic((__force void *)dst, src, size);
+	return copy_user_generic((__force void *)force_user_ptr(dst), src, size);
 }
 
 static __always_inline __must_check
 unsigned long raw_copy_in_user(void __user *dst, const void __user *src, unsigned long size)
 {
-	return copy_user_generic((__force void *)dst,
-				 (__force void *)src, size);
+	return copy_user_generic((__force void *)force_user_ptr(dst),
+				 (__force void *)force_user_ptr(src), size);
 }
 
 extern long __copy_user_nocache(void *dst, const void __user *src,
@@ -93,14 +93,14 @@ __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
 				  unsigned size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_nocache(dst, src, size, 0);
+	return __copy_user_nocache(dst, force_user_ptr(src), size, 0);
 }
 
 static inline int
 __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return __copy_user_flushcache(dst, force_user_ptr(src), size);
 }
 
 unsigned long
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 189344924a2b..8872f2233491 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -28,7 +28,8 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	might_sleep();
 	if (!user_access_begin(src, len))
 		return 0;
-	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
+	sum = csum_partial_copy_generic((__force const void *)force_user_ptr(src),
+					dst, len);
 	user_access_end();
 	return sum;
 }
@@ -53,7 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
 	might_sleep();
 	if (!user_access_begin(dst, len))
 		return 0;
-	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
+	sum = csum_partial_copy_generic(src, (void __force *)force_user_ptr(dst), len);
 	user_access_end();
 	return sum;
 }
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 2f052bc96866..5a95ed6a0a36 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -49,7 +49,7 @@ SYM_FUNC_START(__get_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* force_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
@@ -63,7 +63,7 @@ SYM_FUNC_START(__get_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* force_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl (%_ASM_AX),%edx
@@ -77,7 +77,7 @@ SYM_FUNC_START(__get_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* force_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl (%_ASM_AX),%edx
@@ -92,7 +92,7 @@ SYM_FUNC_START(__get_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* force_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq (%_ASM_AX),%rdx
@@ -103,7 +103,7 @@ SYM_FUNC_START(__get_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user_8
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	sbb %_ASM_DX, %_ASM_DX		/* force_user_ptr() */
 	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl (%_ASM_AX),%edx
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 358239d77dff..3db4e263fcfb 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -45,6 +45,8 @@ SYM_FUNC_START(__put_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* force_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %eax,%eax
@@ -57,6 +59,8 @@ SYM_FUNC_START(__put_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* force_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %eax,%eax
@@ -69,6 +73,8 @@ SYM_FUNC_START(__put_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* force_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %eax,%eax
@@ -81,6 +87,8 @@ SYM_FUNC_START(__put_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
+	sbb %_ASM_BX, %_ASM_BX		/* force_user_ptr() */
+	and %_ASM_BX, %_ASM_CX
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 7d290777246d..1ac802c9e685 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -68,7 +68,7 @@ clear_user(void __user *to, unsigned long n)
 {
 	might_fault();
 	if (access_ok(to, n))
-		__do_clear_user(to, n);
+		__do_clear_user(force_user_ptr(to), n);
 	return n;
 }
 EXPORT_SYMBOL(clear_user);
@@ -331,7 +331,7 @@ do {									\
 
 unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 {
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(__copy_user_ll);
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin_nospec();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index b0dfac3d3df7..bb6d0681e60f 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -42,7 +42,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		_ASM_EXTABLE_UA(0b, 3b)
 		_ASM_EXTABLE_UA(1b, 2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
+		: [size1] "r"(size & 7), "[size8]" (size / 8),
+		  "[dst]" (force_user_ptr(addr)));
 	clac();
 	return size;
 }
@@ -51,7 +52,7 @@ EXPORT_SYMBOL(__clear_user);
 unsigned long clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(to, n))
-		return __clear_user(to, n);
+		return __clear_user(force_user_ptr(to), n);
 	return n;
 }
 EXPORT_SYMBOL(clear_user);
@@ -108,7 +109,7 @@ EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
 {
 	unsigned long flushed, dest = (unsigned long) dst;
-	long rc = __copy_user_nocache(dst, src, size, 0);
+	long rc = __copy_user_nocache(dst, force_user_ptr(src), size, 0);
 
 	/*
 	 * __copy_user_nocache() uses non-temporal stores for the bulk
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ccb247faf79b..ca416e1a489f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -642,7 +642,7 @@ static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
-		n = copy_to_user_mcsafe((__force void *) to, from, n);
+		n = copy_to_user_mcsafe(to, from, n);
 	}
 	return n;
 }
-- 
2.25.4

