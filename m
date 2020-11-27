Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D592C5FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbgK0Fn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:43:27 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33292 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389241AbgK0Fn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:43:27 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiWXO-0000Ph-AJ; Fri, 27 Nov 2020 16:43:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 16:43:18 +1100
Date:   Fri, 27 Nov 2020 16:43:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Samuel Neves <sneves@dei.uc.pt>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [v2 PATCH] crypto: lib/blake2s - Move selftest prototype into header
 file
Message-ID: <20201127054318.GA26215@gondor.apana.org.au>
References: <202011131622.l3VLezRW-lkp@intel.com>
 <20201127054125.GA23521@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127054125.GA23521@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2

Actually include the header file.

---8<---
This patch fixes a missing prototype warning on blake2s_selftest.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
index 74ff77032e52..6e376ae6b6b5 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -16,6 +16,8 @@ void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
 void blake2s_compress_arch(struct blake2s_state *state,const u8 *block,
 			   size_t nblocks, const u32 inc);
 
+bool blake2s_selftest(void);
+
 static inline void blake2s_set_lastblock(struct blake2s_state *state)
 {
 	state->f[0] = -1;
diff --git a/lib/crypto/blake2s-selftest.c b/lib/crypto/blake2s-selftest.c
index 79ef404a990d..5d9ea53be973 100644
--- a/lib/crypto/blake2s-selftest.c
+++ b/lib/crypto/blake2s-selftest.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
-#include <crypto/blake2s.h>
+#include <crypto/internal/blake2s.h>
 #include <linux/string.h>
 
 /*
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 41025a30c524..6a4b6b78d630 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -17,8 +17,6 @@
 #include <linux/bug.h>
 #include <asm/unaligned.h>
 
-bool blake2s_selftest(void);
-
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
 	const size_t fill = BLAKE2S_BLOCK_SIZE - state->buflen;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
