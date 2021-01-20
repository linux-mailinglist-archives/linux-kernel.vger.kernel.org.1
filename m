Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05F2FCE23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbhATKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731676AbhATJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:47:35 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245DC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:46:51 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p20so5436642vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhkW5Un12MQxFKkR9JsfkRF/gz1LnCi9m0FMvMURDwI=;
        b=EDHUMoJhmI1vDbf8WoGqzB0P8ceHOj5SdAnr2Fra+YO2uuty8NaFRqlpwt1+fuHAbu
         btkX0AfouIJVoNP4D95p9U/fmMZco3eBu7FcIEdWDZqvfghi7T8Z1V2P9l+VF9KpOfDJ
         WJOSPi+ZFWYoaZ1CUtwlfV5exs58PEPnZDh1t+DRVhTOQ8jd1OIrOUBctpJtNrWX2uOY
         E6lwdvlFe7m1GwvtJESG69Q+SsqsbG0Jy/2IjdQx+k9rqUrVB4ilgjP/sAT7SQupFwPV
         IMRUpCQ5EwwbE14Z9WPtQWh8Eeo180qitc4WtpQYUVRuhPWdz70SGwIox3WTVWzZencA
         CzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhkW5Un12MQxFKkR9JsfkRF/gz1LnCi9m0FMvMURDwI=;
        b=Ga0lINX8RHek2/Hs1m4vAxdu724Y6+jaLAOnCUrRCZknvG0p/xTlvWIOTgW+NadlJV
         HuE4B6oqvsljTI+giIu7bAFlPL52fK5KLv3al0qgP5WL+Q2upp7nG6qvmCv5mpFy79RZ
         FLEF2tYF39uEHntye6jpXwZxMvcFKqqJv7dFJWDECtLJVe5yiLFPF1eqnpAjHI+16cYF
         4YyXAPcyfs888bHDLWSgXZ0tID/QtHJ6TBzgrxbnbH32krifVBrGJszz8G9PKjseUlgu
         q+4FOgugVTh/PFbJ0ka0gXHPaiN6pEYICJQj7YiUeKKbF4Sqqs0bjcTlaz1pF68KuTTU
         BRXA==
X-Gm-Message-State: AOAM530xIKUr41df1YEv42MruTH9xsTfIvCllXUcdOmRw071HH716nPl
        tn87e89xzJor7VmfVeYEV+bz1ZHZqu7CR8lrCvhDHw==
X-Google-Smtp-Source: ABdhPJwO6uu53BOw77rfLTS5GBUN3JZG76q4E0f/Siu6uksMYN3b96L0snD4x7kn508rPkM54zSM0QQ2t+NOS+nO6Rs=
X-Received: by 2002:a67:f997:: with SMTP id b23mr5655937vsq.34.1611136010227;
 Wed, 20 Jan 2021 01:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120015010.14191-1-digetx@gmail.com> <20210120015010.14191-2-digetx@gmail.com>
 <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
In-Reply-To: <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 10:46:14 +0100
Message-ID: <CAPDyKFp-7CEY42PCEGa97_89Ew6QysbV7pBBQOSLwBKAZwFpvg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PM: domains: Make set_performance_state() callback optional
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 05:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-01-21, 04:50, Dmitry Osipenko wrote:
> > Make set_performance_state() callback optional in order to remove the
> > need from power domain drivers to implement a dummy callback. If callback
> > isn't implemented by a GENPD driver, then the performance state is passed
> > to the parent domain.
> >
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> > [tested on NVIDIA Tegra20/30/124 SoCs]
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 9a14eedacb92..0bd0cdc30393 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> >       return state;
> >  }
> >
> > +static int _genpd_xlate_performance_state(struct generic_pm_domain *src_genpd,
> > +                                       struct generic_pm_domain *dst_genpd,
> > +                                       unsigned int pstate)
>
> I would name them as genpd and parent, that makes it more readable for it.

... and while at it, probably also drop the "_" as the prefix of the
function name.

Other than that, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
