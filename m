Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55292961C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368682AbgJVPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:39:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55587 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504410AbgJVPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:39:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 418D75C010A;
        Thu, 22 Oct 2020 11:39:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1zB38VSUKoWvgoR7ez4MM2+MlQl
        kPY5uetQo112xVEg=; b=jtniElwVgYBxCenzh0Y0ijI9E94wYGg0mLyyCtYaDQy
        81aPUGAE75UwYrLblrM6HKGN4qiSfxTU4Gm1MCdKQj85g7uHhSYPjqKJVS26IrPk
        1VDLd3VDZog/v7UQT7I8O5wjzLwnaZw8adJMQ7XWuRPfe9zg3T0iXkfROmfz6Cod
        5vdmLpsjEu6OU/mZfHSEIH6U9pvASlgPFJmk/PJhQ8yTvhyFZQlE8rIP20sGRvmQ
        AtCZZEj8RkQsoASwJ/avyUWoymxhUuh38xhIYjMFm4NU5i+r22hlfm7e079AJgYx
        0WhBPk2C7LEwQvikp/f438g3JvIODCUPETOGgKFfdOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1zB38V
        SUKoWvgoR7ez4MM2+MlQlkPY5uetQo112xVEg=; b=bkoeoELQ49bxQf68PUkzll
        ELIiuzcJR5Wq20oRWMx3T/nrF3REJdvTUbD6RRtIvreww3wuG2e9i4Arg5BX7SbW
        T/BZFDltB+h9HWwhN4FxeYjqKBDRhBIGnxMoSeNMVNvb8sw5JZg5wglN/oRZ/Jkn
        dnmOzjqJ8TxYBWXwdg8e7g5BVuO7/GN039dt8QjCpuN59qpG1MXzC8/H/ai6N61a
        22DLuqTjlocuuVAta5fB+x3TfF9KfKSwGmiev5ZztRW3rm5hpovEE5hrnw/FHGcG
        H4bfRspVoSXsGwFxnX5GueEciJq3RegC06VAgN1N77wVW+vTU+3ktbNq0y+f1kxA
        ==
X-ME-Sender: <xms:sqeRXzOgUIKbPkqJqP2Tf3YABDd9A0ma6nX1Tj0JaW2ugtfs8fBXjA>
    <xme:sqeRX98jPB0uZGvqnQNaOVx3rRAFlkf9JkuvaPhrfdtHf6dZcO3sU_7p7n76DBFNG
    6YCYUORCm0b7nUaeWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:s6eRXyT4yeWC8rH2L0Lm_qlUYXC3o0_4G2gFhznAooO8b2FqcZnFTQ>
    <xmx:s6eRX3trAooMZg1c2r9ZxNc-2kABfygNN2SD_Fe1a3oonFDao5Xc1A>
    <xmx:s6eRX7cJQOt9bSbKPqs8UIKVvwJWKphqe6dJFeDHL7cjiqU0g6I-MA>
    <xmx:tKeRXzR4Qhr6OWc09tTmlgmEaPThKQ5c_gLiV9XHdpXljQhWiy_IwA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B20853280068;
        Thu, 22 Oct 2020 11:39:30 -0400 (EDT)
Date:   Thu, 22 Oct 2020 17:39:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: Context expectations in ALSA
Message-ID: <20201022153929.g4q6eq5paom73t5h@gilmour.lan>
References: <20201022095041.44jytaelnlako54w@gilmour.lan>
 <20201022135053.GB4826@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qou4qb6o4ose32tc"
Content-Disposition: inline
In-Reply-To: <20201022135053.GB4826@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qou4qb6o4ose32tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Thu, Oct 22, 2020 at 02:50:53PM +0100, Mark Brown wrote:
> On Thu, Oct 22, 2020 at 11:50:41AM +0200, Maxime Ripard wrote:
>=20
> > This is caused by the HDMI driver polling some status bit that reports
> > that the infoframes have been properly sent, and calling usleep_range
> > between each iteration[1], and that is done in our trigger callback that
> > seems to be run with a spinlock taken and the interrupt disabled
> > (snd_pcm_action_lock_irq) as part of snd_pcm_start_lock_irq. This is the
> > entire stack trace:
>=20
> That doesn't sound like something I would expect you do be doing in the
> trigger callback TBH - it feels like if this is something that could
> block then the setup should have been done during parameter
> configuration or something rather than in trigger.
>=20
> > It looks like the snd_soc_dai_link structure has a nonatomic flag that
> > seems to be made to address more or less that issue, taking a mutex
> > instead of a spinlock. However setting that flag results in another
> > lockdep issue, since the dmaengine controller doing the DMA transfer
> > would call snd_pcm_period_elapsed on completion, in a tasklet, this time
> > taking a mutex in an atomic context which is just as bad as the initial
> > issue. This is the stacktrace this time:
>=20
> Like Jaroslav says you could punt to a workqueue here.  I'd be more
> inclined to move the sleeping stuff out of the trigger operations but
> that'd avoid the issue too.  There are some drivers doing this already
> IIRC.
>=20
> > So, I'm not really sure what I'm supposed to do here. The drivers
> > involved don't appear to be doing anything extraordinary, but the issues
> > lockdep report are definitely valid too. What are the expectations in
> > terms of context from ALSA when running the callbacks, and how can we
> > fix it?
>=20
> To me having something in the trigger that needs waiting for is the bit
> that feels the most awkward fit here, trigger is supposed to run very
> quickly.

Indeed, other DRM devices seem to send the infoframes as part of
hw_params, and it solves our issue there too. I'll send a patch

Thanks for the suggestion!
Maxime


--qou4qb6o4ose32tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5GnsQAKCRDj7w1vZxhR
xblHAP0fQlf65iR1se3fsAarud6ONFK7jZeqjn8t60IqTfVxAAEA411CHkGg28vK
ixPKLzGQtCpk5j/utVLuB/a45jkMCgY=
=glSS
-----END PGP SIGNATURE-----

--qou4qb6o4ose32tc--
