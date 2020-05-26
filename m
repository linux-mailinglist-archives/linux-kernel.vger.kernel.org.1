Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34C1AE33E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgDQRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:08:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21864 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgDQRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:08:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 493jH675J5z9tyx9;
        Fri, 17 Apr 2020 19:08:50 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pnn6XBFk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hjB6TXvp6GWJ; Fri, 17 Apr 2020 19:08:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 493jH65QVFz9tyx8;
        Fri, 17 Apr 2020 19:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587143330; bh=5M2bywUXx6YyPXRMVEzeVM0GYx81Gq7MyZArtdKg1lw=;
        h=From:Subject:To:Cc:Date:From;
        b=pnn6XBFkwHLnHA7pmhE4mQk/a9JkK6hjXaOmWdFLwf84oDVj0Rf3FikKJafjPJqOB
         Zykqgyea+rhJynyIbRSyn71VQB2oAcUWH+i4NWsF+TO7vZWgdWnZ/yDzumWyuLfer3
         o5GI2VqF2TcYZkA18X8T7CDcUyyk/0R9RGEacoto=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95F048BB98;
        Fri, 17 Apr 2020 19:08:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id emKREvMkFTdH; Fri, 17 Apr 2020 19:08:52 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36AC68B75E;
        Fri, 17 Apr 2020 19:08:52 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id EBCBE657A3; Fri, 17 Apr 2020 17:08:51 +0000 (UTC)
Message-Id: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 17 Apr 2020 17:08:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsafe_put_user() is designed to take benefit of 'asm goto'.

Instead of using the standard __put_user() approach and branch
based on the returned error, use 'asm goto' and make the
exception code branch directly to the error label. There is
no code anymore in the fixup section.

This change significantly simplifies functions using
unsafe_put_user()

Small exemple of the benefit with the following code:

struct test {
	u32 item1;
	u16 item2;
	u8 item3;
	u64 item4;
};

int set_test_to_user(struct test __user *test, u32 item1, u16 item2, u8 item3, u64 item4)
{
	unsafe_put_user(item1, &test->item1, failed);
	unsafe_put_user(item2, &test->item2, failed);
	unsafe_put_user(item3, &test->item3, failed);
	unsafe_put_user(item4, &test->item4, failed);
	return 0;
failed:
	return -EFAULT;
}

Before the patch:

00000be8 <set_test_to_user>:
 be8:	39 20 00 00 	li      r9,0
 bec:	90 83 00 00 	stw     r4,0(r3)
 bf0:	2f 89 00 00 	cmpwi   cr7,r9,0
 bf4:	40 9e 00 38 	bne     cr7,c2c <set_test_to_user+0x44>
 bf8:	b0 a3 00 04 	sth     r5,4(r3)
 bfc:	2f 89 00 00 	cmpwi   cr7,r9,0
 c00:	40 9e 00 2c 	bne     cr7,c2c <set_test_to_user+0x44>
 c04:	98 c3 00 06 	stb     r6,6(r3)
 c08:	2f 89 00 00 	cmpwi   cr7,r9,0
 c0c:	40 9e 00 20 	bne     cr7,c2c <set_test_to_user+0x44>
 c10:	90 e3 00 08 	stw     r7,8(r3)
 c14:	91 03 00 0c 	stw     r8,12(r3)
 c18:	21 29 00 00 	subfic  r9,r9,0
 c1c:	7d 29 49 10 	subfe   r9,r9,r9
 c20:	38 60 ff f2 	li      r3,-14
 c24:	7d 23 18 38 	and     r3,r9,r3
 c28:	4e 80 00 20 	blr
 c2c:	38 60 ff f2 	li      r3,-14
 c30:	4e 80 00 20 	blr

00000000 <.fixup>:
	...
  b8:	39 20 ff f2 	li      r9,-14
  bc:	48 00 00 00 	b       bc <.fixup+0xbc>
			bc: R_PPC_REL24	.text+0xbf0
  c0:	39 20 ff f2 	li      r9,-14
  c4:	48 00 00 00 	b       c4 <.fixup+0xc4>
			c4: R_PPC_REL24	.text+0xbfc
  c8:	39 20 ff f2 	li      r9,-14
  cc:	48 00 00 00 	b       cc <.fixup+0xcc>
			cc: R_PPC_REL24	.text+0xc08
  d0:	39 20 ff f2 	li      r9,-14
  d4:	48 00 00 00 	b       d4 <.fixup+0xd4>
			d4: R_PPC_REL24	.text+0xc18

00000000 <__ex_table>:
	...
			a0: R_PPC_REL32	.text+0xbec
			a4: R_PPC_REL32	.fixup+0xb8
			a8: R_PPC_REL32	.text+0xbf8
			ac: R_PPC_REL32	.fixup+0xc0
			b0: R_PPC_REL32	.text+0xc04
			b4: R_PPC_REL32	.fixup+0xc8
			b8: R_PPC_REL32	.text+0xc10
			bc: R_PPC_REL32	.fixup+0xd0
			c0: R_PPC_REL32	.text+0xc14
			c4: R_PPC_REL32	.fixup+0xd0

After the patch:

00000be8 <set_test_to_user>:
 be8:	90 83 00 00 	stw     r4,0(r3)
 bec:	b0 a3 00 04 	sth     r5,4(r3)
 bf0:	98 c3 00 06 	stb     r6,6(r3)
 bf4:	90 e3 00 08 	stw     r7,8(r3)
 bf8:	91 03 00 0c 	stw     r8,12(r3)
 bfc:	38 60 00 00 	li      r3,0
 c00:	4e 80 00 20 	blr
 c04:	38 60 ff f2 	li      r3,-14
 c08:	4e 80 00 20 	blr

00000000 <__ex_table>:
	...
			a0: R_PPC_REL32	.text+0xbe8
			a4: R_PPC_REL32	.text+0xc04
			a8: R_PPC_REL32	.text+0xbec
			ac: R_PPC_REL32	.text+0xc04
			b0: R_PPC_REL32	.text+0xbf0
			b4: R_PPC_REL32	.text+0xc04
			b8: R_PPC_REL32	.text+0xbf4
			bc: R_PPC_REL32	.text+0xc04
			c0: R_PPC_REL32	.text+0xbf8
			c4: R_PPC_REL32	.text+0xc04

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
---
v4:
- no change

v3:
- Added <> modifier to __put_user_asm_goto()
- Removed %U1 modifier to __put_user_asm2_goto()

v2:
- Grouped most __goto() macros together
- Removed stuff in .fixup section, referencing the error label
directly from the extable
- Using more flexible addressing in asm.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/uaccess.h | 61 +++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 9cc9c106ae2a..9365b59495a2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -93,12 +93,12 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 #define __get_user(x, ptr) \
 	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)
 #define __put_user(x, ptr) \
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), true)
+	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
+#define __put_user_goto(x, ptr, label) \
+	__put_user_nocheck_goto((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
 
 #define __get_user_allowed(x, ptr) \
 	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
-#define __put_user_allowed(x, ptr) \
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), false)
 
 #define __get_user_inatomic(x, ptr) \
 	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
@@ -162,17 +162,14 @@ do {								\
 	prevent_write_to_user(ptr, size);			\
 } while (0)
 
-#define __put_user_nocheck(x, ptr, size, do_allow)			\
+#define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
 	if (!is_kernel_addr((unsigned long)__pu_addr))		\
 		might_fault();					\
 	__chk_user_ptr(ptr);					\
-	if (do_allow)								\
-		__put_user_size((x), __pu_addr, (size), __pu_err);		\
-	else									\
-		__put_user_size_allowed((x), __pu_addr, (size), __pu_err);	\
+	__put_user_size((x), __pu_addr, (size), __pu_err);		\
 	__pu_err;						\
 })
 
@@ -196,6 +193,52 @@ do {								\
 })
 
 
+#define __put_user_asm_goto(x, addr, label, op)			\
+	asm volatile goto(					\
+		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
+		EX_TABLE(1b, %l2)				\
+		:						\
+		: "r" (x), "m<>" (*addr)				\
+		:						\
+		: label)
+
+#ifdef __powerpc64__
+#define __put_user_asm2_goto(x, ptr, label)			\
+	__put_user_asm_goto(x, ptr, label, "std")
+#else /* __powerpc64__ */
+#define __put_user_asm2_goto(x, addr, label)			\
+	asm volatile goto(					\
+		"1:	stw%X1 %0, %1\n"			\
+		"2:	stw%X1 %L0, %L1\n"			\
+		EX_TABLE(1b, %l2)				\
+		EX_TABLE(2b, %l2)				\
+		:						\
+		: "r" (x), "m" (*addr)				\
+		:						\
+		: label)
+#endif /* __powerpc64__ */
+
+#define __put_user_size_goto(x, ptr, size, label)		\
+do {								\
+	switch (size) {						\
+	case 1: __put_user_asm_goto(x, ptr, label, "stb"); break;	\
+	case 2: __put_user_asm_goto(x, ptr, label, "sth"); break;	\
+	case 4: __put_user_asm_goto(x, ptr, label, "stw"); break;	\
+	case 8: __put_user_asm2_goto(x, ptr, label); break;	\
+	default: __put_user_bad();				\
+	}							\
+} while (0)
+
+#define __put_user_nocheck_goto(x, ptr, size, label)		\
+do {								\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
+	if (!is_kernel_addr((unsigned long)__pu_addr))		\
+		might_fault();					\
+	__chk_user_ptr(ptr);					\
+	__put_user_size_goto((x), __pu_addr, (size), label);	\
+} while (0)
+
+
 extern long __get_user_bad(void);
 
 /*
@@ -470,7 +513,7 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
-#define unsafe_put_user(x, p, e) unsafe_op_wrap(__put_user_allowed(x, p), e)
+#define unsafe_put_user(x, p, e) __put_user_goto(x, p, e)
 #define unsafe_copy_to_user(d, s, l, e) \
 	unsafe_op_wrap(raw_copy_to_user_allowed(d, s, l), e)
 
-- 
2.25.0

