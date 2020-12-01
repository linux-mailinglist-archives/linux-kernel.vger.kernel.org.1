Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB732CAAA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgLASVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLASVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:21:32 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A38C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:20:46 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id y5so2601341iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VB4WdJpknAhtdy/6FU5lpgVyQvzyyXRv43V/9k8IIg=;
        b=UGtZmI5uMYtK2j8reNzIsyprn805+aTQG8IEtXBx/wGYt54MWP0paYcBfYu/zUEzBx
         gxTo5K+7m42S2QcbeYNCaOe6Du/NsG84wl1uSC0RcC4+OUyqRWTcbU71kqttZXjUdSbz
         Q5Fe7pN0YGjlfs0xaFQ1AU9Uw1Y0XQr6ZZWC1JTvl67xOMDeiQZfCv0jO5LwmLupNJ0e
         VZ/Y5lUnVkBbvrVkJfYkkgAONtYJ4JQ5pZ9IW3wtlPAY+JjUZKYxroShbxpk5ec6Z8Qt
         N2gdz1Ujt+HXy13JQy/rc8GnMOYQ0r1Fbnqf3aFaB7Jf8rsIkkB8NjpGUoRwftpe/YnP
         HuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VB4WdJpknAhtdy/6FU5lpgVyQvzyyXRv43V/9k8IIg=;
        b=nMm0/N6Ob2mcHjYcZCVZpxpgq9RlpTRFAGG9y2Jv2mNtZNN7UAElvq0oX0TQolKnsZ
         k8CMJA7rSwDNisIBEWeTv05vEP1AuVYZV/mENuInEBk0BBcsheHE1Q76okwemypteRHL
         cQJtkxtz/N1C+eS3f/dKQldz77/gPQWOvHIicGtbRPgBLN7hD2QDmnPl4Hq6UbILtVWs
         MjrhNi3DNteDpoAnP3QnxprlZL3WEunVnQBxRZWsDQwCKp3HaEHNs8TTMTzBbHZMmTZM
         W9dOixAnXfu8vXqRqpJUAN3ZpyXVa1b3Ia0fUxLuqSWSsIw+cvvCISjMsIx/GWMheQ++
         mQCw==
X-Gm-Message-State: AOAM5302rztikLNWw79ZPhVn2TUnE4vLRUMEftZFeoY+Zj2Fov9Jb1kf
        GbC0zeQeHsTEdRIxgAj+wwjmUVYh0O9WaUW2EZ8gmA==
X-Google-Smtp-Source: ABdhPJyA/x5M6ycyZAEa1UC93jJ/ctxhlSWPFIvDzBIEz5KFMsYDbZfHW//l9ShSmwH4SH1GSfL+h6Gdu1JeCUQHE5I=
X-Received: by 2002:a02:3b26:: with SMTP id c38mr3731469jaa.114.1606846845673;
 Tue, 01 Dec 2020 10:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20201014231158.34117-1-warthog618@gmail.com> <CACRpkdbTsN6p4n3f9SJrgAjdkzDu2S67rU3tLWwX0X50ekjctQ@mail.gmail.com>
 <20201028232211.GB4384@sol> <CAMpxmJX61dRE_d2Eyu2nXKx64rNrrTfScrdg=Cc-N-R_FKfUNg@mail.gmail.com>
 <CAMpxmJXiObcKyoE264oyiZOs08=uRYno6siMzz6BH+jmT_NKgQ@mail.gmail.com>
 <20201031000139.GA7042@sol> <CACRpkdZ2MoV04YCVxCxG-wPTgNAORkN6D+AXVOC1vEqsdGqo8w@mail.gmail.com>
In-Reply-To: <CACRpkdZ2MoV04YCVxCxG-wPTgNAORkN6D+AXVOC1vEqsdGqo8w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Dec 2020 19:20:35 +0100
Message-ID: <CAMRc=MctVES7EVrOMwcH5j4D=PwhSjFseQZ+ggigBgeZqQiLhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 2:49 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Oct 31, 2020 at 1:01 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Fri, Oct 30, 2020 at 03:52:24PM +0100, Bartosz Golaszewski wrote:
>
> > > The series no longer applies on top of v5.10-rc1. Could you rebase and resend?
> >
> > Nuts, it relies on my doc tidy-up series that Linus has pulled into
> > fixes, and so will likely go into v5.10-rc2??
>
> If I have time to get the GPIO fixes into -rc2. Otherwise -rc3
> and then I need to merge the resulting -rc into the devel branch
> before applying.
>
> I will get to it sooner or later, I think Bartosz might have some
> more GPIO fixes that I need to pull first before sending any
> fixes upstream.
>
> Yours,
> Linus Walleij

Hi Linus,

Just a gentle ping on this, so it doesn't get forgotten before the
next merge window.

Bartosz
