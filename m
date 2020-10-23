Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B272977A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbgJWTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:22:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43616 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbgJWTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:22:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id q199so2228158qke.10;
        Fri, 23 Oct 2020 12:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bi7rG0H94VO76zPLa4Hh0/sN75asB3cy5CcRjg5R6zI=;
        b=LV95wACS0FvBwhkzcDPMIkipEhKZJIflYt1uvRDyQdRfrSL1B3YP80qWKdNXDS7+zV
         VVHJr67AeLqBEGwB7Pvr8LbKZA6uM/mZt0SZiavyHl47Wma+6j9z9Re628gVKMNhIJ79
         y+INqCuyBUrNZo4FoUcOE+v9TPdjTAqkDs5WdEqQIf8Zj5K737jrKNGLVjDNpkWFnfeV
         WdS5KlCm1TJFSwUHQgLbMrEfw8TOwbsNUVoILUORlIbHgPtNwaWnArCfNGk/foB2AFuX
         j3uzZbBXXUdFyGTeGPYDCMwuoYeWKmnq8gUYzyzvHxJOSkP5oDPN2FeZ1kD5h1QFbAEi
         fPuA==
X-Gm-Message-State: AOAM532b8R2JrDkU8O9itHCMXir/C3iv5M5L9bjgcUI6Jz2P5BrWYGWD
        ps8vKNcc3KG0PabHGBpeW+M=
X-Google-Smtp-Source: ABdhPJzZ0YAOlaoFKb/Sy7jJeXv9COCoZ28EFLzHBgYJfMmQtu85Qt2AjnFL4nrUYEQ9BmQGrwp4bA==
X-Received: by 2002:a37:aa05:: with SMTP id t5mr3728792qke.126.1603480929063;
        Fri, 23 Oct 2020 12:22:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n199sm1398493qkn.77.2020.10.23.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:22:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 3/5] crypto: lib/sha256 - Clear W[] in sha256_update() instead of sha256_transform()
Date:   Fri, 23 Oct 2020 15:22:01 -0400
Message-Id: <20201023192203.400040-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023192203.400040-1-nivedita@alum.mit.edu>
References: <20201023192203.400040-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temporary W[] array is currently zeroed out once every call to
sha256_transform(), i.e. once every 64 bytes of input data. Moving it to
sha256_update() instead so that it is cleared only once per update can
save about 2-3% of the total time taken to compute the digest, with a
reasonable memset() implementation, and considerably more (~20%) with a
bad one (eg the x86 purgatory currently uses a memset() coded in C).

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 lib/crypto/sha256.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 099cd11f83c1..c6bfeacc5b81 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -43,10 +43,9 @@ static inline void BLEND_OP(int I, u32 *W)
 	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
 }
 
-static void sha256_transform(u32 *state, const u8 *input)
+static void sha256_transform(u32 *state, const u8 *input, u32 *W)
 {
 	u32 a, b, c, d, e, f, g, h, t1, t2;
-	u32 W[64];
 	int i;
 
 	/* load the input */
@@ -200,15 +199,13 @@ static void sha256_transform(u32 *state, const u8 *input)
 
 	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
-
-	/* clear any sensitive info... */
-	memzero_explicit(W, 64 * sizeof(u32));
 }
 
 void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	unsigned int partial, done;
 	const u8 *src;
+	u32 W[64];
 
 	partial = sctx->count & 0x3f;
 	sctx->count += len;
@@ -223,11 +220,13 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 		}
 
 		do {
-			sha256_transform(sctx->state, src);
+			sha256_transform(sctx->state, src, W);
 			done += 64;
 			src = data + done;
 		} while (done + 63 < len);
 
+		memzero_explicit(W, sizeof(W));
+
 		partial = 0;
 	}
 	memcpy(sctx->buf + partial, src, len - done);
-- 
2.26.2

