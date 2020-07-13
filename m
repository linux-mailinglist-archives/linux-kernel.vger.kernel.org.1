Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507AC21A049
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGIMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:53:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36114 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:53:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtW3U-0003uz-5c; Thu, 09 Jul 2020 22:53:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:53:36 +1000
Date:   Thu, 9 Jul 2020 22:53:36 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/1] crypto: ux500: hash: Add namespacing to hash_init()
Message-ID: <20200709125335.GA31057@gondor.apana.org.au>
References: <20200629123003.1014387-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629123003.1014387-1-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:30:03PM +0100, Lee Jones wrote:
> A recent change to the Regulator consumer API (which this driver
> utilises) add prototypes for the some suspend functions.  These
> functions require including header file include/linux/suspend.h.
> 
> The following tree of includes affecting this driver will be
> present:
> 
>    In file included from include/linux/elevator.h:6,
>                     from include/linux/blkdev.h:288,
>                     from include/linux/blk-cgroup.h:23,
>                     from include/linux/writeback.h:14,
>                     from include/linux/memcontrol.h:22,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from include/linux/regulator/consumer.h:35,
>                     from drivers/crypto/ux500/hash/hash_core.c:28:
> 
> include/linux/elevator.h pulls in include/linux/hashtable.h which
> contains its own version of hash_init().  This confuses the build
> system and results in the following error (amongst others):
> 
>  drivers/crypto/ux500/hash/hash_core.c:1362:19: error: passing argument 1 of '__hash_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1362 |  return hash_init(req);
> 
> Fix this by namespacing the local hash_init() such that the
> source of confusion is removed.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Ideally this should go into v5.8's -rcs else it runs the risk of
> breaking when Linus pulls everything in for v5.9-rc1.
> 
>  drivers/crypto/ux500/hash/hash_core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Patch applied to ux500 branch.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
