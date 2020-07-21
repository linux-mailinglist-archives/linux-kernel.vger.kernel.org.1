Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28797227F06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgGULgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:36:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDFC0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:36:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so2496872wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yj1qnl1WLfnKvv1xFJMIVkm5J+E8pmta5ysPZcg545M=;
        b=Ra1p4VangqmV7CM2mbg0ENHiGKAvqOGmm3QzHbwuXOK6VwYR47xfLyfWeo4Z9vQOKG
         xNLUEYZ4KalALdotcQoLjc0oegPpaaIMiry4Npz1FVNm4E1sHQQ7RwqhFy+x89bkbaVN
         1cIXj7j9IG5jR3Ki9Dshx719g4/0p3B0VXkOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yj1qnl1WLfnKvv1xFJMIVkm5J+E8pmta5ysPZcg545M=;
        b=SKbH4TYkfthBOH/e1ek7ikVCZtczmqBy3tsMMIJQxYEhdkVa/VN1eT0Qq3cjCIj7O/
         2CWtiyLPKzyeNwJnGSij3Cay0OpAhBDxfUEkIvawYN3aZxmv7LDw1YDrnrL8Bl2h+ytp
         7APOE+QryVvpI5/X4uMuKTWn5uSjITklBJpeN9+FNL5HbtIJOddOkgY3E1TQxn0aucjO
         dMocYU2QS5XHbZvGT8nx/0g0bA7haWcuZnORWxNvM2/WkDMlJzXwhyNwhFdWNwLUNNOc
         CL22sy9Ptg9Tg/39Q/0zP4oWLcRGfqFaZUHwznSsVlZg2B4RWWCU6ouibShZlz55+r9H
         HmRQ==
X-Gm-Message-State: AOAM533LTFSDHlqeYPxWetKeBdGsdIQtrgh6kZvZs2oe9boXCI7Y4+1C
        EpjYsPWoS8slhz5GEDE+FkkKDz4lLlWFCsU+MEZ1XQ==
X-Google-Smtp-Source: ABdhPJwh6lTkGfTci7wgoDwi1kHu85IEqFzskg/QiL2w0OvgAKxpMaamWsYAIfpujP6j1Keo8EsqOTDtjZZF3ildGPU=
X-Received: by 2002:a1c:6246:: with SMTP id w67mr3574806wmb.42.1595331397735;
 Tue, 21 Jul 2020 04:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200717120207.3471030-1-cychiang@chromium.org>
 <20200717120207.3471030-2-cychiang@chromium.org> <CA+Px+wV211AhRVTecU7OS6uP2AQw7v7Gu5x41L4dgW3xR8mA-A@mail.gmail.com>
In-Reply-To: <CA+Px+wV211AhRVTecU7OS6uP2AQw7v7Gu5x41L4dgW3xR8mA-A@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 21 Jul 2020 19:36:10 +0800
Message-ID: <CAFv8Nw+n9nQio7-3GS0sYrj58D9+Rpq39u4RTDJ0rVgvKtdj1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: sc7180: Add machine driver for sound card registration
To:     Tzung-Bi Shih <tzungbi@google.com>
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
        Douglas Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
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

Hi Tzung-Bi,
Thanks for the review!
On Mon, Jul 20, 2020 at 10:47 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 17, 2020 at 8:02 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> > diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
> > new file mode 100644
> > index 000000000000..cbe6b487d432
> > --- /dev/null
> > +++ b/sound/soc/qcom/sc7180.c
> > @@ -0,0 +1,410 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > + *
> > + * sc7180.c -- ALSA SoC Machine driver for SC7180
> > + */
> Use "//" for all lines (see https://lkml.org/lkml/2020/5/14/332).
>

Thanks for the pointer. Fixed in v2.

> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/jack.h>
> > +#include <sound/soc.h>
> > +#include <uapi/linux/input-event-codes.h>
> > +#include <dt-bindings/sound/sc7180-lpass.h>
> > +#include "../codecs/rt5682.h"
> > +#include "common.h"
> > +#include "lpass.h"
> Insert a blank line in between <...> and "..." and sort the list
> alphabetically to make it less likely to conflict.

Fixed in v2.

>
> > +static int sc7180_snd_hw_params(struct snd_pcm_substream *substream,
> > +                               struct snd_pcm_hw_params *params)
> > +{
> Dummy function?  Or is it still work in progress?
>
Removed in v2.

> > +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> > +       int ret = 0;
> > +
> > +       switch (cpu_dai->id) {
> > +       case MI2S_PRIMARY:
> > +               break;
> > +       case MI2S_SECONDARY:
> > +               break;
> > +       default:
> > +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> -EINVAL.
>
Removed in v2.
> > +static int sc7180_dai_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +       struct snd_soc_component *component;
> > +       struct snd_soc_card *card = rtd->card;
> > +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> > +       struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> > +       struct sc7180_snd_data *pdata = snd_soc_card_get_drvdata(card);
> > +       struct snd_jack *jack;
> > +       int rval;
> > +
> > +       if (!pdata->jack_setup) {
> > +               rval = snd_soc_card_jack_new(
> > +                               card, "Headset Jack",
> > +                               SND_JACK_HEADSET |
> > +                               SND_JACK_HEADPHONE |
> > +                               SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> > +                               SND_JACK_BTN_2 | SND_JACK_BTN_3,
> > +                               &pdata->jack, NULL, 0);
> > +
> > +               if (rval < 0) {
> > +                       dev_err(card->dev, "Unable to add Headphone Jack\n");
> > +                       return rval;
> > +               }
> > +
> > +               jack = pdata->jack.jack;
> > +
> > +               snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > +               snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > +               snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > +               snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> > +               pdata->jack_setup = true;
> This block is something I don't expect to be in "dai_init" (i.e. there
> is only 1 headset jack, why do we need to run the code for n times).
>
Thanks for the suggestion. In v2 I am using aux device so this
function is cleaned up to be specific to aux device for jack
detection.

> > +       switch (cpu_dai->id) {
> > +       case MI2S_PRIMARY:
> > +               jack  = pdata->jack.jack;
> > +               component = codec_dai->component;
> > +
> > +               jack->private_data = component;
> > +               jack->private_free = sc7180_jack_free;
> > +               rval = snd_soc_component_set_jack(component,
> > +                                                 &pdata->jack, NULL);
> > +               if (rval != 0 && rval != -EOPNOTSUPP) {
> > +                       dev_warn(card->dev, "Failed to set jack: %d\n", rval);
> > +                       return rval;
> > +               }
> > +               break;
> > +       case MI2S_SECONDARY:
> > +               break;
> > +       default:
> > +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> -EINVAL.
>
Removed in v2.
> > +static int sc7180_snd_startup(struct snd_pcm_substream *substream)
> > +{
> > +       unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
> > +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +       struct snd_soc_card *card = rtd->card;
> > +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
> > +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> > +       struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> > +       int ret;
> > +
> > +       switch (cpu_dai->id) {
> > +       case MI2S_PRIMARY:
> > +               codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
> If the format is fixed, could it put somewhere statically?
>
Fixed in v2.
> > +               if (++data->pri_mi2s_clk_count == 1) {
> Don't it need to be atomic?
>
soc_pcm_open and soc_pcm_close are protected by card->pcm_mutex so
they will happen in sequence.

> > +                       snd_soc_dai_set_sysclk(cpu_dai,
> > +                                              LPASS_MCLK0,
> > +                                              DEFAULT_MCLK_RATE,
> > +                                              SNDRV_PCM_STREAM_PLAYBACK);
> > +               }
> > +               snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
> > +
> > +               /* Configure PLL1 for codec */
> > +               ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
> > +                                         DEFAULT_MCLK_RATE, RT5682_PLL1_FREQ);
> > +               if (ret < 0) {
> > +                       dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
> > +                       return ret;
> > +               }
> > +
> > +               /* Configure sysclk for codec */
> > +               ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
> > +                                            RT5682_PLL1_FREQ,
> > +                                            SND_SOC_CLOCK_IN);
> > +               if (ret < 0)
> > +                       dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
> > +                               ret);
> > +
> > +               break;
> > +       case MI2S_SECONDARY:
> > +               break;
> > +       default:
> > +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> -EINVAL.
Fixed in v2
>
> > +static void  sc7180_snd_shutdown(struct snd_pcm_substream *substream)
> > +{
> > +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +       struct snd_soc_card *card = rtd->card;
> > +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
> > +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> > +
> > +       switch (cpu_dai->id) {
> > +       case MI2S_PRIMARY:
> > +               if (--data->pri_mi2s_clk_count == 0) {
> Atomic?
ditto
>
> > +                       snd_soc_dai_set_sysclk(cpu_dai,
> > +                                              LPASS_MCLK0,
> > +                                              0,
> > +                                              SNDRV_PCM_STREAM_PLAYBACK);
> > +               }
> > +               break;
> > +       case MI2S_SECONDARY:
> > +               break;
> > +       default:
> > +               pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> -EINVAL.
>
not needed since this returns void
> > +static int sc7180_snd_platform_probe(struct platform_device *pdev)
> > +{
> > +       struct snd_soc_card *card;
> > +       struct sc7180_snd_data *data;
> > +       struct device *dev = &pdev->dev;
> > +       int ret;
> > +
> > +       card = kzalloc(sizeof(*card), GFP_KERNEL);
> > +       if (!card)
> > +               return -ENOMEM;
> Looks like you don't need to allocate the card in runtime.  Also you
> need to use the devm version if needed.
>
Thanks for the great suggestion. In v2 I am using a static sound card.
Also, use devm wherever possible to greatly simplify the code.

> > +       /* Allocate the private data */
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> Use devm.
>
Fixed in v2.
> > +       card->dapm_widgets = sc7180_snd_widgets;
> > +       card->num_dapm_widgets = ARRAY_SIZE(sc7180_snd_widgets);
> Can the struct snd_soc_card allocate statically?
>
Fixed in v2.
> > +       sc7180_add_ops(card);
> > +       ret = snd_soc_register_card(card);
> devm.
>
>
> I didn't dive into the logic too much.  Would need another round
> review if any newer version.

Thanks again.
