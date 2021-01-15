Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98D2F82CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbhAORpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAORpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:45:33 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871CC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:44:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id o144so5800796ybc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM4MaXgvTZAlvr1leXTujrQPLxqm/ubLgNUK1RNGKmU=;
        b=C6TxA79SS2UHJZWdjOMsdX5j68QB687xUftG/IEQRsXZBbcqHTKLZqBvIQQ/f3tPLt
         KisHSDb8dANHLMht8Ztl6L5lBkGSbu8V2hwlXHfu4I2csQYrvaxrsYFh8P/9WPPe4vTP
         pb78VMwiNnqt169FBuqm8h0oJl7wrovy6XUFuW0bRVH5dAQpIv9akaF8wtjhlFpr9zbc
         uRJ4sG88aJZ8bEc8lu/6CqoGgu5soHlqnUsj3HhZABuF3U7kecNGmBxAaF7AgOzRFpMg
         kMCWsnrfADjqTuz/lccK25DnmtFHhlmO+hqDV1HyxIlXcPoqYaq+5XqKUBloIn+IQKD3
         10JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM4MaXgvTZAlvr1leXTujrQPLxqm/ubLgNUK1RNGKmU=;
        b=ZYIWh4KqohZbDr0J3xIDT5TTN9VB0AmhUMiy4eM7EpOXzfWms/BucdubevQsZQCcLf
         NDv8MKUN+Z4N+a5oxAEFDNeT3teeFfpjpMBXtlPHR9kL9TcNJXM53zMtwMzwz0Iy/i7O
         PHD3pHShCurIpMCKm3w23jthtoIYUkb5BXHuruECACFSOoZRYHgQ4brSWZEQYGk86Vw9
         VtRoCsWUlv82iny9+PkrERu47n3LS8tVIeTGkTjMqyxFEauMYpODiuIwMZFdDDeOR/5p
         /4941Wbl/xkt9PNgZxYsOtetpHUAEJF4xgMuj/AniEtTwleo2YervhJtozysUT48KMIl
         I0qQ==
X-Gm-Message-State: AOAM5333JpG+o1lLd4aBc5kVu53biZzCiMAIx+JORJUq91P3zdreuRt1
        YaRK/n+w1ZI6/34CHU48bHtz36O+7v5aQtV8x4Sa4Q==
X-Google-Smtp-Source: ABdhPJzOpXG72PdWzknvcYxjm8t378ZP8M5mL+Ez5KLDIpZx81kJp0pmKfaanhvbEoSDWZ2FNufqczsa/hxe4/FUXiI=
X-Received: by 2002:a25:c343:: with SMTP id t64mr4791124ybf.228.1610732691634;
 Fri, 15 Jan 2021 09:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <X/dpkgTnUk+inKHK@kroah.com> <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
 <ba2fcbfb-d714-2f73-3bd0-962f49363b62@nvidia.com> <CAGETcx8pdPnH1ndOCoi7Qyz8DDshCfMTzDLQM=oEaCjyds9reA@mail.gmail.com>
 <17703ac8-2238-0b64-3c98-ddadc7ae8a36@nvidia.com> <CAGETcx-=y4Ps41Lb0b_MTCbNTC_ah0cJTmPP+GajywFBc7kEfw@mail.gmail.com>
 <f0240065-a4a0-d985-a696-eba4d42ea580@nvidia.com> <CAGETcx_QmbOcof5T8Wo_zFXKB+qswPN3Cbwz5a6A+m+VrnWg0A@mail.gmail.com>
 <a38c0566-a58e-aaf7-ef57-dc294c4e71b4@nvidia.com> <CAGETcx9szf-=JjFNp0p-0LmOfOU1MWE3QqDNe-bAn2wXPH9pEQ@mail.gmail.com>
 <f3683601-66db-ffe3-9066-ac94a9372727@nvidia.com>
In-Reply-To: <f3683601-66db-ffe3-9066-ac94a9372727@nvidia.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 15 Jan 2021 09:44:15 -0800
Message-ID: <CAGETcx-3wjcmTgrqEyDiHx7dj0m3ME8PmVyGm2kLjFoUT=bfAQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 8:13 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 14/01/2021 21:50, Saravana Kannan wrote:
> > On Thu, Jan 14, 2021 at 10:55 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >>
> >> On 14/01/2021 16:52, Saravana Kannan wrote:
> >>
> >> ...
> >>
> >>> Thanks! I think you forgot to enable those logs though. Also, while
> >>> you are at it, maybe enable the logs in device_link_add() too please?
> >>
> >>
> >> Sorry try this one.
> >>
> >> Cheers
> >> Jon
> >
> > Phew! That took almost 4 hours to debug on the side! I think I figured
> > it out. Can you try this patch? If it works or improves things, I'll
> > explain why it helps.
> >
> > -Saravana
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 5f9eed79a8aa..1c8c65c4a887 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1258,6 +1258,8 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > +DEFINE_SIMPLE_PROP(gpio_compat, "gpio", "#gpio-cells")
> > +DEFINE_SIMPLE_PROP(gpios_compat, "gpios", "#gpio-cells")
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> >  DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> > @@ -1296,6 +1298,8 @@ static const struct supplier_bindings
> > of_supplier_bindings[] = {
> >         { .parse_prop = parse_pinctrl6, },
> >         { .parse_prop = parse_pinctrl7, },
> >         { .parse_prop = parse_pinctrl8, },
> > +       { .parse_prop = parse_gpio_compat, },
> > +       { .parse_prop = parse_gpios_compat, },
> >         { .parse_prop = parse_regulators, },
> >         { .parse_prop = parse_gpio, },
> >         { .parse_prop = parse_gpios, },
> >
>
> Thanks, that worked!
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>
> Thanks for digging into that one. Would have taken me more than 4 hours!

Thanks for testing. What was happening was that there was a cycle of
2-3 devices. A -(depends on)-> B -> C -> A.

And fw_devlink only understood A -> B since the rest were the gpio
bindings I added above. Without fw_devlink seeing the cycle, it can't
do cycle workarounds. So C's driver was deferring probe waiting on A
and none of them probed.

Once I added these and made the cycle visible to fw_devlink, it
handled it fine (basically between A, B and C, the device links don't
affect probe order anymore).


-Saravana
