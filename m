Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF72F2599
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbhALBfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbhALBfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:35:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7994022EBF;
        Tue, 12 Jan 2021 01:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610415261;
        bh=8NTfa6eB6TLOe0Z5onwHF/F50VvgNzpzch/K5lNaCHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TOdq7chmA5Wkl9sp9lE6bjT1XcEsGkdTbNB2jEkcqY/ailx+Er81C7rU7B9iPnWV+
         0XO4CLN/Nehhf/8cBkwgr8aKE0Dq5wZWx/orPjyW/Zs+tbXDQfCbsJgBj3P8sCTpTy
         CfmhmZ9xARrhon/EzZPDno391vIQxkt1kRDuRoBBTcH9opm3+HNmaFIoXsvQDxQqNJ
         3CX0xDSsOP01p38N1lXh9WK3VUclbwaCGo6zp0jPTCOiCIU0L5dmYUQKtcVCnz07+1
         WRz09AiMjiJ/RsADFjK1oDgXjSlGC7ts0cw6T72O+JQ+k59LVNfJDTkk09K7C+nl+4
         s4Gu8ueDvIooA==
Message-ID: <12c867b87e67e7d7db0633928654f92b3bfc83d7.camel@kernel.org>
Subject: Re: [PATCH 4/5] security: DH - use KDF implementation from crypto
 API
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        mathew.j.martineau@linux.intel.com, dhowells@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 12 Jan 2021 03:34:16 +0200
In-Reply-To: <3088284.aeNJFYEL58@positron.chronox.de>
References: <4616980.31r3eYUQgx@positron.chronox.de>
         <3088284.aeNJFYEL58@positron.chronox.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-04 at 22:49 +0100, Stephan Müller wrote:
> The kernel crypto API provides the SP800-108 counter KDF implementation.
> Thus, the separate implementation provided as part of the keys subsystem
> can be replaced with calls to the KDF offered by the kernel crypto API.
> 
> The keys subsystem uses the counter KDF with a hash cipher primitive.
> Thus, it only uses the call to crypto_kdf108_ctr_generate.
> 
> The change removes the specific code that adds a zero padding that was
> intended to be invoked when the DH operation result was smaller than the
> modulus. However, this cannot occur any more these days because the
> function mpi_write_to_sgl is used in the code path that calculates the
> shared secret in dh_compute_value. This MPI service function guarantees
> that leading zeros are introduced as needed to ensure the resulting data
> is exactly as long as the modulus. This implies that the specific code
> to add zero padding is dead code which can be safely removed.

Should be thn split into two patches, i.e. prepended with a patch
removing the dead code.

/Jarkko

> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  security/keys/Kconfig |   2 +-
>  security/keys/dh.c    | 118 ++++++------------------------------------
>  2 files changed, 17 insertions(+), 103 deletions(-)
> 
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 83bc23409164..e6604499f0a8 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -106,7 +106,7 @@ config KEY_DH_OPERATIONS
>         bool "Diffie-Hellman operations on retained keys"
>         depends on KEYS
>         select CRYPTO
> -       select CRYPTO_HASH
> +       select CRYPTO_KDF800108_CTR
>         select CRYPTO_DH
>         help
>          This option provides support for calculating Diffie-Hellman
> diff --git a/security/keys/dh.c b/security/keys/dh.c
> index 1abfa70ed6e1..46fa442b81ec 100644
> --- a/security/keys/dh.c
> +++ b/security/keys/dh.c
> @@ -11,6 +11,7 @@
>  #include <crypto/hash.h>
>  #include <crypto/kpp.h>
>  #include <crypto/dh.h>
> +#include <crypto/kdf_sp800108.h>
>  #include <keys/user-type.h>
>  #include "internal.h"
>  
> @@ -79,16 +80,9 @@ static void dh_crypto_done(struct crypto_async_request *req, int err)
>         complete(&compl->completion);
>  }
>  
> -struct kdf_sdesc {
> -       struct shash_desc shash;
> -       char ctx[];
> -};
> -
> -static int kdf_alloc(struct kdf_sdesc **sdesc_ret, char *hashname)
> +static int kdf_alloc(struct crypto_shash **hash, char *hashname)
>  {
>         struct crypto_shash *tfm;
> -       struct kdf_sdesc *sdesc;
> -       int size;
>         int err;
>  
>         /* allocate synchronous hash */
> @@ -102,14 +96,7 @@ static int kdf_alloc(struct kdf_sdesc **sdesc_ret, char *hashname)
>         if (crypto_shash_digestsize(tfm) == 0)
>                 goto out_free_tfm;
>  
> -       err = -ENOMEM;
> -       size = sizeof(struct shash_desc) + crypto_shash_descsize(tfm);
> -       sdesc = kmalloc(size, GFP_KERNEL);
> -       if (!sdesc)
> -               goto out_free_tfm;
> -       sdesc->shash.tfm = tfm;
> -
> -       *sdesc_ret = sdesc;
> +       *hash = tfm;
>  
>         return 0;
>  
> @@ -118,92 +105,20 @@ static int kdf_alloc(struct kdf_sdesc **sdesc_ret, char *hashname)
>         return err;
>  }
>  
> -static void kdf_dealloc(struct kdf_sdesc *sdesc)
> -{
> -       if (!sdesc)
> -               return;
> -
> -       if (sdesc->shash.tfm)
> -               crypto_free_shash(sdesc->shash.tfm);
> -
> -       kfree_sensitive(sdesc);
> -}
> -
> -/*
> - * Implementation of the KDF in counter mode according to SP800-108 section 5.1
> - * as well as SP800-56A section 5.8.1 (Single-step KDF).
> - *
> - * SP800-56A:
> - * The src pointer is defined as Z || other info where Z is the shared secret
> - * from DH and other info is an arbitrary string (see SP800-56A section
> - * 5.8.1.2).
> - *
> - * 'dlen' must be a multiple of the digest size.
> - */
> -static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
> -                  u8 *dst, unsigned int dlen, unsigned int zlen)
> +static void kdf_dealloc(struct crypto_shash *hash)
>  {
> -       struct shash_desc *desc = &sdesc->shash;
> -       unsigned int h = crypto_shash_digestsize(desc->tfm);
> -       int err = 0;
> -       u8 *dst_orig = dst;
> -       __be32 counter = cpu_to_be32(1);
> -
> -       while (dlen) {
> -               err = crypto_shash_init(desc);
> -               if (err)
> -                       goto err;
> -
> -               err = crypto_shash_update(desc, (u8 *)&counter, sizeof(__be32));
> -               if (err)
> -                       goto err;
> -
> -               if (zlen && h) {
> -                       u8 tmpbuffer[32];
> -                       size_t chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
> -                       memset(tmpbuffer, 0, chunk);
> -
> -                       do {
> -                               err = crypto_shash_update(desc, tmpbuffer,
> -                                                         chunk);
> -                               if (err)
> -                                       goto err;
> -
> -                               zlen -= chunk;
> -                               chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
> -                       } while (zlen);
> -               }
> -
> -               if (src && slen) {
> -                       err = crypto_shash_update(desc, src, slen);
> -                       if (err)
> -                               goto err;
> -               }
> -
> -               err = crypto_shash_final(desc, dst);
> -               if (err)
> -                       goto err;
> -
> -               dlen -= h;
> -               dst += h;
> -               counter = cpu_to_be32(be32_to_cpu(counter) + 1);
> -       }
> -
> -       return 0;
> -
> -err:
> -       memzero_explicit(dst_orig, dlen);
> -       return err;
> +       if (hash)
> +               crypto_free_shash(hash);
>  }
>  
> -static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
> +static int keyctl_dh_compute_kdf(struct crypto_shash *hash,
>                                  char __user *buffer, size_t buflen,
> -                                uint8_t *kbuf, size_t kbuflen, size_t lzero)
> +                                uint8_t *kbuf, size_t kbuflen)
>  {
> +       struct kvec kbuf_iov = { .iov_base = kbuf, .iov_len = kbuflen };
>         uint8_t *outbuf = NULL;
>         int ret;
> -       size_t outbuf_len = roundup(buflen,
> -                                   crypto_shash_digestsize(sdesc->shash.tfm));
> +       size_t outbuf_len = roundup(buflen, crypto_shash_digestsize(hash));
>  
>         outbuf = kmalloc(outbuf_len, GFP_KERNEL);
>         if (!outbuf) {
> @@ -211,7 +126,7 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
>                 goto err;
>         }
>  
> -       ret = kdf_ctr(sdesc, kbuf, kbuflen, outbuf, outbuf_len, lzero);
> +       ret = crypto_kdf108_ctr_generate(hash, &kbuf_iov, 1, outbuf, outbuf_len);
>         if (ret)
>                 goto err;
>  
> @@ -240,7 +155,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
>         struct kpp_request *req;
>         uint8_t *secret;
>         uint8_t *outbuf;
> -       struct kdf_sdesc *sdesc = NULL;
> +       struct crypto_shash *hash = NULL;
>  
>         if (!params || (!buffer && buflen)) {
>                 ret = -EINVAL;
> @@ -273,7 +188,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
>                 }
>  
>                 /* allocate KDF from the kernel crypto API */
> -               ret = kdf_alloc(&sdesc, hashname);
> +               ret = kdf_alloc(&hash, hashname);
>                 kfree(hashname);
>                 if (ret)
>                         goto out1;
> @@ -383,9 +298,8 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
>                         goto out6;
>                 }
>  
> -               ret = keyctl_dh_compute_kdf(sdesc, buffer, buflen, outbuf,
> -                                           req->dst_len + kdfcopy->otherinfolen,
> -                                           outlen - req->dst_len);
> +               ret = keyctl_dh_compute_kdf(hash, buffer, buflen, outbuf,
> +                                           req->dst_len + kdfcopy->otherinfolen);
>         } else if (copy_to_user(buffer, outbuf, req->dst_len) == 0) {
>                 ret = req->dst_len;
>         } else {
> @@ -403,7 +317,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
>  out2:
>         dh_free_data(&dh_inputs);
>  out1:
> -       kdf_dealloc(sdesc);
> +       kdf_dealloc(hash);
>         return ret;
>  }
>  


