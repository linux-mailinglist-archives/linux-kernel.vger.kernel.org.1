Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689452C03EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgKWLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:15:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46063 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728650AbgKWLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:15:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DD1895C0139;
        Mon, 23 Nov 2020 06:15:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Nov 2020 06:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=eOnRjyJE1Z3ZmRvnHPBEyLhFqGC
        MaC8++eicc5KO8Hc=; b=LA8jjuYGrOYXkHJvG2tCZBmy/ZtwC0QMh5+zhXCIHuA
        hSOJFE5NB4Vl0s2rP5n0NxlOo903NHzy1t5AcyAt9QIkJeDLuup0G4M78G0BrSkA
        HRKcSBlVGEfQ/S9rneUfspzksqlwdz1Lmys61ull9ttT1WM21jfnrKGiTgAbp7Wy
        DlIEeB3T3TqZXYJa9wVldfmvIZwbjUTj53oZM9crHlk3GxmdkcLsVuIBGd725EHr
        1/LbKFE5Ub3/8FpKdJJ3wZ3dlGvU6cVIj2vU/fncpECzcno3UWDuZ4yyDjlq00e+
        sPjqMIQS8/Bt+RQzN/sftaun6FphXdvaCl5gLzYeSKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eOnRjy
        JE1Z3ZmRvnHPBEyLhFqGCMaC8++eicc5KO8Hc=; b=cS0kXU33YfnvKokdUjOrlp
        mCnr+Y00CncVHWBogwCtZoeci71aTXInsrCFHHI3lXBP8nPEBf3K1g9EOJsGQWII
        KIh9oVUWAFdD35bbo2DGBhYvyvl5HUeum6dsJoXaTyxOA1+g6G4WjrJOcgswGyQp
        sZmZn0intQSz+F1fhRCLSWrsGjuW34Y9q96iosKpVhMscz2IYe0BdVBetk4o8Qxt
        T/nG8OJr9ZEa7V1bTnk1uDWKyUJgYl1rmSX52ZXWPACzg2s8F83P8C51WY65We+s
        htCqnEOaVpG6VBvtFncOPgzwLJgn+kqYSZ9+kUK19NZutLM6HK3iwlIqVA8HJJHA
        ==
X-ME-Sender: <xms:wpm7X-25eksI9V-gTEI0FlTsgdMSMsSWn4mrStJQy41zfSsjm1ZS4A>
    <xme:wpm7XxE0vpqOxkfuM2CYIJp_MjKK-NfrWcb8g1Pr3MZoPHTbu1vdoCnNS4fX2jCel
    ardalDkB5G_pKZdxp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegiedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wpm7X27Jz3pvGBFesyVECRGMCxxxgk78BmWmjTBSqC7guIHgKQdUMA>
    <xmx:wpm7X_0DvVN0QF4oeIlFFVqTgW9vQHgO0bubUhvfNm5C7f2vy-Q0mw>
    <xmx:wpm7XxHFj8jIypt0dW60I3cXHZ4hNqR_i77iw11NrIHnfoqgK0_R9A>
    <xmx:w5m7X250bura4UQ_4lOXqIu8RAG7rUsua5Hnr3AT1ImvUUNnFcTq1Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76DEC3280063;
        Mon, 23 Nov 2020 06:15:14 -0500 (EST)
Date:   Mon, 23 Nov 2020 12:15:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <20201123111512.y7lbwsipbkcpuleb@gilmour>
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125332.2223197-1-icenowy@aosc.io>
 <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
 <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
 <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
 <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
 <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2dkvbthaltnncon2"
Content-Disposition: inline
In-Reply-To: <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2dkvbthaltnncon2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Nov 20, 2020 at 08:51:48PM -0600, Samuel Holland wrote:
> On 11/20/20 5:30 PM, Icenowy Zheng wrote:
> >>>>>>> +/ {
> >>>>>>> +	model =3D "PineTab Developer Sample";
> >>>>>>> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
> >>>>>>> +};
> >>>>>>
> >>>>>> Changing the DT and the compatible half-way through it isn't ok. P=
lease
> >>>>>> add a new DT with the newer revision like we did for the pinephone
> >>>>>
> >>>>> We did this on Pine H64.
> >>>>
> >>>> What are you referring to? I couldn't find a commit where we did what
> >>>> you suggested in that patch to the pine H64.
> >>>
> >>> Oh the situation is complex. On Pine H64, we didn't specify anything =
at
> >>> start (which is the same here), the DT is originally version-neutral
> >>> but then transitioned to model B, then reverted to model A. Here the =
DT is always
> >>> for the sample.
> >>>
> >>> However, for Pine H64 there's model A/B names, but for PineTab there'=
s no
> >>> any samples that are sold, thus except who got the samples, all PineT=
ab
> >>> owners simply owns a "PineTab", not a "PineTab xxx version".
> >>
> >> It's fairly simple really, we can't really predict the future, so any =
DT
> >> submitted is for the current version of whatever board there is. This =
is
>=20
> I don't think that was the intention at all. The DT was submitted for a
> future product, whatever that future product ends up being at the time
> of its release. Since there are necessarily no users until the product
> ships, there is no chance of breaking users by modifying the DT.

There was no indication of that in the commit though

> >> what we (somewhat messily) did for the PineH64, for the pinephone, or
> >> really any other board that has several revisions
>=20
> Surely a non-public prototype doesn't count as a separate revision! This
> sort of policy strongly discourages ever shipping a board with
> out-of-the-box mainline Linux support. Because if there any hardware
> bugs fixed between initial upstreaming and production, the manufacture
> must come up with a new DT name.
>=20
> This is hostile to the users as well, because the "canonical" DT name no
> longer matches the "canonical" (read: the only one ever available)
> version of the hardware.
>=20
> Do you want manufacturers to submit their initial board DT as
> "$BOARD-prototype.dts", just in case they have to make a change before
> production? And only after the board is shipped (with out-of-tree
> patches, of course, to use $BOARD.dts, since the shipped board is *not*
> the prototype) submit a "$BOARD.dts" to mainline?
>=20
> Maxime, can you clarify specifically what the line is where a device
> tree is "locked down" and further changes to the hardware require a new
> name? First sample leaves the factory? $NUMBER units produced? First
> sold to the public for money?

The first board that is shipped to a user. From the wiki, the version
supported here (I guess?) has been shipped to around 100 people, so it
doesn't really qualify for the "non-public prototype". We still have to
support these users, whether we like it or not.

> Without some guidance, or a change in policy, this problem is going to
> keep coming up again and again.

There's a few things that are interleaved here. First, there's two hard
rules: never change the DT name and never change the compatible of a
board.

The former would break any build system, boot script or documentation,
and the latter would break the DT compatibility.

Aside from this, things get a bit blurrier since it's mostly about the
intent. I'm fine with having a DT for a non-public prototype if it's
clear from day one that it is. In this particular case, the DT just
stated that support for the pinetab was added. I guess anyone would make
the assumption without any context that this would be for the (or a)
final design.

Finally, I'd also advise against submitting the parts that are still not
finalized though, because this is also fairly bad for the users. Let's
take the current situation as the example: from what I understand, the
screen changed half-way through the process, and the first one was
upstreamed. This means that any user that would use a kernel with that
bugfix would have the display working, while rolling back to 5.9 would
break the display, even though everyone claimed it was supported
out-of-the-box in mainline. This is a worse situation than not
supporting the display in the first place here.

> You'll note that so far it has mostly affected Pine devices, and I don't
> think that's because they make more board revisions than other
> manufacturers.

Yes definitely. Pine devices may be worse though because of their policy
of making their prototypes public. I guess most of the issues we had
also were due to poor communication: context on what were the Pine
intentions were missing, and thus we couldn't catch things that turned
out to be bad later on during review.

> It's because they're actively involved in getting their
> boards supported upstream. For other manufacturers, it's some user
> sending in a device tree months after the hardware ships to the public
> -- of course the hardware is more stable at that point.

I mean, it's not black and white either. One could very well send the DT
once the final design is done and that would still be upstreamed way
before reaching the first user.

> I think Pine's behavior is something we want to encourage, not
> penalize.

For the DT in particular, yes

> > Okay. But I'm not satisfied with a non-public sample occupies
> > the pinetab name. Is rename it to pinetab-dev and add a
> > pinetab-retail okay?
>
> To me, naming the production version anything but "pinetab" isn't
> satisfying either.

I understand where you're coming from, but the point I was making my
previous mail is precisely that it's not really possible.

You want to name the early adopter version _the_ production version.
Let's assume the hardware changes again between the early adopter and
mass-production version. Which one will be _the_ production version? The
early-adopter or the mass-produced one?

There's really no good answer here, and both would suck in their own
way. The only way to deal with this is to simply avoid defining one
version as the one true board, and just loading the proper DT in u-boot
based on whatever clue we have of the hardware revision.

Maxime

--2dkvbthaltnncon2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7uZwAAKCRDj7w1vZxhR
xY3cAQC5IXDgSlkXpILcFSvlB3PSbM5unhfUr47d0lKQUDhUTgD/YcnzjGKckV+5
4QxyC0mE0W0tPzOe08XA+V0JYwQ6YwE=
=mv5t
-----END PGP SIGNATURE-----

--2dkvbthaltnncon2--
