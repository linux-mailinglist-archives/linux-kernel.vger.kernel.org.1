Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC232E79BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgL3NjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgL3NjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:39:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C74B206A5;
        Wed, 30 Dec 2020 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609335505;
        bh=UhBLZgCv7mN/iqwzx3ww+VJRza+85Eznm3Wt4zyJh8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6Lrdv6hskLKz83zqSey1QQir6lMnlJHTbjT6oewDWiAV0l3vD1yxe7icuEi+YPHa
         PwDq0WcpAOM8ecRzuplBpsJp3HVLwWBwIAQmwz5J5g79hY2vBfK1m3nL16a10VM9wS
         rMUppXa0YTgYgLZj4BbtF5Hw9dWvIFx9iPiSj+m3cRTHl+Qax7Xy4hbD1bjveYheVs
         a+ElD5AQa2qmIcCiOZFFD2eK/Xf1lq1JPmfifdXPaJCs+vfKGMddX2odab0wQwdcy5
         oJyuf3U79jEd3np2MjJ3wdF6uhPcTKB9j0+enlbVwl1fwhN9VZxNEFaj/LA0A43LOG
         wMgdXJlTkKnXQ==
Date:   Wed, 30 Dec 2020 13:38:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201230133803.GC4428@sirena.org.uk>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150807.GF4786@sirena.org.uk>
 <07037a8a-1d35-362e-1b82-b73b81f7c6ac@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <07037a8a-1d35-362e-1b82-b73b81f7c6ac@redhat.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2020 at 04:33:09PM +0100, Hans de Goede wrote:
> On 12/29/20 4:08 PM, Mark Brown wrote:

> > No, that's not the case.  extcon is a port of an Android custom API that
> > looks very similar to what ended up in mainline, it was also a
> > combination of sysfs and uevents but a bit less generic.  It mainly
> > existed to provide information to userspace about what was plugged into
> > the various ports on devices, things like headphone jacks and the
> > pre-USB C multifunction connectors you used to get on phones.

> Interesting, I have close to 0 experience with Android userspace
> (something which I would like to change one of these days). But I have
> encountered a bunch of in-kernel use of extcon on Intel's Android X86
> port for Bay and Cherry Trail devices (which I've ported to the mainline)
> where extcon was e.g. used with a generic extcon-gpio like driver monitoring
> the ID pin and then used by the USB code to detect (through monitoring the
> extcon) if the USB port was in host or device/gadget mode.

> So it seems that extcon has many different uses by different people...

It was extended as part of getting it merged into mainline, there was
some thought about what people could need to do with jacks at the time.

> > The whole purpose of creating sound/core/jack.c is to abstract away the
> > userspace interfaces from the drivers, most audio devices shouldn't be
> > working with extcon directly just as they shouldn't be creating input
> > devices or ALSA controls directly.  The missing bit there is to add
> > extcon into jack.c.

> So what you are suggesting is making sound/core/jack.c register the
> extcon device and then have arizona-extcon.c talk to sound/core/jack.c
> and no longer do any extcon stuff itself.

Yes.

> So we already export 2 userspace-APIs for this IMHO adding a 3th one is not
> really a good idea unless it offers significant benifits which I don't
> really see. The input_dev API is simple enough to use that extcon does
> not really offer any significant benefits.

Quite apart from anything else the reason the switch API was created was
AIUI that the Android people couldn't figure out how to do jack
detection on Linux - the current APIs are not terribly discoverable.
There's also issues with extensibility and applicability to non-audio
use csaes with the existing APIs.

> My current solution to have the machine-driver register a jack and
> then share that with the extcon-arizona.c code still seems like the
> best/simplest solution to me here.

Bodging it at the driver level gets in the way of improving the generic
code.

> Unless we go with your plan to make sound/core/jack.c export
> an extcon device for all sound-devs registering a jack, and then move
> extcon-arizona.c over to using sound/core/jack.c without it doing any
> extcon stuff itself. But as discussed I'm really not a fan of exporting
> a 3th uAPI for jack-detection for all sound-cards with jack-detect
> capability.

That *is* the plan, though clearly it's not exactly been backed by work.
extcon already exists and supports reporting jacks.

> > I do think pushing things over to extcon is a useful goal, the existing
> > interfaces have fairly clear issues that it does actually address.

> I don't really see any "fairly clear issues" with the input-device uAPI,
> I agree that the ALSA controls can be hard to use, but that is not the
> case for the input-device uAPI (*). What are your objections against using
> the input-device uAPI ?

Like I say it's discoverabiity and extensibility in a range of axes.
Other examples of thing that'd be good to have that we don't really have
with the input API are things like saying things like "the red jack on
the front panel".

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/sgroACgkQJNaLcl1U
h9CMlgf/SjdInnQRauNcJW8jl/PnrIjRn+DFyB3a6HsFOzAzc2NJY7WK66gaLKD0
f+hya/I42j27ZqUiZU8JxRM7GO1tTSoLTAYNNvSavG4yac1CcqNmGcFRc1Wbu5xR
+PeTo/90KPTYL7ZRgX9w/ly0brbGTkQhSRhYPrU7wKitPQUylvTkglIYYjKDurys
rLmZOGlRMmMvwCqSmpqn7x147t9ic17lFlutmPRqIklmEPJb8nqBiNfWCgQQfKQ/
yTm/uZvAFTDwnsA5Minuzq5bHBr9WNOLxGgWz7qhZIOS2LVEn0wwICDSJrbwkCio
qvIkPSHs2rRitl+GKjHJ+I/fdS2ljw==
=awoV
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
