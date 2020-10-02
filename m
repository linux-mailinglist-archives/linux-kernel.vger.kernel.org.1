Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE02811A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgJBLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:54:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49142 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:54:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJdx-0005Pr-IS; Fri, 02 Oct 2020 21:54:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:54:33 +1000
Date:   Fri, 2 Oct 2020 21:54:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Botila <andrei.botila@oss.nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] crypto: caam - xts(aes) updates
Message-ID: <20201002115433.GE1205@gondor.apana.org.au>
References: <20200922160328.28926-1-andrei.botila@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922160328.28926-1-andrei.botila@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:03:18PM +0300, Andrei Botila wrote:
> From: Andrei Botila <andrei.botila@nxp.com>
> 
> This patch series fixes some problems in CAAM's implementation of xts(aes):
>  - CAAM until Era 9 can't process XTS with 16B IV
>  - CAAM can only process in hardware XTS key lengths of 16B and 32B
>  - These hardware limitations are resolved through a fallback
>  - CAAM used to return 0 for XTS block length equal to zero
> 
> This patch series also adds a new feature in CAAM's xts(aes):
>  - CAAM is now able to process XTS with 16B IV in HW
> 
> Changes since v2:
> - modified xts_skcipher_ivsize() based on comments
> - squashed the previous 7-9/12 commits
> 
> Changes since v1:
> - use only get_unaligned() for calculating XTS IV size
> - fixed the double calling of crypto_skcipher_set_reqsize() in case of XTS
> - added a patch which modifies the return value for XTS when block length
>   is equal to zero
> 
> Andrei Botila (10):
>   crypto: caam/jr - add fallback for XTS with more than 8B IV
>   crypto: caam/qi - add fallback for XTS with more than 8B IV
>   crypto: caam/qi2 - add fallback for XTS with more than 8B IV
>   crypto: caam/jr - add support for more XTS key lengths
>   crypto: caam/qi - add support for more XTS key lengths
>   crypto: caam/qi2 - add support for more XTS key lengths
>   crypto: caam - add xts check for block length equal to zero
>   crypto: caam/jr - add support for XTS with 16B IV
>   crypto: caam/qi - add support for XTS with 16B IV
>   crypto: caam/qi2 - add support for XTS with 16B IV
> 
>  drivers/crypto/caam/Kconfig        |   3 +
>  drivers/crypto/caam/caamalg.c      |  94 +++++++++++++++++++++---
>  drivers/crypto/caam/caamalg_desc.c |  27 ++++---
>  drivers/crypto/caam/caamalg_qi.c   |  94 +++++++++++++++++++++---
>  drivers/crypto/caam/caamalg_qi2.c  | 111 ++++++++++++++++++++++++++---
>  drivers/crypto/caam/caamalg_qi2.h  |   2 +
>  6 files changed, 293 insertions(+), 38 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
