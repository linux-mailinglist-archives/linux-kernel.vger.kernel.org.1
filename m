Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF64300E05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbhAVUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbhAVUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:43:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A9C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:42:48 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 15so4596794pgx.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05PthPyvl5iM5gx1+ea/6ZO6qWwbH3aECN+X13x7jUI=;
        b=njHYO51lm0GxjnaX+40skXE/3pFlZtm9lU5eRESsBYrQyOghMB0bYzDd2WhYBPH5Ic
         /dU6Ux9KEi9T+POv5R5VTHFz+km0ECUgRZ5vP9bNMJcwGmrj5RCs88UluXY9V/Lj18j2
         i+X5qe1U+NUQ57UDE2YGjy08Nde/KbAVW+QgtQdR1HYk4VQpMOM+9bmrV370y2+EKfZj
         hk0FsIdApPmZ5k9PLh2q/irRCy5gHjRqdVJORWnEB3AI5yoUQAmgq/skKeWe6FKzEmrA
         xChdhyZhazIIWIygSeCphSETQ5dZt/EwZqtWHYrpSgjvUnf9FNqABKt6M9kx2If9vMmG
         Dnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05PthPyvl5iM5gx1+ea/6ZO6qWwbH3aECN+X13x7jUI=;
        b=moHNceK6pvcMVSZCQxrKspHJ4c+mUKzYVHRecrZXAWOIWpyBIrY71CB7+1Tp5mv7FK
         WF3DqokVuXXBWZ55vrqlQmwq8Gasyb9DI4BEn/rw0Ag1k4nOsEJHr9uXlGscayzHEJ9+
         NN2wDEY+Zu/GVglarMjHAifTJ6H+iFErXZp5d75HKUw4Cc3HEb0pflvRrWRQms5mvuG6
         LwKWWUZcZHaVOLlGP33hwprp991kmI4cYZEtqj9+peWfCwirilmtmpJdGV1q6O076r/N
         4FjTRHOpOQXVZaS1pdU8opWXr2h9EY/HAdR25N9HKBcdGJE+RUqi9UVrhpQ9RGlf2s67
         xKAQ==
X-Gm-Message-State: AOAM530tDqkGZ0X9amB90AV5J8A4XgqoxyfGEs4XFQtRARvZKGpiF7q6
        v9MleDy7wFxD979SnHlynFQr2f248OcMB3Ns9J3l+uPZ2s9bOg==
X-Google-Smtp-Source: ABdhPJxWs13cN22X8dHT1/04CCQq1lPRv10Z2NeMrKRu8eMEgXSMUmuBY/cx+TUq9GEx5IFo4Hz4JwoSspnH5pSVbTg=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr6636142pfe.40.1611348167525; Fri, 22 Jan
 2021 12:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20210122164107.361939-1-hdegoede@redhat.com> <20210122164107.361939-9-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-9-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 22:43:36 +0200
Message-ID: <CAHp75VdEJmZ-krjBmip_TaXyrVMwqLBDr=2xCRwW3fE61tGP4A@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] ASoC: arizona-jack: Use arizona->dev for runtime-pm
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
> Drivers for MFD child-devices such as the arizona codec drivers
> and the arizona-extcon driver can choose to either make
> runtime_pm_get/_put calls on their own child-device, which will
> then be propagated to their parent; or they can make them directly
> on their MFD parent-device.
>
> The arizona-extcon code was using runtime_pm_get/_put calls on
> its own child-device where as the codec drivers are using
> runtime_pm_get/_put calls on their parent.
>
> The arizona-extcon MFD cell/child-device has been removed and this
> commit is part of refactoring the arizona-extcon code into a library
> to be used directly from the codec drivers.
>
> Specifically this commit moves the code over to make
> runtime_pm_get/_put calls on the parent device (on arizona->dev)
> bringing the code inline with how the codec drivers do this.
>
> Note this also removes the pm_runtime_enable/_disable calls
> as pm_runtime support has already been enabled on the parent-device
> by the arizona MFD driver.
>
> This is part of a patch series converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report
> jack state through the standard sound/soc/soc-jack.c functions.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/codecs/arizona-jack.c | 42 ++++++++++++++-------------------
>  sound/soc/codecs/arizona.h      |  1 -
>  2 files changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
> index 5b40316d0d75..a6e8071f84ab 100644
> --- a/sound/soc/codecs/arizona-jack.c
> +++ b/sound/soc/codecs/arizona-jack.c
> @@ -251,7 +251,7 @@ static void arizona_start_mic(struct arizona_priv *info)
>         unsigned int mode;
>
>         /* Microphone detection can't use idle mode */
> -       pm_runtime_get_sync(info->dev);
> +       pm_runtime_get_sync(arizona->dev);
>
>         if (info->detecting) {
>                 ret = regulator_allow_bypass(info->micvdd, false);
> @@ -296,7 +296,7 @@ static void arizona_start_mic(struct arizona_priv *info)
>                 dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
>         } else if (!change) {
>                 regulator_disable(info->micvdd);
> -               pm_runtime_put_autosuspend(info->dev);
> +               pm_runtime_put_autosuspend(arizona->dev);
>         }
>  }
>
> @@ -341,8 +341,8 @@ static void arizona_stop_mic(struct arizona_priv *info)
>
>         if (change) {
>                 regulator_disable(info->micvdd);
> -               pm_runtime_mark_last_busy(info->dev);
> -               pm_runtime_put_autosuspend(info->dev);
> +               pm_runtime_mark_last_busy(arizona->dev);
> +               pm_runtime_put_autosuspend(arizona->dev);
>         }
>  }
>
> @@ -534,7 +534,7 @@ static int arizona_hpdet_do_id(struct arizona_priv *info, int *reading,
>                 info->num_hpdet_res = 0;
>                 info->hpdet_retried = true;
>                 arizona_start_hpdet_acc_id(info);
> -               pm_runtime_put(info->dev);
> +               pm_runtime_put(arizona->dev);
>                 return -EAGAIN;
>         }
>
> @@ -631,7 +631,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
>                 arizona_start_mic(info);
>
>         if (info->hpdet_active) {
> -               pm_runtime_put_autosuspend(info->dev);
> +               pm_runtime_put_autosuspend(arizona->dev);
>                 info->hpdet_active = false;
>         }
>
> @@ -656,7 +656,7 @@ static void arizona_identify_headphone(struct arizona_priv *info)
>         dev_dbg(arizona->dev, "Starting HPDET\n");
>
>         /* Make sure we keep the device enabled during the measurement */
> -       pm_runtime_get_sync(info->dev);
> +       pm_runtime_get_sync(arizona->dev);
>
>         info->hpdet_active = true;
>
> @@ -685,7 +685,7 @@ static void arizona_identify_headphone(struct arizona_priv *info)
>
>  err:
>         arizona_extcon_hp_clamp(info, false);
> -       pm_runtime_put_autosuspend(info->dev);
> +       pm_runtime_put_autosuspend(arizona->dev);
>
>         /* Just report headphone */
>         ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
> @@ -708,7 +708,7 @@ static void arizona_start_hpdet_acc_id(struct arizona_priv *info)
>         dev_dbg(arizona->dev, "Starting identification via HPDET\n");
>
>         /* Make sure we keep the device enabled during the measurement */
> -       pm_runtime_get_sync(info->dev);
> +       pm_runtime_get_sync(arizona->dev);
>
>         info->hpdet_active = true;
>
> @@ -1006,7 +1006,7 @@ static void arizona_micd_detect(struct work_struct *work)
>         else
>                 arizona_button_reading(info);
>
> -       pm_runtime_mark_last_busy(info->dev);
> +       pm_runtime_mark_last_busy(arizona->dev);
>         mutex_unlock(&info->lock);
>  }
>
> @@ -1090,7 +1090,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
>         cancelled_hp = cancel_delayed_work_sync(&info->hpdet_work);
>         cancelled_mic = cancel_delayed_work_sync(&info->micd_timeout_work);
>
> -       pm_runtime_get_sync(info->dev);
> +       pm_runtime_get_sync(arizona->dev);
>
>         mutex_lock(&info->lock);
>
> @@ -1110,7 +1110,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
>                 dev_err(arizona->dev, "Failed to read jackdet status: %d\n",
>                         ret);
>                 mutex_unlock(&info->lock);
> -               pm_runtime_put_autosuspend(info->dev);
> +               pm_runtime_put_autosuspend(arizona->dev);
>                 return IRQ_NONE;
>         }
>
> @@ -1210,8 +1210,8 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
>
>         mutex_unlock(&info->lock);
>
> -       pm_runtime_mark_last_busy(info->dev);
> -       pm_runtime_put_autosuspend(info->dev);
> +       pm_runtime_mark_last_busy(arizona->dev);
> +       pm_runtime_put_autosuspend(arizona->dev);
>
>         return IRQ_HANDLED;
>  }
> @@ -1366,7 +1366,6 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>
>         mutex_init(&info->lock);
>         info->arizona = arizona;
> -       info->dev = &pdev->dev;
>         info->last_jackdet = ~(ARIZONA_MICD_CLAMP_STS | ARIZONA_JD1_STS);
>         INIT_DELAYED_WORK(&info->hpdet_work, arizona_hpdet_work);
>         INIT_DELAYED_WORK(&info->micd_detect_work, arizona_micd_detect);
> @@ -1617,9 +1616,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>
>         arizona_extcon_set_mode(info, 0);
>
> -       pm_runtime_enable(&pdev->dev);
> -       pm_runtime_idle(&pdev->dev);
> -       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_get_sync(arizona->dev);
>
>         if (info->micd_clamp) {
>                 jack_irq_rise = ARIZONA_IRQ_MICD_CLAMP_RISE;
> @@ -1689,7 +1686,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>                 goto err_hpdet;
>         }
>
> -       pm_runtime_put(&pdev->dev);
> +       pm_runtime_put(arizona->dev);
>
>         return 0;
>
> @@ -1706,8 +1703,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  err_rise:
>         arizona_free_irq(arizona, jack_irq_rise, info);
>  err_pm:
> -       pm_runtime_put(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put(arizona->dev);
>  err_gpio:
>         gpiod_put(info->micd_pol_gpio);
>         return ret;
> @@ -1747,7 +1743,7 @@ static int arizona_extcon_remove(struct platform_device *pdev)
>                         ret);
>         } else if (change) {
>                 regulator_disable(info->micvdd);
> -               pm_runtime_put(info->dev);
> +               pm_runtime_put(arizona->dev);
>         }
>
>         regmap_update_bits(arizona->regmap,
> @@ -1759,8 +1755,6 @@ static int arizona_extcon_remove(struct platform_device *pdev)
>
>         gpiod_put(info->micd_pol_gpio);
>
> -       pm_runtime_disable(&pdev->dev);
> -
>         return 0;
>  }
>
> diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
> index d1a263a67bba..7132dbc3c840 100644
> --- a/sound/soc/codecs/arizona.h
> +++ b/sound/soc/codecs/arizona.h
> @@ -93,7 +93,6 @@ struct arizona_priv {
>         bool dvfs_cached;
>
>         /* Variables used by arizona-jack.c code */
> -       struct device *dev;
>         struct mutex lock;
>         struct delayed_work hpdet_work;
>         struct delayed_work micd_detect_work;
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
