Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5823382F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 20:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG3SNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 14:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgG3SNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:13:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C6D20829;
        Thu, 30 Jul 2020 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596132797;
        bh=vIJFWrnXpMFHH8EimughuB8y+lmfzGjAgR03PPlEdOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEBcihMz9YjzJB2lwWShh3zEfgGGSl291HW4Zvh8Bc18dbNAvzbYgPG/tHuiihSBU
         jjyvar5wpDBOzT+X6soS9Ny2YyOBoVvbauv+mEFSwlpyjzsq/Si73sVCsUvBl3ZzTG
         rGdennpMtSdGeT66ngzeEAffDlKV9bHKCyxk6RyY=
Date:   Thu, 30 Jul 2020 19:12:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>, zhangn1985@outlook.com,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
Message-ID: <20200730181257.GF5055@sirena.org.uk>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
 <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
 <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 11:04:53AM +0200, Jerome Brunet wrote:

> Carrying redundant information makes things complex and error prone.
> If you really want to update this, here is another proposition:
>  * Removing snd_soc_dai_link_set_capabilities()
>  * Removing both flags completely
>  * Let ASoC figure out what is needed based on the components present.

My understanding is that that was broadly where we were headed with this
stuff - snd_soc_dai_link_set_capabilities() is trying to figure things
out from the components already, it's storing the flags as a cache but
could be modified so we use it every time we need a value.

>=20
> >
> >>
> >> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>
> >>   Hi Mark,
> >>
> >>   Because b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture ch=
ecks')
> >>   introduced more than one problem, the change
> >>   "ASoC: core: use less strict tests for dailink capabilities" [0] is =
still
> >>   necessary but the change of semantic remains a problem with it.
> >>
> >>   This patch applies on top of it.
> >>
> >>   sound/soc/soc-pcm.c | 14 --------------
> >>   1 file changed, 14 deletions(-)
> >>
> >> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> >> index 00ac1cbf6f88..2e205b738eae 100644
> >> --- a/sound/soc/soc-pcm.c
> >> +++ b/sound/soc/soc-pcm.c
> >> @@ -2749,13 +2749,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd=
, int num)
> >>   					break;
> >>   				}
> >>   			}
> >> -
> >> -			if (!playback) {
> >> -				dev_err(rtd->card->dev,
> >> -					"No CPU DAIs support playback for stream %s\n",
> >> -					rtd->dai_link->stream_name);
> >> -				return -EINVAL;
> >> -			}
> >>   		}
> >>   		if (rtd->dai_link->dpcm_capture) {
> >>   			stream =3D SNDRV_PCM_STREAM_CAPTURE;
> >> @@ -2766,13 +2759,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd=
, int num)
> >>   					break;
> >>   				}
> >>   			}
> >> -
> >> -			if (!capture) {
> >> -				dev_err(rtd->card->dev,
> >> -					"No CPU DAIs support capture for stream %s\n",
> >> -					rtd->dai_link->stream_name);
> >> -				return -EINVAL;
> >> -			}
> >>   		}
> >>   	} else {
> >>   		/* Adapt stream for codec2codec links */
> >>
>=20

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8jDagACgkQJNaLcl1U
h9AuXgf8C4yoy4FY4cfbvcLUvUftWpBQ68HnBjmmDssWMcnsYPZ7eZAuo12Pivif
aUOrt8CMxCHQ2wDuoSwzLRNhAIHNUMBwGqLwTiLtT5vivhKDjZjnZqjtkswHWb2T
fJMyArIjKroVQWjmOkarx4gjKfx5mfv1RZmS3xnNvyD+YVY6AcCaITZuEo7j86td
QN1iHXQ1TPJI0wcql4Y3PEVkLC0O7F+4pReUCugbsPAfjTPvUc63KMfbtqzpQeov
WYBOnSzQyhJyeaT7YC9AaiGLgWcHq8o1TrmtQT+DD/qZotxlGOcaxx9GgHdkM3mq
X1YVKyKa3/VCh1h9xxE1P38ZSeo0qA==
=y7TQ
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
