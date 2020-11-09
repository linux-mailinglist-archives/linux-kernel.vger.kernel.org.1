Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332752AC2AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgKIRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbgKIRlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:41:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A276521D93;
        Mon,  9 Nov 2020 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604943682;
        bh=jltC+bDWwlOBb3k+Lvr3JSR+3XveeKXCX1xQmKSLgQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weCjyh02JTUiDSJx+tgvVS4Q1Z4WDTGoYFDi2S8mBUL3rbrib5togaKtxZ5mcNkOY
         7fO6b/qvY+fhk/OiEIPUuQboLa2hqQH9iHS1V+GU9paet0OUOzEOGdu621uDZHdDTJ
         LLoTSytEbhg07OMGI56JrINl99ayhNtlsG9ecy98=
Date:   Mon, 9 Nov 2020 17:41:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
Message-ID: <20201109174108.GK6380@sirena.org.uk>
References: <20201106150747.31273-1-broonie@kernel.org>
 <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
 <CAL_JsqKfEWY8+suK3vrtbJbgWzDkCeDV_s61dh5Xwj13cHzCUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKfEWY8+suK3vrtbJbgWzDkCeDV_s61dh5Xwj13cHzCUQ@mail.gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 11:25:39AM -0600, Rob Herring wrote:
> On Fri, Nov 6, 2020 at 1:09 PM Saravana Kannan <saravanak@google.com> wrote:

> > And all the subsystems that create their own device from an of_node
> > should use of_set_device_of_node() to set the device's of_node. That
> > way, all this is done in a consistent manner across subsystems and
> > avoid all of the of_get/put() and OF_POPULATED set/clear strewn all
> > over the subsystems.

> Perhaps a fwnode call in device_add instead that implements the above
> and anything else needed for each type of fwnode. It might even be
> possible with that to get rid of most of

I'd suggested doing it with a callout as well in the original thread
that sparked my proposal - my patch was just the most minimal
implementation to fix the current problem.

> of_platform_device_create_pdata() and of_device_add(). IIRC, those
> were pretty much copies of the core code.

> That would also be less fragile than having a coccinelle script.

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pfzMACgkQJNaLcl1U
h9BwuAf+Ifvb6jENdSABE4ZiMAMqCgybbePbrFprkqHG4M7jIiXqRSigNor+ptQS
3GFjy2IiR5+LgRW58IThVh97j3Ju4sCIGXZvlV1ixs2HfMDL58cuVkIOEL8Q9zqC
WF0gBQlyO1rhgxbj48fD1czx5I8q5jxcNdophbDNOHNB2vNcr8yXbZyPZLdsD8Dh
N2sfmi9Kls1yfhqzh7B9XU2nS/D4h5afIpfQNz9TEQSg2Ka3otnLdysQUQkim+6S
BxOLUbSxeB+r0IXGSJqjEZYnWREojywWymdHUpXk4w57b0G10bh2CFWmAKNbCEqV
IjUNKcURgrgns5KHUKXXA4NtVLOHmg==
=jsPy
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
