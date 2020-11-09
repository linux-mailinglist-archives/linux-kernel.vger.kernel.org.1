Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAF2AC502
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgKITb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:31:26 -0500
Received: from m12-11.163.com ([220.181.12.11]:36223 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbgKITbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0iIID
        rsAAd6ZlProAR/BEwLdmUB8WfQn7MfRHYskj1I=; b=bbjDPXFV4CF7JxZB5ejq/
        kIoUQAkv43gIzS9tq0v1oF82Hk7wbreBGrwJa2n0LtSrJnJFP7oswq7LTYTepuQN
        SwHZ5zoPYVbSvc00VZYybFcAHBRMVRa56nV9KurCs6Pcr+gLcw9IGB2zSJYgnj22
        U1cB1SFlWBvEHZ0ozKZxbA=
Received: from localhost.localdomain (unknown [120.229.59.65])
        by smtp7 (Coremail) with SMTP id C8CowAAXi6H3mKlfLORZAw--.53711S4;
        Tue, 10 Nov 2020 03:31:09 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 3/3] lib: lzo: Improves decompression performance
Date:   Tue, 10 Nov 2020 03:28:59 +0800
Message-Id: <20201109192859.14267-1-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109191601.14053-1-zengzhaoxiu@163.com>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAXi6H3mKlfLORZAw--.53711S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3trWrJF1DCw1xCryUZFb_yoWrZw4UpF
        nIkF9Fyr1fW3W5JayagF1UG3y5K393Kr13C3y7GrZ2v34aqr9IvFyDtrnaqFWDWFykZFWj
        kw45Gr1a9w4rX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYVbkUUUUU=
X-Originating-IP: [120.229.59.65]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiNR3XgFrPZk3w5gAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

This patch does:
1. Cleanup code
2. Use the copy_from_back to copy the matched bytes from the back output buffer

I testd on 5.8.18-300.fc33.x86_64.
The performance of the lzo1x_decompress_safe function is improved by about 5%.
If no CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS feature, the performance is improved by 60%!

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 lib/lzo/lzo1x_decompress_safe.c | 140 ++++++++++++++------------------
 1 file changed, 59 insertions(+), 81 deletions(-)

diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_safe.c
index 7892a40cf765..afef64cedc51 100644
--- a/lib/lzo/lzo1x_decompress_safe.c
+++ b/lib/lzo/lzo1x_decompress_safe.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #endif
 #include <asm/unaligned.h>
+#include <asm/copy_from_back.h>
 #include <linux/lzo.h>
 #include "lzodefs.h"
 
@@ -43,7 +44,7 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
 	const unsigned char *ip;
 	size_t t, next;
 	size_t state = 0;
-	const unsigned char *m_pos;
+	size_t dist;
 	const unsigned char * const ip_end = in + in_len;
 	unsigned char * const op_end = out + *out_len;
 
@@ -117,29 +118,31 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
 				}
 				state = 4;
 				continue;
-			} else if (state != 4) {
-				next = t & 3;
-				m_pos = op - 1;
-				m_pos -= t >> 2;
-				m_pos -= *ip++ << 2;
-				TEST_LB(m_pos);
+			}
+
+			next = t & 3;
+			dist  = t >> 2;
+			dist += *ip++ << 2;
+			if (state != 4) {
+				dist += 1;
+				TEST_LB(op - dist);
 				NEED_OP(2);
-				op[0] = m_pos[0];
-				op[1] = m_pos[1];
 				op += 2;
-				goto match_next;
 			} else {
-				next = t & 3;
-				m_pos = op - (1 + M2_MAX_OFFSET);
-				m_pos -= t >> 2;
-				m_pos -= *ip++ << 2;
-				t = 3;
+				dist += (1 + M2_MAX_OFFSET);
+				TEST_LB(op - dist);
+				NEED_OP(3);
+				op += 3;
+				op[-3] = op[-3 - dist];
 			}
+			op[-2] = op[-2 - dist];
+			op[-1] = op[-1 - dist];
+			goto match_next;
 		} else if (t >= 64) {
 			next = t & 3;
-			m_pos = op - 1;
-			m_pos -= (t >> 2) & 7;
-			m_pos -= *ip++ << 3;
+			dist = 1;
+			dist += (t >> 2) & 7;
+			dist += *ip++ << 3;
 			t = (t >> 5) - 1 + (3 - 1);
 		} else if (t >= 32) {
 			t = (t & 31) + (3 - 1);
@@ -159,14 +162,15 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
 				t += offset + 31 + *ip++;
 				NEED_IP(2);
 			}
-			m_pos = op - 1;
+			dist = 1;
 			next = get_unaligned_le16(ip);
 			ip += 2;
-			m_pos -= next >> 2;
+			dist += next >> 2;
 			next &= 3;
 		} else {
 			NEED_IP(2);
 			next = get_unaligned_le16(ip);
+
 			if (((next & 0xfffc) == 0xfffc) &&
 			    ((t & 0xf8) == 0x18) &&
 			    likely(bitstream_version)) {
@@ -180,74 +184,48 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
 				next &= 3;
 				ip += 3;
 				goto match_next;
-			} else {
-				m_pos = op;
-				m_pos -= (t & 8) << 11;
-				t = (t & 7) + (3 - 1);
-				if (unlikely(t == 2)) {
-					size_t offset;
-					const unsigned char *ip_last = ip;
+			}
 
-					while (unlikely(*ip == 0)) {
-						ip++;
-						NEED_IP(1);
-					}
-					offset = ip - ip_last;
-					if (unlikely(offset > MAX_255_COUNT))
-						return LZO_E_ERROR;
+			dist = (t & 8) << 11;
+			t = (t & 7) + (3 - 1);
+			if (unlikely(t == 2)) {
+				size_t offset;
+				const unsigned char *ip_last = ip;
 
-					offset = (offset << 8) - offset;
-					t += offset + 7 + *ip++;
-					NEED_IP(2);
-					next = get_unaligned_le16(ip);
+				while (unlikely(*ip == 0)) {
+					ip++;
+					NEED_IP(1);
 				}
-				ip += 2;
-				m_pos -= next >> 2;
-				next &= 3;
-				if (m_pos == op)
-					goto eof_found;
-				m_pos -= 0x4000;
+				offset = ip - ip_last;
+				if (unlikely(offset > MAX_255_COUNT))
+					return LZO_E_ERROR;
+
+				offset = (offset << 8) - offset;
+				t += offset + 7 + *ip++;
+				NEED_IP(2);
+				next = get_unaligned_le16(ip);
 			}
+			ip += 2;
+			dist += next >> 2;
+			if (dist == 0)
+				goto eof_found;
+			dist += M3_MAX_OFFSET;
+			next &= 3;
 		}
-		TEST_LB(m_pos);
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
-		if (op - m_pos >= 8) {
-			unsigned char *oe = op + t;
-			if (likely(HAVE_OP(t + 15))) {
-				do {
-					COPY8(op, m_pos);
-					op += 8;
-					m_pos += 8;
-					COPY8(op, m_pos);
-					op += 8;
-					m_pos += 8;
-				} while (op < oe);
-				op = oe;
-				if (HAVE_IP(6)) {
-					state = next;
-					COPY4(op, ip);
-					op += next;
-					ip += next;
-					continue;
-				}
-			} else {
-				NEED_OP(t);
-				do {
-					*op++ = *m_pos++;
-				} while (op < oe);
+		TEST_LB(op - dist);
+		if (likely(HAVE_OP(t + FAST_COPY_SAFEGUARD_SIZE))) {
+			/* very common case */
+			op = copy_from_back_fast(op, dist, t);
+			if (HAVE_IP(6)) {
+				state = next;
+				COPY4(op, ip);
+				op += next;
+				ip += next;
+				continue;
 			}
-		} else
-#endif
-		{
-			unsigned char *oe = op + t;
+		} else {
 			NEED_OP(t);
-			op[0] = m_pos[0];
-			op[1] = m_pos[1];
-			op += 2;
-			m_pos += 2;
-			do {
-				*op++ = *m_pos++;
-			} while (op < oe);
+			op = copy_from_back(op, dist, t);
 		}
 match_next:
 		state = next;
-- 
2.28.0


