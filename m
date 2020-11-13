Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598822B15C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMGNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:13:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34140 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgKMGNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:13:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kdSKR-0001Kn-Pr; Fri, 13 Nov 2020 17:13:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Nov 2020 17:12:59 +1100
Date:   Fri, 13 Nov 2020 17:12:59 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: lib/curve25519 - Move selftest prototype into header
 file
Message-ID: <20201113061259.GA9370@gondor.apana.org.au>
References: <202011131341.Vd4Z30Z0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011131341.Vd4Z30Z0-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:56:46PM +0800, kernel test robot wrote:
>
> All warnings (new ones prefixed by >>):
> 
> >> lib/crypto/curve25519-selftest.c:1283:13: warning: no previous prototype for 'curve25519_selftest' [-Wmissing-prototypes]
>     1283 | bool __init curve25519_selftest(void)
>          |             ^~~~~~~~~~~~~~~~~~~

---8<---
This patch moves the curve25519_selftest into curve25519.h so
we don't get a warning from gcc complaining about a missing
prototype.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/crypto/curve25519.h b/include/crypto/curve25519.h
index 4e6dc840b159..ece6a9b5fafc 100644
--- a/include/crypto/curve25519.h
+++ b/include/crypto/curve25519.h
@@ -28,6 +28,8 @@ void curve25519_arch(u8 out[CURVE25519_KEY_SIZE],
 void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
 			  const u8 secret[CURVE25519_KEY_SIZE]);
 
+bool curve25519_selftest(void);
+
 static inline
 bool __must_check curve25519(u8 mypublic[CURVE25519_KEY_SIZE],
 			     const u8 secret[CURVE25519_KEY_SIZE],
diff --git a/lib/crypto/curve25519.c b/lib/crypto/curve25519.c
index 288a62cd29b2..fb29739e8c29 100644
--- a/lib/crypto/curve25519.c
+++ b/lib/crypto/curve25519.c
@@ -13,8 +13,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-bool curve25519_selftest(void);
-
 static int __init mod_init(void)
 {
 	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
