Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA98F27CF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgI2Ni2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:38:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34571 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2Ni0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:38:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kNFpj-0006f8-Ab; Tue, 29 Sep 2020 13:38:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: sun8i-ss@: fix memory leak on pointer d
Date:   Tue, 29 Sep 2020 14:38:19 +0100
Message-Id: <20200929133819.156092-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error return path on a failed dma_mapping_error call
is not kfree'ing memory allocated to d. Add an extra error exit label
to end of the function where the kfree and return occurs to fix this
issue.

Addresses-Coverity: ("Resource leak")
Fixes: ac2614d721de ("crypto: sun8i-ss - Add support for the PRNG")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index 08a1473b2145..42b02720dbbf 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -103,7 +103,8 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	dma_iv = dma_map_single(ss->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
 	if (dma_mapping_error(ss->dev, dma_iv)) {
 		dev_err(ss->dev, "Cannot DMA MAP IV\n");
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_free;
 	}
 
 	dma_dst = dma_map_single(ss->dev, d, todo, DMA_FROM_DEVICE);
@@ -167,6 +168,7 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 		memcpy(ctx->seed, d + dlen, ctx->slen);
 	}
 	memzero_explicit(d, todo);
+err_free:
 	kfree(d);
 
 	return err;
-- 
2.27.0

