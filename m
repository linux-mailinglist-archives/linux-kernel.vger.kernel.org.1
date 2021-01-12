Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3A2F3F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394783AbhALWt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732390AbhALWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:49:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2A5823122;
        Tue, 12 Jan 2021 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610491724;
        bh=fWxXcxqHEI+KsLZg+QH/ku9lOvit7R1hyoKrLJ/10dI=;
        h=From:To:Cc:Subject:Date:From;
        b=B1c8aG435fUbuC1xPq3IcCLLYNeEtR6V71UVoKA0CRGj6sk4ilrfp7b0fcCebrM6X
         WU3CR8kyi/yFTWvYk4NHtAdLQ8tNY24nf970YY8Cnr81uD4FDFic2bhthnkfot3+ko
         3wNV5OAccljPV5wcopvGGzHG/Wms3aXdAFpTBW+fRGwTiv6NWhQlnAV3gSJD31lHz2
         VjYFGj/z/3GvIWjbUP7QodBBU1rlhiKV1/rKIldqFoUyo3xsTmfai3rdguqPDDaieB
         IYQZW+W6JTRl6/9YKKiZfV5OonxmEcbo/E4em1hpOVX7mBukuiQJo5i1u0qEfdp4TD
         FYZBdsB/G/GDA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
Date:   Tue, 12 Jan 2021 22:48:32 +0000
Message-Id: <20210112224832.10980-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
beyond the stack pointer, resulting in memory corruption if an interrupt
is taken after the stack pointer has been adjusted but before the
reference has been executed. This leads to subtle, infrequent data
corruption such as the EXT4 problems reported by Russell King at the
link below.

Life is too short for buggy compilers, so raise the minimum GCC version
required by arm64 to 5.1.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Russell King <linux@armlinux.org.uk>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/r/20210105154726.GD1551@shell.armlinux.org.uk
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler-gcc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 74c6c0486eed..555ab0fddbef 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -13,6 +13,12 @@
 /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
 #if GCC_VERSION < 40900
 # error Sorry, your version of GCC is too old - please use 4.9 or newer.
+#elif defined(CONFIG_ARM64) && GCC_VERSION < 50100
+/*
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
+ * https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
+ */
+# error Sorry, your version of GCC is too old - please use 5.1 or newer.
 #endif
 
 /*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

