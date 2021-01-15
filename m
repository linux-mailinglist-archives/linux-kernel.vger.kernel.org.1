Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A999B2F81A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbhAORIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAORIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:08:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69460222B3;
        Fri, 15 Jan 2021 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610730491;
        bh=TTxGRW3tiG7LwSjTKZStrgp68+J+/ZsXQqui4SyalIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gj5MA1QhIl6mv38/JorSQaBuTdgK7JhRQ8W4zqkwTY2LHofctJYuQC/F7ATNbm3q7
         J4z7W/PZKj4xzlJ7DnKO8070MiSiVtC6o/vJbUPNn42rfa3iEJq5ZhcIum2t5RiRqG
         WZ0J28wSu6CQtFLrZnKxueolRqXU0WBQYtqzXc/wDVQuftGXwKsQlG2bttiSIik1UV
         DoKyndUiOV9u7prRSzT6D/ahQ3wRtTTkFaQutL1lc/URgSVKjkkm3AKdgsKON3GzpS
         uf2xyFYGeD06X3z0195kB3GOim7nUK8uRoXRyHLuJRGVVT7cCWcG+GtEI1YnYd6Anr
         GZfk7L3DWyYGg==
Date:   Fri, 15 Jan 2021 17:07:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Argus Lin <argus.lin@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Arnd Bergmann <arnd@arndb.de>, Jack Yu <jack.yu@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Dan Murphy <dmurphy@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "Shane.Chien" <shane.chien@mediatek.com>,
        Chipeng Chang <chipeng.chang@mediatek.com>,
        alsa-devel@alsa-project.org, wsd_upstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt6359: add MT6359 accdet driver
Message-ID: <20210115170737.GE4384@sirena.org.uk>
References: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
 <1609935546-11722-3-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <1609935546-11722-3-git-send-email-argus.lin@mediatek.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 06, 2021 at 08:19:06PM +0800, Argus Lin wrote:
> MT6359 audio codec support accessory detect features, adds MT6359
> accdet driver to support plug detection and key detection.

> ---
>  sound/soc/codecs/Kconfig         |    7 +
>  sound/soc/codecs/Makefile        |    2 +
>  sound/soc/codecs/mt6359-accdet.c | 1951 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/mt6359-accdet.h |  136 +++
>  sound/soc/codecs/mt6359.h        | 1863 +++++++++++++++++++++++++++++++++---

This driver is *huge*.  Looking through the code it feels like there's a
lot of things that are written with mostly duplicated code that differs
only in data so you could shrink things down a lot by refactoring things
to have one copy of the code and pass different data into it.

>  	  Enable support for the platform which uses MT6359 as
>  	  external codec device.
> +config SND_SOC_MT6359_ACCDET

Missing blank line here.

> +++ b/sound/soc/codecs/mt6359-accdet.c
> @@ -0,0 +1,1951 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 MediaTek Inc.

Please make the entire comment a C++ one so things look more
intentional.

> +#include "mt6359-accdet.h"
> +#include "mt6359.h"
> +/* grobal variable definitions */

Spelling mistake and you need more blank lines here.

> +#define REGISTER_VAL(x)	((x) - 1)
> +#define HAS_CAP(_c, _x)	\
> +	({typeof(_c)c = (_c); \
> +	typeof(_x)x = (_x); \
> +	(((c) & (x)) == (x)); })

These need namepsacing.

> +static struct mt63xx_accdet_data *accdet;
> +
> +static struct head_dts_data accdet_dts;
> +struct pwm_deb_settings *cust_pwm_deb;

You'd need a *very* good reason to be using global data rather than
storing anything in the device's driver data like most drivers.  There's
extensive use of global data here, and lots of raw pr_ prints rather
than dev_ prints as well - this doesn't look like how a Linux driver is
supposed to be written.

> +
> +const struct of_device_id mt6359_accdet_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt6359-accdet",
> +		.data = &mt6359_accdet,

Given that this is specific to a particular PMIC why does this need a
compatible string?

> +/* global function declaration */
> +
> +static u64 mt6359_accdet_get_current_time(void)
> +{
> +	return sched_clock();
> +}

It is probably best to remove this wrapper.

> +static bool mt6359_accdet_timeout_ns(u64 start_time_ns, u64 timeout_time_ns)
> +{
> +	u64 cur_time = 0;
> +	u64 elapse_time = 0;
> +
> +	/* get current tick, ns */
> +	cur_time = mt6359_accdet_get_current_time();
> +	if (cur_time < start_time_ns) {
> +		start_time_ns = cur_time;
> +		/* 400us */
> +		timeout_time_ns = 400 * 1000;
> +	}
> +	elapse_time = cur_time - start_time_ns;
> +
> +	/* check if timeout */
> +	if (timeout_time_ns <= elapse_time)
> +		return false;
> +
> +	return true;
> +}

There must be a generic implementation of this already surely?

> +static unsigned int check_key(unsigned int v)
> +{

This looks a lot like open coding of the functionality of the extcon
adc_jack functionality.

> +static void send_key_event(unsigned int keycode, unsigned int flag)
> +{
> +	int report = 0;
> +
> +	switch (keycode) {
> +	case DW_KEY:
> +		if (flag != 0)
> +			report = SND_JACK_BTN_1;

What does flag mean?  At the very least it needs renaming.

> +static void send_status_event(unsigned int cable_type, unsigned int status)
> +{
> +	int report = 0;

This is one of those places that looks like it could be code with
different data passed in.

> +
> +	switch (cable_type) {
> +	case HEADSET_NO_MIC:
> +		if (status)
> +			report = SND_JACK_HEADPHONE;
> +		else
> +			report = 0;
> +		snd_soc_jack_report(&accdet->jack, report, SND_JACK_HEADPHONE);
> +		/* when plug 4-pole out, if both AB=3 AB=0 happen,3-pole plug
> +		 * in will be incorrectly reported, then 3-pole plug-out is
> +		 * reported,if no mantory 4-pole plug-out, icon would be
> +		 * visible.
> +		 */
> +		if (status == 0) {
> +			report = 0;
> +			snd_soc_jack_report(&accdet->jack, report, SND_JACK_MICROPHONE);
> +		}
> +		pr_info("accdet HEADPHONE(3-pole) %s\n",
> +			status ? "PlugIn" : "PlugOut");

You shouldn't be spamming the logs for normal events like this.

> +	regmap_read(accdet->regmap, ACCDET_IRQ_ADDR, &val);
> +	while (val & ACCDET_IRQ_MASK_SFT &&
> +	       mt6359_accdet_timeout_ns(cur_time, ACCDET_TIME_OUT))
> +		;

This is open coding regmap_read_poll_timeout(), this pattern is repeated
in several places.

> +static inline void clear_accdet_eint(unsigned int eintid)
> +{
> +	if ((eintid & PMIC_EINT0) == PMIC_EINT0) {

The == part is redundant here, and again this is another place where it
feels like there's duplicated code that should be using data.  All this
interrupt handling code is really extremely difficult to follow, there's
*lots* of functions all open coding many individual register bits
sometimes redundantly and it's very hard to follow what it's supposed to
be doing.  I can't help but think that in addition to making things data
driven writing more linear code without these abstraction layers would
help a lot with comprehensibility.

> +static irqreturn_t mtk_accdet_irq_handler_thread(int irq, void *data)
> +{
> +	accdet_irq_handle();
> +
> +	return IRQ_HANDLED;
> +}

Why does this wrapper function exist - AFAICT it's just introducing a
bug given that the called function is able to detect spurious interrupts
but this unconditionally reports IRQ_HANDLED.

> +int mt6359_accdet_init(struct snd_soc_component *component,
> +		       struct snd_soc_card *card)
> +{
> +	int ret = 0;
> +	struct mt63xx_accdet_data *priv =
> +			snd_soc_card_get_drvdata(component->card);

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mt6359_accdet_init);

This is a weird interface, what's going on here?

> +int mt6359_accdet_set_drvdata(struct snd_soc_card *card)
> +{
> +	snd_soc_card_set_drvdata(card, accdet);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt6359_accdet_set_drvdata);

This is setting off *massive* alarm bells in that it seems to try to
claim the card level driver data for this specific driver, again what's
going on here?

> +module_init(mt6359_accdet_soc_init);
> +module_exit(mt6359_accdet_soc_exit);

module_platform_driver()

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmABy9gACgkQJNaLcl1U
h9DY/gf/fHBtIfQbXuCCr1+QvKa57mk9zIvrlJKMEtVByp+AvZkXaTLoyMIg1JcO
4rAyQrhsqr3HcLdUVrzQqljjDGREnMvwZOUB9EeEnREwj+vtYm/ogs4ccXmpmCES
tIhNW4JpGfVxCVhM0XfUz8s86Y7mo4bv0pDy6aZMop4p2wG4lZvOcdXDdqVFXVyG
YkT3A7fNgJ5Hi7K3BGViNNLEvCjkXt6KmFjNTPpyc4zUXoOJNkqHv5gUn/NhW9Lv
BYOuUVlwjlJC4SANqXz/5WYI0aux1tFpgnkASGWV1K7TyFyjzEJklB1vmGHE/e+6
WDE6B01vYILmCPElPN8uHzwXEYzv6Q==
=azMJ
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
