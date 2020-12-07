Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9342D1A90
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLGUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:33:00 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E7C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:32:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CqZjq5r7Zz9sVl;
        Tue,  8 Dec 2020 07:32:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607373136;
        bh=n413a+GrSbv/wBxEwbRE4qtzByHdg5UJm8RGITccl9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LTXsnBTcOg7xPYAJJKmwSSc4FbANtxJRsnww8jcCHER7Lmlaxohf/PyMywpYEUa6a
         tC2zZwg6pvo7XbrAkGXF510/lU/4cfoWGS7sgSSnXiaWSWm/+61znM3mnQXXRZezYx
         tTXjk6dBDURTEY67AinGArRV1P1gRxEGO/WhrIpsoB2BfEFQtaJ7qgeQvDcchTA2UO
         Lrg5HamaHUSpSO+/bqPnVUeJYIb9Kq7anYoK8r+9wh26DpsHJMq1CNNZ9FlUJluLWe
         oPVnZuEFCNu0UyReILFrGZFjJvP6uVLS5hwPlGxLLmUz1XwpeI0pzOdsPUS0y35HOi
         TOyz9mZP4Lfbw==
Date:   Tue, 8 Dec 2020 07:32:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marco Elver <elver@google.com>
Cc:     Hui Su <sh_def@163.com>, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][next] arm64: fix the mm build error in mm/kfence/core.c
Message-ID: <20201208073214.0d3bd2b8@canb.auug.org.au>
In-Reply-To: <CANpmjNOWpa17L7mjhKdaFjWYfAzy12NjXUDtuPHpzm808QApRg@mail.gmail.com>
References: <20201205172207.GA4097@rlk>
        <20201207082300.38f5207f@canb.auug.org.au>
        <CANpmjNPifOwd9w34dSJhsvmP2sUkKa0ESPiJ7gj+gUDffhPO3A@mail.gmail.com>
        <CANpmjNOWpa17L7mjhKdaFjWYfAzy12NjXUDtuPHpzm808QApRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AYuN9KtU3laHxkih/=Rs4i4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AYuN9KtU3laHxkih/=Rs4i4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Mon, 7 Dec 2020 15:52:07 +0100 Marco Elver <elver@google.com> wrote:
>
> On Sun, 6 Dec 2020 at 23:08, Marco Elver <elver@google.com> wrote:
> > On Sun, 6 Dec 2020 at 22:23, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote: =20
> [...]
> > > > ../arch/arm64/include/asm/kfence.h:12:2: error: implicit declaratio=
n of
> > > > function =E2=80=98set_memory_valid=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
> > > >    12 |  set_memory_valid(addr, 1, !protect);
> > > >       |  ^~~~~~~~~~~~~~~~
> > > > cc1: some warnings being treated as errors
> > > >
> > > > which introduced by commit d54febeba2ff ("kfence: use pt_regs to
> > > > generate stack trace on faults").
> > > >
> > > > Signed-off-by: Hui Su <sh_def@163.com>
> > > > ---
> > > >  arch/arm64/include/asm/kfence.h | 1 +
> > > >  1 file changed, 1 insertion(+) =20
> >
> > Thanks, but a patch for this is already in the -mm tree:
> > https://lore.kernel.org/mm-commits/20201205011409.o9PNsRntR%25akpm@linu=
x-foundation.org/
> >
> > Perhaps try the latest -next? =20
>=20
> Although I notice that patch somehow was dropped from -mm, or maybe
> I'm not looking hard enough?

It may just be that Andrew has not published that version of his patch
series yet.

--=20
Cheers,
Stephen Rothwell

--Sig_/AYuN9KtU3laHxkih/=Rs4i4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/OkU4ACgkQAVBC80lX
0Gyi3Qf9EAIRGmzw7JNoFMsxGgSgM/wt/AesXfcetRvVOlWlihucsthsrlcVTU4M
Ny6DJxPi6twetta8iZ8CAmdBvJRAxd8Y2vbuPzMlu/n6U6u+YQra071LZHCCXvgy
JnWCRY3QKLuarPVNnhMk15/uU0zlWjzIzsM03/nnaAYKR8aFrGmA9jnaFTrcuRDI
PO6hZPuvYjHnq7Iom2PktTI+PZAjQY6+AD5/Xn26UZusIqEFSrc8qQkaBwTu0T51
9fhQ6VqC27jjDRQE1fCHMOGN17embwbe6lIKd0ZbCVENxZCtW0dP/UvZwLe6Vvt2
aDen7EShSvZwQU090dFd5o9LBhetag==
=JBfN
-----END PGP SIGNATURE-----

--Sig_/AYuN9KtU3laHxkih/=Rs4i4--
