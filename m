Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8E27748C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgIXO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:58:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgIXO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEtGnj037479;
        Thu, 24 Sep 2020 14:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=VJyk/H2s9dDWeqPz/Xhx7qOnjD9xCnM1/44obMCXtFQ=;
 b=kX6ueIyp4SVt52upchUJrxzu7FHQ0xT74oC3QL5lhVkRTFND6nN7NKypsp5fUsJDf9pk
 958nmSRZVe9Uzex2aTzmQ57Zr83VBw8HEm0VZ7OSGJ2kRX4VuK1WxonM0IXjzUWoeBzi
 +uUwjKyxRVOC5rZnIgopDVYDLrOXjsyBYHDvF9PvwKIf+HO+wyf4srOQXCvON7UvG3iM
 EW5CVXAIx95W1opZCIZf9m0KhrjCqt8DPym2k6161BPygIbW8yKCdeGqbmL+F8nc+/Gz
 nDemT3/HIfxX4drL+lE+M0QtjKTHBDGBCuUIBDc9lcwiA7rrh/hMCFv4ev6p48dqQK0i xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgq57x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 14:58:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEuTGG126226;
        Thu, 24 Sep 2020 14:58:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33nujr18a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OEwAkv002765;
        Thu, 24 Sep 2020 14:58:10 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:10 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 03/13] x86: Add early SHA support for Secure Launch early measurements
Date:   Thu, 24 Sep 2020 10:58:31 -0400
Message-Id: <1600959521-24158-4-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=2 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SHA algorithms are necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA libraries directly in
the code since the compressed kernel is not uncompressed at this point.

The SHA code here has its origins in the code from the main kernel. That
code could not be pulled directly into the setup portion of the compressed
kernel because of other dependencies it pulls in. The result is this is a
modified copy of that code that still leverages the core SHA algorithms.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile       |   4 +
 arch/x86/boot/compressed/early_sha1.c   | 104 ++++++++++++++++
 arch/x86/boot/compressed/early_sha1.h   |  17 +++
 arch/x86/boot/compressed/early_sha256.c |   6 +
 arch/x86/boot/compressed/early_sha512.c |   6 +
 include/linux/sha512.h                  |  21 ++++
 lib/sha1.c                              |   4 +
 lib/sha512.c                            | 209 ++++++++++++++++++++++++++++++++
 8 files changed, 371 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/early_sha512.c
 create mode 100644 include/linux/sha512.h
 create mode 100644 lib/sha512.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index ff7894f..0fd84b9 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -96,6 +96,10 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
+
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
 # it is executed as-is without any ELF relocation processing performed
diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
new file mode 100644
index 0000000..198c46d
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ * Copyright (c) 2020 Apertus Solutions, LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/unaligned.h>
+
+#include "early_sha1.h"
+
+#define SHA1_DISABLE_EXPORT
+#include "../../../../lib/sha1.c"
+
+/* The SHA1 implementation in lib/sha1.c was written to get the workspace
+ * buffer as a parameter. This wrapper function provides a container
+ * around a temporary workspace that is cleared after the transform completes.
+ */
+static void __sha_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	memset(ws, 0, sizeof(ws));
+	/*
+	 * As this is cryptographic code, prevent the memset 0 from being
+	 * optimized out potentially leaving secrets in memory.
+	 */
+	wmb();
+
+}
+
+void early_sha1_init(struct sha1_state *sctx)
+{
+	sha1_init(sctx->state);
+	sctx->count = 0;
+}
+
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA1_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, data, p);
+			data += p;
+			len -= p;
+
+			__sha_transform(sctx->state, sctx->buffer);
+		}
+
+		blocks = len / SHA1_BLOCK_SIZE;
+		len %= SHA1_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				__sha_transform(sctx->state, data);
+				data += SHA1_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+
+	if (len)
+		memcpy(sctx->buffer + partial, data, len);
+}
+
+void early_sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
diff --git a/arch/x86/boot/compressed/early_sha1.h b/arch/x86/boot/compressed/early_sha1.h
new file mode 100644
index 0000000..8e19f13
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_SHA1_H
+#define BOOT_COMPRESSED_EARLY_SHA1_H
+
+#include <crypto/sha.h>
+
+void early_sha1_init(struct sha1_state *sctx);
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len);
+void early_sha1_final(struct sha1_state *sctx, u8 *out);
+
+#endif /* BOOT_COMPRESSED_EARLY_SHA1_H */
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 0000000..20cdc43
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
diff --git a/arch/x86/boot/compressed/early_sha512.c b/arch/x86/boot/compressed/early_sha512.c
new file mode 100644
index 0000000..d352c55
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha512.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/sha512.c"
diff --git a/include/linux/sha512.h b/include/linux/sha512.h
new file mode 100644
index 0000000..d562237
--- /dev/null
+++ b/include/linux/sha512.h
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (C) 2020 Apertus Solutions, LLC
+ *
+ *  Author: Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#ifndef SHA512_H
+#define SHA512_H
+
+#include <linux/types.h>
+#include <crypto/sha.h>
+
+extern int sha512_init(struct sha512_state *sctx);
+extern int sha512_update(struct sha512_state *sctx, const u8 *input,
+			 unsigned int length);
+extern int sha512_final(struct sha512_state *sctx, u8 *hash);
+
+#endif /* SHA512_H */
diff --git a/lib/sha1.c b/lib/sha1.c
index 49257a9..f4efe6f 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -187,7 +187,9 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	digest[3] += D;
 	digest[4] += E;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_transform);
+#endif
 
 /**
  * sha1_init - initialize the vectors for a SHA1 digest
@@ -201,4 +203,6 @@ void sha1_init(__u32 *buf)
 	buf[3] = 0x10325476;
 	buf[4] = 0xc3d2e1f0;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_init);
+#endif
diff --git a/lib/sha512.c b/lib/sha512.c
new file mode 100644
index 0000000..7f91d83
--- /dev/null
+++ b/lib/sha512.c
@@ -0,0 +1,209 @@
+/* SHA-512 code by Jean-Luc Cooke <jlcooke@certainkey.com>
+ *
+ * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) 2003 Kyle McMartin <kyle@debian.org>
+ * Copyright (C) 2015 Linaro Ltd <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2020 Apertus Solutions, LLC <dpsmith@apertussolutions.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ */
+#include <linux/bitops.h>
+#include <linux/sha512.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+#include <asm/unaligned.h>
+
+static inline u64 Ch(u64 x, u64 y, u64 z)
+{
+        return z ^ (x & (y ^ z));
+}
+
+static inline u64 Maj(u64 x, u64 y, u64 z)
+{
+        return (x & y) | (z & (x | y));
+}
+
+static const u64 sha512_K[80] = {
+        0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
+        0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+        0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
+        0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+        0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
+        0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+        0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
+        0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+        0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
+        0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+        0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
+        0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+        0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
+        0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+        0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
+        0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+        0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
+        0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+        0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
+        0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+        0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
+        0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+        0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
+        0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+        0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
+        0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+        0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
+};
+
+#define e0(x)       (ror64(x,28) ^ ror64(x,34) ^ ror64(x,39))
+#define e1(x)       (ror64(x,14) ^ ror64(x,18) ^ ror64(x,41))
+#define s0(x)       (ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7))
+#define s1(x)       (ror64(x,19) ^ ror64(x,61) ^ (x >> 6))
+
+static inline void LOAD_OP(int I, u64 *W, const u8 *input)
+{
+	W[I] = get_unaligned_be64((__u64 *)input + I);
+}
+
+static inline void BLEND_OP(int I, u64 *W)
+{
+	W[I & 15] += s1(W[(I-2) & 15]) + W[(I-7) & 15] + s0(W[(I-15) & 15]);
+}
+
+static void sha512_transform(u64 *state, const u8 *input)
+{
+	u64 a, b, c, d, e, f, g, h, t1, t2;
+
+	int i;
+	u64 W[16];
+
+	/* load the state into our registers */
+	a=state[0];   b=state[1];   c=state[2];   d=state[3];
+	e=state[4];   f=state[5];   g=state[6];   h=state[7];
+
+	/* now iterate */
+	for (i=0; i<80; i+=8) {
+		if (!(i & 8)) {
+			int j;
+
+			if (i < 16) {
+				/* load the input */
+				for (j = 0; j < 16; j++)
+					LOAD_OP(i + j, W, input);
+			} else {
+				for (j = 0; j < 16; j++) {
+					BLEND_OP(i + j, W);
+				}
+			}
+		}
+
+		t1 = h + e1(e) + Ch(e,f,g) + sha512_K[i  ] + W[(i & 15)];
+		t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+		t1 = g + e1(d) + Ch(d,e,f) + sha512_K[i+1] + W[(i & 15) + 1];
+		t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+		t1 = f + e1(c) + Ch(c,d,e) + sha512_K[i+2] + W[(i & 15) + 2];
+		t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+		t1 = e + e1(b) + Ch(b,c,d) + sha512_K[i+3] + W[(i & 15) + 3];
+		t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+		t1 = d + e1(a) + Ch(a,b,c) + sha512_K[i+4] + W[(i & 15) + 4];
+		t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+		t1 = c + e1(h) + Ch(h,a,b) + sha512_K[i+5] + W[(i & 15) + 5];
+		t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+		t1 = b + e1(g) + Ch(g,h,a) + sha512_K[i+6] + W[(i & 15) + 6];
+		t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+		t1 = a + e1(f) + Ch(f,g,h) + sha512_K[i+7] + W[(i & 15) + 7];
+		t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	}
+
+	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
+	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
+
+	/* erase our data */
+	a = b = c = d = e = f = g = h = t1 = t2 = 0;
+}
+
+int sha512_init(struct sha512_state *sctx)
+{
+	sctx->state[0] = SHA512_H0;
+	sctx->state[1] = SHA512_H1;
+	sctx->state[2] = SHA512_H2;
+	sctx->state[3] = SHA512_H3;
+	sctx->state[4] = SHA512_H4;
+	sctx->state[5] = SHA512_H5;
+	sctx->state[6] = SHA512_H6;
+	sctx->state[7] = SHA512_H7;
+	sctx->count[0] = sctx->count[1] = 0;
+
+	return 0;
+}
+
+int sha512_update(struct sha512_state *sctx, const u8 *data, unsigned int len)
+{
+	unsigned int partial = sctx->count[0] % SHA512_BLOCK_SIZE;
+
+	sctx->count[0] += len;
+	if (sctx->count[0] < len)
+		sctx->count[1]++;
+
+	if (likely((partial + len) >= SHA512_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA512_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buf + partial, data, p);
+			data += p;
+			len -= p;
+
+			sha512_transform(sctx->state, sctx->buf);
+		}
+
+		blocks = len / SHA512_BLOCK_SIZE;
+		len %= SHA512_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				sha512_transform(sctx->state, data);
+				data += SHA512_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+	if (len)
+		memcpy(sctx->buf + partial, data, len);
+
+	return 0;
+}
+
+int sha512_final(struct sha512_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA512_BLOCK_SIZE - sizeof(__be64[2]);
+	__be64 *bits = (__be64 *)(sctx->buf + bit_offset);
+	__be64 *digest = (__be64 *)out;
+	unsigned int partial = sctx->count[0] % SHA512_BLOCK_SIZE;
+	unsigned int digest_size = SHA512_DIGEST_SIZE;
+	int i;
+
+	sctx->buf[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buf + partial, 0x0, SHA512_BLOCK_SIZE - partial);
+		partial = 0;
+
+		sha512_transform(sctx->state, sctx->buf);
+	}
+
+	memset(sctx->buf + partial, 0x0, bit_offset - partial);
+	bits[0] = cpu_to_be64(sctx->count[1] << 3 | sctx->count[0] >> 61);
+	bits[1] = cpu_to_be64(sctx->count[0] << 3);
+	sha512_transform(sctx->state, sctx->buf);
+
+	for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be64))
+		put_unaligned_be64(sctx->state[i], digest++);
+
+	*sctx = (struct sha512_state){};
+	return 0;
+}
-- 
1.8.3.1

