Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3A2A0878
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJ3Owh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Owh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:52:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A00C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:52:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a71so1587202edf.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5kvv5uw6I8N5KPvISgpcs2bpmjLcnfdZueGm2A3SK8=;
        b=AUALrLqX/UUrnL+q4wDkdzgZ7wuF5HaU5MBavsgLCXvQj+4ga3VfbAFkOIhsxdHXHO
         E1EkfS9xuUF2Gh300k4HOSuPaw+yJHcelaiHgmY172rAlkd/H0ObNbqqWbx/ArqO5o5D
         FN0Iq17ULuvyAYBYz8iBz6cY7I5CGDMjtVnZkdiuJ72rdh3Sml8wGSBgKPUErGYpvpzc
         rJo6cxPLI/d11esOXhhRppysb5MwtbQMEjerU8eUUnbx65dRrZ3lTvTeDq4tkP6m2M0o
         HP6FFTHouyTNLSV3vd6Ldj0GoOxrypDd0YPiaBhSbMC765lfaQmWqvCr8jzfa80qcnMT
         O9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5kvv5uw6I8N5KPvISgpcs2bpmjLcnfdZueGm2A3SK8=;
        b=JHbMb+VrbnUIekdlQ31GnMsH2VNOK0SPv1/3RIbB+EpijnoGSxSUwkLI8uaoOGADfH
         fztF2pTLx14xlWfw09WHFSwkawdUQNQrQKpbq7hLNSmRKITVWWTflOr2kVbSjF+q6Dtc
         h7yj8+NEU5Fphy9pBajj6jz8mMJQ9GS68TWDodWLCEYSA/9RUArFkzc1ggb8dd6G7sXJ
         8z7te63JlbILTQQ3TCxONWpU26eVQncrM2QS2Tn/BcWswjLkH+E7YEYI6RY1dKUuVOdF
         ZvRYugag/iwB+TsSXleNit0mt6ZxgywCEQbAZK+T96+BfMYYeRuoZ01CoePGGF2HWx01
         E2JQ==
X-Gm-Message-State: AOAM530WqOh+xDrbispIoKph9R5T/31hEIvJUgDpp8SZmnPCaWCs1Lxh
        PzCl+13S4pZm2Tw2CskO3RasB5Vzhyi4CXQFESUyOkfc92A=
X-Google-Smtp-Source: ABdhPJwu29d/F6AOrgAwF3wyRRXM+Tg+NruibJSmz3yC3jLPr4PU6pXZ50Ck5FSRy2W2u/GbcYYaXVSzaiCMySz7QEA=
X-Received: by 2002:a50:d987:: with SMTP id w7mr2762637edj.113.1604069555433;
 Fri, 30 Oct 2020 07:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201014231158.34117-1-warthog618@gmail.com> <CACRpkdbTsN6p4n3f9SJrgAjdkzDu2S67rU3tLWwX0X50ekjctQ@mail.gmail.com>
 <20201028232211.GB4384@sol> <CAMpxmJX61dRE_d2Eyu2nXKx64rNrrTfScrdg=Cc-N-R_FKfUNg@mail.gmail.com>
In-Reply-To: <CAMpxmJX61dRE_d2Eyu2nXKx64rNrrTfScrdg=Cc-N-R_FKfUNg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 30 Oct 2020 15:52:24 +0100
Message-ID: <CAMpxmJXiObcKyoE264oyiZOs08=uRYno6siMzz6BH+jmT_NKgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 3:49 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Thu, Oct 29, 2020 at 12:22 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Oct 28, 2020 at 05:01:49PM +0100, Linus Walleij wrote:
> > > On Thu, Oct 15, 2020 at 1:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > > This patch set adds the option to select CLOCK_REALTIME as the source
> > > > clock for line events.
> > > >
> > > > The first patch is the core of the change, while the remaining two update
> > > > the GPIO tools to make use of the new option.
> > > >
> > > > Changes for v2:
> > > >  - change line_event_timestamp() return to u64 to avoid clipping to 32bits
> > > >    on 32bit platforms.
> > > >  - fix the line spacing after line_event_timestamp()
> > >
> > > Where are we standing with this patch set? Good to go so
> > > I should just try to merge it?
> > >
> >
> > I'm fine with it, especially now that I've tested it on 32bit platforms
> > as well as 64bit.
> >
> > Bart was ok with v1, and I doubt the changes for v2 would negatively
> > impact that, though I did overlook adding his review tag.
> >
> > Cheers,
> > Kent.
> >
> > > Yours,
> > > Linus Walleij
>
> I'll take it through my tree then.
>
> Bartosz

The series no longer applies on top of v5.10-rc1. Could you rebase and resend?

Bartosz
