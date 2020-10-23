Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653212976DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbgJWSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460542AbgJWSWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:22:31 -0400
Received: from localhost (cpc102338-sgyl38-2-0-cust404.18-2.cable.virginm.net [77.102.33.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EE52072E;
        Fri, 23 Oct 2020 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603477351;
        bh=g4Z1mEpWuSmzkjJ5L1e+SxSJ9L0l5TW+r7ryephYBoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHrncFJOwMRSpgG4SXq5EHZGizsYd/kfWIaTNsKvXlK2soj26uM33RSr/0qi98Els
         NIVT5OWXTfU3x2fxpSt4ZoW8RPXGgKF9zxfXJhKL//hW+TrtSk3gQzM9L6bg4vjePd
         a1Qu+h5NpbMKQrSog1Hp1VYaXSUVJ9/erkkt78oI=
Date:   Fri, 23 Oct 2020 19:22:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Antti Palosaari <crope@iki.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>,
        Chris Leech <cleech@redhat.com>,
        Colin Cross <ccross@android.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
Subject: Re: [PATCH v3 00/56] Fix several bad kernel-doc markups
Message-ID: <20201023182218.GA5582@sirena.org.uk>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anton Vorontsov <anton@enomsg.org>, Antti Palosaari <crope@iki.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>, Chris Leech <cleech@redhat.com>,
        Colin Cross <ccross@android.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>, Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Maxime Ripard <mripard@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomasz Figa <tfiga@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <20201023111240.2cc72568@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20201023111240.2cc72568@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 11:12:40AM -0700, Jakub Kicinski wrote:
> On Fri, 23 Oct 2020 18:32:47 +0200 Mauro Carvalho Chehab wrote:

> > @maintainers: feel free to pick the patches and
> > apply them directly on your trees, as all patches on=20
> > this series are independent from the other ones.

> Sorry Mauro, can I hassle you for resending 18-20 as a separate series
> or just loose patches to netdev?

> We got a bunch of checks run on all submissions and when folks CC only
> a slice of a series to netdev the CI bot thinks the series is incomplete
> and doesn't pick it up :(

FWIW something similar with patches for different trees sent separately
would also be helpful for my automation.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+TH1kACgkQJNaLcl1U
h9Ag8Qf+K2nlMzzzJryrbVZon7xJUysyeyKlZFW7M0QAHzunBi9F4QOkxoNMF7yZ
ioQchiv1zhOwvC0SffxXvt9GF+jUL4bunjKVnl0PtMFooFjifrKEdi1/QNAP9h3O
JASJ1cWy/sdM44aK7pq9VgXWO02bshk7uzOu4G2UoVw0/QKrRBlsgh1F8zhV4xMV
QN7/oHhL3Bf0BepUbUEcU9luIdLotaaRiqmpwA+kmyBiyExWO3VDrv6GGfOi5/CZ
NoYBHO/lyvqtpKa/h7uDitFhICtKZfHAp/yLiIka6uPN2ZCYiY2+E4j9X8eygiKQ
lPWYN7NRV9paSOvyUXBWPTMOSgX31w==
=WEQy
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
