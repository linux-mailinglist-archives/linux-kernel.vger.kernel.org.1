Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE72A6655
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKDO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:27:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49054 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKDO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:27:08 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1kaJkf-0005nk-Mq
        for linux-kernel@vger.kernel.org; Wed, 04 Nov 2020 14:27:05 +0000
Received: by mail-qk1-f197.google.com with SMTP id h23so13080666qka.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FxTRSiAFwPmYURxbjJy4qhXMwp6/WAsDGgzjyMh2+8=;
        b=GmAISOqhLMohTYyqAmxDZirOp5p/AyU/5A5OLl3Bh17/hYWbPTa+X8GgCRnEKH3FnP
         AUgGkmj95d/qm30pWreueWl5vBATsAiKV9ywA45vjEZAZbY86mslQ6BWVSfeiQrVOthx
         m2SuDfW2EpHWWs0BrFagza8nk8WK4sttFr74a/+TtA3xxHkGYQNokcVTJAopArg8RdSS
         /zLXt0IcTZrndwUsmMwO3CZc8DsOrDFNOGpH9oBFSf0aCicrOEecX8eHYH3+cKBzMoLY
         K5XAWuixe/1IvOtykLG+De4XkNau/LtclZulyUVaCwoMHATfnoYD1WzW4WDaq7CwnEk4
         EFfQ==
X-Gm-Message-State: AOAM53396yqFkzVoghtr+onuoa7xyEo1D7a/bQ4CaGsVwCjzfMVPs8cV
        mHVOhWQdC0SIbnbI2AcwjTD5dkOQjdrqVItmHNPvlsQb5tbVeFVUjsmg8VJZcMPm7NdwafzytAp
        dUwpDpqu9G8hVI0oBC9l5RJ5D8+I0ZUT05dWAPNyI
X-Received: by 2002:a05:620a:1375:: with SMTP id d21mr20367771qkl.309.1604500024702;
        Wed, 04 Nov 2020 06:27:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKsxdAfXcYVfxoaP0+oQhbM1s9s4Tx6B0FRgM4PPcZaEGl/EfjHO1xLtQikwGp2DKIvXWnbw==
X-Received: by 2002:a05:620a:1375:: with SMTP id d21mr20367738qkl.309.1604500024357;
        Wed, 04 Nov 2020 06:27:04 -0800 (PST)
Received: from valinor.lan ([177.27.227.4])
        by smtp.gmail.com with ESMTPSA id g66sm2544676qkb.91.2020.11.04.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:27:03 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:26:54 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Willy Tarreau <w@1wt.eu>, linux-crypto@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        And y Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>, simo@redhat.com
Subject: Re: [PATCH v36 00/13] /dev/random - a new approach
Message-ID: <20201104142654.isznf3lkgupuxubv@valinor.lan>
References: <20200921075857.4424-1-nstange@suse.de>
 <2961243.vtBmWVcJkq@tauon.chronox.de>
 <20201016172619.GA18410@lst.de>
 <3073852.aeNJFYEL58@positron.chronox.de>
 <20201028185117.74300988@blackhole.lan>
 <20201028180728.GA2831268@kroah.com>
 <20201102154435.71cab8c0@blackhole>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3ht24lcycwlydt7"
Content-Disposition: inline
In-Reply-To: <20201102154435.71cab8c0@blackhole>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3ht24lcycwlydt7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 02:44:35PM +0100, Torsten Duwe wrote:
> On Wed, 28 Oct 2020 19:07:28 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > On Wed, Oct 28, 2020 at 06:51:17PM +0100, Torsten Duwe wrote:
> > > On Mon, 19 Oct 2020 21:28:50 +0200
> > > Stephan M=FCller <smueller@chronox.de> wrote:
> > > [...]
> > > > * Sole use of crypto for data processing:
> > > [...]
> > > >  - The LRNG uses only properly defined and implemented
> > > > cryptographic algorithms unlike the use of the SHA-1
> > > > transformation in the existing /dev/random implementation.
> > > >=20
> > > >  - Hash operations use NUMA-node-local hash instances to benefit
> > > > large parallel systems.
> > > >=20
> > > >  - LRNG uses limited number of data post-processing steps
> > > [...]
> > > > * Performance
> > > >=20
> > > >  - Faster by up to 75% in the critical code path of the interrupt
> > > > handler depending on data collection size configurable at kernel
> > > > compile time - the default is about equal in performance with
> > > > existing /dev/random as outlined in [2] section 4.2.
> > >=20
> > > [...]
> > > >  - ChaCha20 DRNG is significantly faster as implemented in the
> > > > existing /dev/random as demonstrated with [2] table 2.
> > > >=20
> > > >  - Faster entropy collection during boot time to reach fully
> > > > seeded level, including on virtual systems or systems with SSDs as
> > > > outlined in [2] section 4.1.
> > > >=20
> > > > * Testing
> > > [...]
> > >=20
> > > So we now have 2 proposals for a state-of-the-art RNG, and over a
> > > month without a single comment on-topic from any `get_maintainer.pl`
> > >=20
> > > I don't want to emphasise the certification aspects so much. The
> > > interrelation is rather that those certifications require certain
> > > code features, features which are reasonable per se. But the
> > > current code is lagging way behind.
> > >=20
> > > I see the focus namely on performance, scalability, testability and
> > > virtualisation. And it certainly is an advantage to use the code
> > > already present under crypto, with its optimisations, and not rely
> > > on some home brew.
> > >=20
> > > Can we please have a discussion about how to proceed?
> > > Ted, Greg, Arnd: which approach would you prefer?
> >=20
> > Greg and Arnd are not the random driver maintainers, as is now
> > correctly shown in the 5.10-rc1 MAINTAINERS file, so I doubt we (well
> > at least I) have any say here, sorry.
>=20
> No problem. get_maintainer (for the proposals) works on paths, not on
> topics and I didn't want to leave anybody out.
>=20
> Ted, if you don't have the time any more to take care of /dev/random,
> it's not a shame to hand over maintainership, especially given your
> long history of Linux contributions.
>=20
> Please do seriously consider to hand it over to someone new. This would
> be a good opportunity.
>=20
> 	Torsten
>

I'd like to help with any solution upstream decide to follow either
testing or with code. I understand some of the concerns the community
has regarding FIPS but that doesn't make it less relevant and it's
totally possible to improve /dev/random while allowing it users to
decide if they want to comply to SP 800 90B. I believe the main
blocker now is the lack of direction.

--=20
Regards,
Marcelo


--i3ht24lcycwlydt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAl+iui0ACgkQ6e82Loes
sAmKJwv+Ifw7npNss6a/lI0XCzmyEpaU09w7DVPDdtWL9zFV5g29b3ETUcvlx4c2
/aT09yb15XxUtmiloUKyFBi7XPp8/xo4a36sxKT/vlEfHWtG4JpK8+DY1yTflqCF
+AS/vD0CUA3ypvSoOma192Eiy9hqy8BK0lwrDEVqH3awyLyTO7j1JYtHYmDsNEif
D5f2ckeBxx4ak9cRnOzkpefzaOBihjdUneROd6L7sVpPkyEyPcOzRRYBf5RwwOkt
rV8VDm+goPtNLgY0YXTrTO8kbcxrvN3Q8duqm9UuJu//a5MOt2iP4YgOs36Hg7Qq
nyBXnmKcP0adhxlHiJ5Ni0KlTxs1UJvXppbI+2xpsWfoUsxp5LQSjgel0aSDoeOn
roqV6+BpniChCF0beHnUXiizau9Vq8vMlanRBAW+nROnd8NpMy+biderEyBN5yU/
d767gg8943GyisRal91J9A8WRNyYvUuw9x+H6aTFrfioVSPh9mCC+DbfPHEt0dkf
As6v0pxl
=nZiN
-----END PGP SIGNATURE-----

--i3ht24lcycwlydt7--
