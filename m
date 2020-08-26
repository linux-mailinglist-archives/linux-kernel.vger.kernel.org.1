Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6D2534EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZQaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:30:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6AF2074A;
        Wed, 26 Aug 2020 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459401;
        bh=hRr/a/YAnLdURZWW/rmGtbraj2KU8FLUxIgB33GwWXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ugkcwvyy2eF4kcFRRMkgRJ1yQXheRkwuhRoP0kXW++xMfPQHBqdS4QxeP9ZlTQONT
         x2lAaQnOSBlzovndPDpdNWf8pmgDu0qQL8oR6ik/g/LjJAu7UBfJos+yhWxS6yB7MU
         fRi9Soxj1q72tXU7iYl9ouFkd5hOJMJhil8YU++M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] crypto: sa2ul - Hide pointer and fix -Wpointer-to-int-cast in dev_dbg()
Date:   Wed, 26 Aug 2020 18:29:52 +0200
Message-Id: <20200826162954.28636-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should not be printed because they might leak important
information about address space layout.  Use %p to hash the value.  This
also fixes compilation warnings on 32-bit architecture:

    drivers/crypto/sa2ul.c:1486:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/sa2ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 5bc099052bd2..4a950437bf44 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1482,8 +1482,8 @@ static int sa_sha_init(struct ahash_request *req)
 	struct sa_sha_req_ctx *rctx = ahash_request_ctx(req);
 	struct sa_tfm_ctx *ctx = crypto_ahash_ctx(tfm);
 
-	dev_dbg(sa_k3_dev, "init: digest size: %d, rctx=%llx\n",
-		crypto_ahash_digestsize(tfm), (u64)rctx);
+	dev_dbg(sa_k3_dev, "init: digest size: %d, rctx=%p\n",
+		crypto_ahash_digestsize(tfm), rctx);
 
 	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback.ahash);
 	rctx->fallback_req.base.flags =
-- 
2.17.1

