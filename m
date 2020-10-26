Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C73298E38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780344AbgJZNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780181AbgJZNio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:38:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722F121BE5;
        Mon, 26 Oct 2020 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603719524;
        bh=+nkoyj7yQTKFExiVobUJ42WV3wBkEKoQDjVeQdK1uug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzjepBlChROEPkQZXalULKXWZ6z0gcY6RHrUBqmueM940tkxh4zgu3aaoHDuPjOeM
         1RPIJOM67NJy8KBEjo+X4zUUm3Wp0xn/qy5+/f00KV7DyBM3w1Tz/YHtCkZgvZEhRV
         YekLsrViYQLPDnDdel3LexZ5PHxKndmJAv17TMsM=
Date:   Mon, 26 Oct 2020 13:38:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        nsaenzjulienne@suse.de, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] ASoC: audio-graph-card: Add plls and sysclks DT
 bindings
Message-ID: <20201026133839.GE7402@sirena.org.uk>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
 <20201016173541.21180-3-rf@opensource.cirrus.com>
 <20201026132704.GA19204@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20201026132704.GA19204@bogus>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 08:27:04AM -0500, Rob Herring wrote:
> On Fri, Oct 16, 2020 at 06:35:36PM +0100, Richard Fitzgerald wrote:

> > +- plls: A list of component pll settings that will be applied with
> > +      snd_soc_component_set_pll. Each entry is a phandle to the node o=
f the
> > +      codec or cpu component, followed by the four arguments id, sourc=
e,
> > +      frequency_in, frequency_out. Multiple entries can have the same =
phandle
> > +      so that several plls can be set in the same component.

> Where do the values of id and source come from?

The device bindings will need to define them.

> > +- sysclks: A list of component sysclk settings that will be applied wi=
th
> > +      snd_soc_component_set_sysclk. Each entry is a phandle to the nod=
e of
> > +      the codec or cpu component, followed by the four arguments id, s=
ource,
> > +      frequency, direction. Direction is 0 if the clock is an input, 1=
 if it
> > +      is an output. Multiple entries can have the same phandle so that=
 several
> > +      clocks can be set in the same component.

> Are these really common properties? They seem kind of Cirrus specific=20
> and perhaps should be located in the codec node(s).

It's very common for audio devices to have very flexible clocking, to
the exetent this is Linux specific it's issues with the clock API not
being able to handle clock controllers on buses that need clock control
to access rather than conceptually.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+W0V4ACgkQJNaLcl1U
h9AVQwf5AeZ5FzIxFAqR5KS3Q6dg/QnmdfAqWm5oroiARb2nuHh+2WKL2jFKLyiR
/mycXkP/S3TVoedKycpB4pAWXpyk0bYpsbZDolvZK8Yqygx8JKtxjzhw5N2fubCn
uKsxDBOuWxK8T4iQUqPI0xlA6CoziSx8jVT8xYEuuQ040IUmyR361aK6OTGxr2p3
Yq/fQyZeswr4i09lwsNk2BpDGKuVaKonvsLqGULZ+j10YQEOi6HKajvxbiyB0/yS
316Siu3n1TpYzclqs4CNsXVa1st0abkNSRvkVKajZo3/8MpCknXIRUI5aGD+cTx6
5MDUXLhvotazUVdZ886Vuqoig378yg==
=qTFO
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
