Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA612A8EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKFFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgKFFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:14:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0262C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:14:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id D41631F466CE
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Date:   Fri,  6 Nov 2020 07:14:36 +0200
Message-Id: <20201106051436.2384842-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a Clang bug [1] neon autoloop vectorization does not happen or
happens badly with no gains and considering previous GCC experiences
which generated unoptimized code which was worse than the default asm
implementation, it is safer to default clang builds to the known good
generic implementation.

The kernel currently supports a minimum Clang version of v10.0.1, see
commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1").

When the bug gets eventually fixed, this commit could be reverted or,
if the minimum clang version bump takes a long time, a warning could
be added for users to upgrade their compilers like was done for GCC.

[1] https://bugs.llvm.org/show_bug.cgi?id=40976

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 arch/arm/include/asm/xor.h | 3 ++-
 arch/arm/lib/Makefile      | 3 +++
 arch/arm/lib/xor-neon.c    | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index aefddec79286..49937dafaa71 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -141,7 +141,8 @@ static struct xor_block_template xor_block_arm4regs = {
 		NEON_TEMPLATES;			\
 	} while (0)
 
-#ifdef CONFIG_KERNEL_MODE_NEON
+/* disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976 */
+#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
 
 extern struct xor_block_template const xor_block_neon_inner;
 
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..53f9e7dd9714 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -43,8 +43,11 @@ endif
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
+# disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976
+ifndef CONFIG_CC_IS_CLANG
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
   NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
+endif
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index e1e76186ec23..84c91c48dfa2 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
  * Pull in the reference implementations while instructing GCC (through
  * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
  * NEON instructions.
+
+ * On Clang the loop vectorizer is enabled by default, but due to a bug
+ * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
+ * so xor-neon is disabled in favor of the default reg implementations.
  */
 #ifdef CONFIG_CC_IS_GCC
 #pragma GCC optimize "tree-vectorize"
-- 
2.29.0

