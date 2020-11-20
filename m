Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F612BA99F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKTLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKTLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:54:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFCEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:54:32 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n129so9617971iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBQOAYOM9U2wwOrK1ihvhs1ugJGYUlTe1HU6Sz1u0+c=;
        b=T/j74qzyTZ77/gaCQZO621EluFS5ggjbWf5urNp57XMhD5tD7d2G7xbMuVU/svCEOF
         f8HHE2FZji6KJlrPKk+gRB9db8F5EofKkb+sXmsDjFZ+IM5Kewvt9F/cTzIjaC8gQ6ql
         /g19zd/aRZV22nMZ5dY42p9OeSaUDAgcEuPpDIh4XeLZeg47fpJDqZrroT+Q0Lyu7plr
         fwjBRyTLAL2GHCH2QRLMBxqy7rZgKpL0SYmZ4rV1gbQssRa88QdoeJU3XHSgQWDZB15L
         G6Y7iIFFAtr1sVxREV8h1mezsiuFrdSEN545ukb1c73qcuIX7auyceBArXj0YBuShlGS
         mJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBQOAYOM9U2wwOrK1ihvhs1ugJGYUlTe1HU6Sz1u0+c=;
        b=GjSnuQWUiqDvW54a16PvWHzQ4orNHycjv44yyqMAngKhK99m4bnQ75G6TMNiw7MT4q
         cwnc7ukQ8OMvMdg1kZFl7b7T9I7kU4gPdj5Hm+/qGTwIN8oQt0xDYUzxZ13FdIK01JWZ
         zSRXUs40VsyqJk8SkIgOr9wr8oEdy7TMqqp/NEV568Lmjd5+Rt0/jYEHmBtzJ2llc4Yp
         OPpzZuQ+ZJOxN1qsmh0BJLAzt3ctte91VPiJQer8c8/cN+HqslNnoTc1bgnxxw+iK6ta
         uPOVsPTqUpwcRcnZB78NVcweLhCV7vJja6yRFMhOQW0aDJkOMm0itgbnrHTxv7In5gYS
         rU+g==
X-Gm-Message-State: AOAM532v1pC4BvgKyNz0DTCgXN4W+++LwkYNDVHvgtT7/qPFPXRcakBk
        hFL6naxXOLfZmHXPgA0I+9x9FPmDWnH7p2xBBOc=
X-Google-Smtp-Source: ABdhPJxV4Cv4eYJOWb112LXcxmMu1+YXT3+h46C0waaOJ6v5tSncgYifjH0IKn7iyEjNPJ9DTnGfJMkf9XaV9zMqNxo=
X-Received: by 2002:a02:c547:: with SMTP id g7mr18483628jaj.88.1605873271453;
 Fri, 20 Nov 2020 03:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com> <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Nov 2020 13:54:20 +0200
Message-ID: <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
Subject: Re: [Cocci] Proposal for a new checkpatch check; matching
 _set_drvdata() & _get_drvdata()
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robo Bot <apw@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 19 Nov 2020, Joe Perches wrote:
>
> > On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > > <ardeleanalex@gmail.com> wrote:
> > > >
> > > > Hey,
> > > >
> > > > So, I stumbled on a new check that could be added to checkpatch.
> > > > Since it's in Perl, I'm reluctant to try it.
> > > >
> > > > Seems many drivers got to a point where they now call (let's say)
> > > > spi_set_drvdata(), but never access that information via
> > > > spi_get_drvdata().
> > > > Reasons for this seem to be:
> > > > 1. They got converted to device-managed functions and there is no
> > > > longer a remove hook to require the _get_drvdata() access
> > > > 2. They look like they were copied from a driver that had a
> > > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > > omitted
> > > >
> > > > There are a few false positives that I can notice at a quick look,
> > > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > > dev_get_drvdata().
> > >
> > > I can say quite a few. And this makes a difference.
> > > So, basically all drivers that are using PM callbacks would rather use
> > > dev_get_drvdata() rather than bus specific.
> > >
> > > > I think checkpatch reporting these as well would be acceptable simply
> > > > from a reviewability perspective.
> > > >
> > > > I did a shell script to quickly check these. See below.
> > > > It's pretty badly written but it is enough for me to gather a list.
> > > > And I wrote it in 5 minutes :P
> > > > I initially noticed this in some IIO drivers, and then I suspected
> > > > that this may be more widespread.
> > >
> > > It seems more suitable for coccinelle.
> >
> > To me as well.
>
> To me as well, since it seems to involve nonlocal information.
>
> I'm not sure to understand the original shell script. Is there
> something interesting about pci_set_drvdata?

Ah, it's a stupid script I wrote in 5 minutes, so I did not bother to
make things smart.
In the text-matching I did in shell, there are some entries that come
from comments and docs.
It's only about 3-4 entries, so I just did a visual/manual ignore.

In essence:
The script searches for all strings that contain _set_drvdata.
The separators are whitespace.
It creates a list of all  xxxx_set_drvdata functions.
For each xxxx_set_drvdata function:
    It checks all files that have a xxxx_set_drvdata entry, but no
xxxx_get_drvdata

I piped this output into a file and started manually checking the drivers.
There is one [I forget which function] that is xxxx_set_drvdata() but
equivalent is xxxx_drvdata()

As Andy said, some precautions must be taken in places where
xxxx_set_drvdata() is called but dev_get_drvdata() is used.
Cases like PM suspend/resume calls.
And there may be some cases outside this context.


>
> julia
