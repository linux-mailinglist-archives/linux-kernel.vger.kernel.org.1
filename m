Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2D25D245
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgIDHW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 03:22:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42594 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDHWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:22:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE62k-0008TA-Ec; Fri, 04 Sep 2020 17:21:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 17:21:54 +1000
Date:   Fri, 4 Sep 2020 17:21:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiaoliang Pang <dawning.pang@gmail.com>
Cc:     davem@davemloft.net, matthias.bgg@gmail.com, swboyd@chromium.org,
        yuehaibing@huawei.com, tianjia.zhang@linux.alibaba.com,
        ryder.lee@mediatek.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dawning.pang@gmail.com
Subject: Re: [PATCH] cypto: mediatek - fix leaks in mtk_desc_ring_alloc
Message-ID: <20200904072154.GA24603@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903063800.27288-1-dawning.pang@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoliang Pang <dawning.pang@gmail.com> wrote:
> In the init loop, if an error occurs in function 'dma_alloc_coherent',
> then goto the err_cleanup section,
> in the cleanup loop, after run i--, 
> the struct mtk_ring rising[i] will not be released,
> causing a memory leak
> 
> Signed-off-by: Xiaoliang Pang <dawning.pang@gmail.com>
> ---
> drivers/crypto/mediatek/mtk-platform.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
> index 7e3ad085b5bd..05d341e4a696 100644
> --- a/drivers/crypto/mediatek/mtk-platform.c
> +++ b/drivers/crypto/mediatek/mtk-platform.c
> @@ -469,7 +469,7 @@ static int mtk_desc_ring_alloc(struct mtk_cryp *cryp)
>        return 0;
> 
> err_cleanup:
> -       for (; i--; ) {
> +       for (; i >= 0; --i) {

How about a do while loop instead?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
