Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58A300E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbhAVU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbhAVU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:58:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y205so4630763pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD8nfRkuspUBdwY3QBA8hFyJ8cWZLQijtR6nIjNPXq8=;
        b=rjGx/iG3qopn8O1l6Z60zF5KKuQOWQclkt6Z3N8lk0f742lIiOKyqWL8FAh2GubPVB
         CktyH+EUdMDwIoyzJEEItQWJOVp0zPojLunv4kkeiWR8X/nkAvrtQE6uEWfe3hRcwMIF
         QiAalDcTGP/EVhKEbeLEWpa1sp6F/s/efsnED24EOQToARj8rdeY/12wNor7UxAlMsPl
         Vjm2GwEX5Dxf39owmHqPbm+sZ5aKutuB1mh+0UKWtMxzZdGaj821xOTc/cLv1w3X+/zz
         ctAUISe9wZ8Hpm/K1H5+O8IBlNgrzKJ7uL329CVfW+nd/vseRrR8Ho6T2dtojO/T9mq/
         HZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD8nfRkuspUBdwY3QBA8hFyJ8cWZLQijtR6nIjNPXq8=;
        b=DCMheaivDWSfpjMo3R4gaCju9py5mMvNj7gxyYLaTeEFajyjHWRASHRMHiDCSERA4t
         q7wfBrMyPA8ztKlBxbl4ssvYwPg2u4Gb7YNeQ/+vGyN+12MqcNQcO5g/jXYFuLic9/X3
         j+7ajBC56S7+G/A/ySbPdEPZO7x+WQfC0+7TJ9wYbYu5Z+TByrJYu8YWCv8GTGydJs6T
         KknT7TUbP2kDvgITGZD8m+wRaqrhJSm9KGsRPnngiTqAjxiz96v0CVpTcgI2eVPv6cmE
         IYv/En+2cisOmSU02OXEtM9TPO2Qfa3GnFmRuoFl/OWqqYaIZVYzkVsjAPWe/yiQccLa
         8ktw==
X-Gm-Message-State: AOAM53109JZjF+5Kd62kRBsa6yrm1aIPbvXta0UkVJn9fjiy4uKZ73Em
        buA78Ysnk9AtNIfzoIQq/XPl2T94arPrHMpUCjk=
X-Google-Smtp-Source: ABdhPJzGozJOgjcNQkilLkF/yxBHze5QdO9nCrumT70boGsJBIhwNwj9/PGSfzo+6nMR/bV5zIbqcITgZY1TyyI+B3k=
X-Received: by 2002:a65:644b:: with SMTP id s11mr6543393pgv.4.1611349058919;
 Fri, 22 Jan 2021 12:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122164107.361939-1-hdegoede@redhat.com> <20210122164107.361939-13-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-13-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 22:58:28 +0200
Message-ID: <CAHp75VdUU=qf=Uh4htyYqcHeQTLwadznXO=dJcVQxpKrQv6a5g@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] ASoC: arizona: Make the wm5102, wm5110, wm8997
 and wm8998 drivers use the new jack library
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Make all arizona codec drivers for which drivers/mfd/arizona-core.c used
> to instantiate a "arizona-extcon" child-device use the new arizona-jack.c
> library for jack-detection.
>
> This has been tested on a Lenovo Yoga Tablet 2 1051L with a WM5102 codec.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/codecs/wm5102.c | 12 +++++++++++-
>  sound/soc/codecs/wm5110.c | 12 +++++++++++-
>  sound/soc/codecs/wm8997.c | 14 ++++++++++++--
>  sound/soc/codecs/wm8998.c |  9 +++++++++
>  4 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
> index 70d353b63fe0..b77595fb3ea8 100644
> --- a/sound/soc/codecs/wm5102.c
> +++ b/sound/soc/codecs/wm5102.c
> @@ -2004,6 +2004,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm5102 = {
>         .remove                 = wm5102_component_remove,
>         .set_sysclk             = arizona_set_sysclk,
>         .set_pll                = wm5102_set_fll,
> +       .set_jack               = arizona_jack_set_jack,
>         .name                   = DRV_NAME,
>         .compress_ops           = &wm5102_compress_ops,
>         .controls               = wm5102_snd_controls,
> @@ -2057,6 +2058,11 @@ static int wm5102_probe(struct platform_device *pdev)
>         if (ret != 0)
>                 return ret;
>
> +       /* This may return -EPROBE_DEFER, so do this early on */
> +       ret = arizona_jack_codec_dev_probe(&wm5102->core, &pdev->dev);
> +       if (ret)
> +               return ret;
> +
>         for (i = 0; i < ARRAY_SIZE(wm5102->fll); i++)
>                 wm5102->fll[i].vco_mult = 1;
>
> @@ -2089,7 +2095,7 @@ static int wm5102_probe(struct platform_device *pdev)
>                                   wm5102);
>         if (ret != 0) {
>                 dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
> -               return ret;
> +               goto err_jack_codec_dev;
>         }
>
>         ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
> @@ -2123,6 +2129,8 @@ static int wm5102_probe(struct platform_device *pdev)
>  err_dsp_irq:
>         arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
>         arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
> +err_jack_codec_dev:
> +       arizona_jack_codec_dev_remove(&wm5102->core);
>
>         return ret;
>  }
> @@ -2141,6 +2149,8 @@ static int wm5102_remove(struct platform_device *pdev)
>         arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
>         arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
>
> +       arizona_jack_codec_dev_remove(&wm5102->core);
> +
>         return 0;
>  }
>
> diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
> index 4238929b2375..ef22051a3599 100644
> --- a/sound/soc/codecs/wm5110.c
> +++ b/sound/soc/codecs/wm5110.c
> @@ -2370,6 +2370,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm5110 = {
>         .remove                 = wm5110_component_remove,
>         .set_sysclk             = arizona_set_sysclk,
>         .set_pll                = wm5110_set_fll,
> +       .set_jack               = arizona_jack_set_jack,
>         .name                   = DRV_NAME,
>         .compress_ops           = &wm5110_compress_ops,
>         .controls               = wm5110_snd_controls,
> @@ -2424,6 +2425,11 @@ static int wm5110_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> +       /* This may return -EPROBE_DEFER, so do this early on */
> +       ret = arizona_jack_codec_dev_probe(&wm5110->core, &pdev->dev);
> +       if (ret)
> +               return ret;
> +
>         for (i = 0; i < ARRAY_SIZE(wm5110->fll); i++)
>                 wm5110->fll[i].vco_mult = 3;
>
> @@ -2456,7 +2462,7 @@ static int wm5110_probe(struct platform_device *pdev)
>                                   wm5110);
>         if (ret != 0) {
>                 dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
> -               return ret;
> +               goto err_jack_codec_dev;
>         }
>
>         ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
> @@ -2490,6 +2496,8 @@ static int wm5110_probe(struct platform_device *pdev)
>  err_dsp_irq:
>         arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
>         arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
> +err_jack_codec_dev:
> +       arizona_jack_codec_dev_remove(&wm5110->core);
>
>         return ret;
>  }
> @@ -2510,6 +2518,8 @@ static int wm5110_remove(struct platform_device *pdev)
>         arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
>         arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
>
> +       arizona_jack_codec_dev_remove(&wm5110->core);
> +
>         return 0;
>  }
>
> diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
> index 229f2986cd96..4f5a848960e0 100644
> --- a/sound/soc/codecs/wm8997.c
> +++ b/sound/soc/codecs/wm8997.c
> @@ -1096,6 +1096,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8997 = {
>         .remove                 = wm8997_component_remove,
>         .set_sysclk             = arizona_set_sysclk,
>         .set_pll                = wm8997_set_fll,
> +       .set_jack               = arizona_jack_set_jack,
>         .controls               = wm8997_snd_controls,
>         .num_controls           = ARRAY_SIZE(wm8997_snd_controls),
>         .dapm_widgets           = wm8997_dapm_widgets,
> @@ -1132,6 +1133,11 @@ static int wm8997_probe(struct platform_device *pdev)
>
>         arizona_init_dvfs(&wm8997->core);
>
> +       /* This may return -EPROBE_DEFER, so do this early on */
> +       ret = arizona_jack_codec_dev_probe(&wm8997->core, &pdev->dev);
> +       if (ret)
> +               return ret;
> +
>         for (i = 0; i < ARRAY_SIZE(wm8997->fll); i++)
>                 wm8997->fll[i].vco_mult = 1;
>
> @@ -1163,10 +1169,10 @@ static int wm8997_probe(struct platform_device *pdev)
>
>         ret = arizona_init_vol_limit(arizona);
>         if (ret < 0)
> -               return ret;
> +               goto err_jack_codec_dev;
>         ret = arizona_init_spk_irqs(arizona);
>         if (ret < 0)
> -               return ret;
> +               goto err_jack_codec_dev;
>
>         ret = devm_snd_soc_register_component(&pdev->dev,
>                                               &soc_component_dev_wm8997,
> @@ -1181,6 +1187,8 @@ static int wm8997_probe(struct platform_device *pdev)
>
>  err_spk_irqs:
>         arizona_free_spk_irqs(arizona);
> +err_jack_codec_dev:
> +       arizona_jack_codec_dev_remove(&wm8997->core);
>
>         return ret;
>  }
> @@ -1194,6 +1202,8 @@ static int wm8997_remove(struct platform_device *pdev)
>
>         arizona_free_spk_irqs(arizona);
>
> +       arizona_jack_codec_dev_remove(&wm8997->core);
> +
>         return 0;
>  }
>
> diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
> index 5413254295b7..f74af1c46933 100644
> --- a/sound/soc/codecs/wm8998.c
> +++ b/sound/soc/codecs/wm8998.c
> @@ -1316,6 +1316,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8998 = {
>         .remove                 = wm8998_component_remove,
>         .set_sysclk             = arizona_set_sysclk,
>         .set_pll                = wm8998_set_fll,
> +       .set_jack               = arizona_jack_set_jack,
>         .controls               = wm8998_snd_controls,
>         .num_controls           = ARRAY_SIZE(wm8998_snd_controls),
>         .dapm_widgets           = wm8998_dapm_widgets,
> @@ -1350,6 +1351,11 @@ static int wm8998_probe(struct platform_device *pdev)
>         wm8998->core.arizona = arizona;
>         wm8998->core.num_inputs = 3;    /* IN1L, IN1R, IN2 */
>
> +       /* This may return -EPROBE_DEFER, so do this early on */
> +       ret = arizona_jack_codec_dev_probe(&wm8998->core, &pdev->dev);
> +       if (ret)
> +               return ret;
> +
>         for (i = 0; i < ARRAY_SIZE(wm8998->fll); i++)
>                 wm8998->fll[i].vco_mult = 1;
>
> @@ -1392,6 +1398,7 @@ static int wm8998_probe(struct platform_device *pdev)
>         arizona_free_spk_irqs(arizona);
>  err_pm_disable:
>         pm_runtime_disable(&pdev->dev);
> +       arizona_jack_codec_dev_remove(&wm8998->core);
>
>         return ret;
>  }
> @@ -1405,6 +1412,8 @@ static int wm8998_remove(struct platform_device *pdev)
>
>         arizona_free_spk_irqs(arizona);
>
> +       arizona_jack_codec_dev_remove(&wm8998->core);
> +
>         return 0;
>  }
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
