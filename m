Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C629FB11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgJ3CLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:11:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36864 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgJ3CLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:11:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kYJsa-0002UE-Pz; Thu, 29 Oct 2020 22:11:00 -0400
Message-ID: <3cac87ec39253019bfa04a9dfd61ce40ac85cc31.camel@surriel.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Chris Mason <clm@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Oct 2020 22:10:57 -0400
In-Reply-To: <CAKfTPtCROc_+rPYm8FGHDNJ-U6h1iZ0nm2+xy+tZ+L1q09h28w@mail.gmail.com>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
         <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
         <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
         <20201026142455.GA13495@vingu-book>
         <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
         <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
         <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
         <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
         <20201026120445.6a5dbbbe@imladris.surriel.com>
         <20201026162029.GA11367@vingu-book>
         <B23038A4-945F-48E9-8D38-EABE8204F208@fb.com>
         <CAKfTPtCROc_+rPYm8FGHDNJ-U6h1iZ0nm2+xy+tZ+L1q09h28w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AV7rVIwkmw82SUPFLhQx"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AV7rVIwkmw82SUPFLhQx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-26 at 17:52 +0100, Vincent Guittot wrote:
> On Mon, 26 Oct 2020 at 17:48, Chris Mason <clm@fb.com> wrote:
> > On 26 Oct 2020, at 12:20, Vincent Guittot wrote:
> >=20
> > > what you are suggesting is something like:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 4978964e75e5..3b6fbf33abc2 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9156,7 +9156,8 @@ static inline void
> > > calculate_imbalance(struct
> > > lb_env *env, struct sd_lb_stats *s
> > >          * emptying busiest.
> > >          */
> > >         if (local->group_type =3D=3D group_has_spare) {
> > > -               if (busiest->group_type > group_fully_busy) {
> > > +               if ((busiest->group_type > group_fully_busy) &&
> > > +                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
> > >                         /*
> > >                          * If busiest is overloaded, try to fill
> > > spare
> > >                          * capacity. This might end up creating
> > > spare
> > > capacity
> > >=20
> > > which also fixes the problem for me and alignes LB with wakeup
> > > path
> > > regarding the migration
> > > in the LLC
> >=20
> > Vincent=E2=80=99s patch on top of 5.10-rc1 looks pretty great:
> >=20
> > Latency percentiles (usec) runtime 90 (s) (3320 total samples)
> >          50.0th: 161 (1687 samples)
> >          75.0th: 200 (817 samples)
> >          90.0th: 228 (488 samples)
> >          95.0th: 254 (164 samples)
> >          *99.0th: 314 (131 samples)
> >          99.5th: 330 (17 samples)
> >          99.9th: 356 (13 samples)
> >          min=3D29, max=3D358
> >=20
> > Next we test in prod, which probably won=E2=80=99t have answers until
> > tomorrow.  Thanks again Vincent!
>=20
> Great !
>=20
> I'm going to run more tests on my setup as well to make sure that it
> doesn't generate unexpected side effects on other kinds of use cases.

We have tested the patch with several pretty demanding
workloads for the past several days, and it seems to
do the trick!

With all the current scheduler code from the Linus tree,
plus this patch on top, performance is as good as it ever
was before with one workload, and slightly better with
the other.

--=20
All Rights Reversed.

--=-AV7rVIwkmw82SUPFLhQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+bdjEACgkQznnekoTE
3oOc/Af8CmCxkm4y64wEJwxHAynhlejaQZbsAHYP8qDgss0yr8OJWhRw5ZiDco5h
qnfGp6hG3bZyA8gI9hqoROJvjSli3L3FZ8vBFO7dfsQfaM5pkE4EOvsZakDwhUcb
874i4jTp2874laTHLb9PgZChP7XYF5pt0/S3RKW0V9yLZ6s1bbLA6ACicq7K6/Ja
cT3iR66AEHXmtKWoDfWXO7zQUnyKP1jC02ivYY5yzLv7vcd3+Vgg8fGzkWk7YuZH
6BKzTel2dgVvJNbiiNhU+wU/dfrFDUQ8OGfvDlx/jggAA8bypz7BKVwRACqcQfCp
4aj1Kl9CwB74yLzofxrOle+PvAINOA==
=+go8
-----END PGP SIGNATURE-----

--=-AV7rVIwkmw82SUPFLhQx--

