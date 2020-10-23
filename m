Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F742968B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460355AbgJWDQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 23:16:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39412 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460347AbgJWDQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 23:16:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kVnZK-0008Bd-EC; Fri, 23 Oct 2020 14:16:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Oct 2020 14:16:42 +1100
Date:   Fri, 23 Oct 2020 14:16:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] crypto: lib/sha256 - Unroll SHA256 loop 8 times
 intead of 64
Message-ID: <20201023031642.GA19027@gondor.apana.org.au>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-5-nivedita@alum.mit.edu>
 <20201022050219.GG857@sol.localdomain>
 <20201023031236.GA135789@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023031236.GA135789@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:12:36PM -0400, Arvind Sankar wrote:
>
> I was aiming for 8 columns per line to match all the other groupings by
> eight. It does slightly exceed 100 columns but can this be an exception,
> or should I maybe make it 4 columns per line?

Please limit it to 4 columns.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
