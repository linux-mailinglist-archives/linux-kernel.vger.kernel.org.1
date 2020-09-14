Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E5268F54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgINPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:13:49 -0400
Received: from foss.arm.com ([217.140.110.172]:39642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgINPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180181FB;
        Mon, 14 Sep 2020 08:10:48 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197423F718;
        Mon, 14 Sep 2020 08:10:46 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/14] arm64: usercopy: Check for overlapping buffers in fixup
Date:   Mon, 14 Sep 2020 15:09:55 +0000
Message-Id: <20200914150958.2200-12-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for overlapping source and destination buffers in the usercopy
fixup before proceeding, and if this is the case then return from
the fixup with the full copy size in x0.

Imported optimized copy routines may contain the implementation of
both memcpy() and memmov(), where the latter code path is very
different and may result in behaviour that is incompatible with
memcopy in the context of constructing a non-exhaustive fixup
recovery routine. For instance, the current memmov() implementation
copies in reverse.

As this is likely to be an edge case across multiple copy routines
(checked for explicitly from within the routines themselves), and
independent of any specific implementation, it should be suitable
to return the full copy width back to the kernel code path calling
the usercopy function.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_from_user.S  | 24 ++++++++--------
 arch/arm64/lib/copy_in_user.S    | 48 ++++++++++++++++----------------
 arch/arm64/lib/copy_to_user.S    | 24 ++++++++--------
 arch/arm64/lib/copy_user_fixup.S | 36 +++++++++++++++++++-----
 4 files changed, 77 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index cd3042e98394..745fbbfc23bb 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -20,7 +20,7 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 reg, ptr, offset=0
-	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
+	USER_F(9996f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
@@ -29,7 +29,7 @@
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, ldtrb \reg, [\ptr])
+	USER_F(9997f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
@@ -38,7 +38,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	USER_F(9998f, ldtr \reg, [\ptr, \offset])
+	USER_F(9997f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
@@ -46,8 +46,8 @@
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, ldtr \regA, [\ptr, \offset])
+	USER_F(9997f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
@@ -55,8 +55,8 @@
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, ldtr \regA, [\ptr, \offset])
+	USER_F(9997f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
@@ -65,7 +65,7 @@
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
@@ -73,7 +73,7 @@
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
@@ -81,7 +81,7 @@
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldr \reg, [\ptr, \offset])
+	USER_F(9997f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
@@ -89,7 +89,7 @@
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
+	USER_F(9997f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
@@ -97,7 +97,7 @@
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9997f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index fe035e513b34..34389d16c338 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -22,93 +22,93 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 reg, ptr, offset=0
-	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
-	USER_F(9998f, sttrb \reg, [\ptr, \offset])
+	USER_F(9997f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, ldtrb \reg, [\ptr])
+	USER_F(9997f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, sttrb \reg, [\ptr])
+	USER_F(9997f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	USER_F(9998f, ldtr \reg, [\ptr, \offset])
+	USER_F(9997f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
-	USER_F(9998f, sttr \reg, [\ptr, \offset])
+	USER_F(9997f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, ldtr \regA, [\ptr, \offset])
+	USER_F(9997f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
-	USER_F(9998f, sttr \regA, [\ptr, \offset])
-	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, ldtr \regA, [\ptr, \offset])
+	USER_F(9997f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
-	USER_F(9998f, sttr \regA, [\ptr, \offset])
-	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
-	USER_F(9998f, strb \reg, [\ptr, \offset])
+	USER_F(9997f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
-	USER_F(9998f, strb \reg, [\ptr, \offset])
+	USER_F(9997f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldr \reg, [\ptr, \offset])
+	USER_F(9997f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
-	USER_F(9998f, str \reg, [\ptr, \offset])
+	USER_F(9997f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
+	USER_F(9997f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
-	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9997f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro copy_exit
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index de0af211b3ba..cbb4cdfc7ad3 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -24,7 +24,7 @@
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
-	USER_F(9998f, sttrb \reg, [\ptr, \offset])
+	USER_F(9997f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
@@ -33,7 +33,7 @@
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, sttrb \reg, [\ptr])
+	USER_F(9997f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
@@ -42,7 +42,7 @@
 	.endm
 
 	.macro str1 reg, ptr, offset=0
-	USER_F(9998f, sttr \reg, [\ptr, \offset])
+	USER_F(9997f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
@@ -50,8 +50,8 @@
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
-	USER_F(9998f, sttr \regA, [\ptr, \offset])
-	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
@@ -59,8 +59,8 @@
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
-	USER_F(9998f, sttr \regA, [\ptr, \offset])
-	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
@@ -69,7 +69,7 @@
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
-	USER_F(9998f, strb \reg, [\ptr, \offset])
+	USER_F(9997f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
@@ -77,7 +77,7 @@
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
-	strb \reg, [\ptr, \offset]
+	USER_F(9997f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
@@ -85,7 +85,7 @@
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
-	USER_F(9998f, str \reg, [\ptr, \offset])
+	USER_F(9997f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
@@ -97,11 +97,11 @@
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
-	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro copy_exit
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index a528b7d7d1bd..01e5c34461d7 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -3,13 +3,35 @@
 addr	.req	x15
 .section .fixup,"ax"
 .align	2
+9997:
+	ldp	x0, x1, [sp], #16 // x0 (dst), x1 (src)
+	ldr	x2, [sp], #16 // x2 (count)
+	add	x3, x0, x2 // x3: dstend
+	add	x4, x1, x2 // x4: srcend
+	/*
+	 * Overlapping buffers:
+	 * (src <= dst && dst < srcend)
+	 *  || (dst <= src && src < dstend)
+	 */
+	cmp	x1, x0 // src (x1), dst (x0)
+	ccmp	x0, x4, #0, le // dst (x0), srcend (x4)
+	b.lt	L(none_copied)
+	cmp	x0, x1 // dst (x0), src (x1)
+	ccmp	x1, x3, #0, le // src (x1), dstend (x3)
+	b.lt	L(none_copied)
+	/*
+	 * Direct to subroutine based on location of fault
+	 */
+	cmp	addr, x1 // addr (x15), src (x1)
+	ccmp	addr, x4, #0x0, ge // addr, x4, #0, ge
+	b.lt	L(src_fault)
+	b	L(dst_fault)
+
+L(src_fault):
+L(dst_fault):
+
 9998:
-	// If it falls in the src range then it was a load that failed,
-	// otherwise it was a store
-	cmp addr, src
-	ccmp addr, srcend, #0x0, ge
-	csel x0, srcend, dstend, lt
-	sub x0, x0, addr
-	add sp, sp, 32
+L(none_copied):
+	mov	x0, x2 // count (x2)
 	ret
 
-- 
2.17.1

