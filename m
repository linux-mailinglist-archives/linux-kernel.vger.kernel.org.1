Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A52AE148
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgKJVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:02:28 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00262C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:02:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so3053721wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/4ivGjpOSzxr0bVTtrL/2oAHyb/02RtqaNu/H/vaQ4I=;
        b=Hm+BKMpx9UbZ/qHsQxtcxkqgo5nuU8Qd7EQLcSjhtJuBqKRh6U8HWodSY29Lle6X/L
         EcB03W8Lp1W4LPCk3xp8QA4mDbeCUxLbnpzwvBznApIH+zwGEdgJuFc16smVv0oe6frp
         s33ebO3415h5vzDyDvEoVXIJlwpAtHpNmuZ5cHq5vTVIoLMexGgEfe+oPtubX2SGnDEg
         rDYMm2aoMUiEEjbXPVU+1GRvbVbsigoeLlJ9zdb740gGgLEtR/EwbUJz2vDXi32iI0cd
         TXbBTpg65bQhHAiLKIvkCw9HfWiXOlNizbLnxhtD3cV4ZwzmJoyctBjHBHnpFRUVOWCi
         T7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/4ivGjpOSzxr0bVTtrL/2oAHyb/02RtqaNu/H/vaQ4I=;
        b=c6L00kfamYa0SweC2OmJYs/L1IQxJzWYcgYMr2h4uCD4dxMsKbR6LohYA4nl09gsXP
         aB76ph9EfQIXt5sGAYWoeW5O2h+TJConBeFxntl7LhWSh18JHsETfrKnMMFABPoE22kK
         pfpmKDcsVMORyMp23mY7s/z/HtRzQM3gp18QeTCGeG4qFyfMdAsxJh+6BLWjpSUht6BO
         re5ixYGrWHbWGDCECza8dAO6fvZV5VFKhXwM4BGe4spi00lGlPYEefp9BO8+fsztsQep
         6v4SirqZlPQf2fKdanqcs6BBN8WpVvoXyAGkYJRy/yHeVrWriDECY1OjFDHNNIfyj4B0
         Wjeg==
X-Gm-Message-State: AOAM533V/iNaWGdiFoY9kHiIvldxQRDGIvyssxGtjZCa1c3BFuXFsrip
        WbiOGx2T8FRDwWTETt2Stg6pHQ==
X-Google-Smtp-Source: ABdhPJy+bbCKjuEncDG1+ba9fnm9l07+jxcwHagMasg+krtBAelC9qSpYEiV3tnmoNKjXce+XpYKaw==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr1125571wma.39.1605042146708;
        Tue, 10 Nov 2020 13:02:26 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 18sm61004wmo.3.2020.11.10.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:02:26 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:02:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
Message-ID: <20201110210224.GJ2063125@dell>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org>
 <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
 <20201110072242.GF2063125@dell>
 <20201110090247.GB2027451@ravnborg.org>
 <20201110094111.GG2063125@dell>
 <CADnq5_PYERS0xHJGQrpokDD7q3GgidSYqSrOoskza7gST4bbmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PYERS0xHJGQrpokDD7q3GgidSYqSrOoskza7gST4bbmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Alex Deucher wrote:

> On Tue, Nov 10, 2020 at 4:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 10 Nov 2020, Sam Ravnborg wrote:
> >
> > > Hi Lee,
> > >
> > > > > the *d.h headers are supposed to just be hardware definitions.  I'd
> > > > > prefer to keep driver stuff out of them.
> > > >
> > > > That's fine (I did wonder if that were the case).
> > > >
> > > > I need an answer from you and Sam whether I can create new headers.
> > > >
> > > > For me, it is the right thing to do.
> > >
> > > Please follow the advice of Alex for the radeon driver.
> >
> > Great.  Thanks for resolving this Sam.
> >
> > Will fix all occurrences.
> 
> I'm not really following these patch sets you are sending out.  They
> all seem completely independent.  I was expecting updated versions
> with feedback integrated, but they seem to be just different fixes.
> Are you planning to send out updated versions based on feedback from
> these series?  Also, some of the patches have subtle errors in them
> (e.g., wrong descriptions of variables, wrong copyright headers on new
> files, etc.), do you mind if I fix them up locally when applying or
> would you rather I point out the changes and you can integrate them
> and resend?

Apologies for any confusion.  Let me try to shed some light.

All 4 sets sent thus far have been independent.  There are 5000 issues
to solve in drivers/gpu - I'm trying my best to whittle them down.
We're down to 2200 right now, so it seems to be going well.

I'm aware that some of the patches have been accepted already, so the
plan is to wait a few days, let them settle into -next, then start;
rebasing sets, applying fix-ups and sending out v2s.

FYI: There are also outstanding rebases due for; wireless, net, input
and SCSI, as well as the 4 DRM sets.  I'm getting to all of them.

With regards to how you deal with incorrectness, that's entirely up to
you.  Feel free to either fix-up any issues you see or to provide
review comments and let me deal with it.  Whatever works for you.

A note on copyrights on new files; the new files are copied directly
from old, previously accepted/currently residing ones in order to keep
in-line with what's expected of the subsystem.  If the format has been
updated and/or you would like them modernised, please either fix them
up at your leisure or let me know what's required and I'll rework and
resubmit them.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
