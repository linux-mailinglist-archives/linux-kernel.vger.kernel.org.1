Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CE2E0D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgLVQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgLVQI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:08:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA556229C5;
        Tue, 22 Dec 2020 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608653297;
        bh=eUmn2rgHeS02zEG4O/F6YVmzX4zPAOjn5j5y4DgTy1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PACE0NgPN6XYWUhbNsfpYPld2Nz2maKtW+Ab5o2Z/HOBEngstpGaJEoyuTrxxnVft
         tslFLca8RW5gyAOTgLsxwNEeKfDaoxSlK0Ynx7l1l+9vgLM2j7uM430PGbDmyRpjja
         kMNtEHWu9LhGI0rEnrPw9LYJTTDGxQuS+sKp7Lqt+gietb3qAMsM+YUJS4obY8GuzX
         xHaHx9TNyOY/6u8kQ9rF+5Cgs8i3SX1Q50pNBk7nL9M62lpc7sditDYiV5whO99/58
         UyuteTJkPDMiRPYzb5c3KbKo3f+NbA97NEl7RCPtvceK+E24jY/gm+a3yAe3siJmyM
         mrDOuvYG7u9jg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/2] crypto: x86/aes-ni-xts - use direct calls to and 4-way stride
Date:   Tue, 22 Dec 2020 17:06:28 +0100
Message-Id: <20201222160629.22268-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222160629.22268-1-ardb@kernel.org>
References: <20201222160629.22268-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XTS asm helper arrangement is a bit odd: the 8-way stride helper
consists of back-to-back calls to the 4-way core transforms, which
are called indirectly, based on a boolean that indicates whether we
are performing encryption or decryption.

Given how costly indirect calls are on x86, let's switch to direct
calls, and given how the 8-way stride doesn't really add anything
substantial, use a 4-way stride instead, and make the asm core
routine deal with any multiple of 4 blocks. Since 512 byte sectors
or 4 KB blocks are the typical quantities XTS operates on, increase
the stride exported to the glue helper to 512 bytes as well.

As a result, the number of indirect calls is reduced from 3 per 64 bytes
of in/output to 1 per 512 bytes of in/output, which produces a 65% speedup
when operating on 1 KB blocks (measured on a Intel(R) Core(TM) i7-8650U CPU)

Fixes: 9697fa39efd3f ("x86/retpoline/crypto: Convert crypto assembler indirect jumps")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/aesni-intel_asm.S  | 115 ++++++++++++--------
 arch/x86/crypto/aesni-intel_glue.c |  25 +++--
 2 files changed, 84 insertions(+), 56 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index a2710f76862f..84d8a156cdcd 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2842,25 +2842,18 @@ SYM_FUNC_END(aesni_ctr_enc)
 	pxor CTR, IV;
 
 /*
- * void aesni_xts_crypt8(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			 const u8 *src, bool enc, le128 *iv)
+ * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			  const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_crypt8)
+SYM_FUNC_START(aesni_xts_encrypt)
 	FRAME_BEGIN
-	testb %cl, %cl
-	movl $0, %ecx
-	movl $240, %r10d
-	leaq _aesni_enc4, %r11
-	leaq _aesni_dec4, %rax
-	cmovel %r10d, %ecx
-	cmoveq %rax, %r11
 
 	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
 	movups (IVP), IV
 
 	mov 480(KEYP), KLEN
-	addq %rcx, KEYP
 
+.Lxts_enc_loop4:
 	movdqa IV, STATE1
 	movdqu 0x00(INP), INC
 	pxor INC, STATE1
@@ -2884,71 +2877,103 @@ SYM_FUNC_START(aesni_xts_crypt8)
 	pxor INC, STATE4
 	movdqu IV, 0x30(OUTP)
 
-	CALL_NOSPEC r11
+	call _aesni_enc4
 
 	movdqu 0x00(OUTP), INC
 	pxor INC, STATE1
 	movdqu STATE1, 0x00(OUTP)
 
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE1
-	movdqu 0x40(INP), INC
-	pxor INC, STATE1
-	movdqu IV, 0x40(OUTP)
-
 	movdqu 0x10(OUTP), INC
 	pxor INC, STATE2
 	movdqu STATE2, 0x10(OUTP)
 
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE2
-	movdqu 0x50(INP), INC
-	pxor INC, STATE2
-	movdqu IV, 0x50(OUTP)
-
 	movdqu 0x20(OUTP), INC
 	pxor INC, STATE3
 	movdqu STATE3, 0x20(OUTP)
 
-	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE3
-	movdqu 0x60(INP), INC
-	pxor INC, STATE3
-	movdqu IV, 0x60(OUTP)
-
 	movdqu 0x30(OUTP), INC
 	pxor INC, STATE4
 	movdqu STATE4, 0x30(OUTP)
 
 	_aesni_gf128mul_x_ble()
-	movdqa IV, STATE4
-	movdqu 0x70(INP), INC
-	pxor INC, STATE4
-	movdqu IV, 0x70(OUTP)
 
-	_aesni_gf128mul_x_ble()
+	add $64, INP
+	add $64, OUTP
+	sub $64, LEN
+	ja .Lxts_enc_loop4
+
 	movups IV, (IVP)
 
-	CALL_NOSPEC r11
+	FRAME_END
+	ret
+SYM_FUNC_END(aesni_xts_encrypt)
+
+/*
+ * void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			  const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(aesni_xts_decrypt)
+	FRAME_BEGIN
+
+	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(KEYP), KLEN
+	add $240, KEYP
 
-	movdqu 0x40(OUTP), INC
+.Lxts_dec_loop4:
+	movdqa IV, STATE1
+	movdqu 0x00(INP), INC
 	pxor INC, STATE1
-	movdqu STATE1, 0x40(OUTP)
+	movdqu IV, 0x00(OUTP)
 
-	movdqu 0x50(OUTP), INC
+	_aesni_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aesni_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aesni_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	call _aesni_dec4
+
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
 	pxor INC, STATE2
-	movdqu STATE2, 0x50(OUTP)
+	movdqu STATE2, 0x10(OUTP)
 
-	movdqu 0x60(OUTP), INC
+	movdqu 0x20(OUTP), INC
 	pxor INC, STATE3
-	movdqu STATE3, 0x60(OUTP)
+	movdqu STATE3, 0x20(OUTP)
 
-	movdqu 0x70(OUTP), INC
+	movdqu 0x30(OUTP), INC
 	pxor INC, STATE4
-	movdqu STATE4, 0x70(OUTP)
+	movdqu STATE4, 0x30(OUTP)
+
+	_aesni_gf128mul_x_ble()
+
+	add $64, INP
+	add $64, OUTP
+	sub $64, LEN
+	ja .Lxts_dec_loop4
+
+	movups IV, (IVP)
 
 	FRAME_END
 	ret
-SYM_FUNC_END(aesni_xts_crypt8)
+SYM_FUNC_END(aesni_xts_decrypt)
 
 #endif
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 2054cd6f55cf..711cabb4a555 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -101,6 +101,12 @@ asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
 
+asmlinkage void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				  const u8 *in, unsigned int len, u8 *iv);
+
+asmlinkage void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				  const u8 *in, unsigned int len, u8 *iv);
+
 #ifdef CONFIG_X86_64
 
 static void (*aesni_ctr_enc_tfm)(struct crypto_aes_ctx *ctx, u8 *out,
@@ -108,9 +114,6 @@ static void (*aesni_ctr_enc_tfm)(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 
-asmlinkage void aesni_xts_crypt8(const struct crypto_aes_ctx *ctx, u8 *out,
-				 const u8 *in, bool enc, le128 *iv);
-
 /* Scatter / Gather routines, with args similar to above */
 asmlinkage void aesni_gcm_init(void *ctx,
 			       struct gcm_context_data *gdata,
@@ -596,14 +599,14 @@ static void aesni_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_dec);
 }
 
-static void aesni_xts_enc8(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
+static void aesni_xts_enc32(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	aesni_xts_crypt8(ctx, dst, src, true, iv);
+	aesni_xts_encrypt(ctx, dst, src, 32 * AES_BLOCK_SIZE, (u8 *)iv);
 }
 
-static void aesni_xts_dec8(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
+static void aesni_xts_dec32(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	aesni_xts_crypt8(ctx, dst, src, false, iv);
+	aesni_xts_decrypt(ctx, dst, src, 32 * AES_BLOCK_SIZE, (u8 *)iv);
 }
 
 static const struct common_glue_ctx aesni_enc_xts = {
@@ -611,8 +614,8 @@ static const struct common_glue_ctx aesni_enc_xts = {
 	.fpu_blocks_limit = 1,
 
 	.funcs = { {
-		.num_blocks = 8,
-		.fn_u = { .xts = aesni_xts_enc8 }
+		.num_blocks = 32,
+		.fn_u = { .xts = aesni_xts_enc32 }
 	}, {
 		.num_blocks = 1,
 		.fn_u = { .xts = aesni_xts_enc }
@@ -624,8 +627,8 @@ static const struct common_glue_ctx aesni_dec_xts = {
 	.fpu_blocks_limit = 1,
 
 	.funcs = { {
-		.num_blocks = 8,
-		.fn_u = { .xts = aesni_xts_dec8 }
+		.num_blocks = 32,
+		.fn_u = { .xts = aesni_xts_dec32 }
 	}, {
 		.num_blocks = 1,
 		.fn_u = { .xts = aesni_xts_dec }
-- 
2.17.1

