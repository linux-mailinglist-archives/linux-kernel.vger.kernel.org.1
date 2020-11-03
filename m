Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BBF2A4602
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKCNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgKCNNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:13:04 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6F221534;
        Tue,  3 Nov 2020 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604409183;
        bh=M+XGL1TF6rEHXAM9ztMrosxOcLuRdxKMEc4oded8c+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRYPhdLk8vpV9wiwTnjT5L1S7ABv/TIk1BabOLB+piUq4y1c8Q9idXD10K9znzYHm
         UCdDpAGpIKx9sWTqSQEEhEJFcKq4jie0saveXB+V5eu4WQ1AM+79WniSfAhjvdBwZl
         UmXH/mC2kMH3mR1R4YQaOYx/7PQTzICl8hur41wI=
Date:   Tue, 3 Nov 2020 13:12:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Limonciello Mario <Mario.Limonciello@dell.com>
Subject: Re: [PATCH] ASoC: rt715:add Mic Mute LED control support
Message-ID: <20201103131253.GA5545@sirena.org.uk>
References: <20201103125859.8759-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20201103125859.8759-1-Perry_Yuan@Dell.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 04:58:59AM -0800, Perry Yuan wrote:
> From: perry_yuan <perry_yuan@dell.com>
>=20
> Some new Dell system is going to support audio internal micphone
> privacy setting from hardware level with micmute led state changing
>=20
> This patch allow to change micmute led state through this micphone
> led control interface like hda_generic provided.

If this is useful it should be done at the subsystem level rather than
open coded in a specific CODEC driver, however I don't undersand why it
is.

> +static int rt715_micmute_led_mode_put(struct snd_kcontrol *kcontrol,
> +      struct snd_ctl_elem_value *ucontrol)
> +{
> +    struct snd_soc_component *component =3D snd_kcontrol_chip(kcontrol);
> +    struct rt715_priv *rt715 =3D snd_soc_component_get_drvdata(component=
);
> +    int led_mode =3D ucontrol->value.integer.value[0];
> +
> +    rt715->micmute_led =3D led_mode;
> +#if IS_ENABLED(CONFIG_LEDS_TRIGGER_AUDIO)
> +    ledtrig_audio_set(LED_AUDIO_MICMUTE,
> +               rt715->micmute_led ? LED_ON : LED_OFF);
> +#endif
> +  return 0;
> +}

This is just adding a userspace API to set a LED via the standard LED
APIs.  Since the LED subsystem already has a perfectly good userspace
API why not use that?  There is no visible value in this being in the
sound subsystem.

Please also follow the kernel coding style, your code doesn't visually
resemble the adjacent code.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hV1UACgkQJNaLcl1U
h9AGAgf+IGVQYbKrvIHSUvGOYs9tp4WUFSmNglhd7Ud3/tdlsnPO/aeUFkBN4Yja
kHuwFCBDhVuOCfuDIX8MbRSeNMAidm8lwbcDiyl86HMWrbLKREut/8x2xzPfBwJ+
juSi/fxeWR+2+QnlsTEy7skHLgQuSyimWjPAC5og6c6df00EooJWtngXe1F5WZNz
vFzBW/pfVQjh/ms+RnSBGETqse51SslYWgtNhXINqqKGDNXi/EOsXxsJFCJxpEWC
xV6OWz3KWnDs53nDHL3nQuZauSHaQYJwhg5IRxqWZUb49UHOCzljejgsCXj0A4eP
k4C44Dcr5APTlkcwicbW0BrAOX635g==
=lmo/
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
