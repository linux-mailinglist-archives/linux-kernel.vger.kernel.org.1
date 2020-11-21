Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46DA2BC09C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgKUQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 11:44:24 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51737 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgKUQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 11:44:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 181BF5C00B3;
        Sat, 21 Nov 2020 11:44:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 21 Nov 2020 11:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dW66yBh2wKDCMFiDhJSefARf8L2
        p1YUXG73bHavlNR0=; b=kADrHJjUkeAmunlKeQqvs1zFllkjmvKfSphr79wIA/6
        I28VZIPeYwzyQ/UHWKnccrb9t+ghjkkZWBwjQMUuORIaMJfnisS48mv3kmwXE3+2
        ELFWWeYdNktdo/MuKwx6wDrxYo9RsbSUMKZrYTwE91locghYtbDTzTOk5j52H3LJ
        nrboQYxWX8NGuFEFAsUHuPFUZKmyV9mPEoWnpt01bvedHmNWaAgAfWw0D9GafgRX
        9GKTQU5Lq3ktM100LF9ldqN05V86f00yw/NzlX7o5EAfs6G3VeHHPVtcHnNoUXL7
        ukkgmHQh/rJqSsa7dIGA307mYu8VJYegmX4j+FjKUAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dW66yB
        h2wKDCMFiDhJSefARf8L2p1YUXG73bHavlNR0=; b=Q2qG+g5z0ZBOTMiMehSCuj
        E6VF4DgtUASotuU2Ukc6yT2tL/9Ix67a28euihvkiSBBUAkh94T4DfJCU/y2QUBI
        OYPK8d0cS6UuAMUpkOsj4/YsE35YYxyeB/z0sK0hyT7eeisK6AVGHVtWvfWNwhxJ
        qKP+5HifUNmNeVdg7bK+pAlms2AM53IpqovyJBqz4H/Z9nyJlVMEo68X7b1UMT8U
        Jcg7Knn2IQ5pht/jasFEiufjEIabTBu5D2fi1dQ8KzVNZDsTpaSenUVX/a84kKHG
        WeH7wSaDZiDKVHbmir1nVQ8AkDdkSwtHFKWE4lRfZj3D0Nkzy9HGwcrWKi364fQA
        ==
X-ME-Sender: <xms:5EO5X2OVxyChbeHcyXeM1FkDWQKJlpP3clHMhIRRID_bKvFLIGeayA>
    <xme:5EO5X0-pax6XdnmquqLlF2LqyfqlVSHWCRa17VYxGKOCoFf45OoDhhlOAEAuwI9Cm
    8vmL-piW5evTeajaB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5EO5X9RoKDwdxGNIKEWcVI_mv1t0Z3s-3rHpP0Q6tz4tHEtoNyCpNg>
    <xmx:5EO5X2uGtqvrmJJZ0KLGtqzS9WjbPmzG_LjXUYkB5VV-nhtED_0E0w>
    <xmx:5EO5X-chYwr1W5puneZH_fdj4jbSf7O69izj960Yv7DXbhjnsay73w>
    <xmx:5kO5X7EbJvToK7SGvWJmc0VfnEX88FAAXOwfgVH_1rVwIp1HMoqMHA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BD1A3280059;
        Sat, 21 Nov 2020 11:44:20 -0500 (EST)
Date:   Sat, 21 Nov 2020 17:44:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201121164418.hxrxzgob7whgzkpj@gilmour>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
 <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
 <20201119111343.74956eae@monster.powergraphx.local>
 <20201120164231.nmzxe5scwnfoyy3o@gilmour>
 <20201121122255.GB22987@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="afrihzhwinwwepzw"
Content-Disposition: inline
In-Reply-To: <20201121122255.GB22987@debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--afrihzhwinwwepzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2020 at 08:22:55PM +0800, fuyao wrote:
> On Fri, Nov 20, 2020 at 05:42:31PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
> > > On Thu, 19 Nov 2020 08:15:23 +0100
> > > Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > can you help me here a bit? I still try to figure out how to do p=
atch sets
> > > > > properly. Some kernel submitting documentation says everything go=
es into the
> > > > > coverletter and other documentation only tells how to split the p=
atches. So
> > > > > what would be the right way? A quick example based on my patch se=
t would be
> > > > > really helpful.
> > > >=20
> > > > I mean, the split between your patches and so on is good, you got t=
hat right
> > > >=20
> > > > The thing I wanted better details on is the commit log itself, so t=
he
> > > > message attached to that patch.
> > >=20
> > > Ah yes, I think I got it now. So basically add a nice summary of the =
coverletter
> > > there.
> >=20
> > Yes, a bit more context as well. Eventually, this should be the
> > motivation on why this patch is useful. So what it can be used for, what
> > are the challenges, how it was tested, etc.
> >=20
> > The cover letter is usually here more to provide some meta-context: what
> > you expect from the maintainers / reviewers if it's an RFC, if there's
> > any feature missing or that could be added later on, etc.
> >=20
> > > > > > Most importantly, this hwspinlock is used to synchronize the AR=
M cores
> > > > > > and the ARISC. How did you test this driver?
> > > > >=20
> > > > > Yes, you are right, I should have mentioned this. I have a simple=
 test kernel
> > > > > module for this. But I must admit, testing the ARISC is very hard=
 and I have
> > > > > no real idea how to do it. Testing the hwspinlocks in general see=
ms to work
> > > > > with my test kernel module, but I'm not sure if this is really su=
fficient. I
> > > > > can provide the code for it if you like. What would be the best w=
ay? Github?
> > > > > Just mailing a patch?
> > > > >=20
> > > > > The test module produces these results:
> > > > >=20
> > > > > # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspi=
nlock_test.ko=20
> > > > > [   45.395672] [init] sunxi hwspinlock test driver start
> > > > > [   45.400775] [init] start test locks
> > > > > [   45.404263] [run ] testing 32 locks
> > > > > [   45.407804] [test] testing lock 0 -----
> > > > > [   45.411652] [test] taking lock attempt #0 succeded
> > > > > [   45.416438] [test] try taken lock attempt #0
> > > > > [   45.420735] [test] unlock/take attempt #0
> > > > > [   45.424752] [test] taking lock attempt #1 succeded
> > > > > [   45.429556] [test] try taken lock attempt #1
> > > > > [   45.433823] [test] unlock/take attempt #1
> > > > > [   45.437862] [test] testing lock 1 -----
> > > >=20
> > > > That doesn't really test for contention though, and dealing with
> > > > contention is mostly what this hardware is about. Could you make a =
small
> > > > test with crust to see if when the arisc has taken the lock, the ARM
> > > > cores can't take it?
> > >=20
> > > So the best solution would be to write a bare metal program that runs=
 on the
> > > arisc and can be triggered from the linux side (the test kernel modul=
e) to take
> > > a spinlock ... or at least take spinlocks periodically for a while an=
d watch it
> > > on the linux side. Okay, I think I can do this. Though, I have to dig=
 through
> > > all this new stuff first.
> >=20
> > It doesn't have to be super complicated, just a loop that takes a lock,
> > sleeps for some time, and releases the lock should be enough to at least
> > validate that the lock is actually working
> >
>
> I think the difficulty is the bare metal program in arsic has little
> documentation.

crust has mostly figured it out:
https://github.com/crust-firmware/crust

Maxime

--afrihzhwinwwepzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7lD4gAKCRDj7w1vZxhR
xeQZAP0Rl4nbpXkJfhbuBiGtAwWrPq0L4Q75V9uJRz2TUbhVUAEAxjnl77iNF4YB
qRMWWNjP+z/q+lNlLLreo9l82PBJYQ4=
=VqzR
-----END PGP SIGNATURE-----

--afrihzhwinwwepzw--
