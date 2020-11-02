Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34532A2871
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgKBKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:46:16 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5436C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:46:15 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id s24so7648973ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRpjL02zuTcuiv/Rvb/qTyae7wJ0n/tsrDk8nGGEoq0=;
        b=JbF7Xzcx6Wu8FIV7/iG4L8/z373ZoWlCO6auRph8RxolPKUCY1c9JzvvbI3Ea8+Uwf
         623DoaDsaJKCpWEQpXNj98q9gCj1aDehvtpItUkRrmtnB8aAV6mbbK04ddWHMkKMYtl7
         4oFJG1NT4N39UbIQ64IZIa0hXFMu0mTCuVoaXGy4E2hUE7fq1sNC37u1OnLRK+srC62G
         gfLCwVF7Pxw1UMQ/VlJ9hmuYmHSRgkVb/yWTy7xhVu91Rqz72oua6GOBx3TI2A2tO1oE
         MW6MhUJSrVNgZbnseXvs+TSZ8ZsJonOti3crmrOCtAmx7l1ybcV9Qx+yIWni9YtIGJ0B
         y6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRpjL02zuTcuiv/Rvb/qTyae7wJ0n/tsrDk8nGGEoq0=;
        b=L0Hv1gxkhBwmp5TsvhD1E95CWVqjhut6xVSqvKRPDdydqA8YmdELzPAsg/wSsYWHu5
         DMy0zoIOY3xHEPPGN0wo9/o3YbYdTR7tn1n3oq2FvolEyBq1U9rG81lTpYe0jNy1xxx8
         GU9DWdhOa6LBfiu21Qd99dGFdRFsP67eJVpc+0WnJ8FSEheyBSqWOsPSHskFRIh46mXF
         Z4dttYAGag+aK07kRukH+CDO2DSqVeDlt8EgPrnStc7zr6FsS5z2LVfrSqCkL8TFdKFL
         bvw/LQeQdRLV0+RUzUFVt0I6QeKjMtHtJnhP/lNRn4AlSrjQR2zf5lpBCoev9ZLNnKnL
         8LbA==
X-Gm-Message-State: AOAM532aM0BlRINUCMdP5N4u16OLQK/w2Gm6SBQCRmtbeZ6h6obuYdfB
        qSu0wC9O5aFLO2RqKbT0ccOzDgcDJJVhEPSH8YgwwQPyW5YkiQ==
X-Google-Smtp-Source: ABdhPJxKwVLNAuofbLNcJ13qTFoIFIxwQPlrQC3KzP9RuGcr//5ixy6TdSJ29X5luQ0fmV1hraBbt8Ty1Pv6VXZ7MzI=
X-Received: by 2002:a6b:7a0b:: with SMTP id h11mr2777649iom.76.1604313974919;
 Mon, 02 Nov 2020 02:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20201102062408.331572-1-ajye_huang@compal.corp-partner.google.com>
 <20201102062408.331572-3-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20201102062408.331572-3-ajye_huang@compal.corp-partner.google.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 2 Nov 2020 18:46:04 +0800
Message-ID: <CA+Px+wV9Lmdphp4iMgF1d72vewb2m9aiZzywvavLGgtkAczCDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
To:     Ajye Huang <ajye.huang@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:24 PM Ajye Huang <ajye.huang@gmail.com> wrote:
>
> In addition, having mixer control to switch between DMICs by
> using "dmic-gpios" property.
>
> Refer to this one as an example,
> commit b7a742cff3f6 ("ASoC: AMD: Use mixer control to switch between DMICs")
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

I am not sure if it would be better if you use another email (e.g.
@gmail) for signoff.

> +static int dmic_get(struct snd_kcontrol *kcontrol,
> +                   struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
> +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(dapm->card);
> +
> +       if (data)

You don't need to check for NULL.  If snd_soc_card_get_drvdata()
returns NULL, it shouldn't run into here.  See other
snd_soc_card_get_drvdata() calls in the file.

> +static int dmic_set(struct snd_kcontrol *kcontrol,
> +                   struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
> +       struct sc7180_snd_data *data = snd_soc_card_get_drvdata(dapm->card);
> +
> +       if (data) {

Ditto.

> +               if (IS_ERR(data->dmic_sel)) {
> +                       dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
> +                               PTR_ERR(data->dmic_sel));
> +                               return PTR_ERR(data->dmic_sel);

Remove 1 level indent.
