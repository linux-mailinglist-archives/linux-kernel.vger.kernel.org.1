Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB22781E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIYHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:44:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53044 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYHog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:44:36 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLiP6-0006b3-Gf; Fri, 25 Sep 2020 17:44:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 17:44:29 +1000
Date:   Fri, 25 Sep 2020 17:44:29 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] crypto: atmel-{aes,sha,tdes} - Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20200925074429.GA19040@gondor.apana.org.au>
References: <20200918081434.32179-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918081434.32179-1-bobo.shaobowang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:14:34PM +0800, Wang ShaoBo wrote:
> Make use of devm_platform_get_and_ioremap_resource() provided by
> driver core platform instead of duplicated analogue, dev_err() is
> removed because it has been done in devm_ioremap_resource().
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/crypto/atmel-aes.c  | 16 +++++-----------
>  drivers/crypto/atmel-sha.c  | 16 +++++-----------
>  drivers/crypto/atmel-tdes.c | 16 +++++-----------
>  3 files changed, 15 insertions(+), 33 deletions(-)

You forgot to send this to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
