Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6DC2234DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGQGnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 02:43:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42854 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgGQGnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:43:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jwK5f-0005nT-RC; Fri, 17 Jul 2020 16:43:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jul 2020 16:43:27 +1000
Date:   Fri, 17 Jul 2020 16:43:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: xts: use memmove to avoid overlapped memory copy
Message-ID: <20200717064327.GA2504@gondor.apana.org.au>
References: <20200716152900.1709694-1-colin.king@canonical.com>
 <CAMj1kXEWyweZ0E3WHthEG9oiOpOS9UxtTB7xskAsF8FeinNg9w@mail.gmail.com>
 <20200717052139.GB2045@gondor.apana.org.au>
 <CAMj1kXH9PHNNUMgwNUv8gBJDxs8w5Eta=AouKM7L=hMWNOQ=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH9PHNNUMgwNUv8gBJDxs8w5Eta=AouKM7L=hMWNOQ=HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:59:54AM +0300, Ard Biesheuvel wrote:
>
> Or change it to b[1] = b[0] (assuming the compiler allows struct
> assignment in that way). This will always copy XTS_BLOCK_SIZE bytes,
> but we have sufficient space, and it is probably more efficient  too
> in most cases.

Sounds good to me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
