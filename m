Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078E304EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392161AbhA0B3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390018AbhAZSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:31:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 620E32224C;
        Tue, 26 Jan 2021 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611685871;
        bh=hwpSfinBZDh5+w+x/QjBXQLW3oRDY80SILSq+Y5HHDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbOc4zipI517A/lToLn+hLdBxnb+4ETZgccGUoDS8yTx9I8CKUKe43KkrBpH2KNhG
         e0TC9cE2cVJ36WFnsJ5mT095cOpAHT5QBmTtwlylevIm6IP0hcaSUAzzfro3uxMJIF
         ftPMqQ63SPF0NLgoBnzcnp/s94+cuxluyG8rzolofAm/h1bKrECj7/ccYV4kmB1vRP
         F3OJZfdJjkZSOKkNmVSk39VQGoAJkWiDpZdGvacm5sx9jttzp/E0xjt64kZQM1LItN
         4uizTTRZqSBEgLk+gwWSVJbledYwceh17445fTuiVRxVGoXCXXuARoGHCK/hClwAoG
         sMu42Mx2KdqFg==
Received: by mail-qk1-f175.google.com with SMTP id x81so14041717qkb.0;
        Tue, 26 Jan 2021 10:31:11 -0800 (PST)
X-Gm-Message-State: AOAM532aqv1C31Bb7aQWOAOMfsnMtd3ajgVQFfokF2vfpvpQBkAUz0Yy
        g6+e7zqNEHRYM4iHXVAoFNYOnpZ4D1fK8nGDrw==
X-Google-Smtp-Source: ABdhPJx5ciP8LyJGQSq/H1+pseWon7Ig+U4yOWlMwo2IZRc9cg1vUsBdUbLWYhYdqnQx92cYs4tCNXh/KuAPK0M0fVw=
X-Received: by 2002:a37:642:: with SMTP id 63mr6985257qkg.311.1611685870559;
 Tue, 26 Jan 2021 10:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20210123034428.2841052-1-swboyd@chromium.org> <20210123034428.2841052-6-swboyd@chromium.org>
In-Reply-To: <20210123034428.2841052-6-swboyd@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Jan 2021 12:30:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbdfhqNF4xgues0Rm7KS8_8Xq2767q7DcdyeQ_Vqb58Q@mail.gmail.com>
Message-ID: <CAL_JsqJbdfhqNF4xgues0Rm7KS8_8Xq2767q7DcdyeQ_Vqb58Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hwmon: (lm70) Avoid undefined reference to match table
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 9:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We're going to remove of_match_ptr() from the definition of
> of_match_device() when CONFIG_OF=n. This way we can always be certain
> that of_match_device() acts the same when CONFIG_OF is set and when it
> isn't. Add of_match_ptr() here so that this doesn't break when that
> change is made to the of_match_device() API.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-hwmon@vger.kernel.org>
> ---
>
> Please ack so Rob can apply.
>
>  drivers/hwmon/lm70.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index ae2b84263a44..e3153ae80634 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -178,7 +178,7 @@ static int lm70_probe(struct spi_device *spi)
>         struct lm70 *p_lm70;
>         int chip;
>
> -       of_match = of_match_device(lm70_of_ids, &spi->dev);
> +       of_match = of_match_device(of_match_ptr(lm70_of_ids), &spi->dev);
>         if (of_match)
>                 chip = (int)(uintptr_t)of_match->data;

Why can't this do:

if (spi->dev.of_node)
    chip = (int)(uintptr_t)of_device_get_match_data();
else {

>         else {
> --
> https://chromeos.dev
>
