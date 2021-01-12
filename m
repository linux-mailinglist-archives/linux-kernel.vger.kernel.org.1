Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925322F37B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbhALRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbhALRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:55:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA222311D;
        Tue, 12 Jan 2021 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610474080;
        bh=1FGZ5YRyYoYsT8ENZ23oRCtaZ1Q53Ycq2i0Ai2+Fwb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpOfZiULlBbkKHWoLhOotg9SNAhYE+XoY70SNtvL9uLcHLQxaHMyHh4PAfsjcaZll
         AbqW21Ifo520DGrMR8NLx67i3gyeUocA/3JgqCYGVXdCm1WVfsp6RTWACT/5IN83mC
         gylXfmJcOpWGQn37Lty61hQHAUbRmss4ywcEpkKWwkMDQ7jGYox0n09QBbubPGCTaG
         YGIei1zNvu3ewVjUJNkhArLsZ002nnQuUDHO37W+IBVFZ31+6hUravjPbtP52BlHoO
         I1I/6fimNm/cxwjQtVGOLYA23g5rei8HoCxH3HVuB6w2izAzB7OLx90D3h+1v0Iy4k
         uEY6Mi3IRxZLg==
Date:   Tue, 12 Jan 2021 17:54:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
Message-ID: <20210112175406.GF4646@sirena.org.uk>
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20210112171814.5404-1-Perry_Yuan@Dell.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 01:18:14AM +0800, Perry Yuan wrote:

> Some new Dell system is going to support audio internal micphone
> privacy setting from hardware level with micmute led state changing
> When micmute hotkey pressed by user, soft mute will need to be enabled
> firstly in case of pop noise, and codec driver need to react to mic
> mute event to EC(embedded controller) notifying that SW mute is completed
> Then EC will do the hardware mute physically within the timeout reached

> This patch allow codec rt715 driver to ack EC when micmute key pressed
> through this micphone led control interface like hda_generic provided
> ACPI method defined in dell-privacy micmute led trigger will be called
> for notifying the EC that software mute has been completed

It feels like there's an abstraction problem here with this being hard
coded in a specific CODEC driver.

>  #include <linux/soundwire/sdw.h>
> @@ -244,6 +245,7 @@ static int rt715_sdca_get_volsw(struct snd_kcontrol *=
kcontrol,
>  	unsigned int max =3D mc->max;
>  	int val;
> =20
> +	pr_err("++++++rt715_sdca_get_volsw++\n");
>  	val =3D snd_soc_component_read(component, mc->reg);
>  	if (val < 0)
>  		return -EINVAL;

This shouldn't be in the patch.

> @@ -287,6 +291,18 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol =
*kcontrol,
>  			return err;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +	/* dell privacy LED trigger state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[=
1]) {
> +			rt715->micmute_led =3D LED_OFF;
> +		} else {
> +			rt715->micmute_led =3D LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
> +	}
> +#endif
> +

This doesn't look good.  There's nothing Dell specific here, and nothing
about this is conditional on any sort of runtime detection of Dell
systems, it's not obvious why this is conditional on DELL_PRIVACY or why
we only report the state if the control is inverted.

I'm also not convinced that it's a good idea to set the mute LED if only
one channel in a stereo microphone is muted, that seems likely to lead
to surprising behaviour for users.

TBH I don't understand why this isn't being done in generic code.

> +	bool micmute_led;

What is this for, it never seems to be read except for in the function
where it's set?

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/94j0ACgkQJNaLcl1U
h9BbyAf/ZlFlV56S+eSk4TW9LTEcwFtqLC40UMS40vmYqaYsmy7Tl7NWCnDY36Qz
TjyUZN9acHq9Xz4a+z7S6x8yPyFbk0KmS98l7xs429tjfck5SpAoPsWGOLuVPcEX
5Nmiq/HUR+Y213AAyOkXjRnVuBA6K6ipQdQ4mM699wW+Mm3ISPcCl+RcK7A73ptH
fKCGq9ETOZXN4fSLz8IWNBjFcCUU2MLAvznCZRlX2ALwhgXHHTIAmsZsai48y88Y
v/H7x/T2Gpc4w8La9V9nhmA7TGsdWSDGCD0BJe1Fglrv2rA9g6/uOuBTTpFd8zzl
9QKo07FI/WjO9dOD4nHnqLiiJb0Mrg==
=uHEo
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
