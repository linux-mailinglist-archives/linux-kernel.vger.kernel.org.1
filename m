Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2469728EF55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgJOJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:24:43 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49307 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgJOJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:24:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UC5QX1p_1602753881;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UC5QX1p_1602753881)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 17:24:41 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: sm2 - remove unnecessary reset operations
Date:   Thu, 15 Oct 2020 17:24:41 +0800
Message-Id: <20201015092441.12939-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an algorithm optimization. The reset operation when
setting the public key is repeated and redundant, so remove it.
At the same time, `sm2_ecc_os2ec()` is optimized to make the
function more simpler and more in line with the Linux code style.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sm2.c | 75 ++++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/crypto/sm2.c b/crypto/sm2.c
index 767e160333f6..b21addc3ac06 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -119,12 +119,6 @@ static void sm2_ec_ctx_deinit(struct mpi_ec_ctx *ec)
 	memset(ec, 0, sizeof(*ec));
 }
 
-static int sm2_ec_ctx_reset(struct mpi_ec_ctx *ec)
-{
-	sm2_ec_ctx_deinit(ec);
-	return sm2_ec_ctx_init(ec);
-}
-
 /* RESULT must have been initialized and is set on success to the
  * point given by VALUE.
  */
@@ -132,55 +126,48 @@ static int sm2_ecc_os2ec(MPI_POINT result, MPI value)
 {
 	int rc;
 	size_t n;
-	const unsigned char *buf;
-	unsigned char *buf_memory;
+	unsigned char *buf;
 	MPI x, y;
 
-	n = (mpi_get_nbits(value)+7)/8;
-	buf_memory = kmalloc(n, GFP_KERNEL);
-	rc = mpi_print(GCRYMPI_FMT_USG, buf_memory, n, &n, value);
-	if (rc) {
-		kfree(buf_memory);
-		return rc;
-	}
-	buf = buf_memory;
+	n = MPI_NBYTES(value);
+	buf = kmalloc(n, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	if (n < 1) {
-		kfree(buf_memory);
-		return -EINVAL;
-	}
-	if (*buf != 4) {
-		kfree(buf_memory);
-		return -EINVAL; /* No support for point compression.  */
-	}
-	if (((n-1)%2)) {
-		kfree(buf_memory);
-		return -EINVAL;
-	}
-	n = (n-1)/2;
+	rc = mpi_print(GCRYMPI_FMT_USG, buf, n, &n, value);
+	if (rc)
+		goto err_freebuf;
+
+	rc = -EINVAL;
+	if (n < 1 || ((n - 1) % 2))
+		goto err_freebuf;
+	/* No support for point compression */
+	if (*buf != 0x4)
+		goto err_freebuf;
+
+	rc = -ENOMEM;
+	n = (n - 1) / 2;
 	x = mpi_read_raw_data(buf + 1, n);
-	if (!x) {
-		kfree(buf_memory);
-		return -ENOMEM;
-	}
+	if (!x)
+		goto err_freebuf;
 	y = mpi_read_raw_data(buf + 1 + n, n);
-	kfree(buf_memory);
-	if (!y) {
-		mpi_free(x);
-		return -ENOMEM;
-	}
+	if (!y)
+		goto err_freex;
 
 	mpi_normalize(x);
 	mpi_normalize(y);
-
 	mpi_set(result->x, x);
 	mpi_set(result->y, y);
 	mpi_set_ui(result->z, 1);
 
-	mpi_free(x);
-	mpi_free(y);
+	rc = 0;
 
-	return 0;
+	mpi_free(y);
+err_freex:
+	mpi_free(x);
+err_freebuf:
+	kfree(buf);
+	return rc;
 }
 
 struct sm2_signature_ctx {
@@ -399,10 +386,6 @@ static int sm2_set_pub_key(struct crypto_akcipher *tfm,
 	MPI a;
 	int rc;
 
-	rc = sm2_ec_ctx_reset(ec);
-	if (rc)
-		return rc;
-
 	ec->Q = mpi_point_new(0);
 	if (!ec->Q)
 		return -ENOMEM;
-- 
2.19.1.3.ge56e4f7

