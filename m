Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A72F9D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbhARK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:57:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbhARK5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:57:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id D3DFA1F44C3A
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
Subject: [PATCH v3 RESEND 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
Date:   Mon, 18 Jan 2021 12:55:56 +0200
Message-Id: <20210118105557.186614-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210118105557.186614-1-adrian.ratiu@collabora.com>
References: <20210118105557.186614-1-adrian.ratiu@collabora.com>
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
which doesn't make much sense and risks misleading users.

As a side-note remark, -fttree-vectorize is on by default in
Clang, but it currently does not work (see linked issues).

Link: https://github.com/ClangBuiltLinux/linux/issues/496
Link: https://github.com/ClangBuiltLinux/linux/issues/503
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 arch/arm/lib/xor-neon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index b99dd8e1c93f..e1e76186ec23 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
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

