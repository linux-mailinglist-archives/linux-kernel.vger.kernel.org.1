Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229B8282E97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJEBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJEBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:08:28 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73EC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 18:08:28 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z1so1998061uaa.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lzi6k3AqyqG7MfTfpPbp6oQnU/CVHLJ/4VcvpRGjvRc=;
        b=nM0rmVuONuIJa+EEBfrSCP2xTfko8vm5CnOGvyCu8krelT0/1VAozhlhcH53yUCuO0
         1HU0fmsWVFjrMW0/1HoPf6feLYpLfSVVE0Z40EK1VFZ6GF4MllxWX3uvhZteLiTFi1oO
         x4SCN21hIFZOx2Nt7IM04ehakAPmGQA0NTYhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lzi6k3AqyqG7MfTfpPbp6oQnU/CVHLJ/4VcvpRGjvRc=;
        b=WguCm5Eh/vOsUEudZHffY7W6nnkYs0MSE61rSgVejLk3lCDxjC1Y/Hhq6ly80lDLI0
         ZV0PXKNHKY8LnNpfxVkF2vy3pUR8EEAnfflS4iSsAWFHGmLPnaW+LW/noWdIOTgn1aSu
         WYmCRDVqJ90AV2J6r1rLA45MKs8nhMn2cX0Efe7syqeJpNuA2nPtx1UtbBuW/+Zz999J
         vtpdlidzJKLzTUB3Scoc8RceFgCJBvK8X3QLrQX00osYcmWpzq1iedBj7vsNqYSSSWXT
         LeLa1/zMlGRXuMtkQSix5pRm8+GX1vSzAaDJIT/LbZF2iNgXPp7tzk1i/wn0e9OCcBX7
         uiMA==
X-Gm-Message-State: AOAM530hA5uk7dOt8+CEbofPCeAcgJXSmt3J0RSYKhqJlcm2rPROnM5o
        o/rvZN6IKbvkpKGqHy5Veb4Ctty66yrdEU2+7tyhvg==
X-Google-Smtp-Source: ABdhPJzlJFbn5aSHJ5VVUc5EutBTtfaO5xYShcZG73bY1PxsEWRc7VNKX0rUoZJMD2F8z09EMgPwHpJevKokqnPd98E=
X-Received: by 2002:ab0:7658:: with SMTP id s24mr439583uaq.48.1601860107092;
 Sun, 04 Oct 2020 18:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200928113107.v2.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
 <fe2f0eeb-ec21-5cf5-7cae-c17855bf0297@gmail.com>
In-Reply-To: <fe2f0eeb-ec21-5cf5-7cae-c17855bf0297@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 5 Oct 2020 09:08:16 +0800
Message-ID: <CANMq1KCnsrPtxxvqHL2pBPPgfna-uqbAnNxzoZSzH4seLQqY=g@mail.gmail.com>
Subject: Re: [PATCH v2] soc: mediatek: Check if power domains can be powered
 on at boot time
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 11:03 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 28/09/2020 05:31, Nicolas Boichat wrote:
> > In the error case, where a power domain cannot be powered on
> > successfully at boot time (in mtk_register_power_domains),
> > pm_genpd_init would still be called with is_off=false, and the
> > system would later try to disable the power domain again, triggering
> > warnings as disabled clocks are disabled again (and other potential
> > issues).
> >
> > Also print a warning splat in that case, as this should never
> > happen.
> >
> > Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Applied to v5.10-tmp/soc which will be v5.10-next/soc as soon as v5.10-rc1 gets
> published.
>
> Nicolas can you please make sure that similar logic will be part of the series
> Enric is working on?

https://patchwork.kernel.org/patch/11811767/ the logic is a bit
different, and the whole scpsys driver would fail to probe, but I
think that's also reasonable behaviour.

Thanks,

>
> Thanks a lot.
> Matthias
>
> > ---
> >
> > Changes in v2:
> >   - Add WARN_ON if the domain can't be powered on, to make it more
> >     obvious that this should not happen (there is already an error
> >     message).
> >
> >   drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index f669d3754627..ca75b14931ec 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >       for (i = 0; i < num; i++) {
> >               struct scp_domain *scpd = &scp->domains[i];
> >               struct generic_pm_domain *genpd = &scpd->genpd;
> > +             bool on;
> >
> >               /*
> >                * Initially turn on all domains to make the domains usable
> > @@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >                * software.  The unused domains will be switched off during
> >                * late_init time.
> >                */
> > -             genpd->power_on(genpd);
> > +             on = !WARN_ON(genpd->power_on(genpd) < 0);
> >
> > -             pm_genpd_init(genpd, NULL, false);
> > +             pm_genpd_init(genpd, NULL, !on);
> >       }
> >
> >       /*
> >
