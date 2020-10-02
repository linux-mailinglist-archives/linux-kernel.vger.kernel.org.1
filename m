Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E02813C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgJBNL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:11:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48028 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:11:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D54641C0B79; Fri,  2 Oct 2020 15:11:26 +0200 (CEST)
Date:   Fri, 2 Oct 2020 15:11:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: FYI: PoC: Running 100000 processes in 5.3.18 (SLES15 SP2)
Message-ID: <20201002131126.GA11778@duo.ucw.cz>
References: <5F76FA24020000A10003BB47@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <5F76FA24020000A10003BB47@gwsmtp.uni-regensburg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Just in case someone is interested: As a Proof-of-Concept I started 100 t=
housand processes on a big machine (72 cores). It worked!
> However starting those too more than 30 minutes, and top needs more than =
30 minutes to refresh ist display. Still, interactive input via SSH works n=
ice, but any file-system access seems quite slow (my test processes just us=
e CPU; the do no t do any I/O).
>

Okay, well. So you have kind of N^2 task, new processes need time and
all the all processes are already eating CPU... You are getting 55
processes per second, and that's not exactly good result.

> Kernel messages while the processes were created:
> kernel: [65648.247688] perf: interrupt took too long (2516 > 2500), lower=
ing kernel.perf_event_max_sample_rate to 79250
> kernel: [65997.263218] perf: interrupt took too long (3146 > 3145), lower=
ing kernel.perf_event_max_sample_rate to 63500
> kernel: [66790.221057] perf: interrupt took too long (3938 > 3932), lower=
ing kernel.perf_event_max_sample_rate to 50750
> kernel: [69884.371426] perf: interrupt took too long (4925 > 4922), lower=
ing kernel.perf_event_max_sample_rate to 40500
>

I'm seething these even without trying to overload the machine.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3cm/gAKCRAw5/Bqldv6
8t55AJ9jdEGeGIv5mB9b2WVmUM9hJ749VgCfc4A7a6dA3siGKNxlAUXEFN2qOO8=
=PHes
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
