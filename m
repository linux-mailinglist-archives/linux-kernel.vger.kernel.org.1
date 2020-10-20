Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B01286E53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJHFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:52:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41248 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHFwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:52:45 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kQOqz-0006af-PP; Thu, 08 Oct 2020 16:52:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Oct 2020 16:52:38 +1100
Date:   Thu, 8 Oct 2020 16:52:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v2 PATCH] crypto: sun4i-ss - Fix sparse endianness markers
Message-ID: <20201008055238.GA9813@gondor.apana.org.au>
References: <202009061621.J89kO43Q%lkp@intel.com>
 <20200907062400.GA15841@gondor.apana.org.au>
 <20200907160029.GC11894@Red>
 <20200908050036.GA19817@gondor.apana.org.au>
 <20200910122248.GA22506@Red>
 <20200911041354.GA5275@gondor.apana.org.au>
 <20200914104058.GA14265@Red>
 <20200924030859.GA8223@gondor.apana.org.au>
 <20200924132738.GA24386@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924132738.GA24386@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:27:38PM +0200, Corentin Labbe wrote:
>
> This is an example on next-20200923+BigEndian
> alg: ahash: sha1 test failed (wrong result) on test vector \"random: psize=194 ksize=0\", cfg=\"random: inplace may_sleep use_finup src_divs=[98.25%@+1124, <flush>1.75%@+5] iv_offset=18\"

Hmm, the only way I can see this happening is if it was triggered
by tcrypt.  Were you using tcrypt by any chance?

Ccing Eric in case he has any insight.

> === DUMP /proc/crypto ===
> name         : sha1
> driver       : sha1-sun4i-ss
> module       : kernel
> priority     : 300
> refcnt       : 1
> selftest     : passed
> internal     : no
> type         : ahash
> async        : no
> blocksize    : 64
> digestsize   : 20

...

> name         : sha1
> driver       : sha1-generic
> module       : kernel
> priority     : 100
> refcnt       : 1
> selftest     : passed
> internal     : no
> type         : shash
> blocksize    : 64
> digestsize   : 20

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
