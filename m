Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6E2D73B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405109AbgLKKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:15:43 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33428 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731920AbgLKKPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:15:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knfR7-0004wZ-4m; Fri, 11 Dec 2020 21:14:06 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Dec 2020 21:14:05 +1100
Date:   Fri, 11 Dec 2020 21:14:05 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Keerthy <j-keerthy@ti.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-i2c - select CONFIG_BITREVERSE
Message-ID: <20201211101405.GC3266@gondor.apana.org.au>
References: <20201203232022.1485386-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203232022.1485386-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:20:04AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The bitreverse helper is almost always built into the kernel,
> but in a rare randconfig build it is possible to hit a case
> in which it is a loadable module while the atmel-i2c driver
> is built-in:
> 
> arm-linux-gnueabi-ld: drivers/crypto/atmel-i2c.o: in function `atmel_i2c_checksum':
> atmel-i2c.c:(.text+0xa0): undefined reference to `byte_rev_table'
> 
> Add one more 'select' statement to prevent this.
> 
> Fixes: 11105693fa05 ("crypto: atmel-ecc - introduce Microchip / Atmel ECC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
