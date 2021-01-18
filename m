Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310012FA787
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393653AbhARR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393597AbhARRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:24:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:23:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so10563672pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m+rUUQDdIhjKXOvL3hkSq8B9mPmn1aBAZoQylBeiLM=;
        b=n86qYIu9xLuWzYbv5gShTHRXcjqMDjkM0L7Ez6qeDZBDJjTSBGiYMV1VuMcQmn3CW2
         HmJauxMzu8xcDFCy8yhRj5ANa+eWQMVPQ40RwNdXfjCjkVZlrheJgNY0Y4AONsglytIS
         Ia3fQW7QcfHW4epgVInXoNKquJdCEkflv15WFP3LAJzYmUXefNozboNUAhp8SM7/cUOY
         7ggLCPvOFIiO38HSZxVVnfDqD4QcnsBekwwVApOQawixQiITtTRkHKHs9ms+8Befx5r+
         nUJErvetE0dCReRQgqIxy8pPTV1u4noYEzL2/ZqCK8fjtOx3+nZK33SVaVbCpLrK1Jcp
         ePCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m+rUUQDdIhjKXOvL3hkSq8B9mPmn1aBAZoQylBeiLM=;
        b=pdgidtWDA5LrnTi2ZRDoG8hOHAGdM8MOfXtbbclwmiPNiZZDAw1YItlXKLftrnI/pE
         1KjKtMvllZ95FyqnHD/7ag5XuANBXhDr5mDAbH1TXgs0R4oD5P1pHTydJf07T5NSqrR8
         HC/cC2joX/XewNVL/lkumMLZIxlV7JRvdRF1xPnOy39tHJ4l3Z2gW5Cs57vSF3yfW8OJ
         pICsZeEQQOxAuywEhtz4Api+nri9uF78GBYlb25BDuRKCxSzbb/AtSiFgKfThK2hCcsp
         KBQfungeCwpf37cuwt6IcYyYST5/+NeqBu0zsCrE3LaKqkcy6bq6pRsh0eMbeMn/gupo
         BSUg==
X-Gm-Message-State: AOAM530wkECUMYkt9/Y4+Qi1XSnybXt/4vfxMHkB2EN7qWSmIAeIAC+T
        e9zslOp0SP1qMI8IkkrCWy2zS1lbcFXUEw/ebpQ=
X-Google-Smtp-Source: ABdhPJycCXTt6CPDhf5rSe5BpyIHmuyVLqOnWDvQyfIQJk/8LVbuHSNzR2+YhxDf2Aqi/p7Kc+CLxDrXgStx3ExNV7U=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr217722pfk.73.1610990611337; Mon, 18 Jan
 2021 09:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com> <20210117160555.78376-9-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-9-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jan 2021 19:24:20 +0200
Message-ID: <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ASoC: arizona-jack: convert into a helper
 library for codec drivers
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

On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Convert the arizona extcon driver into a helper library for direct use
> from the arizona codec-drivers, rather then being bound to a separate
> MFD cell.
>
> Note the probe (and remove) sequence is split into 2 parts:
>
> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
> jack-detect specific variables in struct arizona_priv and tries to get
> a number of resources where getting them may fail with -EPROBE_DEFER.
>
> 2. Then once the machine driver has create a snd_sock_jack through
> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
> the codec component, which will call the new arizona_jack_set_jack(),
> which sets up jack-detection and requests the IRQs.
>
> This split is necessary, because the IRQ handlers need access to the
> arizona->dapm pointer and the snd_sock_jack which are not available
> when the codec-driver's probe function runs.
>
> Note this requires that machine-drivers for codecs which are converted
> to use the new helper functions from arizona-jack.c are modified to
> create a snd_soc_jack through snd_soc_card_jack_new() and register
> this jack with the codec through snd_soc_component_set_jack().

...

> +int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
>  {
> -       struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> +       struct arizona *arizona = info->arizona;
>         struct arizona_pdata *pdata = &arizona->pdata;

> +       int ret, mode;
>
>         if (!dev_get_platdata(arizona->dev))
> -               arizona_extcon_device_get_pdata(&pdev->dev, arizona);
> +               arizona_extcon_device_get_pdata(dev, arizona);
>
> -       info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
> +       info->micvdd = devm_regulator_get(arizona->dev, "MICVDD");

I'm wondering if arizona->dev == dev here. if no, can this function
get a comment / kernel-doc explaining what dev is?

>         if (IS_ERR(info->micvdd)) {

>                 ret = PTR_ERR(info->micvdd);
>                 dev_err(arizona->dev, "Failed to get MICVDD: %d\n", ret);

Side note: at some point perhaps consider to use dev_err_probe() with
functions which may return deferred probe error code.

...

> +       info->edev = devm_extcon_dev_allocate(dev, arizona_cable);
>         if (IS_ERR(info->edev)) {
> -               dev_err(&pdev->dev, "failed to allocate extcon device\n");
> +               dev_err(arizona->dev, "failed to allocate extcon device\n");

Ditto about dev.

>                 return -ENOMEM;
>         }

...

> +               ret = devm_gpio_request_one(dev, arizona->pdata.hpdet_id_gpio,
>                                             GPIOF_OUT_INIT_LOW,
>                                             "HPDET");
>                 if (ret != 0) {
>                         dev_err(arizona->dev, "Failed to request GPIO%d: %d\n",
>                                 arizona->pdata.hpdet_id_gpio, ret);
> -                       goto err_gpio;
> +                       gpiod_put(info->micd_pol_gpio);

Perhaps move before dev_err() ?
Side comment: Do we need dev_err_probe() here?

> +                       return ret;
>                 }

-- 
With Best Regards,
Andy Shevchenko
