Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3972F9F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391091AbhARMOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390861AbhARLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:51:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DAAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:50:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p15so9262882pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bekUkQFAhgR2QZLCVYSsef2aZeUwNBoiuL9ybwHmiio=;
        b=VWQddsAFzbpSpQUIq3J6j6x9XgpGG/Ga/of9rwwoDXfZgrTL6sJe6gXAW+z+nsmXr6
         c6qWsSjtv9YcSkdMV0uKBcd+AyL1XZezomb9WRy3efKHFxGPsYpYhVBPGmh+FAoB+CRw
         S9dpWBn0VXxLfdXcdWpTR7wSoWBYYQD6TEqU+0S8NuuUprFMslz0CgJwYeK3R6ucCdbI
         vv0mXXBSQzxZykhIRmQi70QzKAHATHrKXuXWqmLzkvAq5SRBTLkW6459e6bh5QeM9Roc
         YcSK6jYMDgzTV7msGQhiSMhHqtGG+HNruiyf74dwfjzN5uYsu8/CtXnFvmium0ZTrYpq
         jIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bekUkQFAhgR2QZLCVYSsef2aZeUwNBoiuL9ybwHmiio=;
        b=hDtkomg+aYhPHEV36cX9NL2kG9+cFD7DFNmtfA59eghhrpa0EvOBKxB5GMTPsfnx/n
         RLMfUsl0SRXSPmoqF1jaEbTOAGClWsL8Gi6rc24sY7iIfYEVndgitaTCCNS3nLhfw17j
         W2q4EfGJg/RLYYQQYXKNhOd/OOoyHzG5Lkv5AkY8Cvw0N0E3F57effR1J9StJDRGN5xD
         HQpV4sR6G/YE2q/j5fXPBCnTfW0w4cnbsvVXz9Z2rfDita1M61p4YgCCPilxAuUrcJLK
         he/YLMvfdbBb5I1auwk2Wmd6sTXtq0tWK7veGW1V+KYSRwk0KOXMVdR33X3X3vtk492j
         E5Kg==
X-Gm-Message-State: AOAM531tpoegC4lJtRfWGRGCD4wK9j6MzOD2Phw+zB4QF+UkPZs6Pt6I
        6KH2zdd/EAgi3LRMliQ57o9xzB3J2hNLxsNdUGY=
X-Google-Smtp-Source: ABdhPJztWxrnFhIDxax+TDiNWYYjEBwfNua/MlG7dhmQhveS21GiH0bsf3SXDCd4sUen5lDYfBRSzGsUABLCUXX3Qa0=
X-Received: by 2002:a17:90a:6c90:: with SMTP id y16mr26644109pjj.129.1610970655499;
 Mon, 18 Jan 2021 03:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20210117212252.206115-1-hdegoede@redhat.com> <20210117212252.206115-3-hdegoede@redhat.com>
In-Reply-To: <20210117212252.206115-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jan 2021 13:51:44 +0200
Message-ID: <CAHp75VcKjx7+=+n7xjOE4sL_gOt5h7HzQGdvzYhC5x=EmeXLtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
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

On Sun, Jan 17, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Replace the custom arizona_of_get_type() function with the generic
> device_get_match_data() helper. Besides being a nice cleanup this
> also makes it easier to add support for binding to ACPI enumerated
> devices.
>
> While at it also fix a possible NULL pointer deref of the id
> argument to the probe functions (this could happen on e.g. manual
> driver binding through sysfs).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - New patch in v2 of this patchset
> ---
>  drivers/mfd/arizona-core.c | 11 -----------
>  drivers/mfd/arizona-i2c.c  | 10 ++++++----
>  drivers/mfd/arizona-spi.c  | 10 ++++++----
>  drivers/mfd/arizona.h      |  9 ---------
>  4 files changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 000cb82023e3..75f1bc671d59 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -797,17 +797,6 @@ const struct dev_pm_ops arizona_pm_ops = {
>  EXPORT_SYMBOL_GPL(arizona_pm_ops);
>
>  #ifdef CONFIG_OF
> -unsigned long arizona_of_get_type(struct device *dev)
> -{
> -       const struct of_device_id *id = of_match_device(arizona_of_match, dev);
> -
> -       if (id)
> -               return (unsigned long)id->data;
> -       else
> -               return 0;
> -}
> -EXPORT_SYMBOL_GPL(arizona_of_get_type);
> -
>  static int arizona_of_get_core_pdata(struct arizona *arizona)
>  {
>         struct arizona_pdata *pdata = &arizona->pdata;
> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
> index 2a4a3a164d0a..5e83b730c4ce 100644
> --- a/drivers/mfd/arizona-i2c.c
> +++ b/drivers/mfd/arizona-i2c.c
> @@ -23,14 +23,16 @@
>  static int arizona_i2c_probe(struct i2c_client *i2c,
>                              const struct i2c_device_id *id)
>  {
> +       const void *match_data;
>         struct arizona *arizona;
>         const struct regmap_config *regmap_config = NULL;
> -       unsigned long type;
> +       unsigned long type = 0;
>         int ret;
>
> -       if (i2c->dev.of_node)
> -               type = arizona_of_get_type(&i2c->dev);
> -       else
> +       match_data = device_get_match_data(&i2c->dev);
> +       if (match_data)
> +               type = (unsigned long)match_data;
> +       else if (id)
>                 type = id->driver_data;
>
>         switch (type) {
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 704f214d2614..798b88295c77 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -23,14 +23,16 @@
>  static int arizona_spi_probe(struct spi_device *spi)
>  {
>         const struct spi_device_id *id = spi_get_device_id(spi);
> +       const void *match_data;
>         struct arizona *arizona;
>         const struct regmap_config *regmap_config = NULL;
> -       unsigned long type;
> +       unsigned long type = 0;
>         int ret;
>
> -       if (spi->dev.of_node)
> -               type = arizona_of_get_type(&spi->dev);
> -       else
> +       match_data = device_get_match_data(&spi->dev);
> +       if (match_data)
> +               type = (unsigned long)match_data;
> +       else if (id)
>                 type = id->driver_data;
>
>         switch (type) {
> diff --git a/drivers/mfd/arizona.h b/drivers/mfd/arizona.h
> index 995efc6d7f32..801cbbcd71cb 100644
> --- a/drivers/mfd/arizona.h
> +++ b/drivers/mfd/arizona.h
> @@ -50,13 +50,4 @@ int arizona_dev_exit(struct arizona *arizona);
>  int arizona_irq_init(struct arizona *arizona);
>  int arizona_irq_exit(struct arizona *arizona);
>
> -#ifdef CONFIG_OF
> -unsigned long arizona_of_get_type(struct device *dev);
> -#else
> -static inline unsigned long arizona_of_get_type(struct device *dev)
> -{
> -       return 0;
> -}
> -#endif
> -
>  #endif
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
