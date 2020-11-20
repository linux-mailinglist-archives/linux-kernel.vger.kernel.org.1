Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4622BAB14
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKTN1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:27:15 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71366C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:27:13 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o11so9860018ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khYDe4ODkehJy6MjwBnKiqHGgEbY3DM8JifHtJFFyNc=;
        b=ISDL+Va2Q9i2ZxAJkYOi6SkHb01ET9KdtDy57qKq5uX6+mu+HoUzdq0B//zc/FJsse
         aX0V/As/e/uUbVxfalHXmDYWax01DlUcojzrP3W/dA1budm1XnAnUz873PnJflAXVMF8
         CcsWBuUQqgbSwxx0VVWbG0XitkO4s3mqUqlqV94XUHTAznm3rclRd43IZaTsynxQ40Ef
         j8yYPgFykZlUJ89o4JKmt4vRzDptuBHholYKPwS/mTWrpiZQ+SxOaRTX85pf0E45Ctmd
         RL2NvKNF2jCuHlEoES/qXsVABS4SQHjWI5qDcs7l4gggbyOL4LJS9exCtvyuY5J2IK43
         JMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khYDe4ODkehJy6MjwBnKiqHGgEbY3DM8JifHtJFFyNc=;
        b=LuBygrHqhsX+i5ihbW6SbuDqE25dZyer+QXJFMVY0aLsHG/97rpd0oJYxU2tVlAG5m
         5XIa2LMEx3CVhV/FniJW5ORuVLt8kvXWKznQ3onxusbq6u+5ctMDye8asWbpJnb/KYj2
         36h7yrZVlOEXAd8Mzwby7HnsfZybI1hBsOJqEJCurZC3oPRgxhXtBMLGCwAoqonx9kUZ
         WZuIQBNqAmKFIo1CU99J/ZFXZGX0YCQBxXpwSdKrvEjMzQDu0WTTLbkU8LT3lL30ixv+
         cj/QRSDe0F8Oe9AazcI720VIXZwMR/4nj7mWAAPC58aob3A6MhTcwDV3mOIKcrWqxLul
         JvWQ==
X-Gm-Message-State: AOAM530wu++HhbeWoBAy79XuhHs4guSXaqUMmbtow3vDEN6auByLzAd8
        j+HadrFryd8aNxmXCsyQCl9Aw5tXrj65sSaFqeo=
X-Google-Smtp-Source: ABdhPJylHXVxobE5e1ifiJDHDRquO0pMLQBoaBS/tG4ccMuwhxW9YXfZsUzkdYtO5UNqKBFH5lc+a679a57IWjJb0s4=
X-Received: by 2002:a02:840c:: with SMTP id k12mr18319689jah.91.1605878832764;
 Fri, 20 Nov 2020 05:27:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien> <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
 <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
In-Reply-To: <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Nov 2020 15:27:01 +0200
Message-ID: <CA+U=DsqHvQqkjWKsd_deN_ud3zCL=kzt-Bxd9f=Z9NJ6i+m71Q@mail.gmail.com>
Subject: Re: [Cocci] Proposal for a new checkpatch check; matching
 _set_drvdata() & _get_drvdata()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robo Bot <apw@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 3:16 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/20/20 12:54 PM, Alexandru Ardelean wrote:
> > On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >>
> >>
> >> On Thu, 19 Nov 2020, Joe Perches wrote:
> >>
> >>> On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> >>>> On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> >>>> <ardeleanalex@gmail.com> wrote:
> >>>>> Hey,
> >>>>>
> >>>>> So, I stumbled on a new check that could be added to checkpatch.
> >>>>> Since it's in Perl, I'm reluctant to try it.
> >>>>>
> >>>>> Seems many drivers got to a point where they now call (let's say)
> >>>>> spi_set_drvdata(), but never access that information via
> >>>>> spi_get_drvdata().
> >>>>> Reasons for this seem to be:
> >>>>> 1. They got converted to device-managed functions and there is no
> >>>>> longer a remove hook to require the _get_drvdata() access
> >>>>> 2. They look like they were copied from a driver that had a
> >>>>> _set_drvdata() and when the code got finalized, the _set_drvdata() was
> >>>>> omitted
> >>>>>
> >>>>> There are a few false positives that I can notice at a quick look,
> >>>>> like the data being set via some xxx_set_drvdata() and retrieved via a
> >>>>> dev_get_drvdata().
> >>>> I can say quite a few. And this makes a difference.
> >>>> So, basically all drivers that are using PM callbacks would rather use
> >>>> dev_get_drvdata() rather than bus specific.
> >>>>
> >>>>> I think checkpatch reporting these as well would be acceptable simply
> >>>>> from a reviewability perspective.
> >>>>>
> >>>>> I did a shell script to quickly check these. See below.
> >>>>> It's pretty badly written but it is enough for me to gather a list.
> >>>>> And I wrote it in 5 minutes :P
> >>>>> I initially noticed this in some IIO drivers, and then I suspected
> >>>>> that this may be more widespread.
> >>>> It seems more suitable for coccinelle.
> >>> To me as well.
> >> To me as well, since it seems to involve nonlocal information.
> >>
> >> I'm not sure to understand the original shell script. Is there
> >> something interesting about pci_set_drvdata?
> > Ah, it's a stupid script I wrote in 5 minutes, so I did not bother to
> > make things smart.
> > In the text-matching I did in shell, there are some entries that come
> > from comments and docs.
> > It's only about 3-4 entries, so I just did a visual/manual ignore.
> >
> > In essence:
> > The script searches for all strings that contain _set_drvdata.
> > The separators are whitespace.
> > It creates a list of all  xxxx_set_drvdata functions.
> > For each xxxx_set_drvdata function:
> >      It checks all files that have a xxxx_set_drvdata entry, but no
> > xxxx_get_drvdata
> >
> > I piped this output into a file and started manually checking the drivers.
> > There is one [I forget which function] that is xxxx_set_drvdata() but
> > equivalent is xxxx_drvdata()
> >
> > As Andy said, some precautions must be taken in places where
> > xxxx_set_drvdata() is called but dev_get_drvdata() is used.
> > Cases like PM suspend/resume calls.
> > And there may be some cases outside this context.
> >
> Doing something like this with coccinelle is fairly easy.
>
> But I'd be very cautious about putting such a script into the kernel. It
> will result in too many false positive drive-by patches. Such a script
> will not detect cases such as:

Yeah, it would probably be a good idea to start with a few simple
checks, then scale it.
If we go for the existing _set_drvdata() / _get_drvdata() pair checks,
there is a risk of breaking things.

>
>   * Driver is split over multiple files. One file does
> ..._set_drvdata(), another does ..._get_drvdata().
>
>   * Framework uses drvdata to exchange data with the driver. E.g driver
> is expected to call set_drvdata() and then the framework uses
> get_drvdata() to retrieve the data. This is not a very good pattern, but
> there are some palces int he kernel where this is used. I believe for
> example V4L2 uses this.
>
> - Lars
>
