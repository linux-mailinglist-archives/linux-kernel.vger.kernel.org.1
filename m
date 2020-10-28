Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B829DE06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbgJ2AsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgJ2Aqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:46:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E40C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:46:42 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d19so588646vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QEy4J+snzRnq+uonMPZUIS2A2q1DWej6ezxa9MBmbs=;
        b=gv7tlfRGzl0QcHZwtwLtlgJ8Ro2sSuZOGVeoKNeDEYC3IoQpaaZC0U/uJ/wD3PmAy7
         SnBCG5ctk3apEo4cErFC9DVBouOIu+TBx/QU8tCcnuG/O7+WmUwAwFhYPGSIxDuHsrsj
         PgoqlnJ0DGx7TSwYPJqIEf2cRFi9QjZ5z8Oms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QEy4J+snzRnq+uonMPZUIS2A2q1DWej6ezxa9MBmbs=;
        b=g3U3PjAs693SmDOBonJeouyDzvnqGkdOjOqoOxm6N9CbMZBZQfDu10evnd97qGhnGi
         uIKvzkAo+CPIOBHT3DnIVuynjTRpxFNYE7EwRX4j+Yebk7s4nzI7FT3jdDXGrUtLVrUr
         ivKfjPnfFhoLHVPWzI8Wc5Mou+3HAiD0foxZxiFL1khIg/0wtEizHbdtPfnwYWGh4uw7
         i1/vzXM9CTg+jiA89yk7csLSBH8304Qz/6xSdM/+e/Xu2g8PEEoUbhEzlYG6+EwER5Fi
         N3gco9J0Ir/ibSglvRvlNfn2NVOGaKpt/tVCgrnc4lrX7geo4Ft9Wtbd23ztS17wz6dQ
         dhCA==
X-Gm-Message-State: AOAM531DDQr1dRjbH397yM4Y8sW2/qOgcs3xdX3DQZvPWOgnc8NqC5v6
        gOFflI8t8x4yOBv7ec+QFMOkQWwhp/et23dbYOJExgsa8T4jHw==
X-Google-Smtp-Source: ABdhPJwlLZ+FWh3IcLl2i9Batj31v4ANywYzXBhG6ycHiQHuZNxXJUszvR4nE+KWlyTOeSWz25GyqlZ5/Wg1QkSlCyY=
X-Received: by 2002:a1f:e942:: with SMTP id g63mr3776081vkh.18.1603847614534;
 Tue, 27 Oct 2020 18:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-3-enric.balletbo@collabora.com> <CANMq1KDSsfX3r1440qbmWggqbD7pU_iM4S36LUF8rsS2jVGqOg@mail.gmail.com>
 <ebba9def-e394-c183-dd80-6dc3716a7bd1@collabora.com> <CANMq1KBfKK9-RfMK89hRCGzhqZVqs6+YRdw8o2K+jA+3VN1_gw@mail.gmail.com>
 <2e6def0a-400c-836f-ef8b-c4fe6ac6c26e@collabora.com>
In-Reply-To: <2e6def0a-400c-836f-ef8b-c4fe6ac6c26e@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 28 Oct 2020 09:13:23 +0800
Message-ID: <CANMq1KDJPqiyXJKyeER7rSVbu7VxAcvrcV8rxDLMV+VEyx-Xmg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:25 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nicolas,
>
> On 27/10/20 1:19, Nicolas Boichat wrote:
> > Hi Enric,
> >
> > On Mon, Oct 26, 2020 at 11:17 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Nicolas,
> >>
> >> Many thanks for looking at this.
> >
> > Thanks to you ,-)
> >
> > [snip]
> >>>> +       if (id >= scpsys->soc_data->num_domains) {
> >>>> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: invalid domain id %d\n", node, id);
> >>>> +               return -EINVAL;
> >>>> +       }
> >>>> +
> >>>> +       domain_data = &scpsys->soc_data->domains[id];
> >>>> +       if (!domain_data) {
> >>>
> >>> Is that even possible at all? I mean, even if
> >>> scpsys->soc_data->domains is NULL, as long as id != 0, this will no
> >>> happen.
> >>>
> >>
> >> I think could happen with a bad DT definition. I.e if for the definition of the
> >> MT8173 domains you use a wrong value for the reg property, a value that is not
> >> present in the SoC data. It is unlikely if you use the defines but could happen
> >> if you hardcore the value. We cannot check this with the DT json-schema.
> >
> > I wasn't clear in my explanation, and looking further there is more
> > that looks wrong.
> >
> > This expression &scpsys->soc_data->domains[id] is a pointer to element
> > "id" of the array domains. So if you convert to integer arithmetic,
> > it'll be something like `(long)scpsys->soc_data->domains +
> > (sizeof(struct generic_pm_domain *)) * id`. The only way this can be
> > NULL is if scpsys->soc_data->domains pointer is NULL, which, actually,
> > can't really happen as it's the 5th element of a struct scpsys
> > structure `(long)scpsys->soc_data + offset_of(domains, struct scpsys)
> > + (sizeof(struct generic_pm_domain *)) * id`.
> >
> > I think what you mean is either:
> > domain_data = &scpsys->soc_data->domains[id];
> > if (!*domain_data)
> > [but then domain_data type should be `struct generic_pm_domain **`?
>
> I think you're confusing the field `struct generic_pm_domain *domains[]`from the
> `struct scpsys` with `const struct scpsys_domain_data *domains` from `struct
> scpsys_soc_data`. My bad they have the same name, I should probably rename the
> second one as domain_info or domain_data to avoid that confusion.

Oh, okay, get it, thanks for clarifying, I got myself confused indeed ,-P

But, still, part of my integer arithmetics still holds...

&scpsys->soc_data->domains[id] = (long)scpsys->soc_data->domains +
(sizeof(struct generic_pm_domain *)) * id. The only way domain_data
can be NULL is if scpsys->soc_data->domains pointer is NULL (it can't
be, really, assuming scpsys_soc_data structures are well defined) AND
id is 0.

Now, if I understand what you want to check here. If a domain id is
not specified in scpsys_domain_data (e.g. if there is a gap in
MT8XXX_POWER_DOMAIN_YYY indices and if `id` points at one of those
gaps), you'll get an all-zero entry in domain_data. So maybe you can
just check that domain_data->sta_mask != 0? Would that be enough? (I
expect that sta_mask would always need to be set?)

But then again, are there ever gaps in MT8XXX_POWER_DOMAIN_YYY indices?

>
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
> b/drivers/soc/mediatek/mtk-pm-domains.h
> index 7c8efcb3cef2..6ff095db8a27 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -56,7 +56,7 @@ struct scpsys_domain_data {
>  };
>
>  struct scpsys_soc_data {
> -       const struct scpsys_domain_data *domains;
> +       const struct scpsys_domain_data *domain_data;
>         int num_domains;
>         int pwr_sta_offs;
>         int pwr_sta2nd_offs;
>
> ---
>
> struct scpsys {
>     ...
>     const struct scpsys_soc_data *soc_data;
>     ...
>     struct generic_pm_domain *domains[];
> }
>
>
> domain_data = &scpsys->soc_data->domain_data[id];
> if (!domain_data)
>
> Thanks,
>   Enric
>
>
> > Does your code compile with warnings enabled?]
> > or:
> > domain_data = scpsys->soc_data->domains[id];
> > if (!domain_data)
> > [then the test makes sense]
> >
> > [snip]
> >
