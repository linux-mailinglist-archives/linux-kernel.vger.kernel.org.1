Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978481B0B28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgDTMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgDTMxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:53:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC8E206D5;
        Mon, 20 Apr 2020 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587387234;
        bh=caw1VnqJBp4MmqQVV2viMKeXieGpJDQ6lgh7Vj0LSgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TewWD3QBS7jjs40MyYGUTfuWbpyyyAVRhZmUOezodYD84VT5bL/uVC7hiLSLPFrOy
         8SYQQVx52JndV9PSdr3WR5G/BqK/8pmOohSM6SZvLBLnvc0fdrDo8c2Y50gJxADm+T
         Ur/N8PFT2lKlInjR8r7E/nc8gfXRc09SYxLFx57Q=
Date:   Mon, 20 Apr 2020 13:53:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Message-ID: <20200420125348.GC10045@sirena.org.uk>
References: <20200417221341.31428-1-TheSven73@gmail.com>
 <20200420121542.GB6507@sirena.org.uk>
 <CAGngYiWauBTnXDcP9UC1S7U5Ogy0B=bUZSdGs1Z9aKZ2+sB=Qw@mail.gmail.com>
 <20200420122534.GC6507@sirena.org.uk>
 <CAGngYiV9MxeLrERkgU2+rucCiJ5StCXN7GXxKLMfaJ-bqSpAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <CAGngYiV9MxeLrERkgU2+rucCiJ5StCXN7GXxKLMfaJ-bqSpAAw@mail.gmail.com>
X-Cookie: Hope is a waking dream.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 08:50:45AM -0400, Sven Van Asbroeck wrote:
> On Mon, Apr 20, 2020 at 8:25 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > I'd expect someone with knowledge of the hardware such as yourself.
>=20
> I claim no expertise - I was just getting tired of dragging the
> out-of-tree vendor
> driver for this chip from kernel to kernel. AFAIK, most people using this=
 chip
> have forked the vendor driver and adapted it to their specific needs.

> If my name has to be there, I'd be keen to hand it over once someone more
> familiar with this chip comes along.

I think by virtue of taking this step you have become the de facto
upstream expert on this chip!  Like you say hopefully someone more
familiar (ideally from Microsemi) will turn up.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dm1sACgkQJNaLcl1U
h9C0kAf/VfluleklGZwAwINGUKEsAnNMMpgzkCeC04jQeANQold1WwieTBWwOlcm
t9AoRee4bTR6kFSHkHmRfUMgC3GUl8Dy1St/+2r43UMUYbR4FP3WhrQrVNRRQUob
AjFB/5ibXcAdnqL63YRzKl/NYT0Hpvz8m++w0++NZ0JXjvD8il1Z5kgV6HnHEZq8
4zc9STyT0aZXjDCwBA82dGEXOEit8YOsUwEjTt9k/XzcC7EBZslzgBEMwNmnnCBJ
PHrUFwhx4RJrynRLDDKX4j2RXbwhmiMp6CZAj0wMfNdZdFAFSVNr3ZFA/xIT0QJD
H8Oo73IWb8FVBHM7hm/z2nGhCWl/wQ==
=UrRl
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
