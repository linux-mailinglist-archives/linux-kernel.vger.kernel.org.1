Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7347E29065B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408095AbgJPNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408074AbgJPNcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:32:00 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D433E21527;
        Fri, 16 Oct 2020 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602855120;
        bh=jHgolZn+yVwazInZpUXsUIXLz+WFq+LCgt1cjWpEkcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uI2me769AwM75eyyDkh95DsmJO9h6Qvu8z0Ayc7beFMa6u/y6sPTX58dfz9663RqB
         2zP0XAvHzdeE75ZAtl270HHG5NqWq89oDsrxpoLa+652g3AM6k+qlqenzQba0AHyAX
         Fk5C7pqNZ14YtAy/k6zL/cWuHXg3qD5gkOKP2phA=
Received: by mail-oi1-f181.google.com with SMTP id 16so2411031oix.9;
        Fri, 16 Oct 2020 06:31:59 -0700 (PDT)
X-Gm-Message-State: AOAM531+LIxpTqrMmcL/XbCzmpoGptAhH0QLmFIKyG8bSoLXt/8YLBoH
        MuYoHrJzKLiIuTsl5v29o+6kFpt6Qw74P+kGgQ==
X-Google-Smtp-Source: ABdhPJxDzoh5TQYux51VfrCvIKr2H0fC6EMtKmXq9osyCrsQpVXMppGQGpG8GNPS7dXZ2wVY+84RyeI4fqmJDgomP0U=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr2514377oiy.106.1602855119044;
 Fri, 16 Oct 2020 06:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014145418.31838-2-rf@opensource.cirrus.com> <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
 <90600a67-25e4-7933-35c3-f515deaee94f@arm.com>
In-Reply-To: <90600a67-25e4-7933-35c3-f515deaee94f@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Oct 2020 08:31:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAvJ9fv9pm82iv5YjWVCJu1fmP-t+Fyc95pzUaCEL3XQ@mail.gmail.com>
Message-ID: <CAL_JsqKAvJ9fv9pm82iv5YjWVCJu1fmP-t+Fyc95pzUaCEL3XQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] of: base: Add of_count_phandle_with_fixed_args()
To:     Robin Murphy <robin.murphy@arm.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        - <patches@opensource.cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-10-14 19:39, Rob Herring wrote:
> > On Wed, Oct 14, 2020 at 9:54 AM Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Add an equivalent of of_count_phandle_with_args() for fixed argument
> >> sets, to pair with of_parse_phandle_with_fixed_args().
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >>   drivers/of/base.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/of.h |  9 +++++++++
> >>   2 files changed, 51 insertions(+)
> >>
> >> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >> index ea44fea99813..45d8b0e65345 100644
> >> --- a/drivers/of/base.c
> >> +++ b/drivers/of/base.c
> >> @@ -1772,6 +1772,48 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
> >>   }
> >>   EXPORT_SYMBOL(of_count_phandle_with_args);
> >>
> >> +/**
> >> + * of_count_phandle_with_fixed_args() - Find the number of phandles references in a property
> >> + * @np:                pointer to a device tree node containing a list
> >> + * @list_name: property name that contains a list
> >> + * @cell_count: number of argument cells following the phandle
> >> + *
> >> + * Returns the number of phandle + argument tuples within a property. It
> >> + * is a typical pattern to encode a list of phandle and variable
> >> + * arguments into a single property.
> >> + */
> >> +int of_count_phandle_with_fixed_args(const struct device_node *np,
> >> +                                    const char *list_name,
> >> +                                    int cells_count)
> >> +{
> >
> > Looks to me like you can refactor of_count_phandle_with_args to handle
> > both case and then make this and of_count_phandle_with_args simple
> > wrapper functions.
>
> Although for just counting the number of phandles each with n arguments
> that a property contains, isn't that simply a case of dividing the
> property length by n + 1? The phandles themselves will be validated by
> any subsequent of_parse_phandle*() call anyway, so there doesn't seem
> much point in doing more work then necessary here.
>
> >> +       struct of_phandle_iterator it;
> >> +       int rc, cur_index = 0;
> >> +
> >> +       if (!cells_count) {
> >> +               const __be32 *list;
> >> +               int size;
> >> +
> >> +               list = of_get_property(np, list_name, &size);
> >> +               if (!list)
> >> +                       return -ENOENT;
> >> +
> >> +               return size / sizeof(*list);
>
> Case in point - if it's OK to do exactly that for n == 0, then clearly
> we're *aren't* fussed about validating anything, so the n > 0 code below
> is nothing more than a massively expensive way to check for a nonzero
> remainder :/

Indeed. We should just generalize this. It can still be refactored to
shared code.

It's probably worthwhile to check for a remainder here IMO.

Rob
