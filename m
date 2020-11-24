Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F374B2C299C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389050AbgKXO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:28:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45157 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389012AbgKXO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:28:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 128235C0200;
        Tue, 24 Nov 2020 09:28:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 09:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=P2IAfRmWgCF6SkLcXVmowUKK1Go
        leAqmOJddAqal0fU=; b=eGYcI2vuKDh4awYza3S8kuVMmvWz5DZIX/umVoKHwui
        zKdAu3EwZR85kG4BSZ0TzWbr5RYujb+8nl0h0KgsfkS4mLTV/NFvoDNXrizLalW6
        vL4O5lcPvgGUF6uuDAWDdR46nfULvOzDY7CCwcNVTboZ5pg9c4Kb7/JSgvPdAwL9
        qeOJyUa2rzjv5kvzzQFq/IagCKQmmsmMiOFO02sBe3xENUSXePICS1XN4wwV4ajx
        G6wfAJJ/xjsSZ2mNM9GOvkvYgHmqIhuv6zeVdNXnAoky2IjRwf6weYxq1II3xeuq
        LeOWri5BTsVeObayvwzERB7ZIzVhWxvxCx96hz1F3Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=P2IAfR
        mWgCF6SkLcXVmowUKK1GoleAqmOJddAqal0fU=; b=FDuBSqgaEwOyWg20L9O2jd
        2jEcC0D5MvWlyC0lx0duX8lyBIyeQeN69Iq6gh4MaWb6ySNabnoXc+AQxzjiimno
        eVNauDdjQanA+z+7pooml+oidS37OvlQOWJ0D4YTdt03R4irBKcChu050d/Ume8p
        0v7R6iJwtIcQeN3/qmoYboqi0FH7TT2IAIdgXvnUCfXDpJj9m3oO4pn7dGzi+Vmh
        /2J2A7GRA80R0RhRhCjK9XeCb7HMJrs3/h4ENPIYpbxNNkv4mv7Vla8xTUvuOhK5
        NTVOi1mPzrxGnrY8suSfqhMe11DC0AQuud26q1gaz2yH5e01hTPeAse50E6Iz/bg
        ==
X-ME-Sender: <xms:hxi9X8Vqvpm7kfXikfN1bpJ_Uw4wdpw-xqpelrieQe6xALSS8LvUFA>
    <xme:hxi9XwmQkhWiGBjZLybTfcFMMCgUekzmSaghU52XFInM1iR0rJmuKirlb65eJo5xC
    4S8pNYBId7oba_5ES4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hxi9XwbCe2ooJ_B2Ny8ZAa6Tq705newIn-gZEzCtI5k8fhrj78jW9A>
    <xmx:hxi9X7Vsbt1H_OeYLsWpQq8w5UYu96avW3pkWwyznXDM254rEosXqQ>
    <xmx:hxi9X2mrzuZNkUKHsCcKCOq6VZBozoPwwtfoLSLCdh1mKQyI5ToRgA>
    <xmx:iBi9X0YL4HKeJSgxLSN9r3fhwiMD4LNQ3qS9tNUmyYq8UrBZTtJemA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF0603064AA6;
        Tue, 24 Nov 2020 09:28:22 -0500 (EST)
Date:   Tue, 24 Nov 2020 15:28:21 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201124142821.hevj3qld52qpwnqw@gilmour>
References: <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
 <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
 <20201119111343.74956eae@monster.powergraphx.local>
 <20201120164231.nmzxe5scwnfoyy3o@gilmour>
 <20201121122255.GB22987@debian>
 <20201121164418.hxrxzgob7whgzkpj@gilmour>
 <20201123193206.0b2d1b6d@monster.powergraphx.local>
 <39136764-2b58-f66d-68ea-e1c6b4d74edf@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ys5rq2tpvngb4gox"
Content-Disposition: inline
In-Reply-To: <39136764-2b58-f66d-68ea-e1c6b4d74edf@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ys5rq2tpvngb4gox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 09:35:52PM -0600, Samuel Holland wrote:
> On 11/23/20 12:32 PM, Wilken Gottwalt wrote:
> > On Sat, 21 Nov 2020 17:44:18 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> >=20
> >> On Sat, Nov 21, 2020 at 08:22:55PM +0800, fuyao wrote:
> >>> On Fri, Nov 20, 2020 at 05:42:31PM +0100, Maxime Ripard wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
> >>>>> On Thu, 19 Nov 2020 08:15:23 +0100
> >>>>> Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>>>> can you help me here a bit? I still try to figure out how to do p=
atch sets
> >>>>>>> properly. Some kernel submitting documentation says everything go=
es into the
> >>>>>>> coverletter and other documentation only tells how to split the p=
atches. So
> >>>>>>> what would be the right way? A quick example based on my patch se=
t would be
> >>>>>>> really helpful.
> >>>>>>
> >>>>>> I mean, the split between your patches and so on is good, you got =
that right
> >>>>>>
> >>>>>> The thing I wanted better details on is the commit log itself, so =
the
> >>>>>> message attached to that patch.
> >>>>>
> >>>>> Ah yes, I think I got it now. So basically add a nice summary of th=
e coverletter
> >>>>> there.
> >>>>
> >>>> Yes, a bit more context as well. Eventually, this should be the
> >>>> motivation on why this patch is useful. So what it can be used for, =
what
> >>>> are the challenges, how it was tested, etc.
> >>>>
> >>>> The cover letter is usually here more to provide some meta-context: =
what
> >>>> you expect from the maintainers / reviewers if it's an RFC, if there=
's
> >>>> any feature missing or that could be added later on, etc.
> >>>>
> >>>>>>>> Most importantly, this hwspinlock is used to synchronize the ARM=
 cores
> >>>>>>>> and the ARISC. How did you test this driver?
> >>>>>>>
> >>>>>>> Yes, you are right, I should have mentioned this. I have a simple=
 test kernel
> >>>>>>> module for this. But I must admit, testing the ARISC is very hard=
 and I have
> >>>>>>> no real idea how to do it. Testing the hwspinlocks in general see=
ms to work
> >>>>>>> with my test kernel module, but I'm not sure if this is really su=
fficient. I
> >>>>>>> can provide the code for it if you like. What would be the best w=
ay? Github?
> >>>>>>> Just mailing a patch?
> >>>>>>>
> >>>>>>> The test module produces these results:
> >>>>>>>
> >>>>>>> # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspi=
nlock_test.ko=20
> >>>>>>> [   45.395672] [init] sunxi hwspinlock test driver start
> >>>>>>> [   45.400775] [init] start test locks
> >>>>>>> [   45.404263] [run ] testing 32 locks
> >>>>>>> [   45.407804] [test] testing lock 0 -----
> >>>>>>> [   45.411652] [test] taking lock attempt #0 succeded
> >>>>>>> [   45.416438] [test] try taken lock attempt #0
> >>>>>>> [   45.420735] [test] unlock/take attempt #0
> >>>>>>> [   45.424752] [test] taking lock attempt #1 succeded
> >>>>>>> [   45.429556] [test] try taken lock attempt #1
> >>>>>>> [   45.433823] [test] unlock/take attempt #1
> >>>>>>> [   45.437862] [test] testing lock 1 -----
> >>>>>>
> >>>>>> That doesn't really test for contention though, and dealing with
> >>>>>> contention is mostly what this hardware is about. Could you make a=
 small
> >>>>>> test with crust to see if when the arisc has taken the lock, the A=
RM
> >>>>>> cores can't take it?
> >>>>>
> >>>>> So the best solution would be to write a bare metal program that ru=
ns on the
> >>>>> arisc and can be triggered from the linux side (the test kernel mod=
ule) to take
> >>>>> a spinlock ... or at least take spinlocks periodically for a while =
and watch it
> >>>>> on the linux side. Okay, I think I can do this. Though, I have to d=
ig through
> >>>>> all this new stuff first.
> >>>>
> >>>> It doesn't have to be super complicated, just a loop that takes a lo=
ck,
> >>>> sleeps for some time, and releases the lock should be enough to at l=
east
> >>>> validate that the lock is actually working
> >>>>
> >>>
> >>> I think the difficulty is the bare metal program in arsic has little
> >>> documentation.
> >>
> >> crust has mostly figured it out:
> >> https://github.com/crust-firmware/crust
> >=20
> > I actually have serious trouble to get crust running. It compiles for H=
2+/H3, but
> > I can't figure out if it runs at all. I will switch to a H5 based devic=
e which is
>=20
> Crust does not yet support the H2+/H3 (it is active WIP). H5 should work
> well.
>=20
> > confirmed to work. If I see this correctly crust is doing nothing
> > with spinlocks yet, so I may end up also working on crust, adding
> > the spinlocks there too. Don't know yet how long I will take to
> > understand every detail, but I will report progress.
>=20
> Correct. There is currently no hwspinlock driver in crust. For testing,
> you can poke MMIO from the main loop, near the call to scpi_poll() in
> common/system.c. You can use the timeout.h functions for timing.

Yeah, that would be enough for me. We only really need to make sure that
the concurrency is properly handled to merge the driver

> If you want to write a full driver, I would like to know how you expect
> to use the hwspinlocks. Allocating the locks has to be coordinated among
> all of the users: Linux, U-Boot, crust, any other ARISC firmware, etc.

while that can come as a second step and I wouldn't make it a
requirement for Linux to merged the hwspinlock driver.

Maxime

--ys5rq2tpvngb4gox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX70YhQAKCRDj7w1vZxhR
xQgiAQDk186UDnzAxmqSDbg4WOf+lQ5zyamY2pqb9ZwWVEaukQD+Ina0qJYCxzG7
mNj9gaB28GQxkTK2af4CEp78w5YK/A8=
=stiI
-----END PGP SIGNATURE-----

--ys5rq2tpvngb4gox--
