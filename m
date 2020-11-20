Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF92BA2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:59:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34268 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgKTG7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:59:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg0Nj-0007mN-I4; Fri, 20 Nov 2020 17:58:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:58:55 +1100
Date:   Fri, 20 Nov 2020 17:58:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     dan.carpenter@oracle.com, davem@davemloft.net,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: allwinner: sun8i-ce: fix two error path's memory
 leak
Message-ID: <20201120065855.GI20581@gondor.apana.org.au>
References: <20201115190807.12251-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115190807.12251-1-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 07:08:07PM +0000, Corentin Labbe wrote:
> This patch fixes the following smatch warnings:
> drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c:412
> sun8i_ce_hash_run() warn: possible memory leak of 'result'
> Note: "buf" is leaked as well.
> 
> Furthermore, in case of ENOMEM, crypto_finalize_hash_request() was not
> called which was an error.
> 
> Fixes: 56f6d5aee88d ("crypto: sun8i-ce - support hash algorithms")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
