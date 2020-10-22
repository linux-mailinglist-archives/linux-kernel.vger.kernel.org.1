Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A57295750
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443809AbgJVEew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443637AbgJVEew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:34:52 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F351223C7;
        Thu, 22 Oct 2020 04:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603341291;
        bh=4RFKpKTybK0+7IbTiZ4/o8wJ6wA1YQaEI0tXTaHkFVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnFSHJ38zJo1RdA4AjmDWrmZQ+/uINlWodyNe/dXsTyY0NP0bDu1x44CbOf2MYQbX
         NkyBCa6ulHWqeGSYS+TY47JP9SjLECyqbn2aZBRmRtwlwZgmLQqjhExDTzSLanW07P
         m8fdZS2BsxlhBMlQ0/HY1nUapMg4C8s505oiRjOQ=
Date:   Wed, 21 Oct 2020 21:34:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] crypto: lib/sha - Combine round constants and
 message schedule
Message-ID: <20201022043450.GC857@sol.localdomain>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-7-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020203957.3512851-7-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 04:39:57PM -0400, Arvind Sankar wrote:
> Putting the round constants and the message schedule arrays together in
> one structure saves one register, which can be a significant benefit on
> register-constrained architectures. On x86-32 (tested on Broadwell
> Xeon), this gives a 10% performance benefit.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> ---
>  lib/crypto/sha256.c | 49 ++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
> index 3a8802d5f747..985cd0560d79 100644
> --- a/lib/crypto/sha256.c
> +++ b/lib/crypto/sha256.c
> @@ -29,6 +29,11 @@ static const u32 SHA256_K[] = {
>  	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
>  };
>  
> +struct KW {
> +	u32 K[64];
> +	u32 W[64];
> +};

Note that this doubles the stack usage from 256 to 512 bytes.  That's pretty
large for kernel code, especially when compiler options can increase the stack
usage well beyond the "expected" value.

So unless this gives a big performance improvement on architectures other than
32-bit x86 (which people don't really care about these days), we probably
shouldn't do this.

FWIW, it's possible to reduce the length of 'W' to 16 words by computing the
next W value just before each round 16-63, or by computing the next W values in
batches of 16 before rounds 16, 32, and 48.  (This is similar to what lib/sha1.c
does for SHA-1.)  In a quick userspace benchmark that seems to reduce
performance by about 25% on x86_64, though.

- Eric
