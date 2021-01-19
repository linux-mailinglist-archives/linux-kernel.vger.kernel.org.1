Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D532FB8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393119AbhASN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391951AbhASNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:18:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:17:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id D0B0C1F451BA
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
Date:   Tue, 19 Jan 2021 15:17:23 +0200
Message-Id: <20210119131724.308884-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119131724.308884-1-adrian.ratiu@collabora.com>
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Drop warning because kernel now requires GCC >= v4.9 after
commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
and clarify that -ftree-vectorize now always needs enabling
for GCC by directly testing the presence of CONFIG_CC_IS_GCC.

Another reason to remove the warning is that Clang exposes
itself as GCC < 4.6 so it triggers the warning about GCC
which doesn't make much sense and misleads Clang users by
telling them to update GCC.

Because Clang is now supported by the kernel print a clear
Clang-specific warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/496
Link: https://github.com/ClangBuiltLinux/linux/issues/503
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 arch/arm/lib/xor-neon.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index b99dd8e1c93f..f9f3601cc2d1 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
 #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
 #endif
 
+/*
+ * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
+ * compiler does not produce vectorized code due to its cost model.
+ * See: https://github.com/ClangBuiltLinux/linux/issues/503
+ */
+#ifdef CONFIG_CC_IS_CLANG
+#warning Clang does not vectorize code in this file.
+#endif
+
 /*
  * Pull in the reference implementations while instructing GCC (through
  * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
  * NEON instructions.
  */
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
+#ifdef CONFIG_CC_IS_GCC
 #pragma GCC optimize "tree-vectorize"
-#else
-/*
- * While older versions of GCC do not generate incorrect code, they fail to
- * recognize the parallel nature of these functions, and emit plain ARM code,
- * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
- */
-#warning This code requires at least version 4.6 of GCC
 #endif
 
 #pragma GCC diagnostic ignored "-Wunused-variable"
-- 
2.30.0

