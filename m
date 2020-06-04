Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3661EE450
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFDMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 08:19:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37134 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgFDMTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:19:00 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jgopP-0008CD-Ij; Thu, 04 Jun 2020 22:18:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2020 22:18:35 +1000
Date:   Thu, 4 Jun 2020 22:18:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, phemadri@marvell.com, jsrikanth@marvell.com,
        horia.geanta@nxp.com, gustavo@embeddedor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] crypto: cavium/nitrox - Fix
 'nitrox_get_first_device()' when ndevlist is fully iterated
Message-ID: <20200604121835.GB24286@gondor.apana.org.au>
References: <20200530133537.582843-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530133537.582843-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 03:35:37PM +0200, Christophe JAILLET wrote:
> When a list is completely iterated with 'list_for_each_entry(x, ...)', x is
> not NULL at the end.
> 
> While at it, remove a useless initialization of the ndev variable. It
> is overridden by 'list_for_each_entry'.
> 
> Fixes: f2663872f073 ("crypto: cavium - Register the CNN55XX supported crypto algorithms.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Do not introduce an extra variable to check if the list has been fully
>     iterated. Test with "if (&ndev->list == &ndevlist)" instead
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
