Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32DE2A0136
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgJ3JXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3JXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:23:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355DBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:23:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z5so6820206iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBA+zo6LaSoFeL0OA7IbUTdbUJNI/GOykxoTxkhm2nk=;
        b=UO5IfL8R5QFcwjro3zMCatag08rvnj7MG+rIfVf8CZY1PLx4Z0SoVQtu3DvG/0uf2N
         YIRVCW8AOfZZVXKBcMTqoLCPZMQ5Kdr+w2h4Jyf/fzhu6jZud64aAlrfyOQbqcC7FZig
         6RxtRmtJurOtE9CKuMpk1+tU/vGvKGRNHkDxmw8yP7WTwOpd+GVyHY20Brqmw6oBEwuq
         QvZM45AWJDmHUwcapmaYrBa+pQ32oebVFliheC058EYqeCLz6IBmN6i+RIW2LIsORGah
         PPcv4Mf1Xo6nq/dRGbcCEpsqtymMwkMc30l3lLgjDsRtVNql2yXNOini1QEbK9TJHv/h
         xoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBA+zo6LaSoFeL0OA7IbUTdbUJNI/GOykxoTxkhm2nk=;
        b=UBZZLBitGw5QHXzvA/SJG8+6vnXW7XEOEJRzB7ZYt9hFtzF4ihusAk8Rr7pP10BXh+
         4HfrMh2Q9rRnzm6ElapXEqkyc5mGiI80UpASckK0F3sqi8Bn+mFsuq38oKwleGzaUWun
         G08F6B/mkD3Mw0+njXfp7Ean6xP0JWSCXEp1NE4IiaClty4/4NvGoHH+Y1b9/ZhfYHmI
         vfqeQOCxgiLkRuBYvZQPNiqw9e+ZnY5XqqbzvXFzLQQHgN6JNJXESmPP28QFGKCafv2O
         Vn9iLs83YrbEoxDOKwa313l1OH2PfyCPLtIIlD3CILMYSXpKLnjKowlKWwpYK4YtChpX
         OC+w==
X-Gm-Message-State: AOAM530Hu1bFYe6fWhXCVLTfVtRxA2jcJT2qA0qiK6oMne4CenB4SzwI
        wvQIzE6OsxuiXqHyHpu7ov5hc6cKI5cxWvvOZdb0Ow==
X-Google-Smtp-Source: ABdhPJyH+9c8dw1FcU0h83mbgXToEcZDNuIgSVvIgnpkYquj90LicUxQtsuxCBKhNY9sYkw8F9Rt7qhEa3t2HuwKEyA=
X-Received: by 2002:a6b:c8c1:: with SMTP id y184mr1050821iof.109.1604049801372;
 Fri, 30 Oct 2020 02:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075724.1616766-1-ajye_huang@compal.corp-partner.google.com>
 <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 30 Oct 2020 17:23:10 +0800
Message-ID: <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
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

On Fri, Oct 30, 2020 at 3:57 PM Ajye Huang <ajye.huang@gmail.com> wrote:
> +static struct gpio_desc *dmic_sel;
> +static int dmic_switch;

If you really need them, you should put them in struct sc7180_snd_data.

> +static int dmic_set(struct snd_kcontrol *kcontrol,
> +                   struct snd_ctl_elem_value *ucontrol)
> +{
> +       if (dmic_sel) {

if (IS_ERR(dmic_sel))
But I think you don't need to check dmic_sel.  Suppose your _probe()
already returned error, the code here shouldn't be called.

> +               dmic_switch = ucontrol->value.integer.value[0];

Looks like it can be a local variable.  You don't need to save dmic_switch.
