Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C012E4086
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441446AbgL1ORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441408AbgL1ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:17:14 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70630C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:16:34 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so7418626pgo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tG/RECwRgNQRQ8Y3N/bmt9ivqZMjunU0lDRr6TZ1FSs=;
        b=BASgsSc6AnQXc6h5OKkLHTc8nKdTjRKgDhLNdBqlxiHrzOKY+xmqtDb6hX1w3ne7aP
         +GSzpQldp9Ol/Tsf+3hroeJPMnK9Yvk9n2qUWJ6Nk8vUn3mc2v2Al1DLuCAHnHgTeDd9
         uOP4Jyul3i3FiDyb3ggNcGbZ8phIPSBBjEoFddI9zJwlMrmCStujI/TsjZ5ZhI5pxC+a
         4YFPVDaDV2eC1jaW+sDSERr92tbw9Pgo9SLKTqt73r5rvJuDJgsOaldg/f+7iNutwcG0
         qdijuRjw1OfQMIEKKtuWwiTdSmU5ToRX59ewX+mUuz6Y9x2wPqM9nWeafu9tDnF081lV
         JN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG/RECwRgNQRQ8Y3N/bmt9ivqZMjunU0lDRr6TZ1FSs=;
        b=qybzUeANBrPztVgPnJTqn6ticK0BHm3gE650mmf3DSaWIE9dnRvigm/DYJloI9YO9R
         iVYOG1Stff0iprR25100kNsnbuEx3SCBek/ROp+tlkIc6VSRzVKz3Hfz0BdLRY6oNdHH
         cQC0Z8JyTEAjTXSFZqsgoI5kld7VNipmhnQOXsU61QHEZ3jmgcPbV7HQfLBUkZ6Ov+OU
         rhxQWj7Cmp5dLAQfZlx0KnhT4ppgretx88L1TgpoH6/nUsrfmOYDaNrHgLd1zTm6S2mc
         Fl3FHUu0lOYxeHQSVzPaMe8Gtqe8AhMf5JjI0bt4YW1TpJkGss29nj5NGBD/BNh5eGWZ
         A/dQ==
X-Gm-Message-State: AOAM530/nQzdbGrKgKnWQTZOspuStAgJWeq0pm1N0oH0jmPhgiFPRNbL
        yBg1RMu3DH8JlMkHfHDy2xBllihX0O8NQk0HxVE=
X-Google-Smtp-Source: ABdhPJzgfoxIJsP2SMbDpjaL6TOeeco/9fSOdRZRL5HgwYT+kLVXmorkD+7UgHeMCnuoRe3C8xC6Ph7OGm2IH3XMfIw=
X-Received: by 2002:a63:b1e:: with SMTP id 30mr43741498pgl.203.1609164994000;
 Mon, 28 Dec 2020 06:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20201227211232.117801-1-hdegoede@redhat.com> <20201227211232.117801-11-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-11-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Dec 2020 16:16:17 +0200
Message-ID: <CAHp75VfpdJkDxwynHTaLbVKZ1fp7XZS=RUSC1OV_06cmpyoNAQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] extcon: arizona: Also report jack state through snd_soc_jack_report()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 11:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Linux Arizona driver uses the MFD framework to create several
> sub-devices for the Arizona codec and then uses a driver per function.
>
> The extcon-arizona driver handles jack-detect support and exports info
> about the jack state to userspace through the standard extcon sysfs
> class interface.
>
> Standard Linux userspace does not monitor/use the extcon sysfs interface
> for jack-detection, resulting in the jack-state not being taken into
> account by userspace.
>
> The ASoC machine-driver may have created a standard ASoC jack when
> registering the card. In this case also report the jack-state through the
> ASoC jack so that jack-detection works with standard Linux userspace.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-arizona.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index d5b3231744f9..931a7d239aea 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -20,6 +20,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/extcon-provider.h>
>
> +#include <sound/jack.h>
>  #include <sound/soc.h>
>
>  #include <linux/mfd/arizona/core.h>
> @@ -598,11 +599,19 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
>  static void arizona_set_extcon_state(struct arizona_extcon_info *info,
>                                      unsigned int id, bool state)
>  {
> -       int ret;
> +       int ret, mask = 0;

I would rather prefer... drop  assignment here...

>         ret = extcon_set_state_sync(info->edev, id, state);
>         if (ret)
>                 dev_err(info->arizona->dev, "Failed to set extcon state: %d\n", ret);
> +
> +       switch (id) {
> +       case EXTCON_JACK_HEADPHONE:     mask = SND_JACK_HEADPHONE;      break;
> +       case EXTCON_JACK_MICROPHONE:    mask = SND_JACK_MICROPHONE;     break;

...introduce default here, which immediately bails out (return)...

> +       }
> +
> +       if (info->arizona->jack && mask)

...and drop mask check here.

> +               snd_soc_jack_report(info->arizona->jack, state ? mask : 0, mask);
>  }
>
>  static irqreturn_t arizona_hpdet_irq(int irq, void *data)
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
