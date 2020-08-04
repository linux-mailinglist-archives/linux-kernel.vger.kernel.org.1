Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847DE23B7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHDJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHDJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:29:37 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF6C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:29:36 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id BMVY230074C55Sk01MVYvk; Tue, 04 Aug 2020 11:29:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2tGF-0005hH-WE; Tue, 04 Aug 2020 11:29:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2tGF-0001wN-Tf; Tue, 04 Aug 2020 11:29:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] crypto: sa2ul - fix pointer cast warning on 32-bit
Date:   Tue,  4 Aug 2020 11:29:27 +0200
Message-Id: <20200804092927.7417-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit:

    drivers/crypto/sa2ul.c: In function ‘sa_sha_init’:
    drivers/crypto/sa2ul.c:1486:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       crypto_ahash_digestsize(tfm), (u64)rctx);
				     ^

Fix this by casting the context pointer to "unsigned long" (which is
either 32-bit or 64-bit, just like pointers) instead of "u64", and
update the format specifier accordingly.
While at it, use "%u" to format unsigned int.

Fixes: 2dc53d0047458e28 ("crypto: sa2ul - add sha1/sha256/sha512 support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Notes:
  1. This (still) reveals the kernel pointer value, which would be
     obfuscated by using "%p",
  2. Perhaps we want to use "%px" instead? But there are no users of
     "%px" in drivers/crypto/.
---
 drivers/crypto/sa2ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 5bc099052bd20b3c..4611ac20405a60cb 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1482,8 +1482,8 @@ static int sa_sha_init(struct ahash_request *req)
 	struct sa_sha_req_ctx *rctx = ahash_request_ctx(req);
 	struct sa_tfm_ctx *ctx = crypto_ahash_ctx(tfm);
 
-	dev_dbg(sa_k3_dev, "init: digest size: %d, rctx=%llx\n",
-		crypto_ahash_digestsize(tfm), (u64)rctx);
+	dev_dbg(sa_k3_dev, "init: digest size: %u, rctx=%lx\n",
+		crypto_ahash_digestsize(tfm), (unsigned long)rctx);
 
 	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback.ahash);
 	rctx->fallback_req.base.flags =
-- 
2.17.1

