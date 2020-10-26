Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B578298F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781779AbgJZOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:40:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55304 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781541AbgJZOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:38:33 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kX3dg-0003AN-4n; Mon, 26 Oct 2020 10:38:24 -0400
Message-ID: <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Chris Mason <clm@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Oct 2020 10:38:23 -0400
In-Reply-To: <20201026142455.GA13495@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
         <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
         <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
         <20201026142455.GA13495@vingu-book>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FbC/ZK+CB+Qj4hOykJPj"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FbC/ZK+CB+Qj4hOykJPj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-26 at 15:24 +0100, Vincent Guittot wrote:
> Le lundi 26 oct. 2020 =C3=A0 08:45:27 (-0400), Chris Mason a =C3=A9crit :
> > On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> >=20
> > > Hi Chris
> > >=20
> > > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > > Hi everyone,
> > > >=20
> > > > We=E2=80=99re validating a new kernel in the fleet, and compared wi=
th
> > > > v5.2,
> > >=20
> > > Which version are you using ?
> > > several improvements have been added since v5.5 and the rework of
> > > load_balance
> >=20
> > We=E2=80=99re validating v5.6, but all of the numbers referenced in thi=
s
> > patch are
> > against v5.9.  I usually try to back port my way to victory on this
> > kind of
> > thing, but mainline seems to behave exactly the same as
> > 0b0695f2b34a wrt
> > this benchmark.
>=20
> ok. Thanks for the confirmation
>=20
> I have been able to reproduce the problem on my setup.
>=20
> Could you try the fix below ?
>=20
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9049,7 +9049,8 @@ static inline void calculate_imbalance(struct
> lb_env *env, struct sd_lb_stats *s
>          * emptying busiest.
>          */
>         if (local->group_type =3D=3D group_has_spare) {
> -               if (busiest->group_type > group_fully_busy) {
> +               if ((busiest->group_type > group_fully_busy) &&
> +                   (busiest->group_weight > 1)) {
>                         /*
>                          * If busiest is overloaded, try to fill
> spare
>                          * capacity. This might end up creating spare
> capacity
>=20
>=20
> When we calculate an imbalance at te smallest level, ie between CPUs
> (group_weight =3D=3D 1),
> we should try to spread tasks on cpus instead of trying to fill spare
> capacity.

Should we also spread tasks when balancing between
multi-threaded CPU cores on the same socket?

Say we have groups of CPUs
(0, 2) and CPUs (1, 3),
with CPU 2 idle, and 3 tasks spread between CPUs
1 & 3.

Since they are all on the same LLC, and the task
wakeup code has absolutely no hesitation in moving
them around, should the load balancer also try to
keep tasks within a socket spread across all CPUs?

--=20
All Rights Reversed.

--=-FbC/ZK+CB+Qj4hOykJPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+W318ACgkQznnekoTE
3oPRJwf/ekaSHMN/L8hJqdMIYltLVYfygVSAtGgPBkOpmPLPk5eL9eqdL1vq6Rrt
FwvI4O2D6g4rHdiLDs7TavOvoObeWkvl55P5XZSC/csv22RSr0opPMViYB0G+JYM
r2iJiLom2JnrVb3c0426yBhDw0MXIt+5YYlyQFrMS0ApICPyLqCvj29U3iyV9avu
Gyfn9aX7q4seK3YjN5ZvfO68PrsWy2Q6NjELHDJvqn+x8s2UZoC+8WAISJLy1YLm
n9YgZ80wAdaGGGzXFMvWR+PMnFkoWjDg3AnW5E3ddLj/yX4QVUjYZngYo3nS14F8
vobufUfweqzaA4BCZz+tkISfw1ZR0w==
=BfCB
-----END PGP SIGNATURE-----

--=-FbC/ZK+CB+Qj4hOykJPj--

