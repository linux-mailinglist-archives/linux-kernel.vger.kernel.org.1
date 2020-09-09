Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A502633B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgIIRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbgIIPgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C142078E;
        Wed,  9 Sep 2020 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665771;
        bh=3HW7/YZpNR5PKfJypmmXKtFx2FgzoWRoaPzw05ImMYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLzlH809IZZ8Q09B/sG7jf9PBljl6iCXX/4tdxMzMRKUtkG2wiGZR4Cc90e61dTy5
         1dUPctUxZ8MElnHsnXk2AIxOxLjiSoNmcaIMcOMyywsWtCaAc//woQfJxCoEJg7YY+
         UF4UtexqtQji6PJ8oc/lVuKjdWwKoCies9lvjLG8=
Date:   Wed, 9 Sep 2020 16:35:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Device addition to the tlv320adcx140 and tas2562
Message-ID: <20200909153525.GF4926@sirena.org.uk>
References: <8c47c81f-5f83-2cf4-7bf1-62201b35bed3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <8c47c81f-5f83-2cf4-7bf1-62201b35bed3@ti.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 10:01:51AM -0500, Dan Murphy wrote:

> For the TLV320adcx140 driver I have another device which is register and
> bitmap compatible but it does not support Analog microphones or Line In l=
ike
> the x140.

> Should I add a new driver specifically for this part or should I add the =
new
> audio maps, widgets and controls to the existing driver?=A0 This would ma=
ke
> this existing driver really big in terms of LoC and object size.

Are they sharing anything (eg, the code is the same but the data tables
vary) or is it just two unrelated devices?

> Similar question for the TAS2562.=A0 I have a new device that is register=
 and
> bitmap compatible but removes the I/V sense. Adding this new device to the
> existing driver wouldn't be as intrusive as the x140 as the audio map and
> controls are much simpler

That definitely sounds like sharing the driver makes sense.

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Y9jwACgkQJNaLcl1U
h9BRGgf/a6zuU0wHCq5OOO1RymVVtslMfSmac1WHzxfuSkO69/NsPCzFN75Hf+aU
41aKjkomQcSwL+xAhIG5dvAKqtgxWUpJ/SmMtFT3EVIv3vwerr2aMlK25j1Im444
IJzswJ5J7U+FbLc7Ie8bs18+QX3Vnq/iRyt3tgT6sqEvlpPOQuWeS9a0WSVyYpKc
Ay6Rju4a2WzTYF5+B3XUsNZwpmlBG2UgG+thli0zqg8z/4brKGBSiethg40D6XcV
NeqLIj0x5pe2H/5T61++/KSibVi0HQZoKeUYnLwHM9am0fqxJtk4I2hFCC0d4wHS
kMEY/ad8Gny5AGUphwwmp9WxtI3XdQ==
=kQP4
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
