Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C808F2CE84C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgLDGrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:47:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60772 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgLDGrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:47:00 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl4r3-0006KX-Cl; Fri, 04 Dec 2020 17:46:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 17:46:09 +1100
Date:   Fri, 4 Dec 2020 17:46:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH] implements ecdsa 256, 384 and 521 alghorithm in akcipher
 model; change pcks7 and x509 to load certificates with ecdsa; increment
 testmgr to test ecdsa algo and finally allows signature and verification of
 modules with ecdsa algorithm
Message-ID: <20201204064609.GA26322@gondor.apana.org.au>
References: <20201126020308.25982-1-saulo.alessandre@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126020308.25982-1-saulo.alessandre@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:03:08PM -0300, Saulo Alessandre wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> ---
>  Documentation/admin-guide/module-signing.rst |  10 +
>  crypto/Kconfig                               |  12 +
>  crypto/Makefile                              |   7 +
>  crypto/asymmetric_keys/pkcs7_parser.c        |   7 +-
>  crypto/asymmetric_keys/pkcs7_verify.c        |   5 +-
>  crypto/asymmetric_keys/public_key.c          |  30 +-
>  crypto/asymmetric_keys/x509_cert_parser.c    |  30 +-
>  crypto/ecc.c                                 | 228 ++++++++-
>  crypto/ecc.h                                 |  62 ++-
>  crypto/ecc_curve_defs.h                      |  82 +++
>  crypto/ecdsa.c                               | 508 +++++++++++++++++++
>  crypto/ecdsa_params.asn1                     |   1 +
>  crypto/ecdsa_signature.asn1                  |   6 +
>  crypto/testmgr.c                             |  17 +-
>  crypto/testmgr.h                             |  78 +++
>  include/crypto/ecdh.h                        |   2 +
>  include/linux/oid_registry.h                 |  12 +
>  lib/oid_registry.c                           | 108 +++-
>  18 files changed, 1146 insertions(+), 59 deletions(-)
>  create mode 100644 crypto/ecdsa.c
>  create mode 100644 crypto/ecdsa_params.asn1
>  create mode 100644 crypto/ecdsa_signature.asn1

Please split your patch up.  You should also explain in detail
why this patch is needed in the kernel.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
