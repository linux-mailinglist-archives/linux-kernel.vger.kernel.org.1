Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68AD22AA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGWH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:58:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34788 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgGWH6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:58:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyW7M-0005zW-Dk; Thu, 23 Jul 2020 17:58:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:58:16 +1000
Date:   Thu, 23 Jul 2020 17:58:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     davem@davemloft.net, corbet@lwn.net, linux@armlinux.org.uk,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH for v5.9] crypto: Replace HTTP links with HTTPS ones
Message-ID: <20200723075816.GG14246@gondor.apana.org.au>
References: <20200719164959.60308-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719164959.60308-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 06:49:59PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/crypto/api-intro.txt    |  4 +--
>  Documentation/crypto/userspace-if.rst |  4 +--
>  arch/arm/crypto/crc32-ce-core.S       |  2 +-
>  arch/arm/crypto/sha1-armv4-large.S    |  2 +-
>  arch/arm/crypto/sha256-armv4.pl       |  2 +-
>  arch/arm/crypto/sha256-core.S_shipped |  2 +-
>  arch/arm/crypto/sha512-armv4.pl       |  4 +--
>  arch/arm/crypto/sha512-core.S_shipped |  4 +--
>  crypto/Kconfig                        | 46 +++++++++++++--------------
>  crypto/blake2b_generic.c              |  2 +-
>  crypto/camellia_generic.c             |  2 +-
>  crypto/ecc.c                          |  2 +-
>  crypto/jitterentropy.c                |  4 +--
>  crypto/lrw.c                          |  2 +-
>  crypto/salsa20_generic.c              |  4 +--
>  crypto/sha3_generic.c                 |  2 +-
>  16 files changed, 44 insertions(+), 44 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
