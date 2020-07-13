Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27FE21CB8B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGLVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 17:14:20 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:47515 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgGLVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:14:19 -0400
Received: from localhost.localdomain ([93.22.148.52])
        by mwinf5d61 with ME
        id 2ME52300f183tQl03ME6PW; Sun, 12 Jul 2020 23:14:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Jul 2020 23:14:16 +0200
X-ME-IP: 93.22.148.52
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ayush.sawal@chelsio.com, vinay.yadav@chelsio.com,
        rohitm@chelsio.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] Crypto/chcr: Avoid some code duplication
Date:   Sun, 12 Jul 2020 23:14:04 +0200
Message-Id: <20200712211404.276211-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling path of 'chcr_authenc_setkey()' is the same as this
error handling code.

So just 'goto out' as done everywhere in the function to simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/chelsio/chcr_algo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 4c2553672b6f..ba2469008dd9 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -3609,9 +3609,7 @@ static int chcr_authenc_setkey(struct crypto_aead *authenc, const u8 *key,
 	base_hash  = chcr_alloc_shash(max_authsize);
 	if (IS_ERR(base_hash)) {
 		pr_err("chcr : Base driver cannot be loaded\n");
-		aeadctx->enckey_len = 0;
-		memzero_explicit(&keys, sizeof(keys));
-		return -EINVAL;
+		goto out;
 	}
 	{
 		SHASH_DESC_ON_STACK(shash, base_hash);
-- 
2.25.1

