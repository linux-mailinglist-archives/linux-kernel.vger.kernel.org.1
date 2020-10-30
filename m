Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0752E2A05AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgJ3MoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3MoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:44:16 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:44:16 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id h5so3331335vsp.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNPNFxqPA6enB9KRW2LUYTlhDKvCAVgMX9XkoFBr6eI=;
        b=RxOtR0EIquR42tXsI4tkmj6fxdA2h2dPW+I8oF4xB0X4Sl3os200XZ+XrhGdiLQAgL
         kqvYUvL608QrEN7guKqco9mZfLSDqEtdqCKfL68d05KymFHVD3dOqESPYLt8GekFRAnx
         u+ICycJowDW6OHNKpAWLGnhMoYIm68Y0i0Zig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNPNFxqPA6enB9KRW2LUYTlhDKvCAVgMX9XkoFBr6eI=;
        b=X7rbqbMThh7FLRy7F2QFOaGPTAWIUichVTFG7Zy0SIff1ssrfsOZvSWVuuHU7HwHkR
         2vwm7lkAUU734bfIGlY69wMbjQVa7pmFfDafSxMBvcDX1Sp9IbFQFdnNoCzWHQY0WU57
         eX5x0n8wrqYQbnbKow37tIZ1psgX0hJY6POITOr3gMbWR+B9aNQiED993+86WlK6AVjx
         dH1NRSg4jfkrmsQd3uJizUQp3iMiP20wYdBEWKYPo8rryfP92g3Oslt5jkptpIqDD9+M
         fncQhX+PBVvGJH6goPdasLVjZSyLFAlfLHJjc0yQIMBMrmxfUDT2Qna0m7FhqQkmR+lu
         FRUA==
X-Gm-Message-State: AOAM5329ne8TdZoHUbuZzk6QXKEtwC+xD3badZf7uNTTNyHEbd5iA3tC
        xzfOCcwhwYA045VgHmvu+1hqDkLHH0uUSs5zKDBhFnXl2Zw=
X-Google-Smtp-Source: ABdhPJwQRPMKwjP3+4lI313bVvSNs4P+TAzFBic2C87HryeNWf8GCQOhHGMPRbAP0kqXX84645AZPl58CqldmdyGBvI=
X-Received: by 2002:a67:6504:: with SMTP id z4mr7010900vsb.48.1604061855628;
 Fri, 30 Oct 2020 05:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-3-enric.balletbo@collabora.com> <CANMq1KDSsfX3r1440qbmWggqbD7pU_iM4S36LUF8rsS2jVGqOg@mail.gmail.com>
 <ebba9def-e394-c183-dd80-6dc3716a7bd1@collabora.com> <CANMq1KBfKK9-RfMK89hRCGzhqZVqs6+YRdw8o2K+jA+3VN1_gw@mail.gmail.com>
 <2e6def0a-400c-836f-ef8b-c4fe6ac6c26e@collabora.com> <CANMq1KDJPqiyXJKyeER7rSVbu7VxAcvrcV8rxDLMV+VEyx-Xmg@mail.gmail.com>
 <72dca621-ceb4-72ae-f340-c01474cb5b8d@collabora.com>
In-Reply-To: <72dca621-ceb4-72ae-f340-c01474cb5b8d@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 30 Oct 2020 20:44:04 +0800
Message-ID: <CANMq1KAq9u0S-XtLY-Svk86sR-RN3HGzvpVPuhVeH7uSB8s_Mg@mail.gmail.com>
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

On Fri, Oct 30, 2020 at 6:30 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nicolas,
>
> On 28/10/20 2:13, Nicolas Boichat wrote:
> > On Wed, Oct 28, 2020 at 12:25 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Nicolas,
> >>
> >> On 27/10/20 1:19, Nicolas Boichat wrote:
> >>> Hi Enric,
> >>>
> >>> On Mon, Oct 26, 2020 at 11:17 PM Enric Balletbo i Serra
> >>> <enric.balletbo@collabora.com> wrote:
> >>>>
> >>>> Hi Nicolas,
> >>>>
> >>>> Many thanks for looking at this.
> >>>
> >>> Thanks to you ,-)
> >>>
> >>> [snip]
> >>>>>> +       if (id >= scpsys->soc_data->num_domains) {
> >>>>>> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: invalid domain id %d\n", node, id);
> >>>>>> +               return -EINVAL;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       domain_data = &scpsys->soc_data->domains[id];
> >>>>>> +       if (!domain_data) {
> >>>>>
> >>>>> Is that even possible at all? I mean, even if
> >>>>> scpsys->soc_data->domains is NULL, as long as id != 0, this will no
> >>>>> happen.
> >>>>>
> >>>>
> >>>> I think could happen with a bad DT definition. I.e if for the definition of the
> >>>> MT8173 domains you use a wrong value for the reg property, a value that is not
> >>>> present in the SoC data. It is unlikely if you use the defines but could happen
> >>>> if you hardcore the value. We cannot check this with the DT json-schema.
> >>>
> >>> I wasn't clear in my explanation, and looking further there is more
> >>> that looks wrong.
> >>>
> >>> This expression &scpsys->soc_data->domains[id] is a pointer to element
> >>> "id" of the array domains. So if you convert to integer arithmetic,
> >>> it'll be something like `(long)scpsys->soc_data->domains +
> >>> (sizeof(struct generic_pm_domain *)) * id`. The only way this can be
> >>> NULL is if scpsys->soc_data->domains pointer is NULL, which, actually,
> >>> can't really happen as it's the 5th element of a struct scpsys
> >>> structure `(long)scpsys->soc_data + offset_of(domains, struct scpsys)
> >>> + (sizeof(struct generic_pm_domain *)) * id`.
> >>>
> >>> I think what you mean is either:
> >>> domain_data = &scpsys->soc_data->domains[id];
> >>> if (!*domain_data)
> >>> [but then domain_data type should be `struct generic_pm_domain **`?
> >>
> >> I think you're confusing the field `struct generic_pm_domain *domains[]`from the
> >> `struct scpsys` with `const struct scpsys_domain_data *domains` from `struct
> >> scpsys_soc_data`. My bad they have the same name, I should probably rename the
> >> second one as domain_info or domain_data to avoid that confusion.
> >
> > Oh, okay, get it, thanks for clarifying, I got myself confused indeed ,-P
> >
> > But, still, part of my integer arithmetics still holds...
> >
> > &scpsys->soc_data->domains[id] = (long)scpsys->soc_data->domains +
> > (sizeof(struct generic_pm_domain *)) * id. The only way domain_data
> > can be NULL is if scpsys->soc_data->domains pointer is NULL (it can't
> > be, really, assuming scpsys_soc_data structures are well defined) AND
> > id is 0.
> >
> > Now, if I understand what you want to check here. If a domain id is
> > not specified in scpsys_domain_data (e.g. if there is a gap in
> > MT8XXX_POWER_DOMAIN_YYY indices and if `id` points at one of those
> > gaps), you'll get an all-zero entry in domain_data. So maybe you can
> > just check that domain_data->sta_mask != 0? Would that be enough? (I
> > expect that sta_mask would always need to be set?)
> >
>
> Yes, that would be enough. I'll change for the next version.
>
> > But then again, are there ever gaps in MT8XXX_POWER_DOMAIN_YYY indices?
> >
>
> AFAIK, there is no gaps, but one could make gaps when filling that info.  I
> still think is worth have this check although is "unlikely" to happen due an
> human error :-). I'll maintain for the next version, but I don't really care to
> remove it if all you prefer I remove it.

I'm fine with the sta_mask check. Thanks!

>
> Thanks,
>   Enric
>
>
> >>
> >>
> >> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
> >> b/drivers/soc/mediatek/mtk-pm-domains.h
> >> index 7c8efcb3cef2..6ff095db8a27 100644
> >> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> >> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> >> @@ -56,7 +56,7 @@ struct scpsys_domain_data {
> >>  };
> >>
> >>  struct scpsys_soc_data {
> >> -       const struct scpsys_domain_data *domains;
> >> +       const struct scpsys_domain_data *domain_data;
> >>         int num_domains;
> >>         int pwr_sta_offs;
> >>         int pwr_sta2nd_offs;
> >>
> >> ---
> >>
> >> struct scpsys {
> >>     ...
> >>     const struct scpsys_soc_data *soc_data;
> >>     ...
> >>     struct generic_pm_domain *domains[];
> >> }
> >>
> >>
> >> domain_data = &scpsys->soc_data->domain_data[id];
> >> if (!domain_data)
> >>
> >> Thanks,
> >>   Enric
> >>
> >>
> >>> Does your code compile with warnings enabled?]
> >>> or:
> >>> domain_data = scpsys->soc_data->domains[id];
> >>> if (!domain_data)
> >>> [then the test makes sense]
> >>>
> >>> [snip]
> >>>
