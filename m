Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CA29DC65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgJ2AaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgJ2A34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:29:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B112C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:29:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r127so1065238lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+29/TcPNhKLrZc8ORdUxnAs3h3uQuZ7mIPDZVUJNhE=;
        b=mjZCnUlfK6dWPsPKI+FtqgKir5ir77qbH5PPTjHsAstFcaQBght75bUbcM8QL4XMgZ
         uXGUZLDLijtdRpp0uijwwlaoXM7c/E+PwGTf76bdDNknKzfF1bXdU2DMmKx5naSxdH2F
         gg5p07x6UbPa3aetX0I177kiA2ZTibPAxs3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+29/TcPNhKLrZc8ORdUxnAs3h3uQuZ7mIPDZVUJNhE=;
        b=gu1BssWhcW9bOGbGtt60yVsxmGLr1qzN8q60bTTaKhlOolpfAlYUaJ5d0Pjy57H3Dl
         81bxkMxJiZqcraRmUqMZ//+yLDIK020x1pTi/FGLqua0502viBuqpsfkzWHSBBu6isY7
         +i+QO7z8J44gIhEIxS+aXRYeMDiS445xcOUiZvvs2hdftoINFkXiAzUBEbBcia14WTOy
         i2bI/TeIh9MTd8nAI11J4l+LMuD2GDrumtexWcQ+hRCvfCoJYFeSylFnPVWqrDs0Bhck
         shMOOi/TtvH1ddEOjH+/TZzIdds8GA5406bTXxZGRYKcztKx5/7h8wUq2yNBQp07WTqX
         +Ylw==
X-Gm-Message-State: AOAM5335jgRuWbsmcgOvgdLdlnAU3C1l/pbSFD2yBBuw6DyVO7t52CO2
        Yyra8nJl5ODdGkLcHL6aH+y17ejGMNRl0Q==
X-Google-Smtp-Source: ABdhPJzdTfeidWknJUVcIysDuT4BgT+tqW8SuEm2NW40N160p9MKvM4ZDHvuuUbVX47Qqp07iGVhNA==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr532101lfl.42.1603931393656;
        Wed, 28 Oct 2020 17:29:53 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l14sm128397lji.123.2020.10.28.17.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 17:29:53 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x16so1240502ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:29:52 -0700 (PDT)
X-Received: by 2002:a2e:8e6c:: with SMTP id t12mr644560ljk.432.1603931392354;
 Wed, 28 Oct 2020 17:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201016192654.32610-1-evgreen@chromium.org> <20201016122559.v2.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
 <CAD=FV=WjMi6BdoEjDoM=U=ZHDMsFdLQSU5q20HGjc+DyfnrJEg@mail.gmail.com>
In-Reply-To: <CAD=FV=WjMi6BdoEjDoM=U=ZHDMsFdLQSU5q20HGjc+DyfnrJEg@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 28 Oct 2020 17:29:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft7SWv-QxddmobADpyUWLnrh=qsG=O7LkS+vMFZvP8JG2w@mail.gmail.com>
Message-ID: <CAE=gft7SWv-QxddmobADpyUWLnrh=qsG=O7LkS+vMFZvP8JG2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvmem: core: Add support for keepout regions
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:41 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Oct 16, 2020 at 12:27 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Introduce support into the nvmem core for arrays of register ranges
> > that should not result in actual device access. For these regions a
> > constant byte (repeated) is returned instead on read, and writes are
> > quietly ignored and returned as successful.
> >
> > This is useful for instance if certain efuse regions are protected
> > from access by Linux because they contain secret info to another part
> > of the system (like an integrated modem).
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> > Changes in v2:
> >  - Introduced keepout regions into the core (Srini)
> >
> >  drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++--
> >  include/linux/nvmem-provider.h | 17 ++++++
> >  2 files changed, 108 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index a09ff8409f600..f7819c57f8828 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/of.h>
> >  #include <linux/slab.h>
> >
> > +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> > +#define MIN(a, b) ((a) < (b) ? (a) : (b))
>
> Why not use min() / max() macros from include/linux/kernel.h?
>

Done

>
> > +static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
> > +                                     unsigned int offset, void *val,
> > +                                     size_t bytes, int write)
> > +{
> > +
> > +       unsigned int end = offset + bytes;
> > +       unsigned int kend, ksize;
> > +       const struct nvmem_keepout *keepout = nvmem->keepout;
> > +       const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
> > +       int rc;
> > +
> > +       /* Skip everything before the range being accessed */
>
> nit: "Skip everything" => "Skip all keepouts"
>
> ...might not hurt to remind here that keepouts are sorted?

Done

>
>
> > +       while ((keepout < keepoutend) && (keepout->end <= offset))
> > +               keepout++;
> > +
> > +       while ((offset < end) && (keepout < keepoutend)) {
> > +
>
> nit: remove blank line?

Done

>
>
> > @@ -647,6 +732,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >         nvmem->type = config->type;
> >         nvmem->reg_read = config->reg_read;
> >         nvmem->reg_write = config->reg_write;
> > +       nvmem->keepout = config->keepout;
> > +       nvmem->nkeepout = config->nkeepout;
>
> It seems like it might be worth adding something to validate that the
> ranges are sorted and return an error if they're not.
>
> Maybe worth validating (and documenting) that the keepouts won't cause
> us to violate "stride" and/or "word_size" ?

Done

>
>
> Everything above is just nits and other than them this looks like a
> nice change.  BTW: this is the kind of thing that screams for unit
> testing, though that might be a bit too much of a yak to shave here?

It would be cool, but I'll leave that for another time. Thanks for the
review, Doug!

>
> -Doug
