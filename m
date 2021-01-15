Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B92F784C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbhAOMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbhAOMGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:06:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9DC061757;
        Fri, 15 Jan 2021 04:06:08 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q1so17583435ion.8;
        Fri, 15 Jan 2021 04:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=na1PUSYsGVLnNX7HLmjyBX8gmNyghDEM4Z5I4FTRdlA=;
        b=WZvYRJ3RiaZHZgJyc9mNLm2rnOzE8QOVDq965/Rm3DixSxMc+EVIFsld+OmVkbkCUY
         cH87kbyfcuKVxTuetQ+25uSc6lBZkOvX1HFipZOBkP3CUEnUk007zb0DgVr2Adib1cNt
         crKTFcgGylH8S20V4gjS6enWt5riRX8B6nig76GpTINmMU9Tc8omexlNms6d5i/DJOPE
         3yZt/jCJyavsnTujdGtlY2nPc+eraszYh5B8JVLSmWfJZp+czzm+LZw5mcwILubhVcDk
         U7CLWOn//ZQS6hnHyuFrG2/EjmUpSj288nARBgIZCAvEgA2ajm7ngWLlv/rdN7j/zXKF
         KgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=na1PUSYsGVLnNX7HLmjyBX8gmNyghDEM4Z5I4FTRdlA=;
        b=inHPXFh+HloetPA+PEw4t3CYb8VJHYe3Up67mAPNUZlovhiqFMt6fir6JrZv7ieLwu
         YCsx8/fQCcq1g20nddJQCO2x3hQMyjrZ3DRlbsP6ry0MSQZ8V3exY1og3Z7SbigczvG9
         +0APBF+d4dOvsS3BiNYwEjTD30e++qctQU/8hXd/vZ7pLpvAE+gJ7mpw4vZ5eoCR4gQD
         jmPNnL0N+/ZPuWD7Y36brTa5ez+Lc2sptzj0Pckwz6B5+SbXzPSSpIdg5muqMvaQrQLI
         WaNn+suKoAUtOPFbuhoigbQCY3kYSHX/B2gC99V86QF5TaXrefCIdaNChRSO1rR9xPYv
         V4Hw==
X-Gm-Message-State: AOAM533WrkkKLHsirAzvCyFQO89fd1O53ObWYPzbQzxinwuzvxazNtzx
        jlv23YwrJzdx1Js7PVBFekyBhJyEHXAtNxTSYTc=
X-Google-Smtp-Source: ABdhPJxxAJKcnZHUMm9cZ8ePtFoOwNf/v7mPgWKulE4JiANqv5qr69rplXZAYNH9UdfBqE4zyJxfRXjMlHE7xIVGRMM=
X-Received: by 2002:a92:cd8c:: with SMTP id r12mr10192718ilb.221.1610712367656;
 Fri, 15 Jan 2021 04:06:07 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
 <20210115104947.71d99e87@coco.lan>
In-Reply-To: <20210115104947.71d99e87@coco.lan>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 15 Jan 2021 13:05:56 +0100
Message-ID: <CAKXUXMxRp4tRbMi4+P6pW4Zom7vZ0hfAWX47+aQ7nunLmyYpUQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:49 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Lukas,
>
> Em Fri, 15 Jan 2021 07:12:38 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
>
> > [reduced the recipient list to the main responsible ones and list]
> >
> > Hi Mauro, hi Jonathan,
> >
> > We both, Mauro and I, have been submitting patches to address the
> > documentation warnings on linux-next. If it is okay with you, Mauro, I
> > would like to take responsibility for the task to send out the patches
> > to address all warnings on linux-next in make htmldocs and follow up
> > with all the discussions. I can also provide a short weekly summary
> > (probably always on Friday) on what is pending where and what I could
> > not resolve by myself.
> >
> > Is that okay for you?
> >
> > If at some point I do not have the time to take care anymore, I will
> > let you know.
>
> Yeah, sure!
>
> Anyway, after applying the patches I sent this week, the warnings
> I'm getting are all due to the validation scripts I wrote. So, if
> everything gets merged (either yours or my version), we'll have zero
> Sphinx/kernel-doc warnings again.
>

It is a never ending story... I already have seen two new warnings on
today's linux-next and sent out patches.

> $ scripts/documentation-file-ref-check
> $ scripts/get_abi.pl validate

I will also try out those two scripts, but I cannot commit to
follow-up on all of those yet. I am also looking into addressing all
kerneldoc warnings, even if not pulled in by make htmldocs.

Lukas
