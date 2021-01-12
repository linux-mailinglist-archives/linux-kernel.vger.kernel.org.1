Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF32F3CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437555AbhALVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436944AbhALUaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEF462311F;
        Tue, 12 Jan 2021 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610483366;
        bh=MGuTtXoLe99kX/sbH8vTCXKT8YVod7BidDBwx8FWAUg=;
        h=From:To:Cc:Subject:Date:From;
        b=uuYnMGWDZ1PxZ2i52hZuv+LpFhlIwJ7VB4bTeoJTiZ/GB/7IGlKgh71HM5l6SqDXP
         +V5EQsP6mH0dX++5wjSmh8Ku36E2a7Y+VHXrvCGaD5Ir66On6g1lSZOazhwW8B5E0j
         obZ1cZRIdUFLfjAIa0LIiCwUNd7xFwhS+ZeSmX4ilpOneLpVtheKks7RTdbPHW6p9e
         zag8ceTis3kieR8wgUfV1ekAC3IONGSmKGtKwuqI0762Q5D94edpYQhdiQm68zsYsP
         qyb9AQu5M4spNKWApdaoLv0mjG56fK7/uSK6cV2Q9PveykMLB4MczgcwEqQQq9TTjL
         Dzcww37qE0YNw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] ubsan: disable unsigned-overflow check for i386
Date:   Tue, 12 Jan 2021 21:29:15 +0100
Message-Id: <20210112202922.2454435-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building ubsan kernels even for compile-testing introduced these
warnings in my randconfig environment:

crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
static void blake2b_compress(struct blake2b_state *S,
crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])

Further testing showed that this is caused by
-fsanitize=unsigned-integer-overflow, but is isolated to the 32-bit
x86 architecture.

The one in blake2b immediately overflows the 8KB stack area architectures,
so better ensure this never happens by disabling the option for 32-bit
x86.

Fixes: d0a3ac549f38 ("ubsan: enable for all*config builds")
Link: https://lore.kernel.org/lkml/20201230154749.746641-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: only turn it off for i386 as discussed
---
 lib/Kconfig.ubsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 8b635fd75fe4..3a0b1c930733 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -123,6 +123,7 @@ config UBSAN_SIGNED_OVERFLOW
 config UBSAN_UNSIGNED_OVERFLOW
 	bool "Perform checking for unsigned arithmetic overflow"
 	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
+	depends on !X86_32 # avoid excessive stack usage on x86-32/clang
 	help
 	  This option enables -fsanitize=unsigned-integer-overflow which checks
 	  for overflow of any arithmetic operations with unsigned integers. This
-- 
2.29.2

