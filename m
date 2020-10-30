Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60229FE16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJ3GyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:54:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60550 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJ3GyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:54:06 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kYOIO-0004wp-1U; Fri, 30 Oct 2020 17:53:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Oct 2020 17:53:56 +1100
Date:   Fri, 30 Oct 2020 17:53:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] crypto: lib/sha256 - cleanup/optimization
Message-ID: <20201030065355.GJ25453@gondor.apana.org.au>
References: <20201025143119.1054168-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025143119.1054168-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 10:31:13AM -0400, Arvind Sankar wrote:
> Patch 1/2 -- Use memzero_explicit() instead of structure assignment/plain
> memset() to clear sensitive state.
> 
> Patch 3 -- Currently the temporary variables used in the generic sha256
> implementation are cleared, but the clearing is optimized away due to
> lack of compiler barriers. Drop the clearing.
> 
> The last three patches are optimizations for generic sha256.
> 
> v4:
> - Split the first patch into two, the first one just does
>   lib/crypto/sha256.c, so that the second one can be applied or dropped
>   depending on the outcome of the discussion between Herbert/Eric.
> 
> v3:
> - Add some more files to patch 1
> - Reword commit message for patch 2
> - Reformat SHA256_K array
> - Drop v2 patch combining K and W arrays
> 
> v2:
> - Add patch to combine K and W arrays, suggested by David
> - Reformat SHA256_ROUND() macro a little
> 
> Arvind Sankar (6):
>   crypto: lib/sha256 - Use memzero_explicit() for clearing state
>   crypto: Use memzero_explicit() for clearing state
>   crypto: lib/sha256 - Don't clear temporary variables
>   crypto: lib/sha256 - Clear W[] in sha256_update() instead of
>     sha256_transform()
>   crypto: lib/sha256 - Unroll SHA256 loop 8 times intead of 64
>   crypto: lib/sha256 - Unroll LOAD and BLEND loops
> 
>  arch/arm64/crypto/ghash-ce-glue.c |   2 +-
>  arch/arm64/crypto/poly1305-glue.c |   2 +-
>  arch/arm64/crypto/sha3-ce-glue.c  |   2 +-
>  arch/x86/crypto/poly1305_glue.c   |   2 +-
>  include/crypto/sha1_base.h        |   3 +-
>  include/crypto/sha256_base.h      |   3 +-
>  include/crypto/sha512_base.h      |   3 +-
>  include/crypto/sm3_base.h         |   3 +-
>  lib/crypto/sha256.c               | 212 +++++++++---------------------
>  9 files changed, 76 insertions(+), 156 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
