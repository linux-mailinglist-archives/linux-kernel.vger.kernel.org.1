Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18D240BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHJRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 13:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgHJRcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:32:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FD12065C;
        Mon, 10 Aug 2020 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597080723;
        bh=oZe42++Hgg6ZFjBHnsP0bMFn0TjS0RlTPEWAMgF4BiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7sCw4r3USXIU8egMjTAkXitAFF46fszmesuZJeIykHkKHtbCwJM+qagK/ijQKPhq
         M8vNPDPCof0urrAP/M/iuC7UWlY+2EBxh2TTloYPm6IC95AzFbGu5FKSgsW2LERQB+
         THFCep3l7mpcetAM2B6Jym/1pq/QpeLSqysENHcE=
Date:   Mon, 10 Aug 2020 18:31:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810173136.GF6438@sirena.org.uk>
References: <20200809222537.GA5522@qmqm.qmqm.pl>
 <20200810153928.GD6438@sirena.org.uk>
 <20200810160936.GA1100@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20200810160936.GA1100@qmqm.qmqm.pl>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:09:36PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Aug 10, 2020 at 04:39:28PM +0100, Mark Brown wrote:
> > On Mon, Aug 10, 2020 at 12:25:37AM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:

> > > regulator_lock_dependent() starts by taking regulator_list_mutex, The
> > > same mutex covers eg. regulator initialization, including memory allo=
cations
> > > that happen there. This will deadlock when you have filesystem on eg.=
 eMMC
> > > (which uses a regulator to control module voltages) and you register
> > > a new regulator (hotplug a device?) when under memory pressure.

> > OK, that's very much a corner case, it only applies in the case of
> > coupled regulators.  The most obvious thing here would be to move the
> > allocations on registration out of the locked region, we really only
> > need this in the regulator_find_coupler() call I think.  If the
> > regulator isn't coupled we don't need to take the lock at all.

> Currently, regulator_lock_dependent() is called by eg. regulator_enable()=
 and
> regulator_get_voltage(), so actually any regulator can deadlock this way.

The initialization cases that are the trigger are only done for coupled
regulators though AFAICT, otherwise we're not doing allocations with the
lock held and should be able to progress.

> > > Basically, we have a BKL for regulator_enable() and we're using ww_mu=
tex
> > > as a recursive mutex with no deadlock prevention whatsoever. The locks
> > > also seem to cover way to much (eg. initialization even before making=
 the
> > > regulator visible to the system).

> > Could you be more specific about what you're looking at here?  There's
> > nothing too obvious jumping out from the code here other than the bit
> > around the coupling allocation, otherwise it looks like we're locking
> > list walks.

> When you look at the regulator API (regulator_enable() and friends),
> then in their implementation we always start by .._lock_dependent(),
> which takes regulator_list_mutex around its work. This mutex is what
> makes the code deadlock-prone vs memory allocations. I have a feeling
> that this lock is a workaround for historical requirements (recursive
> locking of regulator_dev) that might be no longer needed or is just
> too defensive programming. Hence my other patches and this inquiry.

We need to both walk up the tree for operations that involve the parent
and rope in any peers that are coupled, the idea is basically to avoid
changes to the coupling while we're trying to figure that out.

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xhHgACgkQJNaLcl1U
h9CfMQf9Eg4+ug/C1LBFP+DyBk2x5i1vOxSZ+e/rIg1GhlKDWHbo+8xs2JaF0irl
dJJjCqiD0Uy1ZSfeWT2hRFnugj4rIyd+5LZ6LCXBSl7qQfMA/v8gOt4kvgmtFx41
tOSnZnthSbpPvtbqwZiwuSbHbHxGSmkgiQkEgB2P+AuviLX8kWi3RfiqZybvfNIy
5h77CXoMf0mXDVc8KGqrPGRABMucGs9gN9nGyvDjn29oEUU9e7bfdN90Piv2fOlV
FVirjg0avq8plN5cMGVKAJ5CpGwXSBY1sKydNRChNJUN68c/Y7a7FrKkZmRx3fXM
G+042653oviF+K1wcb1c3HGy0RXc5g==
=3WG/
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
