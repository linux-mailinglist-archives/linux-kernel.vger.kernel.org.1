Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8862CA6D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391525AbgLAPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390132AbgLAPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:17:55 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835362084C;
        Tue,  1 Dec 2020 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606835835;
        bh=dGfNSOBgGRBJkk/Dgt6x48Q5cXIZYVgrqNOCHjMDkls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jm01DLEJUVd9ljYXUFOFnvDXYouaD7xBo/EfaVWKNbXZaKWnA8Enq2kgNj3Dzr65D
         9+v/oLboL5EjgttiJnoat4rw1L/ku95iNEl3J7Dtn4AlshxKZvoGi4tm95B8LEE38b
         6KKT/FCY/dFGKul8AkDWrjXE1u12QzCJedmi23XQ=
Date:   Tue, 1 Dec 2020 15:16:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shane Chien <shane.chien@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        alsa-devel@alsa-project.org, jiaxin.yu@mediatek.com,
        chipeng.chang@mediatek.com, jeter.chen@mediatek.com,
        tzungbi@google.com, fan.chen@mediatek.com,
        Hsin-Hsiung.Wang@mediatek.com
Subject: Re: [RFC] ASoC: Add compatible for mt6359-sound device
Message-ID: <20201201151645.GI5239@sirena.org.uk>
References: <1606801293-19472-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <1606801293-19472-1-git-send-email-shane.chien@mediatek.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 01:41:33PM +0800, Shane Chien wrote:

> However, if the device is not given a comaptible,
> of_node of struct device is null. I cannot use
> devm_iio_channel_get such iio interface to get
> auxadc value from iio channel. Because during
> using devm_iio_channel_get, of_node of mt6359-sound is a
> input parameter of of_iio_channel_get_by_name.
> If the of_node is null, devm_iio_channel_get will
> eventually return ENODEV error.

I would expect the IIO channel to be requestable using the top level
device for the MFD - part of the deal here is that the function drivers
for the MFD know they're part of the MFD so can look at their parent
device for some things (eg, this is how regmaps are normally obtained).

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GXlwACgkQJNaLcl1U
h9BAOwf/YpwGU5QaZRcMFXBXVD7bkQtu2EutCs5svrbEIbr3lA1niZuznQAxi+6a
EJCmeJQMOhfM1eWqoPsMR8Ys1EKuWKLwG6YQWS08MaQnTYWfxbrUOVojFD58OzaL
hQo4Yi/3k08L2Hne44kqKBRtlKsOUinIUZi3Bfd+kApSW1EpnKsSr91qfyTJRFrx
7qBCTxt2qNnd47lDqIrDEm72iyFR9SyCAttQJCGBnqm6ByFEhZgGQh92GOZfWG/w
Ubq9Y3f3nY08xj3kCQD+H8HAjTPh8zdtXk5oJe8X80j9FyZDbQ01GlFkcnWeL7+p
cc8ntzCYuiapNx0EQQhYBOrTDUkX8Q==
=4ZF0
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
