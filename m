Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C982E7AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgL3Pse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgL3Pse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:48:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B291221FA;
        Wed, 30 Dec 2020 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343273;
        bh=vBYeDCgOLFmbNPmETuajmSAtm33RRNayRLyoFoCHSrY=;
        h=From:To:Cc:Subject:Date:From;
        b=QXphXNuQKEJ1/HDJRty278cbV37eRN7AUufjsysI9oEKN7trELi1Rg3DHUVb4Jl7G
         o4ByG+8ipcJJsYduu9PNfzZWCaMIR1ffEE4qreJecc8QVZx8FgKlHHdcnVOkIiENxn
         37cjeYXjL2ZOJiwtYR0ATzT4yd6a3r5MYXHPFBOcS3vXg3jUJsswD9vOpU7g+SMwOf
         xta3U8QagccOEY+TM+7VkDcNdup4pElj4JC/18imPEIHdCI7bhQpiHs9tvDhpoTFEU
         CEqbNoreQywMBPo3m7TjyAJTCmbCuRL2pd4yfmSbEjIInukh4kufInrvxHaQE0bi55
         ilf43KYL2ID5A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
Date:   Wed, 30 Dec 2020 16:47:35 +0100
Message-Id: <20201230154749.746641-1-arnd@kernel.org>
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
-fsanitize=unsigned-integer-overflow.

The one in blake2b immediately overflows the 8KB stack area on 32-bit
architectures, so better ensure this never happens by making this
option gcc-only.

Fixes: d0a3ac549f38 ("ubsan: enable for all*config builds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.ubsan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 8b635fd75fe4..e23873282ba7 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
 
 config UBSAN_UNSIGNED_OVERFLOW
 	bool "Perform checking for unsigned arithmetic overflow"
+	# clang hugely expands stack usage with -fsanitize=object-size
+	depends on !CC_IS_CLANG
 	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
 	help
 	  This option enables -fsanitize=unsigned-integer-overflow which checks
-- 
2.29.2

