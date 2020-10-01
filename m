Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C343628008D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgJANz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732139AbgJANzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:55:24 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE96C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:55:24 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id k78so1044045vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9wXc2FL41clBWsp7rvXXZv0AtepezSEVuo0O/dks5k=;
        b=QU8ojKUo1IKM4m+9xmGFyhjLAgwLGZ8/lgfMKhKu/eJCkfcHqYBgx9MzdTwNj6D6Pt
         HEydpLCUaOLBglg7GnCsW+IiSOGSvOqeAOL/Qc39KndUMe0g5FyVnRIByXrLMXhJ3LAd
         xq9DoPQ0BRLl31KnCk8at7/DwrItAFExlUW934H7zxd8FDPotNw1A1E+06tF/tUUho02
         RCxJF+Ysai4yHjIxrYpYPmFj2a/OO/xukDKEIsOdMgCTwQRUn7Bww+NSD6v2kbHjnDrB
         bdsmPGOqWPirU/uDbZJUWj9phxavANppXzHFsJBh+B2VKgIzEad1U5MM2e+S+kqsMUpR
         VE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9wXc2FL41clBWsp7rvXXZv0AtepezSEVuo0O/dks5k=;
        b=nRE4jB3NgjrLB5hK3Id0JG/UuA54udYc2Dp0zKwL3Vlw61ueblOwfrVlfehB6MOa/n
         u76Xva2ZVi7ABzL6q06mz17FQ7wcCWIyFjQlLP6gTrBD4bgX+ELlS3Juus+9Q0uYPFha
         lIu2nNvqSjn1meb0So1+M6rX2bjMfVpvsqVRBSag0EkyK7gE0hPER1kFh4YDDp8BORBI
         S5wVqJvrm4+o5rOnMSg2U0PsPUJHcqwowImn7fXjsx2C8TmcDqu/vvo/3MIDu+ZrU6aM
         RQnrXEPINAtHZVcf67EeAH7WMbHwlC9fmUNrSy6z310p73Bl/sqPCh0QlL9JprdPlFRW
         3ihQ==
X-Gm-Message-State: AOAM532zVZ3Ye2MFdD0dVUnB9qcDAFW1oP1QlU49qT2lZQjl+OZBve97
        v+UkbkP2uB2ZxrZk+M+jW+LCv0Auqjswq0Gys48g3qFdlh8=
X-Google-Smtp-Source: ABdhPJx90eHaIEvg1hFaxASdCVIylukofMwKDlZ7N7MQ6og3cNUASp0AJvobq/ik+73iaUTJ+jVSmoV3KLpyUYQIQIg=
X-Received: by 2002:a1f:9913:: with SMTP id b19mr4797101vke.4.1601560523107;
 Thu, 01 Oct 2020 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201001132758.12280-1-aouledameur@baylibre.com>
In-Reply-To: <20201001132758.12280-1-aouledameur@baylibre.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Thu, 1 Oct 2020 15:55:11 +0200
Message-ID: <CAHNvnFO=kH25CqrAcndVO4xTQ2pGDFi5ZHEALpFaZaGL=e_c0Q@mail.gmail.com>
Subject: Re: [PATCH] reset: Add reset controller API
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An update on the patch title, since we don't add an API but extend it,
The title should rather be: Add a new call to the reset framework

Le jeu. 1 oct. 2020 =C3=A0 15:28, Amjad Ouled-Ameur
<aouledameur@baylibre.com> a =C3=A9crit :
>
> The current reset framework API does not allow to release what is done by
> reset_control_reset(), IOW decrement triggered_count. Add the new
> reset_control_resettable() call to do so.
>
> When reset_control_reset() has been called once, the counter
> triggered_count, in the reset framework, is incremented i.e the resource
> under the reset is in-use and the reset should not be done again.
> reset_control_resettable() would be the way to state that the resource is
> no longer used and, that from the caller's perspective, the reset can be
> fired again if necessary.
>
> This patch will fix a usb suspend warning seen on the libretech-cc
> related to the shared reset line. This warning was addressed by the
> previously reverted commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shar=
ed
> reset control use")
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/core.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/reset.h |  1 +
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 01c0c7aa835c..53653d4b55c4 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -207,6 +207,19 @@ static int reset_control_array_reset(struct reset_co=
ntrol_array *resets)
>         return 0;
>  }
>
> +static int reset_control_array_resettable(struct reset_control_array *re=
sets)
> +{
> +       int ret, i;
> +
> +       for (i =3D 0; i < resets->num_rstcs; i++) {
> +               ret =3D reset_control_resettable(resets->rstc[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int reset_control_array_assert(struct reset_control_array *resets=
)
>  {
>         int ret, i;
> @@ -324,6 +337,50 @@ int reset_control_reset(struct reset_control *rstc)
>  }
>  EXPORT_SYMBOL_GPL(reset_control_reset);
>
> +/**
> + * reset_control_resettable - decrements triggered_count of the controll=
ed device
> + * @rstc: reset controller
> + *
> + * On a shared reset line the actual reset pulse is only triggered once =
for the
> + * lifetime of the reset_control instance, except if this function is us=
ed.
> + * In fact, It decrements triggered_count that makes sure of not allowin=
g
> + * a reset if triggered_count is not null.
> + *
> + * This is a no-op in case triggered_count is already null i.e shared re=
set line
> + * is ready to be triggered.
> + *
> + * Consumers must not use reset_control_(de)assert on shared reset lines=
 when
> + * reset_control_reset has been used.
> + *
> + * If rstc is NULL it is an optional clear and the function will just
> + * return 0.
> + */
> +int reset_control_resettable(struct reset_control *rstc)
> +{
> +       if (!rstc)
> +               return 0;
> +
> +       if (WARN_ON(IS_ERR(rstc)))
> +               return -EINVAL;
> +
> +       if (reset_control_is_array(rstc))
> +               return reset_control_array_resettable(rstc_to_array(rstc)=
);
> +
> +       if (rstc->shared) {
> +               if (WARN_ON(atomic_read(&rstc->deassert_count) !=3D 0))
> +                       return -EINVAL;
> +
> +               if (atomic_read(&rstc->triggered_count) > 0)
> +                       atomic_dec(&rstc->triggered_count);
> +       } else {
> +               if (!rstc->acquired)
> +                       return -EPERM;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_resettable);
> +
>  /**
>   * reset_control_assert - asserts the reset line
>   * @rstc: reset controller
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 05aa9f440f48..ffa447d0d1d6 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -13,6 +13,7 @@ struct reset_control;
>  #ifdef CONFIG_RESET_CONTROLLER
>
>  int reset_control_reset(struct reset_control *rstc);
> +int reset_control_resettable(struct reset_control *rstc);
>  int reset_control_assert(struct reset_control *rstc);
>  int reset_control_deassert(struct reset_control *rstc);
>  int reset_control_status(struct reset_control *rstc);
> --
> 2.17.1
>


--=20
Amjad Ouled-Ameur
Embedded Linux Engineer - Villeneuve Loubet, FR
Engit@BayLibre - At the Heart of Embedded Linux
