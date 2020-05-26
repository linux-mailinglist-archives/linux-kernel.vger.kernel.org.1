Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A701D45C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEOGVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 02:21:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34332 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgEOGVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:21:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jZTiL-0007Ua-GG; Fri, 15 May 2020 16:20:58 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2020 16:20:57 +1000
Date:   Fri, 15 May 2020 16:20:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Sterba <dsterba@suse.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] crypto: blake2b - Fix clang optimization for ARMv7-M
Message-ID: <20200515062057.GA22330@gondor.apana.org.au>
References: <20200505135402.29356-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505135402.29356-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:53:45PM +0200, Arnd Bergmann wrote:
> When building for ARMv7-M, clang-9 or higher tries to unroll some loops,
> which ends up confusing the register allocator to the point of generating
> rather bad code and using more than the warning limit for stack frames:
> 
> warning: stack frame size of 1200 bytes in function 'blake2b_compress' [-Wframe-larger-than=]
> 
> Forcing it to not unroll the final loop avoids this problem.
> 
> Fixes: 91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/blake2b_generic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
