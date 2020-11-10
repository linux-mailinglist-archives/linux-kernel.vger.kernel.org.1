Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97372AE07C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgKJUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:08:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC918C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:08:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so10187704wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+aRaf/umltBKE+6wKwCltWBTDsHe6mFK5nuqJMfHRM=;
        b=AT7A+sdzPTebSa8CRPKagqX5MZY14t7gK6NGGqSdR7qAhUjMzNXYlJBQ6hjpk7v1wM
         BAYpLc4Bm2ztIC+0pH9PK/lzqxNzvtrboUOiQR4nTPh8tmEVWqyVESEqLWvlfWxuvmhn
         57yB0LUlyGh/qrr54mGQzHNMO5a2KDm4j5Y5RtNftz/Dm64LT3ISGsgeJOBYgkG6eBwa
         9JVIRcKLc7VM1yq/XOyY5D60scIF1p+iLGHYzs0DzruASiViVMz1DExZonwRXNJNXChk
         SyMaxz7KbD2K6lJ32lQJViaCbmvLljOzB2/SfL7O2Zu+Y8+p+5Y3uIExfmkwdvfH5trI
         BLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+aRaf/umltBKE+6wKwCltWBTDsHe6mFK5nuqJMfHRM=;
        b=XI/i5YJpOTv1/TWWjPi4g66mPpxxF1FNbomJNht12Q6nt9w0VfMX1hODcLINT70wpg
         Hnu/44rQmaXC3h+81XifPXpNIWuF/wc/r9UU0yYZUSTLovbk1/cs0nR3UE+EbI2J9ETU
         oxA/N34KCBECiPI3n/cY8G2xpeNizugV/CEAz7H9lAS0Vyhegkt1NRZl22TeVAduW4Fg
         9+U1op+RnAXFg2FmPF/fqyiQAX4qe1StvkJxVGLPP3yupvpFHftSbnL6BUobIIIa8hlj
         7sVMiQwlA1mljvYjLYecKmMju7B7OCrX7RbhgJgd0+eWcjKQLX+vTWM5o/oLyAl8F2Gu
         UvbQ==
X-Gm-Message-State: AOAM532IIxO1ptFxIq+QLUqwvgbwXgxPA9gPnjX9CpmbYMBdoIikj2BR
        OFgAPDy5BWa9Briy+tmdYzxxSXcW6g9UZ7ORik4=
X-Google-Smtp-Source: ABdhPJwrSX9xukmOEZt2t2UgYrm/3CRwEzEeuKzkuwExrEkQQhfxYFbx4SD1FE77XopCiFFi8l8EdIAeX1AKCRVCXXg=
X-Received: by 2002:adf:e551:: with SMTP id z17mr26546390wrm.374.1605038931452;
 Tue, 10 Nov 2020 12:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org> <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
 <20201110072242.GF2063125@dell> <20201110090247.GB2027451@ravnborg.org> <20201110094111.GG2063125@dell>
In-Reply-To: <20201110094111.GG2063125@dell>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 15:08:40 -0500
Message-ID: <CADnq5_PYERS0xHJGQrpokDD7q3GgidSYqSrOoskza7gST4bbmQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 4:41 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 10 Nov 2020, Sam Ravnborg wrote:
>
> > Hi Lee,
> >
> > > > the *d.h headers are supposed to just be hardware definitions.  I'd
> > > > prefer to keep driver stuff out of them.
> > >
> > > That's fine (I did wonder if that were the case).
> > >
> > > I need an answer from you and Sam whether I can create new headers.
> > >
> > > For me, it is the right thing to do.
> >
> > Please follow the advice of Alex for the radeon driver.
>
> Great.  Thanks for resolving this Sam.
>
> Will fix all occurrences.

I'm not really following these patch sets you are sending out.  They
all seem completely independent.  I was expecting updated versions
with feedback integrated, but they seem to be just different fixes.
Are you planning to send out updated versions based on feedback from
these series?  Also, some of the patches have subtle errors in them
(e.g., wrong descriptions of variables, wrong copyright headers on new
files, etc.), do you mind if I fix them up locally when applying or
would you rather I point out the changes and you can integrate them
and resend?

Thanks,

Alex

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
