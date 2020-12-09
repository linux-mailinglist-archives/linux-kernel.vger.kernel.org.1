Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295102D4D21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgLIVud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:50:33 -0500
Received: from ozlabs.org ([203.11.71.1]:37605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbgLIVud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:50:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CrrLR0BWQz9sWC;
        Thu, 10 Dec 2020 08:49:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607550591;
        bh=Pk02nl7oTUMr2c6X6wITnTNYYj3cZDfXZsaQ+OKUodo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/iq7qd9SpcfTPObrU843JXtz2vdjRTG5R6U0tWUPpkHsHsphqzBsEPBsp8m8GU/W
         VRPGBiWRWH/rZwZCv19vl8jxun6D7gZVXWQa7CEtziNO/AJYuFbl7T/4keQO8jnYUu
         BYvbpmOQs2yHQAxYCn2+l+wEk9Htm/Mjc8r/neli4sRKp2lRQaeky8c/x+/fWOqP/c
         Vgv7+sofq5/bUXwFgXS+L0JqmqDV+MfiPwpYkZHDP8ul6J8M2NYaHU0XV/oNFM0O6h
         syIUeVPyL+bE05jwlDNbyR8VYk9HZycYvtZWE5DlrOoAhAPAFQElLy15hXQWpTiWN4
         ss2ZxGCRi9Rzw==
Date:   Thu, 10 Dec 2020 08:49:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, akpm@linux-foundation.org,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] kcov: don't instrument with UBSAN
Message-ID: <20201210084950.208c89ba@canb.auug.org.au>
In-Reply-To: <202012091054.08D70D4F@keescook>
References: <20201209100152.2492072-1-dvyukov@google.com>
        <202012091054.08D70D4F@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bv6x0ikC3MH.6utRbkJsmF_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bv6x0ikC3MH.6utRbkJsmF_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 9 Dec 2020 10:54:39 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 09, 2020 at 11:01:52AM +0100, Dmitry Vyukov wrote:
> > Both KCOV and UBSAN use compiler instrumentation. If UBSAN detects a bug
> > in KCOV, it may cause infinite recursion via printk and other common
> > functions. We already don't instrument KCOV with KASAN/KCSAN for this
> > reason, don't instrument it with UBSAN as well.
> >=20
> > As a side effect this also resolves the following gcc warning:
> >=20
> > conflicting types for built-in function '__sanitizer_cov_trace_switch';
> > expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mism=
atch]
> >=20
> > It's only reported when kcov.c is compiled with any of the sanitizers
> > enabled. Size of the arguments is correct, it's just that gcc uses 'lon=
g'
> > on 64-bit arches and 'long long' on 32-bit arches, while kernel type is
> > always 'long long'.
> >=20
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com> =20
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> Thanks for chasing this down!
>=20
> Andrew, can you add this to the stack of ubsan patches you're carrying,
> please?

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Bv6x0ikC3MH.6utRbkJsmF_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/RRn4ACgkQAVBC80lX
0Gx0rQf9FjZqWLlSg8chBznagG08qJuEV4mhrUiKjKEZuLw403VfIKXJwqcVNGiF
nR1lISGeRZTgCR9jP+0nWCPucghMIdHsOhWv678HvEiDLf+IL0er45ht/2rjH57g
ILDRwH60FyWnEAFk3gnmfsugWfFLJQhOYav2SFfGSOBkUEYDUVWFqdRhRW5fyvXn
kbVEUowz+QGZWqwTqY8tBj36GCOttjyqn4n3g0sRRMkV2NUdRIFKbfAQG1u9JIr+
N0H/hdH+G79cr9oo3u6msxvVWd/y2tfRv6VrdL9VQZ42oUc1MuZ+Ds/K4kua2tyW
3c+mdPIE2Cg7BbnBCvwIpDBWFlO9Fg==
=giMY
-----END PGP SIGNATURE-----

--Sig_/Bv6x0ikC3MH.6utRbkJsmF_--
