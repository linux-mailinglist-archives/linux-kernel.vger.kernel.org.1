Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494C029E708
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgJ2JOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:14:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58736 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2JOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:14:53 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kY1kn-0000aA-0t; Thu, 29 Oct 2020 17:49:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Oct 2020 17:49:45 +1100
Date:   Thu, 29 Oct 2020 17:49:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: arm/aes-neonbs - fix usage of cbc(aes) fallback
Message-ID: <20201029064944.GA19977@gondor.apana.org.au>
References: <20201028090320.4222-1-horia.geanta@nxp.com>
 <CAMj1kXGfwuY_uEGT83QpoUZwy9X=6k7zaxHs2kFrdsArKpVpOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGfwuY_uEGT83QpoUZwy9X=6k7zaxHs2kFrdsArKpVpOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:06:58AM +0100, Ard Biesheuvel wrote:
>
> Not sure what is happening here: IIRC the intention was to rely on the
> fact that only the sync cbc(aes) implementation needs the fallback,
> and therefore, allocating a sync skcipher explicitly would avoid this
> recursion.
> 
> Herbert?

It works only if everything is built in.  If cbc is built as a
module then you need Horia's patch to prevent a loop.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
