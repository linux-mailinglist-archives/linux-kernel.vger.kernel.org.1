Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADAC1E58B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgE1Hef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 03:34:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35238 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgE1Hef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:34:35 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeD3a-0000ob-Sc; Thu, 28 May 2020 17:34:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 May 2020 17:34:26 +1000
Date:   Thu, 28 May 2020 17:34:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: engine - do not requeue in case of fatal error
Message-ID: <20200528073426.GB32600@gondor.apana.org.au>
References: <1589926645-32686-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589926645-32686-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:17:25AM +0300, Iuliana Prodan wrote:
> Now, in crypto-engine, if hardware queue is full (-ENOSPC),
> requeue request regardless of MAY_BACKLOG flag.
> If hardware throws any other error code (like -EIO, -EINVAL,
> -ENOMEM, etc.) only MAY_BACKLOG requests are enqueued back into
> crypto-engine's queue, since the others can be dropped.
> The latter case can be fatal error, so those cannot be recovered from.
> For example, in CAAM driver, -EIO is returned in case the job descriptor
> is broken, so there is no possibility to fix the job descriptor.
> Therefore, these errors might be fatal error, so we shouldn’t
> requeue the request. This will just be pass back and forth between
> crypto-engine and hardware.
> 
> Fixes: 6a89f492f8e5 ("crypto: engine - support for parallel requests based on retry mechanism")
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  crypto/crypto_engine.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
