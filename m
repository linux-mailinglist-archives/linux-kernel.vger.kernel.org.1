Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B022BA9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgKTL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKTL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:59:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2197EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:59:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id t13so8336061ilp.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8htsfEW+bcedsDdsedrZxpDWxJcl6/ddkcCxJR7FWc=;
        b=L4eFMAF7iR2JjO0+0NEvwWRnZFWzt9hi6Nh/2Osl20k3Ou7e4KVF/VBSoow10XtU6k
         tfg13sY70YfjZJ512ez7noPtKrQ9ZavXwSOaRg7wwE8F8wSllILVbBKCyru7MjUvhVK4
         iOKq546n3dl2QIcmUY8z31UIj8dz0GT1R0ePuKUHexnhkt0imclaQAsnFeBePp9umoQ7
         Coci33Ym4Rq4cz8T50wJKv4lpGk4rPWe2BjVSjy6K8WxALd2klZuiK0WSyMu8TEdRKOL
         r9dOXBdq1WW8DNjqqNal1M+VFVQpykYp6Meormc/fd66F1NxbktkeE5LsjaW1jY+5YNb
         aYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8htsfEW+bcedsDdsedrZxpDWxJcl6/ddkcCxJR7FWc=;
        b=mMVxLlSX3xGOn3wBnagZL8Bq4Q2AJW+e/XrGk6iKTVeIeRua7/AEapLcosyl48Kqy8
         r2tsfMFP7KnuEdULhr2JlIufWSEDuPxMhpWyqSXIo/KP2eUOCAXhgNJqczfJGZZa9aIB
         KuJdVOZUK/YThrB0JIKp6clm59+bLUowxUt0oZj3MhdV5/jW5ab3iUaOemzPbsghgRRu
         9zJMcx8DxCkzRdO+2JF2MSlt8WrT1T7HjrQe57xNIRWFx+rICEyexlxvSFWIpP7Wwbrp
         swmKsoBVh8SoolKO8jMse0KylcoE8F0ZVuTajtyrm0GDppoBjlhNY9rbf5w9ITS12v+M
         OuhA==
X-Gm-Message-State: AOAM531NcHFFHQaxTqHj1988SocIU/uebBbCiXkZNDZZjCwCC92tUmr/
        bdl4Magyf3+PN//QzN9ykTbTSv/5UGc/UT61CQE=
X-Google-Smtp-Source: ABdhPJxbKDy2FtUrKvfy454WCF6aitL5ITooSSyN3IvnXlCVxPbLtmxUbkGmLk5PLcXjP1Cdavr21W2SPWszUj4C/UM=
X-Received: by 2002:a92:c844:: with SMTP id b4mr25962195ilq.292.1605873543474;
 Fri, 20 Nov 2020 03:59:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien> <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
 <alpine.DEB.2.22.394.2011201256150.2750@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2011201256150.2750@hadrien>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Nov 2020 13:58:52 +0200
Message-ID: <CA+U=DsoS3y46Y37Uc85w_CUgDjcLqDCKyOF7CwEvoX7D=UnUFA@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 1:57 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 20 Nov 2020, Alexandru Ardelean wrote:
>
> > On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Thu, 19 Nov 2020, Joe Perches wrote:
> > >
> > > > On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > > > > <ardeleanalex@gmail.com> wrote:
> > > > > >
> > > > > > Hey,
> > > > > >
> > > > > > So, I stumbled on a new check that could be added to checkpatch.
> > > > > > Since it's in Perl, I'm reluctant to try it.
> > > > > >
> > > > > > Seems many drivers got to a point where they now call (let's say)
> > > > > > spi_set_drvdata(), but never access that information via
> > > > > > spi_get_drvdata().
> > > > > > Reasons for this seem to be:
> > > > > > 1. They got converted to device-managed functions and there is no
> > > > > > longer a remove hook to require the _get_drvdata() access
> > > > > > 2. They look like they were copied from a driver that had a
> > > > > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > > > > omitted
> > > > > >
> > > > > > There are a few false positives that I can notice at a quick look,
> > > > > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > > > > dev_get_drvdata().
> > > > >
> > > > > I can say quite a few. And this makes a difference.
> > > > > So, basically all drivers that are using PM callbacks would rather use
> > > > > dev_get_drvdata() rather than bus specific.
> > > > >
> > > > > > I think checkpatch reporting these as well would be acceptable simply
> > > > > > from a reviewability perspective.
> > > > > >
> > > > > > I did a shell script to quickly check these. See below.
> > > > > > It's pretty badly written but it is enough for me to gather a list.
> > > > > > And I wrote it in 5 minutes :P
> > > > > > I initially noticed this in some IIO drivers, and then I suspected
> > > > > > that this may be more widespread.
> > > > >
> > > > > It seems more suitable for coccinelle.
> > > >
> > > > To me as well.
> > >
> > > To me as well, since it seems to involve nonlocal information.
> > >
> > > I'm not sure to understand the original shell script. Is there
> > > something interesting about pci_set_drvdata?
> >
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
> >     It checks all files that have a xxxx_set_drvdata entry, but no
> > xxxx_get_drvdata
>
> OK, but I have the impression that you want to ignore pci_set_drvdata for
> some reason?  Or did I misunderstand?

Yes. See difficultly visible double quote :P
'  "pci_set_drvdata   '
Apologies for the confusion

        if [ "$fn" == '"pci_set_drvdata' ] ; then
                continue
        fi


>
> julia
>
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
> >
> > >
> > > julia
> >
