Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00A724D019
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHUH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:57:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49968 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHUH5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:57:20 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91vB-0003zP-Is; Fri, 21 Aug 2020 17:57:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:57:09 +1000
Date:   Fri, 21 Aug 2020 17:57:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove none supported ciphers
Message-ID: <20200821075709.GG25143@gondor.apana.org.au>
References: <20200805062302.16569-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805062302.16569-1-gilad@benyossef.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:22:59AM +0300, Gilad Ben-Yossef wrote:
> the CryptoCell HW has support for ciphers and modes not supported
> and used at this time by Linux. Remove the code supporting this
> in the ccree ddriver until such time support is added in the kernel.
> 
> Gilad Ben-Yossef (2):
>   crypto: ccree: remove data unit size support
>   crypto: ccree: remove bitlocker cipher
> 
>  drivers/crypto/ccree/cc_cipher.c     | 282 +--------------------------
>  drivers/crypto/ccree/cc_crypto_ctx.h |   1 -
>  drivers/crypto/ccree/cc_driver.h     |   1 -
>  3 files changed, 4 insertions(+), 280 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
