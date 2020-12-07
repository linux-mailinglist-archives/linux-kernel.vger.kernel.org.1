Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F12D1262
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLGNoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgLGNoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:44:05 -0500
Date:   Mon, 7 Dec 2020 13:43:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607348605;
        bh=wotNOYxA0QL56wa7cv2eh0l6rqQGsnFURh59UqWfzcI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Etdi2P97rsqOiU/zkCnFOWgZkSi6IWJKDp2cYzZy4bw3py/FpbC2cDTa0Kfv5bnV6
         6aru8Gts7KIE3bQDbjiuB8wUmVceg/lp8vFxPhOCDdaaZT71Z81/IV/o64/APEaB5s
         69yAankV1/NUlY4gVLKPB8bVFioFENVhwupSUDS0KEDyFZrTfo3/hbjuTEeRnyNJvA
         mPFIGx52/azwbR8ZxaxVuc1AEEDzcAvdK9bxb/7g5as3I4HYi72fBErSjPiFaIe7xo
         OfvPRcrL+8CRMsO0Yvfio6pD6i2VIVkCcymmkRrzj+j5MorH8VQBxCmkPghWUZ35V6
         eqSbHN5Jo+f6g==
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201207134319.GD5694@sirena.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <20201205205744.GD8578@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20201205205744.GD8578@amd>
X-Cookie: Absinthe makes the tart grow fonder.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 05, 2020 at 09:57:44PM +0100, Pavel Machek wrote:

> If the patch causes regression it will ultimately need to be
> reverted... no matter how much it fixes.

It's regression fixes all the way down...

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/OMXYACgkQJNaLcl1U
h9A7egf+OKPMlMqpnJRmYxrR2zo8x+e16XmFT2HBgfNbTQ3vQVEVDv8f5MMxB1n8
ad3/tkpuwyBAHBwiaUEI2fr6uebD2E2tnQp+KavBWF82+AZfqHajsLeR3f5teV/S
XM5baZdGDvGVNxz0UozzkJIGuUu9DDMjiiCqzPcC6AQUl4sd1YBXApG4EWaTmWP+
GBZ1+p2VH43GXhD7GgmjBG8RTXkZDFXf86D1CxrNVaztS63DFlW/44i0V6DR/YeR
2o1HjIsYH0n+ONbQzdzUFSbExlDFl6LZICuA3Df2G2T5iOxakk37q1VMZpB9plPL
iCjU6kAaPsHBPztxUJEriHMYOawfeg==
=rQb+
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
