Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9929DF80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbgJ2BBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbgJ1WRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C49B24729;
        Wed, 28 Oct 2020 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603888384;
        bh=JjosDQUQWy+igGYJmi0WKgC37EooXcht+4cENWAQ6Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbLyeh/f2x+UbRkun//FS7B6sqSJ49mZj3OjgR6PH4K3KimUfhQFLFQ6BQPpDkCrd
         xi6fy+k5S0DCdxxqLMWbdRDThoe5KIcN/Br4V+NWhUhQd3f5FlHfQqGnMXr4lOYcJO
         tMDfNOqREnHBUA/He70ECmiVEDgoqoC5rZiPVyWs=
Date:   Wed, 28 Oct 2020 12:32:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulator: add support for MT6392
Message-ID: <20201028123258.GA6302@sirena.org.uk>
References: <20201024200304.1427864-1-fparent@baylibre.com>
 <20201026121316.GB7402@sirena.org.uk>
 <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
 <20201026172431.GI7402@sirena.org.uk>
 <CAOwMV_xt=OV6cKqQTZUUSAvYKxUUQZAUywAHtFFHL=E5xVu-Zg@mail.gmail.com>
 <20201026203608.GJ7402@sirena.org.uk>
 <CAOwMV_xUWea81rKFE=zD4xWL3rZ5G8cpWm5xJHT_AX=_frLDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <CAOwMV_xUWea81rKFE=zD4xWL3rZ5G8cpWm5xJHT_AX=_frLDRQ@mail.gmail.com>
X-Cookie: Allow 6 to 8 weeks for delivery.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 10:16:22PM +0100, Fabien Parent wrote:

> You are correct, the regulator driver is running and probes
> successfully. From my investigation it seems the failure when removing
> the compatible string from the MFD and the DTS is because the
> regulator driver does not have a of_node matched since the compatible
> is gone. Because of that all the regulators registered by the driver
> are not linked to the regulator definitions in the device tree. And
> all the drivers that tries to acquire a regulator get -EPROBE_DEFER
> because of it.

You should be using the of_node from the parent device to find the
regulators set, look at how other drivers do this.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+ZZPkACgkQJNaLcl1U
h9DLuwf8DzKutRHbnWwgtdxlm8DfM8hWMooeqasKequJUEAmXWGYbeSU5pTqxSXk
b0EkuVYWkUZn8gQI7baerDzLXYRr2pJ64DMrFazHGKBOKzcWza4s93rt7B7O2ORg
5Y4BqFFcD3qAH6ESQ+fGxT7bGLxtWX9CdZBUK8boENVDTn7Q/ZF833nj6jrgFaq6
w3ZzA7Vh4xp9HU16R3bpQEtAvVZgj1QR0yD4T7aXooPAWsYhkm1sRwUyntmoiPse
Qt0z6RRjCFjMuiVk06KlVFvSQ3irJ4YCDEw/o0jyr+97cIvXuAqB4DuRBN+kYScs
s97xCQiyWLaspaWtWP3UyF3CS1IO8w==
=epRM
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
