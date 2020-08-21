Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64D24D4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHUM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 08:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:26:32 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F5C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:26:32 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g20so475184uap.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbvZEDhT/LcMLyvCAf7W/2A5AJcrgbYSsTCXLVpDb7s=;
        b=Z4VlJ6wvagU/7m6fCodRzqPd9uoB6IfPMwJiSa8EHj+ecEI9FrdBaZeWa112Dd1EeL
         eZNbhhNYzV0JRbHaiZm/4fBrCqxnU3bYjlJxScyF73wwOAIvQISWE/N52XeGpi/E024m
         RH9lHcyLZCUwenOrnfEYs0qW05FSqI7585FhPUnTwfaucwe9LasxQSyPtXDPUj17k/Zr
         m/cppwsq5HW+goVgPrawrY3zqc+fddtVfanHyXiTpArjeb79utA+JWgEWIm1sWeMFEpm
         IyhKQTFhje/k5LBGc9Kc+VvPZkMMuIZxjPFqVfpStlGUg11Lzqc2bT2zm3BlFOaY3x1c
         7IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbvZEDhT/LcMLyvCAf7W/2A5AJcrgbYSsTCXLVpDb7s=;
        b=lXQp9TjEUkVlXnLCicSs9cxxV65vkQAWPmylGILV5vx5YbyF7aWZ52iOmqIWZvek7t
         7HjuKRwEa9E+K3CvDV6eqrtZDJgX5oCY1v+JbbmK/Ixc58DIrnvSWcvNGr/yaABk12J4
         i2ckhpWVZceye2JZ3a6qyC17fQR33/M8o+FvaeZhoNl24lb+izL8hHmp/b1Yrad/hyRG
         qbVqpd5vcDFrxxZqxPMAwIOYJngwQM48OlpUEbBS73jlhPpVUs/2P+5s3aZfRFoF4gkf
         bOHJX29Z4Qey9+HWXQBqurY3AVXRB+17x3oEyj55DlpUWDqzWN2m6wtb0cjAm/YZ++Lv
         xAeA==
X-Gm-Message-State: AOAM530sSi7OSMCoU2Q0RxKZW4dpFNKHb7ZN3ZaPieGkmSsAygWQAUDs
        QkQBiJ5VaiPZsHqsj743GOH0gghDMdlVaEomUZ0YBQ==
X-Google-Smtp-Source: ABdhPJwNshA5yEX75DfSqWoXnYvYsVNqit6ZzrjaXCOdj7MNSkZy55mB9pdb+gcu1chYr56ErmmeZ2JYY6g9cBloDBw=
X-Received: by 2002:ab0:65c3:: with SMTP id n3mr1290605uaq.100.1598012791719;
 Fri, 21 Aug 2020 05:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110848.29114-1-benchuanggli@gmail.com>
 <CAPDyKFoGQFxdNVA+A76NitGP=yZvE2z90fewAo21Q8U+bgPbBQ@mail.gmail.com> <CACT4zj_iO58CPk_PTfNCot+c2Z1_vcWeVUwH2nPgN-jx43eN2g@mail.gmail.com>
In-Reply-To: <CACT4zj_iO58CPk_PTfNCot+c2Z1_vcWeVUwH2nPgN-jx43eN2g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 14:25:55 +0200
Message-ID: <CAPDyKFoL8Yh_SJSw56kQsFBRE64oRGTnyzgvOm__-1f+Cvxpzw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 04/21] mmc: core: UHS-II support, try to select
 UHS-II interface
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > @@ -2300,6 +2304,33 @@ void mmc_rescan(struct work_struct *work)
> > >                 goto out;
> > >         }
> > >
> > > +       if (host->caps & MMC_CAP_UHS2) {
> > > +               /*
> > > +                * Start to try UHS-II initialization from 52MHz to 26MHz
> > > +                * (RCLK range) per spec.
> > > +                */
> > > +               for (i = 0; i < ARRAY_SIZE(uhs2_freqs); i++) {
> > > +                       unsigned int freq = uhs2_freqs[i];
> > > +                       int err;
> > > +
> > > +                       err = mmc_uhs2_rescan_try_freq(host,
> > > +                                                      max(freq, host->f_min));
> > > +                       if (!err) {
> > > +                               mmc_release_host(host);
> > > +                               goto out;
> > > +                       }
> > > +
> > > +                       if (err == UHS2_PHY_INIT_ERR)
> > > +                               /* UHS2 IF detect or Lane Sync error.
> > > +                                * Try legacy interface.
> > > +                                */
> > > +                               break;
> > > +
> > > +                       if (freq <= host->f_min)
> > > +                               break;
> > > +               }
> >
> > Assuming we change the initialization order, trying to initialize the
> > legacy SD interface first to figure out if UHS-II is supported, then I
> > think we should be able to move the entire code above into a the
> > UHS-II specific code/path.
>
> If the host tries to use the SD interface first,
> some failure status needs to be considered.
>
> For example, first run in SD mode, try UHS-II interface failure,
>  and then return to SD flow again.
> I don't know a good way to go back to SD flow again.

Right, a re-try path for the legacy SD interface is a very good idea!
However, I don't think the initial support for UHS-II needs to cover
it. Instead we can add that on top, don't you think?

As a matter of fact, we could even use something like that for
different legacy SD speed modes. For example, if UHS-I SDR104 fails we
could try with UHS-I SDR25.

>
> >
> > > +       }
> > > +
> > >         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > >                 unsigned int freq = freqs[i];
> > >                 if (freq > host->f_max) {
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > index 5a2210c25aa7..c5b071bd98b3 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -901,6 +901,20 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
> > >                 err = mmc_read_switch(card);
> > >                 if (err)
> > >                         return err;
> > > +               if (host->flags & MMC_UHS2_INITIALIZED) {
> >
> > Rather than using host->flags, to tweak the behavior of
> > mmc_sd_setup_card() to support UHS-II, I would prefer to give
> > mmc_sd_setup_card() a new in-parameter that it can look at instead.
>
> Do you mean that adding a new in-parameter to mmc_sd_setup_card() likes this
> mmc_sd_setup_card(struct mmc_host *, struct mmc_card *, boot reinit,
> boot uhsii); ?

Correct.

[...]

Looks like we have covered most of the review for the mmc core
changes. But please tell me, if there is anything else you want me to
look at - at any time. Otherwise I am deferring to wait for a new
version of the series.

If I get some time, I may start to help with hacking some code.
Perhaps I can do some preparations, so it makes it easier for you to
add the UHS-II specific code. If so, I will let you know about it, of
course.

When it comes to the changes to SDHCI, I am relying on Adrian to give
his opinions.

Kind regards
Uffe
