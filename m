Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393AC270089
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgIRPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:08:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:08:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so3614059pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGGCKEp4K9GjwoPVxOOO2axTbNb8r7W1/g/yQhmQlPs=;
        b=a/D8P1Joz0DA0/FJh9vDYtQUzeMAdc0qggLrzY6jWIOxmNO2DvPj/y49Qvh4eTgLQc
         bHF2P/99KpphHSf7/FeTwW6wBzd37N1UWctbMT0kH2/zDNYcbd/ci/UZOo0DZt9Hl1pn
         r8Th90dKi/UOmpJXHM+IOw+LX3JZunRHgbWNozufbitsON+c+VT5kQN4uTYN0AQ9GPqp
         BamwWKePpMPAc7L7cbPD0emuHbw86qwA76uswgdArU9NZ88r+YMDRaF76feiH2ra3HXF
         yNd6d7MMReV1w+uuMa19crlNfhXWMLDIV6xXdfpSp/QhLYcH4PleWzMx0IgZFckRFyJ5
         1aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGGCKEp4K9GjwoPVxOOO2axTbNb8r7W1/g/yQhmQlPs=;
        b=ByaaPtLZGsmG3k+sHpuvZ0J43NTvk9T+t1pjxWwmf2c4d1LAOf/ZJITByusntTA+rH
         Dsm6glTXy9/vXnK2NYVkg5zUPqp9QtE8q6XE9SVLt6X8bWN2tyB1xonMkBh6emQb5/it
         8Zk29U02EkYGiOs2ssIfaTs2iyudQriT7zECBmaeXQO9HXCT3gnv3pqu7sqPUiEF8Y3j
         5umDzfmA3KyoAn0NE6bMzRwAcqkfxY81i3SGVRz3HuQHWxbZXMuirkkyRHxkOsZ/aFlp
         2Y9F8USLD/UdBEg3pjRTdFHY1y+kMRn3+jbokdQmsC09wATQNaC31aKi/jN2mxgZrHJA
         bd7Q==
X-Gm-Message-State: AOAM531z5Npfi3UBFZYa5xfdN7BjNoj7rGxSeIKXzu0n6iEgZcrdDv5Q
        kMwJkurFyxeVgmHOyd+WhhB0fVVm5Uxf2z8ZhNGa2g==
X-Google-Smtp-Source: ABdhPJxnj8meNJtzWdHLvtJvvdc2zevWc/WQjbDuyOCDAV/XyUh7CPXZXHlH43Q95yZABuWM1LRrGutx0uprTGvbu3Y=
X-Received: by 2002:a63:5d07:: with SMTP id r7mr14529655pgb.440.1600441689365;
 Fri, 18 Sep 2020 08:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <0a35b29d161bf2559d6e16fbd903e49351c7f6b8.1600204505.git.andreyknvl@google.com>
 <20200918105206.GB2384246@elver.google.com>
In-Reply-To: <20200918105206.GB2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 17:07:58 +0200
Message-ID: <CAAeHK+wqzZJWWh+u3HaLvSAt=4SxaFT4JUgTqzMYcPNGhBFFBg@mail.gmail.com>
Subject: Re: [PATCH v2 31/37] kasan, x86, s390: update undef CONFIG_KASAN
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:52 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> [...]
> >  arch/s390/boot/string.c         | 1 +
> >  arch/x86/boot/compressed/misc.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
> > index b11e8108773a..faccb33b462c 100644
> > --- a/arch/s390/boot/string.c
> > +++ b/arch/s390/boot/string.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #undef CONFIG_KASAN
> > +#undef CONFIG_KASAN_GENERIC
>
> Is CONFIG_KASAN still used to guard instrumented versions of functions?
>
> It looks like #undef CONFIG_KASAN is no longer needed -- at least
> <linux/string.h> no longer mentions it.

I'm pretty sure this is still necessary (something didn't work when I
forgot to make this change), but I'll check again.
