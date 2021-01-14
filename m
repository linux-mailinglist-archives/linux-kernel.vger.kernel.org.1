Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCB2F5B07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhANHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhANHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:03:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C19C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:03:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ce17so426364pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5seRGvP8vmacCVEL3pbg1QeHk09V62rs/qNfpgeSeUA=;
        b=G2+pmoaTcsDoZFj7y01sac5Yh4ukZ4h5ZG0Ysbc8qI+tNKGXT/51MWGhi4ypjxFIKl
         mXmH/SePkIwdiDyAFPdqhcjBD5f+Ck7kVn//bHstFUXD7CB15dF5nbm2qJCF7t/2GOi0
         Vbn/mxIIxIZKLvyj2gGvV7lFANIOzOdLkSDOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5seRGvP8vmacCVEL3pbg1QeHk09V62rs/qNfpgeSeUA=;
        b=CYVC2PRFb/Zv9K498E2V1Wri4FXv3RwLnO4cv5mz8A4xi8Efs7xTuKw5H0szanP2lq
         OEoy84YK++L59em0tvh+8GL4oCNBU8ZQLc7uQ3vv2tCLwhdKkYr0RKk3qvbcv7Mgdmum
         gVlfqeX3gY9nn3xUssf97kdoe7mkEsCqOe/XB+ExGWsjvk5IShKAKejgVttfqblfCtty
         skwaAAmgGJbJp1CXj4cLBZNiAxM+WLFPyBLprwKtl+jIGTSys5pFSY9apcc6dbL6Bpqv
         XT1eWzdlEoedGkEeARLPkoiKkf2mUpHj+3tW3Js3NgvtrKQdf5EOoSm+uwfckEiCXeXg
         /Fyg==
X-Gm-Message-State: AOAM532fnjoe+i2C1fxhLKNSw6Mv0DG7WSd14C2xpcHDYF9KGihkZg3s
        hkP1cOsXvVOZ5XxPir70i5B37g==
X-Google-Smtp-Source: ABdhPJy3+8yPBJbEguuvFDTthZsGKEsiwdpHEkK6h01M0BapkXwi6VWIJIcwFubiBP4e+5tkC5bXXw==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr6250681plr.52.1610607798828;
        Wed, 13 Jan 2021 23:03:18 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q12sm4407378pgj.24.2021.01.13.23.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:03:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210108093339.v5.3.I32d0f4e174d45363b49ab611a13c3da8f1e87d0f@changeid>
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid> <20210108093339.v5.3.I32d0f4e174d45363b49ab611a13c3da8f1e87d0f@changeid>
Subject: Re: [PATCH v5 3/4] pinctrl: qcom: Properly clear "intr_ack_high" interrupts when unmasking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 13 Jan 2021 23:03:16 -0800
Message-ID: <161060779688.3661239.1942891250020009723@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-08 09:35:15)
> In commit 4b7618fdc7e6 ("pinctrl: qcom: Add irq_enable callback for
> msm gpio") we tried to Ack interrupts during unmask.  However, that
> patch forgot to check "intr_ack_high" so, presumably, it only worked
> for a certain subset of SoCs.
>=20
> Let's add a small accessor so we don't need to open-code the logic in
> both places.
>=20
> This was found by code inspection.  I don't have any access to the
> hardware in question nor software that needs the Ack during unmask.
>=20
> Fixes: 4b7618fdc7e6 ("pinctrl: qcom: Add irq_enable callback for msm gpio=
")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One minor nit below.

> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pi=
nctrl-msm.c
> index 1787ada6bfab..a6b0c17e2f78 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -96,6 +96,14 @@ MSM_ACCESSOR(intr_cfg)
>  MSM_ACCESSOR(intr_status)
>  MSM_ACCESSOR(intr_target)
> =20
> +static void msm_ack_intr_status(struct msm_pinctrl *pctrl,
> +                               const struct msm_pingroup *g)
> +{
> +       u32 val =3D (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;

Would be nice to remove that extra parenthesis too.

> +
> +       msm_writel_intr_status(val, pctrl, g);
> +}
> +
>  static int msm_get_groups_count(struct pinctrl_dev *pctldev)
>  {
>         struct msm_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> @@ -903,8 +910,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
> =20
>         raw_spin_lock_irqsave(&pctrl->lock, flags);
> =20
> -       val =3D (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;

Even though it is here.
