Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AFC20AB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFZEpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 00:45:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51750 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFZEpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:45:43 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jogF4-0003af-KS; Fri, 26 Jun 2020 14:45:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jun 2020 14:45:34 +1000
Date:   Fri, 26 Jun 2020 14:45:34 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        George Cherian <gcherian@marvell.com>,
        Wei Xu <xuwei5@hisilicon.com>, Zaibo Xu <xuzaibo@Huawei.com>
Subject: Re: [PATCH 1/3] crypto: pass the flag CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20200626044534.GA2870@gondor.apana.org.au>
References: <alpine.LRH.2.02.2006091259250.30590@file01.intranet.prod.int.rdu2.redhat.com>
 <20200610010450.GA6449@gondor.apana.org.au>
 <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com>
 <20200610121106.GA23137@gondor.apana.org.au>
 <alpine.LRH.2.02.2006161052540.28052@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com>
 <20200616173620.GA207319@gmail.com>
 <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:09:28AM -0400, Mikulas Patocka wrote:
>
> Index: linux-2.6/include/linux/crypto.h
> ===================================================================
> --- linux-2.6.orig/include/linux/crypto.h
> +++ linux-2.6/include/linux/crypto.h
> @@ -97,9 +97,18 @@
>  #define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
>  
>  /*
> + * The driver may allocate memory during request processing, so it shouldn't be
> + * used in cases where memory allocation failures aren't acceptable, such as
> + * during block device encryption.
> + */
> +#define CRYPTO_ALG_ALLOCATES_MEMORY	0x00008000
> +
> +/*
>   * Don't trigger module loading
>   */
> -#define CRYPTO_NOLOAD			0x00008000
> +#define CRYPTO_NOLOAD			0x00010000
> +
> +#define CRYPTO_ALG_INHERITED_FLAGS	(CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY)

Any reason why you need to renumber NOLOAD? If not please keep
the existing values.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
