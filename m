Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088E2BB0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgKTQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:42:36 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36103 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728685AbgKTQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:42:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E52B5C0160;
        Fri, 20 Nov 2020 11:42:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 11:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XfY08vrjtp3gNppAgC2INtj3l8R
        wQt/02jEKP7reLVg=; b=ubWJ2QHxKdUgVLSQL2MwcyOWLpfWWnsO4FZnI+b7tab
        84iclH7VT+sj/zaUEk9EHdhOBewpri4W+vWNRMdvrpTNqkgZG4cM20orxqjO69Qw
        mc2L00/9RRfHfdDwezRhPxIasTpVfph25HPiFqfHA401nZPlVNTMqm1ksJwIMJBX
        0k2zddPdtpSW4MYQzsivE07gBEykv6Kmvsy0gJ/POMrXyVSKZOwvKI6T6VBHDj8X
        rw+gzOGFWDzGu7YNRZxlgRPJndVZZMnMhIA+3/XfwYpdvfAPWSI1T8YrLQDTIg14
        nDy/4vuclOfVI4OJvQ0uU0v4HX323hwcOJgcW8DD+pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XfY08v
        rjtp3gNppAgC2INtj3l8RwQt/02jEKP7reLVg=; b=NlqauZ7cuB0xKxDnf4XRHC
        QNtkTATSUTN8GPcmvX6JpTciF45Dco0qY2JTdWrJmHS8MDYEO4jy/odvSwFNTqM9
        KWRq2fXKYQYmmdoe9M/Iz7PVUPlDumRST6/yOmftI3S32RFwr7dEjTCTJQHucsqS
        1s1nQmqwzLafMBwIdBXp7oZreYz3umoi3RU+d/XOARkdtb4THkji1ygrMda+Mmmn
        wdqZ5hJyzVAI/7zU2gxofJRywFv9okLSlhMi/bgtgcOvgKDIvqBP7f2Hu0j0wS1y
        m7sAT4a57lhV3373itYlvAwrDEM4NQyQZSN92PYyGsZm5hzdNuPWTBQY46iHVg5g
        ==
X-ME-Sender: <xms:-fG3X-D-fWeqZpthgxSwpoINl_0k9di94KEyWt41fUEprTr4QioYCw>
    <xme:-fG3X4jhGMLa24i8vPZhpuRovEg3O-nR3nDdWTpCqgoTKt-W7D3oBGyzIlzU2phtf
    ISM2hTSZoz9-fFqkV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-fG3XxmP-M8GnVjxxkgJmHg9HTjtDQEqGXSibJr_OloDqZ5fRhNnSA>
    <xmx:-fG3X8zPVLvWhkEwGfVKw3CO0-qYenBQFJWpOV5MtzbKW9Whiy5PGw>
    <xmx:-fG3XzSGIapE4KjqCQ3_MsNJJbJsGSkT5Ye4af7x-v8JTJ0UrnKBOw>
    <xmx:-vG3X0L3SNLQz0spUVhrI7RsZ7g1_ppG3GrHSKqApl2uefVfaaXrQw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27BD53064AB8;
        Fri, 20 Nov 2020 11:42:33 -0500 (EST)
Date:   Fri, 20 Nov 2020 17:42:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201120164231.nmzxe5scwnfoyy3o@gilmour>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
 <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
 <20201119111343.74956eae@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vl2s3l567u4phv4v"
Content-Disposition: inline
In-Reply-To: <20201119111343.74956eae@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vl2s3l567u4phv4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
> On Thu, 19 Nov 2020 08:15:23 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
> > > can you help me here a bit? I still try to figure out how to do patch=
 sets
> > > properly. Some kernel submitting documentation says everything goes i=
nto the
> > > coverletter and other documentation only tells how to split the patch=
es. So
> > > what would be the right way? A quick example based on my patch set wo=
uld be
> > > really helpful.
> >=20
> > I mean, the split between your patches and so on is good, you got that =
right
> >=20
> > The thing I wanted better details on is the commit log itself, so the
> > message attached to that patch.
>=20
> Ah yes, I think I got it now. So basically add a nice summary of the cove=
rletter
> there.

Yes, a bit more context as well. Eventually, this should be the
motivation on why this patch is useful. So what it can be used for, what
are the challenges, how it was tested, etc.

The cover letter is usually here more to provide some meta-context: what
you expect from the maintainers / reviewers if it's an RFC, if there's
any feature missing or that could be added later on, etc.

> > > > Most importantly, this hwspinlock is used to synchronize the ARM co=
res
> > > > and the ARISC. How did you test this driver?
> > >=20
> > > Yes, you are right, I should have mentioned this. I have a simple tes=
t kernel
> > > module for this. But I must admit, testing the ARISC is very hard and=
 I have
> > > no real idea how to do it. Testing the hwspinlocks in general seems t=
o work
> > > with my test kernel module, but I'm not sure if this is really suffic=
ient. I
> > > can provide the code for it if you like. What would be the best way? =
Github?
> > > Just mailing a patch?
> > >=20
> > > The test module produces these results:
> > >=20
> > > # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinloc=
k_test.ko=20
> > > [   45.395672] [init] sunxi hwspinlock test driver start
> > > [   45.400775] [init] start test locks
> > > [   45.404263] [run ] testing 32 locks
> > > [   45.407804] [test] testing lock 0 -----
> > > [   45.411652] [test] taking lock attempt #0 succeded
> > > [   45.416438] [test] try taken lock attempt #0
> > > [   45.420735] [test] unlock/take attempt #0
> > > [   45.424752] [test] taking lock attempt #1 succeded
> > > [   45.429556] [test] try taken lock attempt #1
> > > [   45.433823] [test] unlock/take attempt #1
> > > [   45.437862] [test] testing lock 1 -----
> >=20
> > That doesn't really test for contention though, and dealing with
> > contention is mostly what this hardware is about. Could you make a small
> > test with crust to see if when the arisc has taken the lock, the ARM
> > cores can't take it?
>=20
> So the best solution would be to write a bare metal program that runs on =
the
> arisc and can be triggered from the linux side (the test kernel module) t=
o take
> a spinlock ... or at least take spinlocks periodically for a while and wa=
tch it
> on the linux side. Okay, I think I can do this. Though, I have to dig thr=
ough
> all this new stuff first.

It doesn't have to be super complicated, just a loop that takes a lock,
sleeps for some time, and releases the lock should be enough to at least
validate that the lock is actually working

Maxime

--vl2s3l567u4phv4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7fx9wAKCRDj7w1vZxhR
xVh5AQCo2PMZzvWUnDrdECdc1PSp7Bf2yleADRnK9iLu7nJNiwEA2ihSZ+VDLMUv
CIRYjbGb8sYFp0wUHlGFQVEefyQhwAA=
=X5hI
-----END PGP SIGNATURE-----

--vl2s3l567u4phv4v--
