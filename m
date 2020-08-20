Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9624C6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHTVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 17:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgHTVFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:05:46 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6FD2075E;
        Thu, 20 Aug 2020 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597957546;
        bh=AqhgGqChx4PyupGE6ugWK1kycl0VueGsjaews8FHDA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2A/0r+aqwPe+i8dVHD1kYe6oKDrVXTPiY/JViCwkwWN4RMjYCLPQD4eHbxpR2ubi
         EO35uXejQa9jiezSvQEvSTJxUWZd9iVADrZNB+1fjlYNRV5e52kiqo/t0qB4N4YDNu
         PY2iZsevrL2ULfE1EW8qM4HR0QsxGtML0nLf+WIY=
Date:   Thu, 20 Aug 2020 22:05:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] regulator: mp886x: implement set_ramp_delay
Message-ID: <20200820210513.GA41191@sirena.org.uk>
References: <20200820171020.5df4683b@xhacker.debian>
 <20200820171051.55a238e8@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20200820171051.55a238e8@xhacker.debian>
X-Cookie: Chairman of the Bored.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 05:10:51PM +0800, Jisheng Zhang wrote:
> Implement the .set_ramp_delay for MP8867 and MP8869. MP8867 and MP8869
> could share the implementation, the only difference is the slew_rates
> array.

This doesn't apply against current code, please check and resend.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+5YgACgkQJNaLcl1U
h9A1nAf8D1GyahknGkTwFFwdcrvR2D4z5498nu11SANPZlbnnyCJKMCiUTH7Dvgh
xBIE5I38VWRWSsQJ2TwNXQVyTa6bYcP60ZuUW1HWHC62SN2fHu0d9I/DxffUtGv2
VJAI8V5vySIg2BwPsXUamVRhOJOZuuBNmYpBCkRy30f6hWGxpNRq4AQ41uuAxSkK
MptKVOXI9JkcO8kTFICZIlMLId74qKzS4JeK7tSN1mbVd9FUAJ7iye9LLxiPeVb3
tnQ3U+uYLfADpb85X9urveXefyoc28xPgFC9PMXevvR4mPFYk0GOkeML1xAmYo6A
gLqQgHWbmkRUjwAtCJWIoKzgpq26+A==
=Frl2
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
