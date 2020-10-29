Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474229DD06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgJ1WUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEC62468B;
        Wed, 28 Oct 2020 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876030;
        bh=/lrSDP0AmQJOcuRx3S891VP10onVPlgynY6E24iOlPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obDj4W/cxxzuDRDhjEJ02wxDJFrEbj2hQ1HZkLoVMTZ3E0w5Hmw4ij5iHZ7d/jvdH
         oJ10fcvj9aGpeidvV7oDDCpKRSIDtiwSNN3uHkXWsYb4sUhlegL9qU5sibWLM0hMm0
         MCx7vEeRMavkKSq4YMaHmIE5H/axpVLxEuOxOQ8w=
Received: by mail-ot1-f50.google.com with SMTP id f97so3600577otb.7;
        Wed, 28 Oct 2020 02:07:10 -0700 (PDT)
X-Gm-Message-State: AOAM530xlpC9CTDRFQpcRWcSPx+KFdbutqqchZ7cI4V0148+vfElzUNQ
        +DZzZsYXbBXWqqE1YaLe/h+YYfbLeeBQHmK3xVw=
X-Google-Smtp-Source: ABdhPJwP+vy3R9eXrfedfzYbhfaXJuGzXN7uUJfjpOFZSxVQke3eJWxIT2+Uk0rOjQpaqkmJvdNc/EeC5kO2jG4c1QY=
X-Received: by 2002:a9d:2daa:: with SMTP id g39mr4698778otb.77.1603876029925;
 Wed, 28 Oct 2020 02:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028090320.4222-1-horia.geanta@nxp.com>
In-Reply-To: <20201028090320.4222-1-horia.geanta@nxp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 28 Oct 2020 10:06:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGfwuY_uEGT83QpoUZwy9X=6k7zaxHs2kFrdsArKpVpOw@mail.gmail.com>
Message-ID: <CAMj1kXGfwuY_uEGT83QpoUZwy9X=6k7zaxHs2kFrdsArKpVpOw@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/aes-neonbs - fix usage of cbc(aes) fallback
To:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 at 10:03, Horia Geant=C4=83 <horia.geanta@nxp.com> wrot=
e:
>
> Loading the module deadlocks since:
> -local cbc(aes) implementation needs a fallback and
> -crypto API tries to find one but the request_module() resolves back to
> the same module
>
> Fix this by changing the module alias for cbc(aes) and
> using the NEED_FALLBACK flag when requesting for a fallback algorithm.
>
> Fixes: 00b99ad2bac2 ("crypto: arm/aes-neonbs - Use generic cbc encryption=
 path")
> Signed-off-by: Horia Geant=C4=83 <horia.geanta@nxp.com>

Not sure what is happening here: IIRC the intention was to rely on the
fact that only the sync cbc(aes) implementation needs the fallback,
and therefore, allocating a sync skcipher explicitly would avoid this
recursion.

Herbert?

> ---
>  arch/arm/crypto/aes-neonbs-glue.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/crypto/aes-neonbs-glue.c b/arch/arm/crypto/aes-neon=
bs-glue.c
> index bda8bf17631e..f70af1d0514b 100644
> --- a/arch/arm/crypto/aes-neonbs-glue.c
> +++ b/arch/arm/crypto/aes-neonbs-glue.c
> @@ -19,7 +19,7 @@ MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.or=
g>");
>  MODULE_LICENSE("GPL v2");
>
>  MODULE_ALIAS_CRYPTO("ecb(aes)");
> -MODULE_ALIAS_CRYPTO("cbc(aes)");
> +MODULE_ALIAS_CRYPTO("cbc(aes)-all");
>  MODULE_ALIAS_CRYPTO("ctr(aes)");
>  MODULE_ALIAS_CRYPTO("xts(aes)");
>
> @@ -191,7 +191,8 @@ static int cbc_init(struct crypto_skcipher *tfm)
>         struct aesbs_cbc_ctx *ctx =3D crypto_skcipher_ctx(tfm);
>         unsigned int reqsize;
>
> -       ctx->enc_tfm =3D crypto_alloc_skcipher("cbc(aes)", 0, CRYPTO_ALG_=
ASYNC);
> +       ctx->enc_tfm =3D crypto_alloc_skcipher("cbc(aes)", 0, CRYPTO_ALG_=
ASYNC |
> +                                            CRYPTO_ALG_NEED_FALLBACK);
>         if (IS_ERR(ctx->enc_tfm))
>                 return PTR_ERR(ctx->enc_tfm);
>
> @@ -441,7 +442,8 @@ static struct skcipher_alg aes_algs[] =3D { {
>         .base.cra_blocksize     =3D AES_BLOCK_SIZE,
>         .base.cra_ctxsize       =3D sizeof(struct aesbs_cbc_ctx),
>         .base.cra_module        =3D THIS_MODULE,
> -       .base.cra_flags         =3D CRYPTO_ALG_INTERNAL,
> +       .base.cra_flags         =3D CRYPTO_ALG_INTERNAL |
> +                                 CRYPTO_ALG_NEED_FALLBACK,
>
>         .min_keysize            =3D AES_MIN_KEY_SIZE,
>         .max_keysize            =3D AES_MAX_KEY_SIZE,
> --
> 2.17.1
>
