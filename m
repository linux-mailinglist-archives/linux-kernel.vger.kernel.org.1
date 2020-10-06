Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B928448F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgJFESh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJFESh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:18:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4ACC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 21:18:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a1so993390pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcoaRr39n3pJ3sesrCDq8ky5x8Qln0X+2e7YbCVQ4pU=;
        b=nsRLTz7VjwM0NuyZMyQDjOnbBBVnYbZxMdoaHHlw7HG2FTwnokTccs4Rf1Grupmb0z
         owX3wtIxJCXzY768ohg5XAd5M3WTYk2buQ3sZ6PcJO+A9xrDNJU5ybmZS9gQR6r+yJ5C
         9PxumrNW1jmPqNCXL8rz62k0Wiyrf0I7pHQBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcoaRr39n3pJ3sesrCDq8ky5x8Qln0X+2e7YbCVQ4pU=;
        b=gom5gpuHb8rpQPmRLz8TkxJBhuj0bIFNvip3VYu5pY0mf7NAEJoHF+5Q2rs1sqBPYN
         UDhre0dcEjviSQ8+igfacSv4JjPW9qxxW8fkxMcL//kgcZMH8UdKrb2J1UsNChNGBOim
         Pb0zZRH3aYqdJG01/0Mx1iPMrHV5aV24z+SysHV9fY/4PBKWU74jp03yfR+HvasC/j6l
         axFDhQrhRsWaDAwM/+s4hAvz9vELPNA42SLlwm7PCmYeAbSefG+k8fRM3P36Aj7Upd4S
         64C/10OtL6n5UIG5FMl2qAxJ0exKcgK1KD6gXNR8ZIw4sbmmDcH4L3XSbL+UZHR8+x2X
         bCFg==
X-Gm-Message-State: AOAM531Jrbd3/mLAgO4CCWTjil0sy4QxKpnYRE5k4JkksdR1AVi0X9cc
        pvl3R06ahhqt4Q/9ywOKYQNpKxZdSoMoCCEO6w8KWg==
X-Google-Smtp-Source: ABdhPJxicw6MQR7cluHUrvRs30Bprxs3MLmOY9NsL7Zxm8PzCKU233r0WZtTzaxg2zkmtvGZylOAlsYCzhxqviSx93E=
X-Received: by 2002:a17:902:8693:b029:d3:9c6b:ca5f with SMTP id
 g19-20020a1709028693b02900d39c6bca5fmr1551836plo.67.1601957916321; Mon, 05
 Oct 2020 21:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201005225004.0d3b59a1@canb.auug.org.au> <CAATdQgB6aN8-BXwTG7=u8c+Q7mPmU+A9=O=_7u_wbPkuVNhjvA@mail.gmail.com>
In-Reply-To: <CAATdQgB6aN8-BXwTG7=u8c+Q7mPmU+A9=O=_7u_wbPkuVNhjvA@mail.gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 6 Oct 2020 12:18:25 +0800
Message-ID: <CAATdQgAjk2fjtk+yprpeftihwJpKrNUWpQaB00R9vzFLc_30Tg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the battery tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 11:57 AM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> On Mon, Oct 5, 2020 at 7:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   f9d293364b45 ("power: supply: sbs-battery: keep error code when get_property() fails")
> >
> > Fixes tag
> >
> >   Fixes: c4f382930145 (power: supply: sbs-battery: don't assume i2c errors as battery disconnect)
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe you meant
> >
> > Fixes: 395a7251dc2b ("power: supply: sbs-battery: don't assume i2c errors as battery disconnect")
> >
>
> Yes, you're right. I guess I made a mistake here.
> I'll send a v2 patch.

Oh I'm sorry, it's from linux-next!

I found d6e24aa0bf15 ("power: supply: sbs-battery: keep error code
when get_property() fails") on sre/for-next branch
with a valid Fixes tag:

    power: supply: sbs-battery: keep error code when get_property() fails

    Commit c4f382930145 (power: supply: sbs-battery: don't assume
    i2c errors as battery disconnect) overwrites the original error code
    returned from internal functions. On such a sporadic i2c error,
    a user will get a wrong value without errors.

    Fixes: 395a7251dc2b (power: supply: sbs-battery: don't assume i2c
errors as battery disconnect)

    Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

but there is still a wrong sha-1 hash in the commit message,
Sebastian, can you please amend the commit message before merge?


>
> Thank you!
>
> > --
> > Cheers,
> > Stephen Rothwell
