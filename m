Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB67F27AB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1J62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1J62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:58:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:58:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q4so590640ils.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bynqe8oqfLSmRS8jPy3IQGtOrQle4bDHlhly7glDXtE=;
        b=E6pi/58he3Bw+tuVCJbgXrJPbzgzvilKEDqpPwZ6gDn4Y3NLB9WHKZVomKAoHyYgyw
         Pf/fvJFUPbY1TAJTKewr93xn76mzrr0DHIylwkGiejOR6rA2kT/dIa9u8PngfJphK8UO
         y3uA3ABoePxwD06j8F3cSTq+fNqADptlbwN11t1cQp3lPAzxj3wZoKopB8Glto4cM8f9
         EvkBygwREatGM2BurfQ7g/KzI/mYn2WQDh0UCxm3aFIb+aenjVZqx0sj5vHYrsUY/z9o
         SCHhYORqNAzwkDMCk+kzQkkN2h73nJbgRCh9SEG8VwXIPJa254vcVoCtD8hsPaXp7cE4
         qDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bynqe8oqfLSmRS8jPy3IQGtOrQle4bDHlhly7glDXtE=;
        b=SIsR9KSUtf2ZUJdZ6njwOCW0yeWT2uhdRASlyUTiiBII5/OYIaGDwlcSJKTo/PqWb7
         59RrdAOy0PpHm1YcsuJO17s4AcNkBabSOY1hSjF53X96z3dZT2LOwyj7ygcL6j/x57jj
         B0max/ZuEDVf7f36AenmIZT1F881hpq6mPn+x2444MTvIIfg2f8ctReIo5rRV0+mfqj8
         LJ3reyxn2VwPFbOPHLyzVyEMpeLL89XtID0tyq7iLqN4hJwHwjLeEglKWPm/MgvD4Zsy
         slIv6JMAwFlEY8PL6pGFhndUhWy3e0iXLz7XrTSXdUzLDa7LgVg35D06lVHIr4L7arrv
         R/JA==
X-Gm-Message-State: AOAM530E/KFH87KogKwYAc8tudcgeELsbR0f30FuJ2KUv0EXQkguYp6/
        zpLpFNvZd9f/iKMgI8VA6/IMnI11ZGyHervluw26rQ==
X-Google-Smtp-Source: ABdhPJzsnbR4X2gtOKMUOyny3SQ3EJ35XjKu1q3fJ+jImDN/PZpQkDGibLVlL4P3ysT+VeTtQfzSLC34OxMezTb95us=
X-Received: by 2002:a05:6e02:f10:: with SMTP id x16mr444999ilj.220.1601287107416;
 Mon, 28 Sep 2020 02:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200924113842.11670-1-brgl@bgdev.pl> <20200924113842.11670-9-brgl@bgdev.pl>
 <20200925090329.GZ3956970@smile.fi.intel.com> <CAMpxmJWBSwofFy94mHZWB2mdvHGStYp5oLDZp2M+wO57t40HSQ@mail.gmail.com>
 <20200925123000.GD3956970@smile.fi.intel.com> <CAMRc=McfBLaE=N12z29JjTDJ0ABzC8OW4rPWeeSU82kag+9pgQ@mail.gmail.com>
 <CAHp75Vd9N+OWCq_M3U3RfTEwx+xCyJHzSpZOXWiXQRRdv3tSDQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd9N+OWCq_M3U3RfTEwx+xCyJHzSpZOXWiXQRRdv3tSDQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 28 Sep 2020 11:58:16 +0200
Message-ID: <CAMRc=MecMWopShuSSiGTFpwdHKLf7DCsm-vADZ6gokKnnrepNA@mail.gmail.com>
Subject: Re: [PATCH 8/9] gpio: mockup: use the generic 'gpio-line-names' property
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 11:45 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Fri, Sep 25, 2020 at 6:41 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 25, 2020 at 01:40:10PM +0200, Bartosz Golaszewski wrote:
> > > > On Fri, Sep 25, 2020 at 11:03 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Sep 24, 2020 at 01:38:41PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > > > +             kfree_strarray(line_names, line_names ? ngpio : 0);
> > > > >
> > > > > Perhaps you may check for NULL pointer in the kfree_strarray() and drop ternary
> > > > > here?
> > > > >
> > > >
> > > > I did in the previous series and you told me to not to. :)
> > >
> > > Hmm... What was my argument? What was wrong with me? free() should be NULL-aware.
> >
> > Well, it is - your just need to make sure ngpio is 0 too. :)
>
> Do you really need that? If you have NULL as a first parameter, the
> second one can be anything.
>
> > I'll revert back to having the NULL check.
>

Yes that's what I'm saying but under patch 1/9 you previously said:

--
Shouldn't we expect that caller will supply NULL, 0 and above check is not
needed?
--

this is why it works like this in v1.

Bartosz
