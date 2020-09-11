Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623DF2657E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 06:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKEOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 00:14:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58424 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgIKEOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:14:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGaRf-0005x0-5T; Fri, 11 Sep 2020 14:13:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 14:13:55 +1000
Date:   Fri, 11 Sep 2020 14:13:55 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v2 PATCH] crypto: sun4i-ss - Fix sparse endianness markers
Message-ID: <20200911041354.GA5275@gondor.apana.org.au>
References: <202009061621.J89kO43Q%lkp@intel.com>
 <20200907062400.GA15841@gondor.apana.org.au>
 <20200907160029.GC11894@Red>
 <20200908050036.GA19817@gondor.apana.org.au>
 <20200910122248.GA22506@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910122248.GA22506@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:22:48PM +0200, Corentin Labbe wrote:
>
> I get some md5 error on both A20+BE:
> alg: ahash: md5 test failed (wrong result) on test vector \"random: psize=129 ksize=0\", cfg=\"random: inplace use_finup nosimd src_divs=[<reimport,nosimd>85.99%@+3999, 5.85%@+30, <reimport>0.96%@+25, <reimport,nosimd>5.9%@+2263, <flush,nosimd>2.11%@+1950] iv_offset=2 key_offset=43\"
> and A33+BE:
> [   84.469045] alg: ahash: md5 test failed (wrong result) on test vector \"random: psize=322 ksize=0\", cfg=\"random: inplace may_sleep use_finup src_divs=[<reimport>99.1%@+2668, <reimport>0.88%@alignmask+3630, 0.11%@+3403] iv_offset=33\"
> +[   84.469074] need:35966fc8 b31ea266 2bf064e9 f20f40ad
> +[   84.469084] have:e29e4491 f3b6effc fa366691 00e04bd9
> 
> Thoses errors are random. (1 boot out of 2)

Do these really go away without this patch applied? AFAICS the
generated code should be identical.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
