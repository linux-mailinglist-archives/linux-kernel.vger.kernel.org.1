Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA60299070
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783047AbgJZPEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:04:47 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55400 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782998AbgJZPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:04:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kX437-0003c0-HP; Mon, 26 Oct 2020 11:04:41 -0400
Message-ID: <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Chris Mason <clm@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Oct 2020 11:04:40 -0400
In-Reply-To: <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
         <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
         <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
         <20201026142455.GA13495@vingu-book>
         <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
         <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uoSqbbpvT8hC+tuw0JPB"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uoSqbbpvT8hC+tuw0JPB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-26 at 15:56 +0100, Vincent Guittot wrote:
> On Mon, 26 Oct 2020 at 15:38, Rik van Riel <riel@surriel.com> wrote:
> > On Mon, 2020-10-26 at 15:24 +0100, Vincent Guittot wrote:
> > > Le lundi 26 oct. 2020 =C3=A0 08:45:27 (-0400), Chris Mason a =C3=A9cr=
it :
> > > > On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> > > >=20
> > > > > Hi Chris
> > > > >=20
> > > > > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > > > > Hi everyone,
> > > > > >=20
> > > > > > We=E2=80=99re validating a new kernel in the fleet, and compare=
d
> > > > > > with
> > > > > > v5.2,
> > > > >=20
> > > > > Which version are you using ?
> > > > > several improvements have been added since v5.5 and the
> > > > > rework of
> > > > > load_balance
> > > >=20
> > > > We=E2=80=99re validating v5.6, but all of the numbers referenced in
> > > > this
> > > > patch are
> > > > against v5.9.  I usually try to back port my way to victory on
> > > > this
> > > > kind of
> > > > thing, but mainline seems to behave exactly the same as
> > > > 0b0695f2b34a wrt
> > > > this benchmark.
> > >=20
> > > ok. Thanks for the confirmation
> > >=20
> > > I have been able to reproduce the problem on my setup.
> > >=20
> > > Could you try the fix below ?
> > >=20
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9049,7 +9049,8 @@ static inline void
> > > calculate_imbalance(struct
> > > lb_env *env, struct sd_lb_stats *s
> > >          * emptying busiest.
> > >          */
> > >         if (local->group_type =3D=3D group_has_spare) {
> > > -               if (busiest->group_type > group_fully_busy) {
> > > +               if ((busiest->group_type > group_fully_busy) &&
> > > +                   (busiest->group_weight > 1)) {
> > >                         /*
> > >                          * If busiest is overloaded, try to fill
> > > spare
> > >                          * capacity. This might end up creating
> > > spare
> > > capacity
> > >=20
> > >=20
> > > When we calculate an imbalance at te smallest level, ie between
> > > CPUs
> > > (group_weight =3D=3D 1),
> > > we should try to spread tasks on cpus instead of trying to fill
> > > spare
> > > capacity.
> >=20
> > Should we also spread tasks when balancing between
> > multi-threaded CPU cores on the same socket?
>=20
> My explanation is probably misleading. In fact we already try to
> spread tasks. we just use spare capacity instead of nr_running when
> there is more than 1 CPU in the group and the group is overloaded.
> Using spare capacity is a bit more conservative because it tries to
> not pull more utilization than spare capacity

Could utilization estimates be off, either lagging or
simply having a wrong estimate for a task, resulting
in no task getting pulled sometimes, while doing a
migrate_task imbalance always moves over something?

Within an LLC we might not need to worry too much
about spare capacity, considering select_idle_sibling=20
doesn't give a hoot about capacity, either.

--=20
All Rights Reversed.

--=-uoSqbbpvT8hC+tuw0JPB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+W5YgACgkQznnekoTE
3oNlGAgAtkGVNBd2a9XHIag/z/SA4HsBvh9aBDgkRFVq/c+5d6rO2Lg8cOYEU6hm
oFcZDlMEXGXNPLa8MBsAEsDqY8r8kz/pjpFSjLk81oeodMpKM2ZUAwacmTXfvgfL
9ZzYiuU6wKQVs1n78KTS15aRLd/1K1NLTR+kqW44Gi6UkWmV85YjqCagI8l2HbnB
VXxaLsiLVhMtd0dOFGZybKYpllrehaG18Jszeli8xzDm80DQ88a+L91g79mLAbxS
pfXc8x1rhw+J4dMwCJq185oT9qxcblANRH1lYrxZQV9xENdRPAMCpxjIar/T8jVK
NzSVEs3ZUvNHSityHaXdURJEg2/fTA==
=0/4b
-----END PGP SIGNATURE-----

--=-uoSqbbpvT8hC+tuw0JPB--

