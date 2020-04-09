Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C71A3CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDIXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 19:34:08 -0400
Received: from ozlabs.org ([203.11.71.1]:37169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgDIXeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:34:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48yyCG5dd0z9sQt;
        Fri, 10 Apr 2020 09:34:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586475243;
        bh=iDTVLKuqXJrCBfSTzDq+b5Cuz3DDrj7b2y5pTvSP+lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bT828MiueJAlvr8WUvLkOGX5mDc99OjEY+pWZ04WC5QeQAMpxFeWVrQ2RvlTfEPD5
         rG/YEtMF/ET7pkpt3zzgddG7LtkP5ZdhJV3H0Kcdgw9eowu8ethxrWB6a6MziYtc06
         ujObB8s6lSOLjmRoH+nzMqUVrgIRH/gJ44bO9Ur5cmb5KauQ9sKvf8CnPpLjY6ae/r
         jX4wJExOT3ktEAraOSocj2fmjiRNZXmrHkgSNh40mB5gzuNQhKyY0wXek+WnklqWIm
         JWQVsxBR/jndTbTjayibKrCigCAFL7TFRNIBcSaFJPovvDQf9QyU48KZDlj1gEXOJH
         Lp+TK4j08SlPw==
Date:   Fri, 10 Apr 2020 09:34:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200410093402.304ac89b@canb.auug.org.au>
In-Reply-To: <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <20200409114940.GT21484@bombadil.infradead.org>
        <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
        <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
        <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
        <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
        <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
        <20200409195633.GZ21484@bombadil.infradead.org>
        <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
        <20200409202751.GA7976@gmail.com>
        <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cyo+WHzp6CCvCDaVjoZLMqd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Apr 2020 13:34:18 -0700 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> On Thu, Apr 9, 2020 at 1:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Would it help if bugs blocking testing on linux-next were Cc'ed to
> > linux-next@vger.kernel.org, so that Stephen could investigate? =20
>=20
> Maybe. I'll let Stephen say.

It would certainly help so I could at least chase people and maybe
revert commits.  Dropping trees can be problematic once Andrew has
built his quilt series on top of them, so I try not to drop whole trees.
I can also use a previous version of a tree (which is usually what I
do if I discover a build problem).

--=20
Cheers,
Stephen Rothwell

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6PsOoACgkQAVBC80lX
0GxWLggAgmL7x+eqNfGwjUwzwkR4SsmGhiMBB64I7FHl3YEYFmnGcpuy45CJRUTF
QE4pclJV1QJEFbJ6ubyevuNvdp/kEbSiJZd/XeuGTc4SNX16sY+I4DHEKIe28zlO
RU767VR4GGrZWICQKsIWygH/qn1vIwvRTNmxK/jxcSLabxVmth9gmLH1VOIeIUvz
JwtpFkk+ZlvCw3vdm7XZ9UnsCimylrr3Nd4DdkxFtq6bwLIepCGQ0MW5Rg8nVUE5
wM5qMKStGjDt4BJnjJ3WvaabpIq45X8msM6/YWzVgxXEGlIsU4Tk8OABEyY9to0f
ez0nXrcOZ5h0tfYSpSNIXfN+Ninjcw==
=7JuK
-----END PGP SIGNATURE-----

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd--
