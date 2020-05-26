Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970E71CA384
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 02:04:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40102 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgEHGEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:04:45 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jWw0z-0004u9-0O; Fri, 08 May 2020 15:57:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 May 2020 16:04:20 +1000
Date:   Fri, 8 May 2020 16:04:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lionel Debieve <lionel.debieve@st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] crypto: stm32/hash: Defer probe management
Message-ID: <20200508060420.GA24789@gondor.apana.org.au>
References: <20200427064226.6991-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427064226.6991-1-lionel.debieve@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:42:23AM +0200, Lionel Debieve wrote:
> These patches manage properly the defer probe for STM32 Hash driver.
> It allows the driver to be probed later if clock, reset or dma return
> a defer error.
> It also removes the error print messages in such cases.
> 
> Etienne Carriere (2):
>   crypto: stm32/hash - defer probe for reset controller
>   crypto: stm32/hash - defer probe for dma device
> 
> Lionel Debieve (1):
>   crypto: stm32/hash - don't print error on probe deferral
> 
>  drivers/crypto/stm32/stm32-hash.c | 38 ++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 11 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
