Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E226B7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIPA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:27:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbgIOOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B92AE14211608C44A87;
        Tue, 15 Sep 2020 21:19:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 21:19:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
Date:   Tue, 15 Sep 2020 21:16:15 +0800
Message-ID: <20200915131615.3138-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200915131615.3138-1-thunder.leizhen@huawei.com>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only support the kernels where the base of physical memory is
at a 16MiB boundary. Because the add/sub instructions only contains 8bits
unrotated value. But we can use one more "add/sub" instructions to handle
bits 23-16. The performance will be slightly affected.

Since most boards meet 16 MiB alignment, so add a new configuration
option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
anyone really needs it.

All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
the whole head.S file. So choose it.

Because the calculation of "y = x + __pv_offset[63:24]" have been done,
so we only need to calculate "y = y + __pv_offset[23:16]", that's why
the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
(above y).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/Kconfig              | 18 +++++++++++++++++-
 arch/arm/include/asm/memory.h | 16 +++++++++++++---
 arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658765..19fc2c746e2ce29 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
 	  kernel in system memory.
 
 	  This can only be used with non-XIP MMU kernels where the base
-	  of physical memory is at a 16MB boundary.
+	  of physical memory is at a 16MiB boundary.
 
 	  Only disable this option if you know that you do not require
 	  this feature (eg, building a kernel for a single machine) and
 	  you need to shrink the kernel to the minimal size.
 
+config ARM_PATCH_PHYS_VIRT_RADICAL
+	bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
+	default n
+	depends on ARM_PATCH_PHYS_VIRT
+	depends on !THUMB2_KERNEL
+	help
+	  This can only be used with non-XIP MMU kernels where the base
+	  of physical memory is at a 64KiB boundary.
+
+	  Compared with ARM_PATCH_PHYS_VIRT, one or two more instructions
+	  need to be added to implement the conversion of bits 23-16 of
+	  the VA/PA in phys-to-virt and virt-to-phys. The performance is
+	  slightly affected.
+
+	  If unsure say N here.
+
 config NEED_MACH_IO_H
 	bool
 	help
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 99035b5891ef442..71b3a60eeb1b1c6 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -173,6 +173,7 @@
  * so that all we need to do is modify the 8-bit constant field.
  */
 #define __PV_BITS_31_24	0x81000000
+#define __PV_BITS_23_16	0x00810000
 #define __PV_BITS_7_0	0x81
 
 extern unsigned long __pv_phys_pfn_offset;
@@ -201,7 +202,7 @@
 	: "=r" (t)					\
 	: "I" (__PV_BITS_7_0))
 
-#define __pv_add_carry_stub(x, y)			\
+#define __pv_add_carry_stub(x, y, type)			\
 	__asm__ volatile("@ __pv_add_carry_stub\n"	\
 	"1:	adds	%Q0, %1, %2\n"			\
 	"	adc	%R0, %R0, #0\n"			\
@@ -209,7 +210,7 @@
 	"	.long	1b\n"				\
 	"	.popsection\n"				\
 	: "+r" (y)					\
-	: "r" (x), "I" (__PV_BITS_31_24)		\
+	: "r" (x), "I" (type)				\
 	: "cc")
 
 static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
@@ -218,9 +219,15 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 
 	if (sizeof(phys_addr_t) == 4) {
 		__pv_stub(x, t, "add", __PV_BITS_31_24);
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
+		__pv_stub(t, t, "add", __PV_BITS_23_16);
+#endif
 	} else {
 		__pv_stub_mov_hi(t);
-		__pv_add_carry_stub(x, t);
+		__pv_add_carry_stub(x, t, __PV_BITS_31_24);
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
+		__pv_add_carry_stub(t, t, __PV_BITS_23_16);
+#endif
 	}
 	return t;
 }
@@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	 * in place where 'r' 32 bit operand is expected.
 	 */
 	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
+	__pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
+#endif
 	return t;
 }
 
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 02d78c9198d0e8d..d9fb226a24d43ae 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -120,7 +120,7 @@ ENTRY(stext)
 	bl	__fixup_smp
 #endif
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
-	bl	__fixup_pv_table
+	bl	__fixup_pv_table		@r11 will be used
 #endif
 	bl	__create_page_tables
 
@@ -614,8 +614,13 @@ __fixup_pv_table:
 	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
 	str	r0, [r6]	@ save computed PHYS_PFN_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
+	mov	r6, r3, lsr #16	@ constant for add/sub instructions
+	teq	r3, r6, lsl #16 @ must be 64KiB aligned
+#else
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+#endif
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
 	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
@@ -636,7 +641,9 @@ __fixup_a_pv_table:
 	add	r6, r6, r3
 	ldr	r0, [r6, #HIGH_OFFSET]	@ __pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ __pv_offset low word
-	mov	r6, r6, lsr #24
+	mov	r11, r6, lsl #8
+	mov	r11, r11, lsr #24	@ bits 23-16
+	mov	r6, r6, lsr #24		@ bits 31-24
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
 	moveq	r0, #0x200000	@ set bit 21, mov to mvn instruction
@@ -682,14 +689,20 @@ ARM_BE8(rev16	ip, ip)
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	@ in BE8, we load data in BE, but instructions still in LE
 	bic	ip, ip, #0xff000000
-	tst	ip, #0x000f0000	@ check the rotation field
+	tst	ip, #0x00040000	@ check the rotation field
 	orrne	ip, ip, r6, lsl #24 @ mask in offset bits 31-24
+	tst	ip, #0x00080000	@ check the rotation field
+	orrne	ip, ip, r11, lsl #24 @ mask in offset bits 23-16
+	tst	ip, #0x000f0000	@ check the rotation field
 	biceq	ip, ip, #0x00004000 @ clear bit 22
 	orreq	ip, ip, r0      @ mask in offset bits 7-0
 #else
 	bic	ip, ip, #0x000000ff
-	tst	ip, #0xf00	@ check the rotation field
+	tst	ip, #0x400	@ check the rotation field
 	orrne	ip, ip, r6	@ mask in offset bits 31-24
+	tst	ip, #0x800	@ check the rotation field
+	orrne	ip, ip, r11	@ mask in offset bits 23-16
+	tst	ip, #0xf00	@ check the rotation field
 	biceq	ip, ip, #0x400000	@ clear bit 22
 	orreq	ip, ip, r0	@ mask in offset bits 7-0
 #endif
@@ -705,12 +718,12 @@ ENDPROC(__fixup_a_pv_table)
 3:	.long __pv_offset
 
 ENTRY(fixup_pv_table)
-	stmfd	sp!, {r4 - r7, lr}
+	stmfd	sp!, {r4 - r7, r11, lr}
 	mov	r3, #0			@ no offset
 	mov	r4, r0			@ r0 = table start
 	add	r5, r0, r1		@ r1 = table size
 	bl	__fixup_a_pv_table
-	ldmfd	sp!, {r4 - r7, pc}
+	ldmfd	sp!, {r4 - r7, r11, pc}
 ENDPROC(fixup_pv_table)
 
 	.data
-- 
1.8.3


