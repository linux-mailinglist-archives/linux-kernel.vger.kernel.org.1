Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70966265970
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgIKGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 02:37:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58878 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgIKGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:36:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGcff-0007aQ-Uo; Fri, 11 Sep 2020 16:36:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:36:31 +1000
Date:   Fri, 11 Sep 2020 16:36:31 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 09/18] crypto: sun8i-ce: split into
 prepare/run/unprepare
Message-ID: <20200911063631.GA19560@gondor.apana.org.au>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
 <1599217803-29755-10-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599217803-29755-10-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:09:54AM +0000, Corentin Labbe wrote:
>
> +static int sun8i_ce_cipher_unprepare(struct crypto_engine *engine, void *async_req)
> +{
> +	struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
> +	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> +	struct sun8i_ce_dev *ce = op->ce;
> +	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
> +	struct sun8i_ce_flow *chan;
> +	struct ce_task *cet;
> +	unsigned int ivsize, offset;
> +	int nr_sgs = rctx->nr_sgs;
> +	int nr_sgd = rctx->nr_sgd;
> +	int flow;
> +
> +	flow = rctx->flow;
> +	chan = &ce->chanlist[flow];
> +	cet = chan->tl;
> +	ivsize = crypto_skcipher_ivsize(tfm);
> +
> +	if (areq->src == areq->dst) {
> +		dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_BIDIRECTIONAL);
> +	} else {
> +		if (nr_sgs > 0)
> +			dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
> +		dma_unmap_sg(ce->dev, areq->dst, nr_sgd, DMA_FROM_DEVICE);
> +	}
> +
> +	if (areq->iv && ivsize > 0) {
> +		if (cet->t_iv)
> +			dma_unmap_single(ce->dev, cet->t_iv, rctx->ivlen,
> +					 DMA_TO_DEVICE);

This creates a sparse warning:

  CHECK   ../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:311:25: warning: incorrect type in argument 2 (different base types)
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:311:25:    expected unsigned long long [usertype] addr
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:311:25:    got restricted __le32 [usertype] t_iv
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:322:9: warning: incorrect type in argument 2 (different base types)
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:322:9:    expected unsigned long long [usertype] addr
../drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:322:9:    got restricted __le32 [usertype] t_key

Please fix.  Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
