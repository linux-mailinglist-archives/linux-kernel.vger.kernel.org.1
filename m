Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553D3268F59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgINPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:14:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgINPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452DA1595;
        Mon, 14 Sep 2020 08:10:49 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ECD33F718;
        Mon, 14 Sep 2020 08:10:48 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/14] arm64: usercopy: Add intermediate fixup routine
Date:   Mon, 14 Sep 2020 15:09:56 +0000
Message-Id: <20200914150958.2200-13-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an intermediate fixup routine that initiates an in-order
byte-wise copy that is expected to fault for a second time, and then
be redirected to the final fixup where the precise number of bytes
remaining is obtained. As well as compatibility with the latest
optimized copy routine, these fixups should also be applicable to
future copy algorithms that utilize out-of-order copying.

The copy template is extended to add the relevant macros for the
second-stage fixup to each of the usercopy functions, where the
exception table entries are inserted to redirect the PC to the
conclusive fixup from the second instruction fault.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_from_user.S     | 18 ++++++++++++++-
 arch/arm64/lib/copy_in_user.S       | 16 ++++++++++++++
 arch/arm64/lib/copy_template_user.S |  2 ++
 arch/arm64/lib/copy_to_user.S       | 16 ++++++++++++++
 arch/arm64/lib/copy_user_fixup.S    | 34 ++++++++++++++++++++++++++++-
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 745fbbfc23bb..7d3b7a790091 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -20,7 +20,7 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 reg, ptr, offset=0
-	USER_F(9996f, ldtrb \reg, [\ptr, \offset])
+	USER_F(9997f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
@@ -104,6 +104,22 @@
 	stp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro ldrb2_post reg, ptr, offset=0
+	USER_F(9998f, ldtrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro strb2_post reg, ptr, offset=0
+	strb \reg, [\ptr], \offset
+	.endm
+
+	.macro ldrb2_post_nuao reg, ptr, offset=0
+	USER_F(9998f, ldrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro strb2_post_nuao reg, ptr, offset=0
+	strb \reg, [\ptr], \offset
+	.endm
+
 	.macro copy_exit
 	b	.Luaccess_finish
 	.endm
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 34389d16c338..ded937129270 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -111,6 +111,22 @@
 	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
+	.macro ldrb2_post reg, ptr, offset=0
+	USER_F(9998f, ldtrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro strb2_post reg, ptr, offset=0
+	USER_F(9998f, sttrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro ldrb2_post_nuao reg, ptr, offset=0
+	USER_F(9998f, ldrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro strb2_post_nuao reg, ptr, offset=0
+	USER_F(9998f, strb \reg, [\ptr], \offset)
+	.endm
+
 	.macro copy_exit
 	b	.Luaccess_finish
 	.endm
diff --git a/arch/arm64/lib/copy_template_user.S b/arch/arm64/lib/copy_template_user.S
index 1d13daf314b0..e94911e4df0f 100644
--- a/arch/arm64/lib/copy_template_user.S
+++ b/arch/arm64/lib/copy_template_user.S
@@ -17,6 +17,8 @@
 #define strb1 strb1_nuao
 #define ldrb1_reg ldrb1_nuao_reg
 #define strb1_reg strb1_nuao_reg
+#define ldrb2_post ldrb2_post_nuao
+#define strb2_post strb2_post_nuao
 
 L(copy_non_uao):
 #undef L
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index cbb4cdfc7ad3..05a87ebe3ddc 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -104,6 +104,22 @@
 	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
+	.macro ldrb2_post reg, ptr, offset=0
+	ldrb \reg, [\ptr], \offset
+	.endm
+
+	.macro strb2_post reg, ptr, offset=0
+	USER_F(9998f, sttrb \reg, [\ptr], \offset)
+	.endm
+
+	.macro ldrb2_post_nuao reg, ptr, offset=0
+	ldrb \reg, [\ptr], \offset
+	.endm
+
+	.macro strb2_post_nuao reg, ptr, offset=0
+	USER_F(9998f, strb \reg, [\ptr], \offset)
+	.endm
+
 	.macro copy_exit
 	b	.Luaccess_finish
 	.endm
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 01e5c34461d7..6a7b2406d948 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -27,11 +27,43 @@ addr	.req	x15
 	b.lt	L(src_fault)
 	b	L(dst_fault)
 
+/*
+ * Reached here from load instruction during
+ * copy_{from/in}_user(dst, __user src, count)
+ */
 L(src_fault):
+	mov	x3, x1 // x3: initial target (user) load address
+	mov	x4, x0 // x4: initial target store address
+	add	x5, x1, x2 // x5: srcend
+
+L(src_buf_scan):
+	ldrb2_post	w6, x3, #1
+	strb2_post	w6, x4, #1
+	cmp		x3, x5
+	b.lt		L(src_buf_scan)
+	b		L(all_copied)
+
+/*
+ * Reached here from store instruction during
+ * copy_{to/in}_user(__user dst, src, count)
+ */
 L(dst_fault):
+	mov	x3, x0 // x3: initial target (user) store address
+	mov	x4, x1 // x4: initial target load address
+	add	x5, x0, x2 // x5: dstend
+
+L(dst_buf_scan):
+	ldrb2_post	w6, x4, #1
+	strb2_post	w6, x3, #1
+	cmp		x3, x5
+	b.lt		L(dst_buf_scan)
+
+L(all_copied):
+	mov	x0, #0 // reached the end of buffer
+	ret
 
 9998:
+// TODO: add accurate fixup
 L(none_copied):
 	mov	x0, x2 // count (x2)
 	ret
-
-- 
2.17.1

