Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224EE2EECA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 05:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhAHEnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:43:55 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:40388 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbhAHEnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:43:55 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kxjcB-0006jz-BN; Fri, 08 Jan 2021 15:43:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jan 2021 15:43:07 +1100
Date:   Fri, 8 Jan 2021 15:43:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tero Kristo <t-kristo@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: omap-sham - Fix link error without crypto-engine
Message-ID: <20210108044307.GD12339@gondor.apana.org.au>
References: <20210103140318.3902174-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103140318.3902174-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 03:03:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver was converted to use the crypto engine helper
> but is missing the corresponding Kconfig statement to ensure
> it is available:
> 
> arm-linux-gnueabi-ld: drivers/crypto/omap-sham.o: in function `omap_sham_probe':
> omap-sham.c:(.text+0x374): undefined reference to `crypto_engine_alloc_init'
> arm-linux-gnueabi-ld: omap-sham.c:(.text+0x384): undefined reference to `crypto_engine_start'
> arm-linux-gnueabi-ld: omap-sham.c:(.text+0x510): undefined reference to `crypto_engine_exit'
> arm-linux-gnueabi-ld: drivers/crypto/omap-sham.o: in function `omap_sham_finish_req':
> omap-sham.c:(.text+0x98c): undefined reference to `crypto_finalize_hash_request'
> arm-linux-gnueabi-ld: omap-sham.c:(.text+0x9a0): undefined reference to `crypto_transfer_hash_request_to_engine'
> arm-linux-gnueabi-ld: drivers/crypto/omap-sham.o: in function `omap_sham_update':
> omap-sham.c:(.text+0xf24): undefined reference to `crypto_transfer_hash_request_to_engine'
> arm-linux-gnueabi-ld: drivers/crypto/omap-sham.o: in function `omap_sham_final':
> omap-sham.c:(.text+0x1020): undefined reference to `crypto_transfer_hash_request_to_engine'
> 
> Fixes: 133c3d434d91 ("crypto: omap-sham - convert to use crypto engine")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
