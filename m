Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01329E28E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgJ2CTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:19:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34141 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgJ1VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:24 -0400
Received: by mail-yb1-f196.google.com with SMTP id o70so441344ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZfGMZOlyIfrdtI2jObKxuhMFXzNJJxLtmREdUxwtXKw=;
        b=EdC0Mv/ASSEdQM3X6sJVE8rFSpsKbK7PLyUYMW7WSIlrz7YGcePkN80k0JI1DTpdTK
         WH8a5SzYR8gM79U7+KNUxKb+S4tsKC5f0lF2nudFV1z5SdmHrcy5cZvlFh5UejJMFh3f
         wHeTpuxJuRTERLkLou5CHK257CUl37duB0/D4qQkhWqgCqXuh8kd/DVE1Sw1wpgHkrXm
         AqhpoREfLnBDL1/wOwkqCatJt4KWc57AwBNG6hvTQGDiErPASfzLPKU6j7kTI3S/oZgn
         Ar+rrDm7WTDu4kzNqhLyRdOgW8ppqY9QRtdB5nOTR1XfcdV6IvMLZG1PO6B4+IBeyjvN
         R6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZfGMZOlyIfrdtI2jObKxuhMFXzNJJxLtmREdUxwtXKw=;
        b=l0MhCLyjPU1WOZcbkSyV4xAeXuz0VvONSQDug7ZxyWi8WEk+e5SRj97pRTwCz3iaoR
         Vgn2voSPvg3J+3EUnwiYEmGBiZBoqSzMAwb+Jho+QvibIXZw3JG7Tf87w/jzWy+9s9IU
         2f2Xz9kPd/LyAv3BwYFgSWWIw1rDC4ng0SDk3yeHOyQFACy4TqS5gmf76R0In44OZ7lK
         wZUvfbBVoe4H7wCbMN2DTn/dFTVDOXIlZugGC8bWDb2wOqEWWDcFphbw0wOgegbqQmL8
         9rehcYIKaqcRtd3mZlBe6xQ8lLgz11bXYdO31FXLp5JJqxDWDS5ie3NqqVeqnhUmU+lP
         C7rQ==
X-Gm-Message-State: AOAM5332mTmUoCK++5fKKBsN0B8V3Ku72BchKxPLrIhEIk3mFUoHgAn3
        rzCKW+3uRAXeFKyLuaob7JXwIEc9ey3BskYwk9BOPbMTY7c=
X-Google-Smtp-Source: ABdhPJwUKJsKFZwQaM/RozJpF8Q4x1PJAKTkqCFAMSwGdiV8T611A75j+X+2fe6elkjpDptOFONkttXWUw1kMZS5eY0=
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr585141oor.21.1603917226627;
 Wed, 28 Oct 2020 13:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134900.532249571@linuxfoundation.org> <20201028170621.GA118534@roeck-us.net>
 <20201028194647.GA124690@roeck-us.net>
In-Reply-To: <20201028194647.GA124690@roeck-us.net>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 28 Oct 2020 14:33:35 -0600
Message-ID: <CAEUSe7_72XC=Dz=yy6UrHLrgAQbHzP9V2UfmWXbwmeUSeVzgJA@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/112] 4.4.241-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 28 Oct 2020 at 13:46, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Oct 28, 2020 at 10:06:21AM -0700, Guenter Roeck wrote:
> > On Tue, Oct 27, 2020 at 02:48:30PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.241 release.
> > > There are 112 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Thu, 29 Oct 2020 13:48:36 +0000.
> > > Anything received after that time might be too late.
> > >
> >
> > Build results:
> >       total: 165 pass: 165 fail: 0
> > Qemu test results:
> >       total: 332 pass: 332 fail: 0
> >
>
> Did anyone receive the original e-mail ? Looks like I have been tagged as
> spammer, and I am having trouble sending e-mails.

If the original is from 3.5 hours ago, yeah, we got it. I'm not seeing
lore updated, but that's probably another issue.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
