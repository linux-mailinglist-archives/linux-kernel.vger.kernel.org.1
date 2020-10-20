Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F14294402
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438621AbgJTUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:40:15 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34880 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438581AbgJTUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:40:06 -0400
Received: by mail-qv1-f68.google.com with SMTP id cv1so1625255qvb.2;
        Tue, 20 Oct 2020 13:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4iHrcJ2rc/d4t8J47bnne3HGhnZovnOfKdRyGwsHeY=;
        b=e9inG+h6dm2MeCm9d3cQw6B69k/xFgQlhxrJIf9Wv7sUK554tYojv94bbLw0DfxNCM
         8cAnMpUjPktXADX91wZ4X1BYfiJ/FmhiDY7X2AfJ8aHEktkJTqmzl2jLk84wZNuffnp7
         lj1HJzFEsCe7a2QQ3YccBnbvwvKGokz/yz71DwAn4NF9bfCfe5iuN7h17H83RjtJGr/0
         XsYbNiiuJRuBCa+kqgfEN3ac78qAs/+/riiwaRxgHf5P2b4ondBiZO7OCt0IGKPhHYGS
         v6SxrwdRzmTAQvvThIKxM1M2RNnzu1YoKLkS1Hn68rfhr9AY5FyMSER0Ps2SfRfXAKyK
         D7MA==
X-Gm-Message-State: AOAM532kzFPOLGuGlDcsg4dUnEknf1kX0Sj5TepYq3bQlwUjGZg/ZJbc
        pr7D1emoG0wC3J5Efg6YVPQ=
X-Google-Smtp-Source: ABdhPJyPjwvvP07MCczUqR+yKnlaZwC2q2s9w1FlUFPIL6oCrV/ALWC1vfJNUSl0r50rdrFVgUnaCg==
X-Received: by 2002:a05:6214:a94:: with SMTP id ev20mr5343251qvb.4.1603226404443;
        Tue, 20 Oct 2020 13:40:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m18sm1411165qkk.102.2020.10.20.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 13:40:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] crypto: lib/sha256 - Unroll SHA256 loop 8 times intead of 64
Date:   Tue, 20 Oct 2020 16:39:55 -0400
Message-Id: <20201020203957.3512851-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020203957.3512851-1-nivedita@alum.mit.edu>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces code size substantially (on x86_64 with gcc-10 the size of
sha256_update() goes from 7593 bytes to 1952 bytes including the new
SHA256_K array), and on x86 is slightly faster than the full unroll
(tesed on Broadwell Xeon).

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 lib/crypto/sha256.c | 166 ++++++++------------------------------------
 1 file changed, 30 insertions(+), 136 deletions(-)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index c6bfeacc5b81..5efd390706c6 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -18,6 +18,17 @@
 #include <crypto/sha.h>
 #include <asm/unaligned.h>
 
+static const u32 SHA256_K[] = {
+	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
+	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
+	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
+	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
+	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
+	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
+};
+
 static inline u32 Ch(u32 x, u32 y, u32 z)
 {
 	return z ^ (x & (y ^ z));
@@ -43,9 +54,17 @@ static inline void BLEND_OP(int I, u32 *W)
 	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
 }
 
+#define SHA256_ROUND(i, a, b, c, d, e, f, g, h) do {		\
+	u32 t1, t2;						\
+	t1 = h + e1(e) + Ch(e, f, g) + SHA256_K[i] + W[i];	\
+	t2 = e0(a) + Maj(a, b, c);				\
+	d += t1;						\
+	h = t1 + t2;						\
+} while (0)
+
 static void sha256_transform(u32 *state, const u8 *input, u32 *W)
 {
-	u32 a, b, c, d, e, f, g, h, t1, t2;
+	u32 a, b, c, d, e, f, g, h;
 	int i;
 
 	/* load the input */
@@ -61,141 +80,16 @@ static void sha256_transform(u32 *state, const u8 *input, u32 *W)
 	e = state[4];  f = state[5];  g = state[6];  h = state[7];
 
 	/* now iterate */
-	t1 = h + e1(e) + Ch(e, f, g) + 0x428a2f98 + W[0];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x71374491 + W[1];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xb5c0fbcf + W[2];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xe9b5dba5 + W[3];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x3956c25b + W[4];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x59f111f1 + W[5];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x923f82a4 + W[6];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xab1c5ed5 + W[7];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xd807aa98 + W[8];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x12835b01 + W[9];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x243185be + W[10];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x550c7dc3 + W[11];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x72be5d74 + W[12];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x80deb1fe + W[13];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x9bdc06a7 + W[14];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xc19bf174 + W[15];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xe49b69c1 + W[16];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xefbe4786 + W[17];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x0fc19dc6 + W[18];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x240ca1cc + W[19];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x2de92c6f + W[20];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x4a7484aa + W[21];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x5cb0a9dc + W[22];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x76f988da + W[23];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x983e5152 + W[24];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xa831c66d + W[25];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xb00327c8 + W[26];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xbf597fc7 + W[27];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0xc6e00bf3 + W[28];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xd5a79147 + W[29];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x06ca6351 + W[30];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x14292967 + W[31];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x27b70a85 + W[32];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x2e1b2138 + W[33];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x4d2c6dfc + W[34];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x53380d13 + W[35];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x650a7354 + W[36];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x766a0abb + W[37];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x81c2c92e + W[38];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x92722c85 + W[39];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xa2bfe8a1 + W[40];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xa81a664b + W[41];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xc24b8b70 + W[42];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xc76c51a3 + W[43];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0xd192e819 + W[44];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xd6990624 + W[45];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0xf40e3585 + W[46];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x106aa070 + W[47];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x19a4c116 + W[48];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x1e376c08 + W[49];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x2748774c + W[50];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x34b0bcb5 + W[51];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x391c0cb3 + W[52];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x4ed8aa4a + W[53];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x5b9cca4f + W[54];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x682e6ff3 + W[55];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x748f82ee + W[56];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x78a5636f + W[57];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x84c87814 + W[58];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x8cc70208 + W[59];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x90befffa + W[60];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xa4506ceb + W[61];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0xbef9a3f7 + W[62];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xc67178f2 + W[63];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
+	for (i = 0; i < 64; i += 8) {
+		SHA256_ROUND(i + 0, a, b, c, d, e, f, g, h);
+		SHA256_ROUND(i + 1, h, a, b, c, d, e, f, g);
+		SHA256_ROUND(i + 2, g, h, a, b, c, d, e, f);
+		SHA256_ROUND(i + 3, f, g, h, a, b, c, d, e);
+		SHA256_ROUND(i + 4, e, f, g, h, a, b, c, d);
+		SHA256_ROUND(i + 5, d, e, f, g, h, a, b, c);
+		SHA256_ROUND(i + 6, c, d, e, f, g, h, a, b);
+		SHA256_ROUND(i + 7, b, c, d, e, f, g, h, a);
+	}
 
 	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
-- 
2.26.2

