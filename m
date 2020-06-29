Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC120DFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgF2UkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbgF2TOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D239C08EC0C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:48:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so16704182ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMiOaRXPbBCmvsQhZQZwPQhO0CEmmeEuzVBe8QB9/bw=;
        b=eZN+AKNqDPqkzjHlgJVXVozWvev4EslhTtOwR9F7cRMyVurHeID6ZtGHxLXI6DwfO4
         7ZepBNV+kKuvghwEAJLJYqR2JJe+nZLD+XcBOA/kFM30hKbyI2tNhPJBgcQhCM7GckoA
         6u9oZfZq3Eshn5GTmWpaFRpOKGYX1NjO9lxfthdgptQctcBQoUChdMjiOTV4/kekfBMi
         b/fzY/qxRfFyBeuMo25vEm+OckxCoSE16THKHctHFWQ+0jCFSVdWqbMBJsMEWjQcECYa
         wfb+dQ/FNlF+ZSWwP3R2CB4SST9aMucAY+EyH8zmPEQPe2DG5hShPKC5a8pNF8tOdcKy
         z8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMiOaRXPbBCmvsQhZQZwPQhO0CEmmeEuzVBe8QB9/bw=;
        b=Swt8lmzDbYa/4DBqVD4N2VzsYsBtgUDSdVjg00wrhwuf2aKHhrmaPYXTkOP36EwSwr
         pgedO7CQsXhYbMNeASri9WuRcGwHYW8DEZVl8dhPDFkT7XInwtGrQZdfhXK51NMPJsDI
         lw3VtptmDUpWWfz2Sp+2ogxRSjHY2YVs3VC9UdarVl3/MGMqFWqC5D0+qXk/OJkjJY2O
         3Vq7UMYK6TE6YS6ordlWtcGsyxXHqcbhYnGbsOGqE0LEREG2088GZ+hn/0yFPtGq+LmL
         Wy9fluM+IPj3K5buluMqGHwIiGGOVs+QY2zFLB+xP92x29jmODmI9NKeXQj7A9QOsA/N
         zFdA==
X-Gm-Message-State: AOAM530dRsZXRmQjfmTaJcIRa2qBNRiV17E2LCD7TLtq1f/Hi5H+GITt
        flA8jVaRbiPFxbqADxCtXsN2nLZ+VU23SaJpAgU54g==
X-Google-Smtp-Source: ABdhPJz8Xi/8RhtlNzOxfZcCcsQ6wXqbmRLtT2FZvNHfcrfRdS7lFVKrxm6GjHGDNhqpKJg6rwrDW4am/48Bpmy6opo=
X-Received: by 2002:a2e:9d10:: with SMTP id t16mr7294802lji.46.1593413306316;
 Sun, 28 Jun 2020 23:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <202006281417.GPpEXCGD%lkp@intel.com> <20200628060359.GA29916@8567a11ddfea>
In-Reply-To: <20200628060359.GA29916@8567a11ddfea>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 29 Jun 2020 12:18:15 +0530
Message-ID: <CAP245DVK6+if=73AtveXJO=y-J75cWZkCRzFy1G+RJ0QXokCzg@mail.gmail.com>
Subject: Re: [RFC PATCH linus] drivers: thermal: tsens: tsens_critical_irq_thread()
 can be static
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A patch to fix this was already submitted on 27th May.

I believe Daniel plans to send it as fixes for -rc4.

Regards,
Amit

On Sun, Jun 28, 2020 at 11:34 AM kernel test robot <lkp@intel.com> wrote:
>
>
> Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into tsens.c")
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  tsens.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8d3e94d2a9ed4..39c4462e38f62 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -382,7 +382,7 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>   *
>   * Return: IRQ_HANDLED
>   */
> -irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> +static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>  {
>         struct tsens_priv *priv = data;
>         struct tsens_irq_data d;
> @@ -452,7 +452,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>   *
>   * Return: IRQ_HANDLED
>   */
> -irqreturn_t tsens_irq_thread(int irq, void *data)
> +static irqreturn_t tsens_irq_thread(int irq, void *data)
>  {
>         struct tsens_priv *priv = data;
>         struct tsens_irq_data d;
> @@ -520,7 +520,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> -int tsens_set_trips(void *_sensor, int low, int high)
> +static int tsens_set_trips(void *_sensor, int low, int high)
>  {
>         struct tsens_sensor *s = _sensor;
>         struct tsens_priv *priv = s->priv;
> @@ -557,7 +557,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
>         return 0;
>  }
>
> -int tsens_enable_irq(struct tsens_priv *priv)
> +static int tsens_enable_irq(struct tsens_priv *priv)
>  {
>         int ret;
>         int val = tsens_version(priv) > VER_1_X ? 7 : 1;
> @@ -570,7 +570,7 @@ int tsens_enable_irq(struct tsens_priv *priv)
>         return ret;
>  }
>
> -void tsens_disable_irq(struct tsens_priv *priv)
> +static void tsens_disable_irq(struct tsens_priv *priv)
>  {
>         regmap_field_write(priv->rf[INT_EN], 0);
>  }
