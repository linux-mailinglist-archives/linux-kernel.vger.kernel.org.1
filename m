Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764DA2659FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgIKHFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 03:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgIKHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:05:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z25so9930287iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otF8H1RNd/1xFgPWM+UYeAZ5JGJnziYMUvZT/Xjw4hM=;
        b=qe4hkqMBNjrfKmSzuLVus6EU9eYDBsofp7qqtq8YlvMw/Wjw74o8vcRMGH9JvNfccZ
         RjXMT1koZlUphilobl4V1XvQAi+X2mDvt2q7b+muUVlyHxx94WmHNIl09v2Yoyt8sNa3
         WtWX6BM+X+zYBPZxkjFLsJipzKs6YD59tk5p8MMlvBc1MwGDuo0cC0/IuJwWpfHxvDfA
         Q3mU2POB/NRiZYsQ+sUnXy5Sz1krQd3Y+QZD0qaP3WLaSYzlQTFEr+WaCByAXoZTKuNq
         TNWTF2B+eRYvSopuAXve89apo0iWr2xpAlRQbuHzugZa9WocdsJLJQ2+A+dxQz4eW4ph
         jctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otF8H1RNd/1xFgPWM+UYeAZ5JGJnziYMUvZT/Xjw4hM=;
        b=nR8UkRLg2Nzrj6XuFYyQMpH917tBm7QWnDgLjk30f9ravVx7or3apHY7A5ooyrX80D
         470AasNZfYwqLw0Of/PzzMK/ycC9HypUPxpSqRdT/21kWQiZjewmXCAvk/HItZvPIxfP
         G80SCxgwLkDWJcnmElfTtzUQFO1i0x7NBQLkljceuPXPSvcTitRWebYr3fgGznw+RfC2
         zUojlUXQxiVL8mPJ+cQ5jVJFq1iXuFEZITV5fV//YvXAVQ6jzqy/G/+EVAnB3C6lXnnE
         3uQVJze4OCCiicZ2WDRm1mdXMwPYFpBtOGTNcQXWYW+0982BhYRTGFFeLUBC3t8VynI6
         bIqA==
X-Gm-Message-State: AOAM530ETkVZtEfiR9hLCFnmI4F/1GpitChbsWGaOiiLqnAb7gJ3ijbp
        PIZ2dDSC5r4BNVftVE/8wuyh+MObvCS9UlXAzbF/K7EYnv8=
X-Google-Smtp-Source: ABdhPJwodniZiAtfvQUmjWFccNMw2WLlrmOeP9LT9dEB93y9plKXNJu5aLa8hLG3YBW74NGPxP1i41/CNLxqL0iHbp0=
X-Received: by 2002:a5e:9b04:: with SMTP id j4mr731216iok.59.1599807936340;
 Fri, 11 Sep 2020 00:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200910052347.1790735-1-cychiang@chromium.org> <20200910052347.1790735-2-cychiang@chromium.org>
In-Reply-To: <20200910052347.1790735-2-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 11 Sep 2020 15:05:25 +0800
Message-ID: <CA+Px+wUh_PDZCg15bx7=teUeS=0fr22fnCKq5u2WUoTOXdTrbg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] ASoC: hdmi-codec: Use set_jack ops to set jack
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
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 1:24 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 8c6f540533ba..d1de5bcd5daa 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -698,13 +698,9 @@ static void plugged_cb(struct device *dev, bool plugged)
>                 hdmi_codec_jack_report(hcp, 0);
>  }
>
> -/**
> - * hdmi_codec_set_jack_detect - register HDMI plugged callback
> - * @component: the hdmi-codec instance
> - * @jack: ASoC jack to report (dis)connection events on
> - */
> -int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> -                              struct snd_soc_jack *jack)
> +static int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> +                                     struct snd_soc_jack *jack,
> +                                     void *data)
To be neat, name it "hdmi_codec_set_jack".

>  static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
>  {
> @@ -806,6 +801,7 @@ static const struct snd_soc_component_driver hdmi_driver = {
>         .use_pmdown_time        = 1,
>         .endianness             = 1,
>         .non_legacy_dai_naming  = 1,
> +       .set_jack               = hdmi_codec_set_jack_detect,
"hdmi_codec_set_jack" looks better to me.

If you would send a newer version, consider changing the name.

With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
