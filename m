Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0B29CB52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374163AbgJ0Ve4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:34:56 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34237 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374160AbgJ0Vey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:34:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 931105803F4;
        Tue, 27 Oct 2020 17:34:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Oct 2020 17:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CezU/dgj5+5orBpUNPrDSyKMRKG
        0im0x8YN75ut3nvo=; b=sbDvA38lKlV3Myf7YFDHWT7g2d8dUkSuLFD84ZYAKVL
        +WVldz6qL8WCE/Uzj/8+qUDzbCPMi+9cWfJqcbSksccvEX3RgUk47VrQDf3OM245
        MmVU1MNmNfLhlqthIV7RebrjsLy/hiifeGuaxtA0upHDVNPOmmzDQxUHWE9fRKoP
        XhTUHdQwW4e6VKEFw9ULtKSrk1s25lG7ZZ8E1eZWqCZgFe+oxQ4yEJwMfKwLjh0B
        UwUc6kYieyzS2KrAQJYWbz+t2f+I3OZfiQ7H///vrEfkTfTF58Qy2DcYrTLsVM0d
        mvKufPfT6xnXYZLeZGAaV6p2xn+Cxk6UL5Rs2HE8SQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CezU/d
        gj5+5orBpUNPrDSyKMRKG0im0x8YN75ut3nvo=; b=Nz1cpbLS25Dw7CsQif2C2s
        RL8tHiZ3e1Lws1hPpcYS/IqnDMc8ZFiB6DVrhLn7N3q2ZiKuuQPNcOUTpleRJwzM
        HPp9eOlAsgC7U44TeBzu07VNrNB1i3bTW3zvOF1iZmv/0cwznnqGeUnahoz+8+yf
        Sc+E9U5kgLNjkU0fI5/zJK+1E9oXClS9OnF6G2g+RXe3Pyl+cPZfTCfIMqBeZsuE
        030++v/mKaaqcfcbOetaknwSmDWnj9MwfSQ3jlJhgfAmGSVsDZIaesE6LQyFMfOT
        58hHeYHkcoxepRbjEPRoLncUyPcNA6ZC/ktwtUJV82xMz2q9L40Il9kS0cZxCMdw
        ==
X-ME-Sender: <xms:eZKYXwNy_8kp7QIDC_165xZQOn5t2Kd2IQqBiWOLkjMO2xLUqCicXA>
    <xme:eZKYX29Z7H5lh_RmePqHVxOQipDdsCBfknwF25LWPnFgzOhH32zZvUCS_mRjxxA0o
    -8I_nEmMeznNVLdVAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:eZKYX3QmsA5eVPmhEes7rjlMCGTku1exXMkHulPUewAUKk5dtwOmYQ>
    <xmx:eZKYX4sDYNMH5lYzPGbxXyLheQSAo_tpKVIN1V6JigvzQuS438Iyuw>
    <xmx:eZKYX4coeE2inv7SzSVoH1U94EzJOsgbxQq1RBBuVM40aG2Wr16J0Q>
    <xmx:fJKYX5XqZSmy_VErqnXBPkdDc_HVlz8MsSpIdmc2KMWeLJTScVauow>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6712E3280060;
        Tue, 27 Oct 2020 17:34:49 -0400 (EDT)
Date:   Tue, 27 Oct 2020 22:34:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/vc4: hdmi: Avoid sleeping in atomic context
Message-ID: <20201027213447.3fhnkqqik3pbhw5d@gilmour.lan>
References: <20201027101558.427256-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rg67p2rixirimeqk"
Content-Disposition: inline
In-Reply-To: <20201027101558.427256-1-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rg67p2rixirimeqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 11:15:58AM +0100, Maxime Ripard wrote:
> When running the trigger hook, ALSA by default will take a spinlock, and
> thus will run the trigger hook in atomic context.
>=20
> However, our HDMI driver will send the infoframes as part of the trigger
> hook, and part of that process is to wait for a bit to be cleared for up =
to
> 100ms. To be nicer to the system, that wait has some usleep_range that
> interact poorly with the atomic context.
>=20
> There's several ways we can fix this, but the more obvious one is to make
> ALSA take a mutex instead by setting the nonatomic flag on the DAI link.
> That doesn't work though, since now the cyclic callback installed by the
> dmaengine helpers in ALSA will take a mutex, while that callback is run by
> dmaengine's virt-chan code in a tasklet where sleeping is not allowed
> either.
>=20
> Given the delay we need to poll the bit for, changing the usleep_range for
> a udelay and keep running it from a context where interrupts are disabled
> is not really a good option either.
>=20
> However, we can move the infoframe setup code in the hw_params hook, like
> is usually done in other HDMI controllers, that isn't protected by a
> spinlock and thus where we can sleep. Infoframes will be sent on a regular
> basis anyway, and since hw_params is where the audio parameters that end =
up
> in the infoframes are setup, this also makes a bit more sense.
>=20
> Fixes: bb7d78568814 ("drm/vc4: Add HDMI audio support")
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Applied to drm-misc-fixes

Maxime

--rg67p2rixirimeqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5iSdwAKCRDj7w1vZxhR
xe5LAQD2z4jrHFI7lepdfsHTZyw73NdLCmF62GCIDGYB6AmypgD+KFUl+5dP9Xj/
iu2xv69jA6EvGgqK5hY1OaSNYbOXrwg=
=sECL
-----END PGP SIGNATURE-----

--rg67p2rixirimeqk--
