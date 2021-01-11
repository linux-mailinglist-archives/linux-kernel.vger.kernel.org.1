Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC32F1F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403907AbhAKTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbhAKTbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:31:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FA6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:30:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id c132so325892pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qo2fQAXd+OsMiLPHSUfSpNVkpbDbRR3kE8tJYakNl9E=;
        b=ax0g20+io9+hknWBPpMxAQv86e3BV9BnGMFgIqXJ9pFv1sGGayp8i3795ZIxSkMX8w
         sbhmLQZbNam8/SGqG8EAQzIj2k55phmPp6LF3oUCv0Ys+SZvKDJPdZpq7/YAVAXY8s62
         c+LidHl99KI5JXqsljDZrcrpJPEMVXH4vAL6MtI56FSRor4vCDSD3vv0bg3IWq5cVANZ
         GLDHUEO3zwD0hgxSKUdlCf1dsNIbmaiekqEHoyzlSXmDfWpvhMESBCOXOTlLrxsfjlJv
         Y8Y43ATIACr24S3GqGb6p3pg5RaYkhN0eHtAvg/DD7XAGQCRN6gUP267twpShI2WGMvP
         QX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qo2fQAXd+OsMiLPHSUfSpNVkpbDbRR3kE8tJYakNl9E=;
        b=g5fWgT2pso2pq2ZNhmyW5AnqOYSk1+JxM2eWJWP4Nfltn1MEg3uf1GKwcJHfRqPJ4B
         b1LLiGf6wzSOwAqiXwMINOm4g/2LxY7k49rJGSHFHVe709iHlKFEYTGk9FtgKtKokEYB
         JUve20x64+7B2aT1AzWcIaZay0a7JpGHWbIIq4Ul9lv8LfOMMYmM897TdNbJvnscgpxQ
         R1/qd+4VPH8ITqFX3gpPVwqcbIyjjlAIB0Jw+0DrutLKmWK51QjDZ2aoatNVxHxr0H2l
         fi5W/LzkYd5zYiwzQqkWUHnwwiYyalTdmMuWteOVbakLroYnvjZP32c2fZv4HOksJyca
         WtCA==
X-Gm-Message-State: AOAM531dfayVl9Fcp0kkkqFpWn9zswO7FAkgCD7PRVoM7JtX263hxjNn
        iLflsMPc/0Ka++TnL5AsP/FNp6a+9Hc1Ii/u/Yvuuw==
X-Google-Smtp-Source: ABdhPJxfnVekwDDs7W26tTKMU0LtLEZSR7eufar20rcVzDPc4DtJT/9lOoaOHA5Sf6AozuXRQZaWL4OnIHnX0NlzO/4=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr927134pfh.24.1610393439604; Mon, 11 Jan
 2021 11:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20210108040940.1138-1-walter-zh.wu@mediatek.com>
 <CAAeHK+weY_DMNbYGz0ZEWXp7yho3_L3qfzY94QbH9pxPgqczoQ@mail.gmail.com>
 <20210111185902.GA2112090@ubuntu-m3-large-x86> <CAAeHK+y8B9x2av0C3kj_nFEjgHmkxu1Y=5Y3U4-HzxWgTMh1uQ@mail.gmail.com>
 <20210111191154.GA2941328@ubuntu-m3-large-x86>
In-Reply-To: <20210111191154.GA2941328@ubuntu-m3-large-x86>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 11 Jan 2021 20:30:28 +0100
Message-ID: <CAAeHK+x5VaQ5U4G0pei7Bzf6CWcz+BqADj411rd9P6b=j4uNvw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: remove redundant config option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 8:11 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 08:03:29PM +0100, Andrey Konovalov wrote:
> > On Mon, Jan 11, 2021 at 7:59 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > > > -config KASAN_STACK_ENABLE
> > > > > +config KASAN_STACK
> > > > >         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> > > >
> > > > Does this syntax mean that KASAN_STACK is only present for
> > > > CC_IS_CLANG? Or that it can only be disabled for CC_IS_CLANG?
> > >
> > > It means that the option can only be disabled for clang.
> >
> > OK, got it.
> >
> > > > Anyway, I think it's better to 1. allow to control KASAN_STACK
> > > > regardless of the compiler (as it was possible before), and 2. avoid
> > >
> > > It has never been possible to control KASAN_STACK for GCC because of the
> > > bool ... if ... syntax. This patch does not change that logic. Making it
> > > possible to control KASAN_STACK with GCC seems fine but that is going to
> > > be a new change that would probably be suited for a new patch on top of
> > > this one.
> >
> > The if syntax was never applied to KASAN_STACK, only to
> > KASAN_STACK_ENABLE, so it should have been possible (although I've
> > never specifically tried it).
>
> CONFIG_KASAN_STACK was not a user selectable symbol so it was always 1
> for GCC.

Ah, indeed.

Thanks for the clarification!
