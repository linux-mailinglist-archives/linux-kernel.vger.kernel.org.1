Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F742255F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGTCrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgGTCrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:47:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF93C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 19:47:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so16032375ioh.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td6BerRuIm6Osr5k4KANv/zOEQY+Vf9NqOqMaPkayYo=;
        b=EYSOJPShDEjAvUeQAIslmRzXW8sF/c7GhHhfjJo/2SwWsOP3nKF/IzQ0cjkPVvxfU3
         Cnqd1vXWqG0+iPuQUIEY53o1zuqeakzsDG8rlCeUd1kMT42Ebqz++T/stGUjv7DaHYsO
         ik5VgLtXjCn4S4KUR/GfP+hCqNQneWiX8a5fgNAQa60MDwF/l3o/q0YtpyDE4xUa8r1X
         pQa//lGRWICp0GkSPJfIauUvAXXAApnahmzpdiVVI1uNIR0Tli+Ufk4O4jEm3JFWDbPd
         5B9UmVMCBs6sQB4pOrB7kGY7zXWtYmcfCqi5qIuO2bNdg59PPJ0E70k6aak38NDlyfLy
         kTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td6BerRuIm6Osr5k4KANv/zOEQY+Vf9NqOqMaPkayYo=;
        b=HQ2K8EOishqSgKOMa+nrxBK/y7UB5g7gsI1AbfiZrRtXV1hCPkCenyrPypqerTlP0n
         kt5e/b8uMkQUbYWiIXVWryKUVYHxQzGStwDfpgQiNMl1Qa1ZaM/TkBYY42u1zpmCCJha
         4yzj5E2K3ItnEQCcviGLRq4JC7zfI1zLAIgNPopGgY7uBt0KFhmgiOd1rxvy19w3Phbk
         8yfTnxlIkaMLBHb5Bc8C1IdD9Y8SP9HI6t5ve2HDaqnGwz1UrazucdEDC5jzGtkcXSy+
         M6JRpW2nkXrOajl50i2pY14DYZg0lmGKbuoElAmqidSW5uGVtO+GIJzd4l4zE+NQ7TcW
         vVNg==
X-Gm-Message-State: AOAM5314LDJQcLEi6i2xrNbBa3W4HzEbBKoBf5hzjLMALWp6YLNX2VJ1
        j05t1PctQ9WvGxFvLGDMMdx3QR03yjiDoaL2RIrsUA==
X-Google-Smtp-Source: ABdhPJzTyYx8+W9PEUhbmpm/S1Z6Algx0mLobofGyjcCATOwB1r364ddF/4JxLNvDkrpQWdc3h5V4ESoBYtuYAH3KgA=
X-Received: by 2002:a6b:d301:: with SMTP id s1mr20615004iob.146.1595213225672;
 Sun, 19 Jul 2020 19:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200717120207.3471030-1-cychiang@chromium.org> <20200717120207.3471030-2-cychiang@chromium.org>
In-Reply-To: <20200717120207.3471030-2-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 20 Jul 2020 10:46:54 +0800
Message-ID: <CA+Px+wV211AhRVTecU7OS6uP2AQw7v7Gu5x41L4dgW3xR8mA-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: sc7180: Add machine driver for sound card registration
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        Ajit Pandey <ajitp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 8:02 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
> new file mode 100644
> index 000000000000..cbe6b487d432
> --- /dev/null
> +++ b/sound/soc/qcom/sc7180.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + * sc7180.c -- ALSA SoC Machine driver for SC7180
> + */
Use "//" for all lines (see https://lkml.org/lkml/2020/5/14/332).

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/jack.h>
> +#include <sound/soc.h>
> +#include <uapi/linux/input-event-codes.h>
> +#include <dt-bindings/sound/sc7180-lpass.h>
> +#include "../codecs/rt5682.h"
> +#include "common.h"
> +#include "lpass.h"
Insert a blank line in between <...> and "..." and sort the list
alphabetically to make it less likely to conflict.

> +static int sc7180_snd_hw_params(struct snd_pcm_substream *substream,
> +                               struct snd_pcm_hw_params *params)
> +{
Dummy function?  Or is it still work in progress?

> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +       int ret = 0;
> +
> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               break;
> +       case MI2S_SECONDARY:
> +               break;
> +       default:
> +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
-EINVAL.

> +static int sc7180_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct snd_soc_component *component;
> +       struct snd_soc_card *card = rtd->card;
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +       struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +       struct sc7180_snd_data *pdata = snd_soc_card_get_drvdata(card);
> +       struct snd_jack *jack;
> +       int rval;
> +
> +       if (!pdata->jack_setup) {
> +               rval = snd_soc_card_jack_new(
> +                               card, "Headset Jack",
> +                               SND_JACK_HEADSET |
> +                               SND_JACK_HEADPHONE |
> +                               SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +                               SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +                               &pdata->jack, NULL, 0);
> +
> +               if (rval < 0) {
> +                       dev_err(card->dev, "Unable to add Headphone Jack\n");
> +                       return rval;
> +               }
> +
> +               jack = pdata->jack.jack;
> +
> +               snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +               snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +               snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +               snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +               pdata->jack_setup = true;
This block is something I don't expect to be in "dai_init" (i.e. there
is only 1 headset jack, why do we need to run the code for n times).

> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               jack  = pdata->jack.jack;
> +               component = codec_dai->component;
> +
> +               jack->private_data = component;
> +               jack->private_free = sc7180_jack_free;
> +               rval = snd_soc_component_set_jack(component,
> +                                                 &pdata->jack, NULL);
> +               if (rval != 0 && rval != -EOPNOTSUPP) {
> +                       dev_warn(card->dev, "Failed to set jack: %d\n", rval);
> +                       return rval;
> +               }
> +               break;
> +       case MI2S_SECONDARY:
> +               break;
> +       default:
> +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
-EINVAL.

> +static int sc7180_snd_startup(struct snd_pcm_substream *substream)
> +{
> +       unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +       struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +       int ret;
> +
> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
If the format is fixed, could it put somewhere statically?

> +               if (++data->pri_mi2s_clk_count == 1) {
Don't it need to be atomic?

> +                       snd_soc_dai_set_sysclk(cpu_dai,
> +                                              LPASS_MCLK0,
> +                                              DEFAULT_MCLK_RATE,
> +                                              SNDRV_PCM_STREAM_PLAYBACK);
> +               }
> +               snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
> +
> +               /* Configure PLL1 for codec */
> +               ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
> +                                         DEFAULT_MCLK_RATE, RT5682_PLL1_FREQ);
> +               if (ret < 0) {
> +                       dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
> +                       return ret;
> +               }
> +
> +               /* Configure sysclk for codec */
> +               ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
> +                                            RT5682_PLL1_FREQ,
> +                                            SND_SOC_CLOCK_IN);
> +               if (ret < 0)
> +                       dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
> +                               ret);
> +
> +               break;
> +       case MI2S_SECONDARY:
> +               break;
> +       default:
> +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
-EINVAL.

> +static void  sc7180_snd_shutdown(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               if (--data->pri_mi2s_clk_count == 0) {
Atomic?

> +                       snd_soc_dai_set_sysclk(cpu_dai,
> +                                              LPASS_MCLK0,
> +                                              0,
> +                                              SNDRV_PCM_STREAM_PLAYBACK);
> +               }
> +               break;
> +       case MI2S_SECONDARY:
> +               break;
> +       default:
> +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
-EINVAL.

> +static int sc7180_snd_platform_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card;
> +       struct sc7180_snd_data *data;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       card = kzalloc(sizeof(*card), GFP_KERNEL);
> +       if (!card)
> +               return -ENOMEM;
Looks like you don't need to allocate the card in runtime.  Also you
need to use the devm version if needed.

> +       /* Allocate the private data */
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
Use devm.

> +       card->dapm_widgets = sc7180_snd_widgets;
> +       card->num_dapm_widgets = ARRAY_SIZE(sc7180_snd_widgets);
Can the struct snd_soc_card allocate statically?

> +       sc7180_add_ops(card);
> +       ret = snd_soc_register_card(card);
devm.


I didn't dive into the logic too much.  Would need another round
review if any newer version.
