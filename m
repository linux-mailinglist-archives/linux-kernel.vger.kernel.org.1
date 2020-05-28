Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BD1E5795
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgE1Ge3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 02:34:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34684 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1Ge2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:34:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeC6w-0007mj-Vx; Thu, 28 May 2020 16:33:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 May 2020 16:33:50 +1000
Date:   Thu, 28 May 2020 16:33:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, jsrikanth@marvell.com, phemadri@marvell.com,
        gustavo@embeddedor.com, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/nitrox - Fix 'nitrox_get_first_device()'
 when ndevlist is fully iterated
Message-ID: <20200528063350.GA26818@gondor.apana.org.au>
References: <20200519204503.281872-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519204503.281872-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:45:03PM +0200, Christophe JAILLET wrote:
> When a list is completely iterated with 'list_for_each_entry(x, ...)', x is
> not NULL at the end.
> 
> Introduce an intermediate variable and test it instead, in order to
> reliably know if something was found or not.
> 
> Fixes: f2663872f073 ("crypto: cavium - Register the CNN55XX supported crypto algorithms.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> index 788c6607078b..172cafe7c039 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -278,15 +278,18 @@ static void nitrox_remove_from_devlist(struct nitrox_device *ndev)
>  
>  struct nitrox_device *nitrox_get_first_device(void)
>  {
> -	struct nitrox_device *ndev = NULL;
> +	struct nitrox_device *ndev;
> +	bool found = false;
>  
>  	mutex_lock(&devlist_lock);
>  	list_for_each_entry(ndev, &ndevlist, list) {
> -		if (nitrox_ready(ndev))
> +		if (nitrox_ready(ndev)) {
> +			found = true;
>  			break;
> +		}
>  	}
>  	mutex_unlock(&devlist_lock);
> -	if (!ndev)

Instead of adding found, you could fix this by changing the test to

	if (&ndev->list == &nevlist)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
