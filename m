Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0628E2C08BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgKWM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:59:21 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54289 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387876AbgKWMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:53:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A114810B6;
        Mon, 23 Nov 2020 07:53:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Nov 2020 07:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TXevwkoGc/Ez7M0GkeKpx3qKPIa
        RmhPdqwr5IHiovho=; b=lbz4a9uetDsFjMGqJ2bbC63Y23ecb3bzMRXqZiZ2fij
        8qPuwGp8uy9eWFaF7TuOOEPbLlyA3bUD8B/2/zZ+fPEzOzeGAyzoMOQKbHEog9ZC
        suKlA01b3A8xeuieAJ+r6D4WzPyIbQTxpnVxBs4Hz+wlykwA6Qk9wMq9d64pzoHq
        BLKBV+1cbgO2/wfynJHHaqRZQSAKaoW1uPp3aB9WBCzrP0FSXLx62EiabXDwGSkk
        NJrbxKdxTUi7cuAU7yhMunIiggjATg+E+8e1wUAQh3kSRP60iU4MFJ7igRFcJbPT
        S9hw3bSwQYnvSV8i6VuJIZaiJf8UW/AWvuh1hk+h7UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TXevwk
        oGc/Ez7M0GkeKpx3qKPIaRmhPdqwr5IHiovho=; b=Kaysmc5D7BnN25V0PXWQ01
        yiQvlyt7ufvfj03uQ1k9pyRcDDa5GVs/gZsdcvhEeRj3wmnd6UhmnAqkE0gE7tWm
        RpCVAvIJlU8dM0S8jbk6s03CKiTqERRf+/sj9aPg7hRMgWLUKUjV8B4+IMmieG4B
        vYuNJxd6G2UsBfKDwnVrDG3jh0TH2iJqXe9zCQbfdS1yvXweAZiYEvkcg/YVspzD
        9t9jhZ4cAJnN/9YJsVm9AherPViKTasbng9BFStXesj0IJVKFsq3qxA8AA4pKSKg
        pK8MmZr+LAmMTP5ZRe0iNThZt2WQtAES71PlyYZX0T8A62REES/tTconA6qnnKoA
        ==
X-ME-Sender: <xms:zbC7X-oGhA49oqDyzt-NFmdWwlxdvWjsCliJAUHRPh6kmsPDKlW9PA>
    <xme:zbC7X8pJG2Dg0Fa53dzoyXafIfr3Iec5Us8NVGvFhYDnovO1dLzMpw4Vta1tyvSSh
    eu9GiaJAQyO3cXhEco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zrC7XzM_gpmfGU21BAP0K7YzMfZgG-howbcecnqqc7TAEaHOUw5h6Q>
    <xmx:zrC7X94mJCP44MQMLA01UeDC_Ea0RpZ0wbOvfoWPCVURS_HCV0RcVw>
    <xmx:zrC7X97EOwaf5GxSjJaOahrNmbH4uJXfdk1cSLtsDd-yEVpYm3kujw>
    <xmx:z7C7X6v6CEVhHU8tyNMu8oBBrRctwANZ4RHvEYeFYnNqQe5H-ukt3Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1E2C3280068;
        Mon, 23 Nov 2020 07:53:33 -0500 (EST)
Date:   Mon, 23 Nov 2020 13:53:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <20201123125332.2p5z3ew7svszvyfs@gilmour>
References: <20201107125332.2223197-1-icenowy@aosc.io>
 <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
 <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
 <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
 <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
 <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour>
 <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7cnayo7plubyxrr"
Content-Disposition: inline
In-Reply-To: <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7cnayo7plubyxrr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 07:25:47PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8823=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=887:15:12, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >Hi!
> >
> >On Fri, Nov 20, 2020 at 08:51:48PM -0600, Samuel Holland wrote:
> >> On 11/20/20 5:30 PM, Icenowy Zheng wrote:
> >> >>>>>>> +/ {
> >> >>>>>>> +	model =3D "PineTab Developer Sample";
> >> >>>>>>> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
> >> >>>>>>> +};
> >> >>>>>>
> >> >>>>>> Changing the DT and the compatible half-way through it isn't
> >ok. Please
> >> >>>>>> add a new DT with the newer revision like we did for the
> >pinephone
> >> >>>>>
> >> >>>>> We did this on Pine H64.
> >> >>>>
> >> >>>> What are you referring to? I couldn't find a commit where we did
> >what
> >> >>>> you suggested in that patch to the pine H64.
> >> >>>
> >> >>> Oh the situation is complex. On Pine H64, we didn't specify
> >anything at
> >> >>> start (which is the same here), the DT is originally
> >version-neutral
> >> >>> but then transitioned to model B, then reverted to model A. Here
> >the DT is always
> >> >>> for the sample.
> >> >>>
> >> >>> However, for Pine H64 there's model A/B names, but for PineTab
> >there's no
> >> >>> any samples that are sold, thus except who got the samples, all
> >PineTab
> >> >>> owners simply owns a "PineTab", not a "PineTab xxx version".
> >> >>
> >> >> It's fairly simple really, we can't really predict the future, so
> >any DT
> >> >> submitted is for the current version of whatever board there is.
> >This is
> >>=20
> >> I don't think that was the intention at all. The DT was submitted for
> >a
> >> future product, whatever that future product ends up being at the
> >time
> >> of its release. Since there are necessarily no users until the
> >product
> >> ships, there is no chance of breaking users by modifying the DT.
> >
> >There was no indication of that in the commit though
> >
> >> >> what we (somewhat messily) did for the PineH64, for the pinephone,
> >or
> >> >> really any other board that has several revisions
> >>=20
> >> Surely a non-public prototype doesn't count as a separate revision!
> >This
> >> sort of policy strongly discourages ever shipping a board with
> >> out-of-the-box mainline Linux support. Because if there any hardware
> >> bugs fixed between initial upstreaming and production, the
> >manufacture
> >> must come up with a new DT name.
> >>=20
> >> This is hostile to the users as well, because the "canonical" DT name
> >no
> >> longer matches the "canonical" (read: the only one ever available)
> >> version of the hardware.
> >>=20
> >> Do you want manufacturers to submit their initial board DT as
> >> "$BOARD-prototype.dts", just in case they have to make a change
> >before
> >> production? And only after the board is shipped (with out-of-tree
> >> patches, of course, to use $BOARD.dts, since the shipped board is
> >*not*
> >> the prototype) submit a "$BOARD.dts" to mainline?
> >>=20
> >> Maxime, can you clarify specifically what the line is where a device
> >> tree is "locked down" and further changes to the hardware require a
> >new
> >> name? First sample leaves the factory? $NUMBER units produced? First
> >> sold to the public for money?
> >
> >The first board that is shipped to a user. From the wiki, the version
> >supported here (I guess?) has been shipped to around 100 people, so it
> >doesn't really qualify for the "non-public prototype". We still have to
> >support these users, whether we like it or not.
> >
> >> Without some guidance, or a change in policy, this problem is going
> >to
> >> keep coming up again and again.
> >
> >There's a few things that are interleaved here. First, there's two hard
> >rules: never change the DT name and never change the compatible of a
> >board.
> >
> >The former would break any build system, boot script or documentation,
> >and the latter would break the DT compatibility.
> >
> >Aside from this, things get a bit blurrier since it's mostly about the
> >intent. I'm fine with having a DT for a non-public prototype if it's
> >clear from day one that it is. In this particular case, the DT just
> >stated that support for the pinetab was added. I guess anyone would
> >make
> >the assumption without any context that this would be for the (or a)
> >final design.
> >
> >Finally, I'd also advise against submitting the parts that are still
> >not
> >finalized though, because this is also fairly bad for the users. Let's
> >take the current situation as the example: from what I understand, the
> >screen changed half-way through the process, and the first one was
> >upstreamed. This means that any user that would use a kernel with that
> >bugfix would have the display working, while rolling back to 5.9 would
> >break the display, even though everyone claimed it was supported
> >out-of-the-box in mainline. This is a worse situation than not
> >supporting the display in the first place here.
> >
> >> You'll note that so far it has mostly affected Pine devices, and I
> >don't
> >> think that's because they make more board revisions than other
> >> manufacturers.
> >
> >Yes definitely. Pine devices may be worse though because of their
> >policy
> >of making their prototypes public. I guess most of the issues we had
> >also were due to poor communication: context on what were the Pine
> >intentions were missing, and thus we couldn't catch things that turned
> >out to be bad later on during review.
> >
> >> It's because they're actively involved in getting their
> >> boards supported upstream. For other manufacturers, it's some user
> >> sending in a device tree months after the hardware ships to the
> >public
> >> -- of course the hardware is more stable at that point.
> >
> >I mean, it's not black and white either. One could very well send the
> >DT
> >once the final design is done and that would still be upstreamed way
> >before reaching the first user.
> >
> >> I think Pine's behavior is something we want to encourage, not
> >> penalize.
> >
> >For the DT in particular, yes
> >
> >> > Okay. But I'm not satisfied with a non-public sample occupies
> >> > the pinetab name. Is rename it to pinetab-dev and add a
> >> > pinetab-retail okay?
> >>
> >> To me, naming the production version anything but "pinetab" isn't
> >> satisfying either.
> >
> >I understand where you're coming from, but the point I was making my
> >previous mail is precisely that it's not really possible.
> >
> >You want to name the early adopter version _the_ production version.
> >Let's assume the hardware changes again between the early adopter and
> >mass-production version. Which one will be _the_ production version?
> >The
> >early-adopter or the mass-produced one?
> >
> >There's really no good answer here, and both would suck in their own
> >way. The only way to deal with this is to simply avoid defining one
> >version as the one true board, and just loading the proper DT in u-boot
> >based on whatever clue we have of the hardware revision.
>=20
> Then will it be okay to rename current pinetab DT to pinetab-sample and
> then introduce new DTs all with suffixes?

No. From my previous mail:

> > there's two hard rules: never change the DT name and never change
> > the compatible of a board.
> >
> > The former would break any build system, boot script or
> > documentation, and the latter would break the DT compatibility.

Maxime

--c7cnayo7plubyxrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7uwzAAKCRDj7w1vZxhR
xdn/AQCkcLG7bjZbg70fjulrAh9FMmxUGRzRiV8oeKzRLNQAvQEA5wbQXdo4FlOA
JmoGpD7HZSFrkX4VaPEg0VkZei+V3AQ=
=oeXf
-----END PGP SIGNATURE-----

--c7cnayo7plubyxrr--
