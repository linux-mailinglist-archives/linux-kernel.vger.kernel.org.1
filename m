Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8119C1C279A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgEBS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 14:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgEBS2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:28:09 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672BA20775;
        Sat,  2 May 2020 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588444088;
        bh=MpOpLyRp32OcEAeGdDPZsgk7eR7jNOoThKxfaag+uuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7M5DGleg8HtwnRWGrZDYKUoXl1liD0BSvTxyqAANiFELjUZgVrniqTADhg/TCk3E
         uF0p8KFSTKCi+I4YKGOKoYEfHstkiLieaID0OTBJq/kvF8W0nyBd1KrTBhCmaxzDNc
         juGKbyxbNDMbRB5V3Zm/k6KTFlKzpVpQlLHWWzKw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/7] crypto: powerpc/sha1 - prefix the "sha1_" functions
Date:   Sat,  2 May 2020 11:24:23 -0700
Message-Id: <20200502182427.104383-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502182427.104383-1-ebiggers@kernel.org>
References: <20200502182427.104383-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Prefix the PowerPC SHA-1 functions with "powerpc_sha1_" rather than
"sha1_".  This allows us to rename the library function sha_init() to
sha1_init() without causing a naming collision.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/sha1.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/crypto/sha1.c b/arch/powerpc/crypto/sha1.c
index db46b6130a9642..b40dc50a6908ae 100644
--- a/arch/powerpc/crypto/sha1.c
+++ b/arch/powerpc/crypto/sha1.c
@@ -22,7 +22,7 @@
 
 void powerpc_sha_transform(u32 *state, const u8 *src);
 
-static int sha1_init(struct shash_desc *desc)
+static int powerpc_sha1_init(struct shash_desc *desc)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -33,8 +33,8 @@ static int sha1_init(struct shash_desc *desc)
 	return 0;
 }
 
-static int sha1_update(struct shash_desc *desc, const u8 *data,
-			unsigned int len)
+static int powerpc_sha1_update(struct shash_desc *desc, const u8 *data,
+			       unsigned int len)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 	unsigned int partial, done;
@@ -68,7 +68,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 
 
 /* Add padding and return the message digest. */
-static int sha1_final(struct shash_desc *desc, u8 *out)
+static int powerpc_sha1_final(struct shash_desc *desc, u8 *out)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 	__be32 *dst = (__be32 *)out;
@@ -81,10 +81,10 @@ static int sha1_final(struct shash_desc *desc, u8 *out)
 	/* Pad out to 56 mod 64 */
 	index = sctx->count & 0x3f;
 	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
-	sha1_update(desc, padding, padlen);
+	powerpc_sha1_update(desc, padding, padlen);
 
 	/* Append length */
-	sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+	powerpc_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
 
 	/* Store state in digest */
 	for (i = 0; i < 5; i++)
@@ -96,7 +96,7 @@ static int sha1_final(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
-static int sha1_export(struct shash_desc *desc, void *out)
+static int powerpc_sha1_export(struct shash_desc *desc, void *out)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -104,7 +104,7 @@ static int sha1_export(struct shash_desc *desc, void *out)
 	return 0;
 }
 
-static int sha1_import(struct shash_desc *desc, const void *in)
+static int powerpc_sha1_import(struct shash_desc *desc, const void *in)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -114,11 +114,11 @@ static int sha1_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	sha1_init,
-	.update		=	sha1_update,
-	.final		=	sha1_final,
-	.export		=	sha1_export,
-	.import		=	sha1_import,
+	.init		=	powerpc_sha1_init,
+	.update		=	powerpc_sha1_update,
+	.final		=	powerpc_sha1_final,
+	.export		=	powerpc_sha1_export,
+	.import		=	powerpc_sha1_import,
 	.descsize	=	sizeof(struct sha1_state),
 	.statesize	=	sizeof(struct sha1_state),
 	.base		=	{
-- 
2.26.2

