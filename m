Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600C427B3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1RyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgI1RyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:54:07 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E980920739;
        Mon, 28 Sep 2020 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601315646;
        bh=eRK9s/qdp7HfBAgb/9dXe02+7LZBsL6ffyU2erZwEFM=;
        h=Date:From:To:Cc:Subject:From;
        b=0dLGNWA5IX9gZnjYZAzBKptuiEXVyZdwEyKIeEyvpzCYz9dSe+7O9FbXIwADMA+PU
         /tTbj3P+yG+3V0zYKqLB1/FHjW+NId+zvcnAkAab12fRCEBLKwcWynNGQXYpR2gsj2
         MHFIhbhI2ew71U2OAButRmh8e2575TGGd9LIKqlM=
Date:   Mon, 28 Sep 2020 12:59:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] crypto: sun8i-ss - Fix memory leak in
 sun8i_ss_prng_generate()
Message-ID: <20200928175945.GA11320@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set _err_ to the return error code -EFAULT before jumping to the new
label err_d, so resources for _d_ can be released before returning
from function sun8i_ss_prng_generate().

Addresses-Coverity-ID: 1497459 ("Resource leak")
Fixes: ac2614d721de ("crypto: sun8i-ss - Add support for the PRNG")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index 08a1473b2145..0573f6289e8b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -103,7 +103,8 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	dma_iv = dma_map_single(ss->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
 	if (dma_mapping_error(ss->dev, dma_iv)) {
 		dev_err(ss->dev, "Cannot DMA MAP IV\n");
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_d;
 	}
 
 	dma_dst = dma_map_single(ss->dev, d, todo, DMA_FROM_DEVICE);
@@ -160,7 +161,7 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	dma_unmap_single(ss->dev, dma_dst, todo, DMA_FROM_DEVICE);
 err_iv:
 	dma_unmap_single(ss->dev, dma_iv, ctx->slen, DMA_TO_DEVICE);
-
+err_d:
 	if (!err) {
 		memcpy(dst, d, dlen);
 		/* Update seed */
-- 
2.27.0

