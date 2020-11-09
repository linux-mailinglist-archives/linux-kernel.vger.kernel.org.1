Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE62AC1D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgKIRJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbgKIRJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:09:00 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9795221D46;
        Mon,  9 Nov 2020 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941740;
        bh=mBaKv66FToFYhmWgmhHHLo9LkMrZiN2hV4di0JEK8NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0+9jUp7LmN+a1tGzUYWub0WDFR1wIDjTU4X4037efeXLmFlawaJSMVhUvOGPkYfJv
         lVgtB9azvvou3eAUwd8Cx2A0kK0DTqZrCsqz4LcC9wBhWtQfKui6liY77r3ug+8qEv
         FFY8zXCfcdG6nusHviIXkH5rVbunsomsxrMcOc48=
Date:   Mon, 9 Nov 2020 17:08:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
Message-ID: <20201109170845.GH6380@sirena.org.uk>
References: <20201106150747.31273-1-broonie@kernel.org>
 <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
 <20201106192300.GG49612@sirena.org.uk>
 <CAGETcx_hoDS1jHxfvrQv_+oMQw6E=AAiPANED+Ob6+a9mohW_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <CAGETcx_hoDS1jHxfvrQv_+oMQw6E=AAiPANED+Ob6+a9mohW_A@mail.gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2020 at 05:55:10PM -0800, Saravana Kannan wrote:
> On Fri, Nov 6, 2020 at 11:23 AM Mark Brown <broonie@kernel.org> wrote:

> > That also sounds good, particularly if we have a coccinelle spatch

> I've never used coccinelle. But I can fix 5-10 easily findable ones
> like i2c, platform, spi, slimbus, spmi, etc.

The thought with coccinelle (or like I say some other mechanism) is that
we would have something around to catch any new users that should be
using the helper but aren't rather than issues with making the changes.

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pd50ACgkQJNaLcl1U
h9BRjAf+LfJI8bpAjf1WYFl9exVtn3pN50+XT8g2bDDPgHl5WVVFa21AAQXYCnC7
yo/UR5HaX0cTJKedw+Roaq+5abc86g7uM0fnR1UwqQyI76mTJNwmSKanZgE0F/LX
ytyMnn4qeCHifD+aHpc0a4+rnbPR2zxFvVGDTbUvloKPA54n0fPEHIGT0D8iKogM
I1JSsOPwTVzZQSGdpsOC1L6B1EIgXaguJ9CffjzvznKOG03omXiuL8MkNO+sc4ET
290lrZ4qHjs7nYAQKK4k+ls5xxtWo0Vby+uHtP54M2cCCy8ifgDFpUV5CeC6MaMw
SCmSSr5ednsrngkOXeuqaRg/fczF7g==
=ZZ1E
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
