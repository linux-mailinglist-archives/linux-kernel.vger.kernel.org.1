Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657EA2F7A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbhAOMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbhAOMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:49:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A459C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:48:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq1so4999732pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwEZ0vJjMhibVYpx1I3U5rxwVwXQCQH8qptIRt+vn6E=;
        b=Nf+g+CufTKuWQeJMV9uHdSlZksBUQk17DZIgfQCyiWAqye1BgqcFBpCzSjIXheeO0h
         cSp343LeRF+qD7fG5DZ6x4DOUcSJ8p/QXc9yl16Qy26PXHZa+Dd3UJHqIkXXJeutXsdP
         50g7slIbR+WAKAPoyAHAYZkNEHB42kapJINggrprDYbe1f/dnNPXsV1IYoOSbopM4N9m
         mjaRSuiawq0qxVFMPn4KYG/LAEtOwXIh1b9uBLPJ4zujCvyDvnFNF5ltQFGusVXO5FIb
         oUpR6ggYs7WWdp978cZgRrK5Hw/W/iAUxp7QfmtlHCdeDKDo47nQVYgr2EaM4Zz+LS2M
         lsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwEZ0vJjMhibVYpx1I3U5rxwVwXQCQH8qptIRt+vn6E=;
        b=FUHAPYiMq5DQzS5fk5Lu+tH+EAp4CnOKojvSQeHYFMiRSz0dyutp7U5GEwtOadyoyo
         YbLAzf2lGoPfc85u5h2SaDS/RTMhN1/jbH01lqs3gmbxtNEa8tZL3x36Ig5MednCJapP
         Fu905snG6FME9slQv3MrQ6twvDrq/dabprN3nZEysVZFVBEtGwoaEpOnDGbtMlHTBkxl
         pTqn7V0LQ3K3rDqfxMU3vfy146G1b3twEUWvTyeEYG+Bm27pzCvBLYRDrXhSxky+VPXY
         XomA610SHZKmAwyP+eIAdUA+3g6kv5/ODsWAevw/PCLBi1yNpbBserQUtr/xXEugi57D
         BSiA==
X-Gm-Message-State: AOAM532yJlct9frydT4h5ABkFqKx9RWxYbOvsiBDU3vn1db7f7/ripZe
        J4FmgTyFsB5jvL5uLiPsypjzBhbX1She5+Z60VIOaA==
X-Google-Smtp-Source: ABdhPJxHhwtCYNkaIcLQzrs1mT8U40yWsSHAGn1Ly0f4oZqippoLTkuqzC11rJfiFXZYQ9/Ni2wegco99FQ/U0bJ4Ew=
X-Received: by 2002:a17:902:ff06:b029:de:362c:bd0b with SMTP id
 f6-20020a170902ff06b02900de362cbd0bmr11764451plj.13.1610714929783; Fri, 15
 Jan 2021 04:48:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652791.git.andreyknvl@google.com> <3d9e6dece676e9da49d9913c78fd647db7dad552.1610652791.git.andreyknvl@google.com>
 <20210115104945.GB16707@gaia>
In-Reply-To: <20210115104945.GB16707@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 13:48:38 +0100
Message-ID: <CAAeHK+w49og7TTfwA3MdySkXsc0ndNYDNTO2o2YTo=kqb7U3Fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan, arm64: fix pointer tags in KASAN reports
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:49 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Jan 14, 2021 at 08:33:57PM +0100, Andrey Konovalov wrote:
> > As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> > that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> > while KASAN uses 0xFX format (note the difference in the top 4 bits).
> >
> > Fix up the pointer tag before calling kasan_report.
> >
> > Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
> > Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
> > Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/mm/fault.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 3c40da479899..a218f6f2fdc8 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> >  {
> >       bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> >
> > +     /* The format of KASAN tags is 0xF<x>. */
> > +     addr |= (0xF0UL << MTE_TAG_SHIFT);
> >       /*
> >        * SAS bits aren't set for all faults reported in EL1, so we can't
> >        * find out access size.
>
> I already replied here but I don't see any change in v2:
>
> https://lore.kernel.org/linux-arm-kernel/20210113165441.GC27045@gaia/

Hi Catalin,

Sorry, Gmail decided to mark all your emails as spam for some reason,
so I didn't see any of them :(

I'll fix this in v3.

Thanks!
