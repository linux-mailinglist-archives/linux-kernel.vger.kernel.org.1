Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4024D01E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgHUH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:57:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49994 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgHUH5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:57:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91vh-00041d-GC; Fri, 21 Aug 2020 17:57:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:57:41 +1000
Date:   Fri, 21 Aug 2020 17:57:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH -next] crypto: sa2ul: add Kconfig selects to fix build
 error
Message-ID: <20200821075741.GJ25143@gondor.apana.org.au>
References: <6e04b405-7369-ff04-a2dd-aa7c561e13d6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e04b405-7369-ff04-a2dd-aa7c561e13d6@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:54:48AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> sa2ul.c uses sha{1,256,512}_zero_message_hash, so select the
> Kconfig symbols that provide those, like other crypto drivers do.
> 
> Fixes this build error:
> 
> ld: drivers/crypto/sa2ul.o: in function `sa_sha_digest':
> sa2ul.c:(.text+0x2b25): undefined reference to `sha512_zero_message_hash'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org> # 2020-07-29
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/crypto/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
