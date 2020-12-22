Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085A2E0D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgLVQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgLVQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:09:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C642423105;
        Tue, 22 Dec 2020 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608653299;
        bh=GimLp4FS9dHFVzltelKWNeWgDjwe6R+OzJ0sPf1/wBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2Xabyla41H4p77fODBQ6PxgkR+SUZnBjPiUipxALvPDvd13Rp9xrfv9iq2854WR4
         +p87MYI7QTMwkLS0NHuB1oQd0weWTjGYFLXvaRwRveo21MV6dOrIW/1JXMWT+Sewe2
         CSEtcVwZy7qadACwruYKHtBsnncAU6pFdz2cJjB89PXhbVXVtr5WYPvOBZ1qaNBmeg
         dSTnvZvlVyZuimcEL53RFUvkNPuNE8NiHGcXvBH/bFW0M+jnbDK/3VsHbiY66E84+i
         gsLMJW6Q8H1TAPR7u06VOpe6p024/2yBS74H8H4PYdBS9d7QXPHtOOJLI3Ti/INpOy
         WeWw5Hx28N7rg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/2] crypto: x86/aes-ni-xts - rewrite and drop indirections via glue helper
Date:   Tue, 22 Dec 2020 17:06:29 +0100
Message-Id: <20201222160629.22268-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222160629.22268-1-ardb@kernel.org>
References: <20201222160629.22268-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AES-NI driver implements XTS via the glue helper, which consumes
a struct with sets of function pointers which are invoked on chunks
of input data of the appropriate size, as annotated in the struct.

Let's get rid of this indirection, so that we can perform direct calls
to the assembler helpers. Instead, let's adopt the arm64 strategy, i.e.,
provide a helper which can consume inputs of any size, provided that the
penultimate, full block is passed via the last call if ciphertext stealing
needs to be applied.

This also allows us to enable the XTS mode for i386.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/aesni-intel_asm.S  | 280 ++++++++++++++++----
 arch/x86/crypto/aesni-intel_glue.c | 221 ++++++++-------
 2 files changed, 357 insertions(+), 144 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 84d8a156cdcd..dbe2ca0d8e86 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -43,10 +43,6 @@
 #ifdef __x86_64__
 
 # constants in mergeable sections, linker can reorder and merge
-.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
-.align 16
-.Lgf128mul_x_ble_mask:
-	.octa 0x00000000000000010000000000000087
 .section	.rodata.cst16.POLY, "aM", @progbits, 16
 .align 16
 POLY:   .octa 0xC2000000000000000000000000000001
@@ -146,7 +142,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define CTR	%xmm11
 #define INC	%xmm12
 
-#define GF128MUL_MASK %xmm10
+#define GF128MUL_MASK %xmm7
 
 #ifdef __x86_64__
 #define AREG	%rax
@@ -2823,6 +2819,14 @@ SYM_FUNC_START(aesni_ctr_enc)
 	ret
 SYM_FUNC_END(aesni_ctr_enc)
 
+#endif
+
+.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
+.align 16
+.Lgf128mul_x_ble_mask:
+	.octa 0x00000000000000010000000000000087
+.previous
+
 /*
  * _aesni_gf128mul_x_ble:		internal ABI
  *	Multiply in GF(2^128) for XTS IVs
@@ -2835,11 +2839,11 @@ SYM_FUNC_END(aesni_ctr_enc)
  *	CTR:	== temporary value
  */
 #define _aesni_gf128mul_x_ble() \
-	pshufd $0x13, IV, CTR; \
+	pshufd $0x13, IV, KEY; \
 	paddq IV, IV; \
-	psrad $31, CTR; \
-	pand GF128MUL_MASK, CTR; \
-	pxor CTR, IV;
+	psrad $31, KEY; \
+	pand GF128MUL_MASK, KEY; \
+	pxor KEY, IV;
 
 /*
  * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
@@ -2847,65 +2851,153 @@ SYM_FUNC_END(aesni_ctr_enc)
  */
 SYM_FUNC_START(aesni_xts_encrypt)
 	FRAME_BEGIN
-
+#ifndef __x86_64__
+	pushl IVP
+	pushl LEN
+	pushl KEYP
+	pushl KLEN
+	movl (FRAME_OFFSET+20)(%esp), KEYP	# ctx
+	movl (FRAME_OFFSET+24)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+28)(%esp), INP	# src
+	movl (FRAME_OFFSET+32)(%esp), LEN	# len
+	movl (FRAME_OFFSET+36)(%esp), IVP	# iv
 	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
+#else
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+#endif
 	movups (IVP), IV
 
 	mov 480(KEYP), KLEN
 
 .Lxts_enc_loop4:
+	sub $64, LEN
+	jl .Lxts_enc_1x
+
 	movdqa IV, STATE1
-	movdqu 0x00(INP), INC
-	pxor INC, STATE1
+	movdqu 0x00(INP), IN
+	pxor IN, STATE1
 	movdqu IV, 0x00(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE2
-	movdqu 0x10(INP), INC
-	pxor INC, STATE2
+	movdqu 0x10(INP), IN
+	pxor IN, STATE2
 	movdqu IV, 0x10(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE3
-	movdqu 0x20(INP), INC
-	pxor INC, STATE3
+	movdqu 0x20(INP), IN
+	pxor IN, STATE3
 	movdqu IV, 0x20(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE4
-	movdqu 0x30(INP), INC
-	pxor INC, STATE4
+	movdqu 0x30(INP), IN
+	pxor IN, STATE4
 	movdqu IV, 0x30(OUTP)
 
 	call _aesni_enc4
 
-	movdqu 0x00(OUTP), INC
-	pxor INC, STATE1
+	movdqu 0x00(OUTP), IN
+	pxor IN, STATE1
 	movdqu STATE1, 0x00(OUTP)
 
-	movdqu 0x10(OUTP), INC
-	pxor INC, STATE2
+	movdqu 0x10(OUTP), IN
+	pxor IN, STATE2
 	movdqu STATE2, 0x10(OUTP)
 
-	movdqu 0x20(OUTP), INC
-	pxor INC, STATE3
+	movdqu 0x20(OUTP), IN
+	pxor IN, STATE3
 	movdqu STATE3, 0x20(OUTP)
 
-	movdqu 0x30(OUTP), INC
-	pxor INC, STATE4
+	movdqu 0x30(OUTP), IN
+	pxor IN, STATE4
 	movdqu STATE4, 0x30(OUTP)
 
 	_aesni_gf128mul_x_ble()
 
 	add $64, INP
 	add $64, OUTP
-	sub $64, LEN
-	ja .Lxts_enc_loop4
+	cmp $0, LEN
+	jnz .Lxts_enc_loop4
 
+.Lxts_enc_ret_iv:
 	movups IV, (IVP)
 
+.Lxts_enc_ret:
+#ifndef __x86_64__
+	popl KLEN
+	popl KEYP
+	popl LEN
+	popl IVP
+#endif
 	FRAME_END
 	ret
+
+.Lxts_enc_1x:
+	add $64, LEN
+	jz .Lxts_enc_ret_iv
+	sub $16, LEN
+	jl .Lxts_enc_cts4
+
+.Lxts_enc_loop1:
+	movdqu (INP), STATE
+	pxor IV, STATE
+	call _aesni_enc1
+	pxor IV, STATE
+	_aesni_gf128mul_x_ble()
+
+	cmp $0, LEN
+	jz .Lxts_enc_out
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_enc_cts1
+
+	movdqu STATE, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_enc_loop1
+
+.Lxts_enc_out:
+	movdqu STATE, (OUTP)
+	jmp .Lxts_enc_ret_iv
+
+.Lxts_enc_cts4:
+	movdqa STATE4, STATE
+	sub $16, OUTP
+
+.Lxts_enc_cts1:
+#ifndef __x86_64__
+	lea .Lcts_permute_table, T1
+#else
+	lea .Lcts_permute_table(%rip), T1
+#endif
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), %xmm4
+	movaps STATE, IN2
+	pshufb %xmm4, STATE
+	movups STATE, (LEN)
+
+	movups (IVP), %xmm0
+	pshufb %xmm0, IN1
+	pblendvb IN2, IN1
+	movaps IN1, STATE
+
+	pxor IV, STATE
+	call _aesni_enc1
+	pxor IV, STATE
+
+	movups STATE, (OUTP)
+	jmp .Lxts_enc_ret
 SYM_FUNC_END(aesni_xts_encrypt)
 
 /*
@@ -2914,66 +3006,158 @@ SYM_FUNC_END(aesni_xts_encrypt)
  */
 SYM_FUNC_START(aesni_xts_decrypt)
 	FRAME_BEGIN
-
+#ifndef __x86_64__
+	pushl IVP
+	pushl LEN
+	pushl KEYP
+	pushl KLEN
+	movl (FRAME_OFFSET+20)(%esp), KEYP	# ctx
+	movl (FRAME_OFFSET+24)(%esp), OUTP	# dst
+	movl (FRAME_OFFSET+28)(%esp), INP	# src
+	movl (FRAME_OFFSET+32)(%esp), LEN	# len
+	movl (FRAME_OFFSET+36)(%esp), IVP	# iv
 	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
+#else
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+#endif
 	movups (IVP), IV
 
 	mov 480(KEYP), KLEN
 	add $240, KEYP
 
+	test $15, LEN
+	jz .Lxts_dec_loop4
+	sub $16, LEN
+
 .Lxts_dec_loop4:
+	sub $64, LEN
+	jl .Lxts_dec_1x
+
 	movdqa IV, STATE1
-	movdqu 0x00(INP), INC
-	pxor INC, STATE1
+	movdqu 0x00(INP), IN
+	pxor IN, STATE1
 	movdqu IV, 0x00(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE2
-	movdqu 0x10(INP), INC
-	pxor INC, STATE2
+	movdqu 0x10(INP), IN
+	pxor IN, STATE2
 	movdqu IV, 0x10(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE3
-	movdqu 0x20(INP), INC
-	pxor INC, STATE3
+	movdqu 0x20(INP), IN
+	pxor IN, STATE3
 	movdqu IV, 0x20(OUTP)
 
 	_aesni_gf128mul_x_ble()
 	movdqa IV, STATE4
-	movdqu 0x30(INP), INC
-	pxor INC, STATE4
+	movdqu 0x30(INP), IN
+	pxor IN, STATE4
 	movdqu IV, 0x30(OUTP)
 
 	call _aesni_dec4
 
-	movdqu 0x00(OUTP), INC
-	pxor INC, STATE1
+	movdqu 0x00(OUTP), IN
+	pxor IN, STATE1
 	movdqu STATE1, 0x00(OUTP)
 
-	movdqu 0x10(OUTP), INC
-	pxor INC, STATE2
+	movdqu 0x10(OUTP), IN
+	pxor IN, STATE2
 	movdqu STATE2, 0x10(OUTP)
 
-	movdqu 0x20(OUTP), INC
-	pxor INC, STATE3
+	movdqu 0x20(OUTP), IN
+	pxor IN, STATE3
 	movdqu STATE3, 0x20(OUTP)
 
-	movdqu 0x30(OUTP), INC
-	pxor INC, STATE4
+	movdqu 0x30(OUTP), IN
+	pxor IN, STATE4
 	movdqu STATE4, 0x30(OUTP)
 
 	_aesni_gf128mul_x_ble()
 
 	add $64, INP
 	add $64, OUTP
-	sub $64, LEN
-	ja .Lxts_dec_loop4
+	cmp $0, LEN
+	jnz .Lxts_dec_loop4
 
+.Lxts_dec_ret_iv:
 	movups IV, (IVP)
 
+.Lxts_dec_ret:
+#ifndef __x86_64__
+	popl KLEN
+	popl KEYP
+	popl LEN
+	popl IVP
+#endif
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_xts_decrypt)
 
+.Lxts_dec_1x:
+	add $64, LEN
+	jz .Lxts_dec_ret_iv
+
+.Lxts_dec_loop1:
+	movdqu (INP), STATE
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_dec_cts1
+
+	pxor IV, STATE
+	call _aesni_dec1
+	pxor IV, STATE
+	_aesni_gf128mul_x_ble()
+
+	cmp $0, LEN
+	jz .Lxts_dec_out
+
+	movdqu STATE, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_dec_loop1
+
+.Lxts_dec_out:
+	movdqu STATE, (OUTP)
+	jmp .Lxts_dec_ret_iv
+
+.Lxts_dec_cts1:
+	movdqa IV, STATE4
+	_aesni_gf128mul_x_ble()
+
+	pxor IV, STATE
+	call _aesni_dec1
+	pxor IV, STATE
+
+#ifndef __x86_64__
+	lea .Lcts_permute_table, T1
+#else
+	lea .Lcts_permute_table(%rip), T1
 #endif
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), %xmm4
+	movaps STATE, IN2
+	pshufb %xmm4, STATE
+	movups STATE, (LEN)
+
+	movups (IVP), %xmm0
+	pshufb %xmm0, IN1
+	pblendvb IN2, IN1
+	movaps IN1, STATE
+
+	pxor STATE4, STATE
+	call _aesni_dec1
+	pxor STATE4, STATE
+
+	movups STATE, (OUTP)
+	jmp .Lxts_dec_ret
+SYM_FUNC_END(aesni_xts_decrypt)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 711cabb4a555..9f5d25d8f377 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -33,9 +33,7 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
-#ifdef CONFIG_X86_64
-#include <asm/crypto/glue_helper.h>
-#endif
+#include <crypto/gf128mul.h>
 
 
 #define AESNI_ALIGN	16
@@ -565,98 +563,6 @@ static int ctr_crypt(struct skcipher_request *req)
 	return err;
 }
 
-static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			    unsigned int keylen)
-{
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int err;
-
-	err = xts_verify_key(tfm, key, keylen);
-	if (err)
-		return err;
-
-	keylen /= 2;
-
-	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
-				 key, keylen);
-	if (err)
-		return err;
-
-	/* second half of xts-key is for tweak */
-	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
-				  key + keylen, keylen);
-}
-
-
-static void aesni_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_enc);
-}
-
-static void aesni_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_dec);
-}
-
-static void aesni_xts_enc32(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	aesni_xts_encrypt(ctx, dst, src, 32 * AES_BLOCK_SIZE, (u8 *)iv);
-}
-
-static void aesni_xts_dec32(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	aesni_xts_decrypt(ctx, dst, src, 32 * AES_BLOCK_SIZE, (u8 *)iv);
-}
-
-static const struct common_glue_ctx aesni_enc_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = 1,
-
-	.funcs = { {
-		.num_blocks = 32,
-		.fn_u = { .xts = aesni_xts_enc32 }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = aesni_xts_enc }
-	} }
-};
-
-static const struct common_glue_ctx aesni_dec_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = 1,
-
-	.funcs = { {
-		.num_blocks = 32,
-		.fn_u = { .xts = aesni_xts_dec32 }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = aesni_xts_dec }
-	} }
-};
-
-static int xts_encrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&aesni_enc_xts, req, aesni_enc,
-				   aes_ctx(ctx->raw_tweak_ctx),
-				   aes_ctx(ctx->raw_crypt_ctx),
-				   false);
-}
-
-static int xts_decrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&aesni_dec_xts, req, aesni_enc,
-				   aes_ctx(ctx->raw_tweak_ctx),
-				   aes_ctx(ctx->raw_crypt_ctx),
-				   true);
-}
-
 static int
 rfc4106_set_hash_subkey(u8 *hash_subkey, const u8 *key, unsigned int key_len)
 {
@@ -905,6 +811,128 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 }
 #endif
 
+static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			    unsigned int keylen)
+{
+	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int err;
+
+	err = xts_verify_key(tfm, key, keylen);
+	if (err)
+		return err;
+
+	keylen /= 2;
+
+	/* first half of xts-key is for crypt */
+	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
+				 key, keylen);
+	if (err)
+		return err;
+
+	/* second half of xts-key is for tweak */
+	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
+				  key + keylen, keylen);
+}
+
+static int xts_crypt(struct skcipher_request *req, bool encrypt)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+	int err;
+
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   blocks * AES_BLOCK_SIZE, req->iv);
+		req = &subreq;
+		err = skcipher_walk_virt(&walk, req, false);
+	} else {
+		tail = 0;
+	}
+
+	kernel_fpu_begin();
+
+	/* calculate first value of T */
+	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
+
+	while (walk.nbytes > 0) {
+		int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+
+		if (encrypt)
+			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+					  walk.dst.virt.addr, walk.src.virt.addr,
+					  nbytes, walk.iv);
+		else
+			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+					  walk.dst.virt.addr, walk.src.virt.addr,
+					  nbytes, walk.iv);
+		kernel_fpu_end();
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+
+		if (walk.nbytes > 0)
+			kernel_fpu_begin();
+	}
+
+	if (unlikely(tail > 0 && !err)) {
+		struct scatterlist sg_src[2], sg_dst[2];
+		struct scatterlist *src, *dst;
+
+		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->dst != req->src)
+			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+
+		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+					   req->iv);
+
+		err = skcipher_walk_virt(&walk, &subreq, false);
+		if (err)
+			return err;
+
+		kernel_fpu_begin();
+		if (encrypt)
+			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+					  walk.dst.virt.addr, walk.src.virt.addr,
+					  walk.nbytes, walk.iv);
+		else
+			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+					  walk.dst.virt.addr, walk.src.virt.addr,
+					  walk.nbytes, walk.iv);
+		kernel_fpu_end();
+
+		err = skcipher_walk_done(&walk, 0);
+	}
+	return err;
+}
+
+static int xts_encrypt(struct skcipher_request *req)
+{
+	return xts_crypt(req, true);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	return xts_crypt(req, false);
+}
+
 static struct crypto_alg aesni_cipher_alg = {
 	.cra_name		= "aes",
 	.cra_driver_name	= "aes-aesni",
@@ -991,6 +1019,7 @@ static struct skcipher_alg aesni_skciphers[] = {
 		.setkey		= aesni_skcipher_setkey,
 		.encrypt	= ctr_crypt,
 		.decrypt	= ctr_crypt,
+#endif
 	}, {
 		.base = {
 			.cra_name		= "__xts(aes)",
@@ -1004,10 +1033,10 @@ static struct skcipher_alg aesni_skciphers[] = {
 		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
 		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
 		.ivsize		= AES_BLOCK_SIZE,
+		.walksize	= 2 * AES_BLOCK_SIZE,
 		.setkey		= xts_aesni_setkey,
 		.encrypt	= xts_encrypt,
 		.decrypt	= xts_decrypt,
-#endif
 	}
 };
 
-- 
2.17.1

