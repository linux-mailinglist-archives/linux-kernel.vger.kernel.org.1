Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4452F7C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbhAONM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbhAONM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:12:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC2D82256F;
        Fri, 15 Jan 2021 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610716337;
        bh=/pOnbiJh8C5AScCuERBndwrdoUImzTZwz+BjkazkJSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1A9eyEeghxG1xu1NXHmeM5jdKyYsMTWyjGjEPzU3Qt+zw820bLH01AR+pO3WHXlz
         OPmNP8wlAovbpkvhjC5E1IriHEC7U+5sv45dDxR2t04sQVGzZ7OR4gg0lUb/hCxemR
         QzGu52Bd9/Bq8BgZ4AEx8+44Tjxs66DH4dKM6ha3PWUjtITDHqXlV/q/qmQXL8PmqB
         BLyjV7vXMmHlk37iFS7vTmGaS4sWhAlbR+eVRSY+207l5ljs1gdpeNjlMEUDWeXS8l
         80pY0mJomBDIgeuNWjZLgQO9k0eUS94e0BfxbQmCzV+5jJpYtDaJ1UCH4LBMSM6X3V
         m2RP42hyRiDFg==
Date:   Fri, 15 Jan 2021 13:11:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Rob Herring <robh@kernel.org>, kuninori.morimoto.gx@renesas.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
Message-ID: <20210115131142.GA4384@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
 <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 15, 2021 at 10:35:23AM +0000, Richard Fitzgerald wrote:
> On 13/01/2021 16:09, Mark Brown wrote:
> > On Wed, Jan 13, 2021 at 09:22:25AM -0600, Rob Herring wrote:

> some_codec {
> 	pll: pll {
> 		compatible = "fixed-clock";
> 		clocks = <&audio_mclk>;
> 		clock-frequency = <98304000>;
> 	}

A PLL is not a fixed clock, why would you define a fixed clock here?
Are you confusing the selection of rates on existing clocks with the use
of the assigned-* properties that the clock binding provides?

> For this to work the clock binding must be a real clock object (so needs
> a valid compatible=). But I need to somehow specify the PLL ID and

That seems like a *very* surprising requirement - why would the clock
binding have that requirement?  It would seem to create issues for a
single device providing multiple clocks which should be a pretty common
coase.

> > > > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > > > +    description: |
> > > > +      A list of clock names giving the source clock for each setting
> > > > +      in the sysclks property.
> > > > +


Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmABlI0ACgkQJNaLcl1U
h9Ad4wf+NpbjhW4qXIhAE/mkqs7cQ7UrZ5RbD3y9XQxnUyiF4huBFqAnfcKRy+RU
Rbv5BkqxDJm6VcvlGqzZ9Uq16JOFFXNxN9ovQItAl5T0UkIksMm8WHxYWC34ckaq
cOrgHsEUvFsgRO0SwwBSl/0Miyndfy5kdppsML2bxC3bu+h/P/BX0dsAen67aNbG
LbhemYBmgjMIU41DtfaKHd9qtKULmX8OUgB4h2aaHOQP3pXVdSs0FhYYazqgRHZJ
7rUqEG4zvt7sJ9AsSZllA95Nqg2KQ2LYAuugSVER+GIIoWtVoqjgeBwKkNnu2dYo
4RzIeg4/17T68RY72c0AmwGDOkFVTg==
=klrm
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
