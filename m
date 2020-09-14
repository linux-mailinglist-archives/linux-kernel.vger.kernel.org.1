Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E200268F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgINPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:14:23 -0400
Received: from foss.arm.com ([217.140.110.172]:39640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgINPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D710F1570;
        Mon, 14 Sep 2020 08:10:46 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03623F718;
        Mon, 14 Sep 2020 08:10:45 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/14] arm64: usercopy: Store the arguments on stack
Date:   Mon, 14 Sep 2020 15:09:54 +0000
Message-Id: <20200914150958.2200-11-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914150958.2200-1-oli.swede@arm.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the stack to preserve the initial arguments to the usercopy
functions before the copy routine modifies the relevant registers.
The values in x0 (dst), x1 (src) and x2 (count) may be modified
in the code paths for large copy sizes, and saving them before
the copy begins enables restoration by the fixup routines to
ensure they have the required information to backtrack effectively.

The stack is used instead of other general-purpose registers due to
resource constraints as all scratch registers x0-x17 defined by the
PCS in the ABI are utilized by the imported copy routine.

The stack pointer is restored to its initial position either from
the fixup code in the case of a fault, or at the end of the copy
algorithm otherwise. The .Luaccess_finish directive is also moved
to copy_template_user.S as the code is common to all usercopy
functions.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_from_user.S     | 3 ---
 arch/arm64/lib/copy_in_user.S       | 3 ---
 arch/arm64/lib/copy_template_user.S | 6 ++++++
 arch/arm64/lib/copy_to_user.S       | 3 ---
 arch/arm64/lib/copy_user_fixup.S    | 1 +
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index fa319f27a42b..cd3042e98394 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -110,9 +110,6 @@
 
 SYM_FUNC_START(__arch_copy_from_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_from_user)
 EXPORT_SYMBOL(__arch_copy_from_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 6b9bb6091dd8..fe035e513b34 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -117,9 +117,6 @@
 
 SYM_FUNC_START(__arch_copy_in_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_in_user)
 EXPORT_SYMBOL(__arch_copy_in_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_template_user.S b/arch/arm64/lib/copy_template_user.S
index 3db24dcdab05..1d13daf314b0 100644
--- a/arch/arm64/lib/copy_template_user.S
+++ b/arch/arm64/lib/copy_template_user.S
@@ -21,4 +21,10 @@
 L(copy_non_uao):
 #undef L
 #define L(l) .Lnuao ## l
+	str     x2, [sp, #-16]!		// count
+	stp     x0, x1, [sp, #-16]!	// dstin, src
 #include "copy_template.S"
+.Luaccess_finish:
+	add	sp, sp, 32
+	mov	x0, #0
+	ret
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 23af6af254da..de0af211b3ba 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -110,9 +110,6 @@
 
 SYM_FUNC_START(__arch_copy_to_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_to_user)
 EXPORT_SYMBOL(__arch_copy_to_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 32fae9e2e799..a528b7d7d1bd 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -10,5 +10,6 @@ addr	.req	x15
 	ccmp addr, srcend, #0x0, ge
 	csel x0, srcend, dstend, lt
 	sub x0, x0, addr
+	add sp, sp, 32
 	ret
 
-- 
2.17.1

