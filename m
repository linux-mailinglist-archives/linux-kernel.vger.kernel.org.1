Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3B2FCBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhATHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbhATHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:47:10 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F8C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:46:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y4so18621978ybn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2I7rI5GjEUa1LLS76qVO2YXGGEG72Ek4zDDQZ5QMYgg=;
        b=vMdbhKGjPnV/6BvG4c8Bvey4dQqb09nuR+r8kuPnpEhiNJa4rUT+5ct46DvukfOiQn
         +mpDvVtExlO3gMymMvWfppMJDgxKW/+4RiWOns+R3xGXTN/1EvYOo64mp5KIQau8fFzv
         qD+jxS0AxbLyNHbrGAWWs8Y+jDD2bm3be+UFddcxMoMMb+JexIaX0q60bc3t2wIM6zph
         agDX4OYfH9MD2duSCVOZkA+3o0ygY0IO4FmglUmAzDJ10zOdQ3jDjaovTkuOcksRooEH
         ZOIhgWSC0QGpCttkjjMSTXKd4vfJTInvR9Ph8xX2+pb0Vl445V5fRbDAHgvgak0A4D46
         yPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2I7rI5GjEUa1LLS76qVO2YXGGEG72Ek4zDDQZ5QMYgg=;
        b=KwR3VYkDgecBHnnKaJGxAbIMFbgiS9i2VmU1j5/PO+LybiB9Ozvw9CX/qCnPY3jR89
         I8LUn8JmbcjQqjUrTVbR0n55O4rsHh2b70nFrLKmiFOnkNHFhLgbZ2TTiYY8vZegSXIB
         ON/KTSSLZBoUrX7WWg+Ewdn+0qyqivN7wz/NYxbFIur6wSpXhTZSI9Y1OLYqnmxorHO4
         fNQFU+UV6dJvYVnUp/JGw8SbiLeJ5aEx+p14xcJqUpq6tKQQntJm8ZBDVl9yRjpTRpu3
         p4Q/VOqZ3l8wXOZ1xZ4YN7iJUUQy80uVKdND5XOaPlOiHU4tsi6xPzc0aSS9Yl17TYVo
         T+7w==
X-Gm-Message-State: AOAM533ULUupN632qonFMd7iO8jd3S8P8qYw8x1StSHGhykbZVLlbqCJ
        36OZ3fqbNxmw8KlgXztUDmwIpRY1LDLzXxZ04Y5B3g==
X-Google-Smtp-Source: ABdhPJwpmKi2+dpWZocyWr8KvJ8s9tQQA9oc+J+oMTZwVYMBU1GdDE0K7i4l6NIjYGA3kESWmM0Yk5FvSzBwl0vBuqc=
X-Received: by 2002:a25:c343:: with SMTP id t64mr11504051ybf.228.1611128789791;
 Tue, 19 Jan 2021 23:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20210120073310.427462-1-saravanak@google.com>
In-Reply-To: <20210120073310.427462-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 Jan 2021 23:45:53 -0800
Message-ID: <CAGETcx_pUxH9gUUigsC7pFgtC_Ppw7gzcvHdSqZO0YtUvb3fcg@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: Add fw_devlink support for "gpio" and
 "gpios" binding
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:33 PM Saravana Kannan <saravanak@google.com> wrote:
>
> To provide backward compatibility for boards that use deprecated DT
> bindings, we need to add fw_devlink support for "gpio" and "gpios".
>
> Cc: linux-tegra <linux-tegra@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Greg/Rob,
>
> I think it's better for this to go into driver-core-next because this
> fixed fw_devlink=on change that's queued for 5.12-rcX.
>
> -Saravana
>
>  drivers/of/property.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 5f9eed79a8aa..0b256ce9d7d5 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1271,6 +1271,24 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
>         return of_parse_phandle(np, prop_name, (index * 4) + 1);
>  }
>
> +static struct device_node *parse_gpio_compat(struct device_node *np,
> +                                            const char *prop_name, int index)
> +{
> +       struct of_phandle_args sup_args;
> +
> +       if (strcmp(prop_name, "gpio") && strcmp(prop_name, "gpios"))
> +               return NULL;
> +
> +       if (of_find_property(np, "gpio-hog", NULL))
> +               return NULL;
> +
> +       if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", index,
> +                                      &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}
> +
>  static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_clocks, },
>         { .parse_prop = parse_interconnects, },
> @@ -1296,6 +1314,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_pinctrl6, },
>         { .parse_prop = parse_pinctrl7, },
>         { .parse_prop = parse_pinctrl8, },
> +       { .parse_prop = parse_gpio_compat, },
>         { .parse_prop = parse_regulators, },
>         { .parse_prop = parse_gpio, },
>         { .parse_prop = parse_gpios, },
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

Please ignore this patch. I'm going to make this part of a series I'll
be sending out.

-Saravana
