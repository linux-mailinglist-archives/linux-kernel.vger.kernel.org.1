Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631611C64F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 02:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgEFAPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 20:15:21 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:50385 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEFAPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:15:21 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id be89da68;
        Wed, 6 May 2020 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=W0BXXU08zoHh3hSor9TA2hhTz
        is=; b=QrZYmVWbd0Bc4YajW9Xe0WaZ5bIKFMeYqnJj/oRZFwb1BV85dcXnDdu52
        q5q0nsxOn0lHwhxJusJIyYNYyh2JrCsOpIZKjWYKMnuXe49RHj5DpDFJxYJY/2Ch
        X4viGdBESMwT/Lkst7xIPOOB5KvyaRutHCJEAxoZCT6uDtuo5Jk2jAc+JNs52mdE
        GfrvhjJHwHn+kWDwLXpTWgA32WkYqpPeM98tLw1an9XcqUfIAcIv7xOi2oPcjRWX
        Fuj9ix2LJ4Eqp+Aw4CIkKwY+TRFReiFdU8rZSbdBEHO9m3/GtZm7CprY6CYaG7Vz
        FdTSWZCQXv77bq/Gj7uTEEIUq5Fxw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc6ea39a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 6 May 2020 00:02:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] security: disable FORTIFY_SOURCE on clang
Date:   Tue,  5 May 2020 18:14:53 -0600
Message-Id: <20200506001453.764332-1-Jason@zx2c4.com>
In-Reply-To: <202005051617.F9B32B5526@keescook>
References: <202005051617.F9B32B5526@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-10 has a broken optimization stage that doesn't allow the
compiler to prove at compile time that certain memcpys are within
bounds, and thus the outline memcpy is always called, resulting in
horrific performance, and in some cases, excessive stack frame growth.
Here's a simple reproducer:

    typedef unsigned long size_t;
    void *c(void *dest, const void *src, size_t n) __asm__("memcpy");
    extern inline __attribute__((gnu_inline)) void *memcpy(void *dest, const void *src, size_t n) { return c(dest, src, n); }
    void blah(char *a)
    {
      unsigned long long b[10], c[10];
      int i;

      memcpy(b, a, sizeof(b));
      for (i = 0; i < 10; ++i)
        c[i] = b[i] ^ b[9 - i];
      for (i = 0; i < 10; ++i)
        b[i] = c[i] ^ a[i];
      memcpy(a, b, sizeof(b));
    }

Compile this with clang-9 and clang-10 and observe:

zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-10 -Wframe-larger-than=0 -O3 -c b.c -o c10.o
b.c:5:6: warning: stack frame size of 104 bytes in function 'blah' [-Wframe-larger-than=]
void blah(char *a)
     ^
1 warning generated.
zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-9 -Wframe-larger-than=0 -O3 -c b.c -o c9.o

Looking at the disassembly of c10.o and c9.o, one can see that c9.o is
properly optimized in the obvious way one would expect, while c10.o has
blown up and includes extern calls to memcpy.

But actually, for versions of clang earlier than 10, fortify source
mostly does nothing. So, between being broken and doing nothing, it
probably doesn't make sense to pretend to offer this option. So, this
commit just disables it entirely when compiling with clang.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: George Burgess <gbiv@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://bugs.llvm.org/show_bug.cgi?id=45802
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 security/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/Kconfig b/security/Kconfig
index cd3cc7da3a55..76bcfb3eb16f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -191,6 +191,7 @@ config HARDENED_USERCOPY_PAGESPAN
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
+	depends on !CC_IS_CLANG
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.26.2

