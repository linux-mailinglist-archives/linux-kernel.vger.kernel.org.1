Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA882AF8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgKKTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKTFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:05:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D911C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:05:10 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n11so3179814ota.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqQUt8nF2kgPMW+WfpdEe9JIcv1VB4HVulAU3CTX4MU=;
        b=IHIZ/9tFgR6oUqI2s20AR2vQEbvYVpaiSYLJuPVf3iwe2ZQV1VwFJ9+pAW89ziWPTO
         9dlpBiurvBMFq0/RivSJhV1RO9wMucn8oyQ/k8VPIc0KiK+mL+wcfVOwXQAYdACEdDiy
         Z1EtjzXKr4mVitKEWIKdU9HTi2vZdEXGthD/g42ZTPEfS/pgLTCxhjwev1uXzFhoO+WO
         5PC2y9Kp0PNdwULAeFnTowPwEyAVV7srzimiCunf/CzRr+vzc+SoT5gnQGNjiQIxLC9o
         5K1alRUaaVRVStwgo/41+Sxg8AIJE0nGGsCWwN6EgKZZ+dsBOyp8oawS5ER6EBBNZ6xY
         sFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqQUt8nF2kgPMW+WfpdEe9JIcv1VB4HVulAU3CTX4MU=;
        b=j4PXk5dzey0vCGzx7g7AsFZddvw/XC/DQdJphn9PAUzArg6lWlgt0VL18HUV5dqCOK
         7KwGCW2FhF1i0OP/7mZ7j7rmMa1FLjBZrwVQ+Ynltazb+7RzX5kAiDM/dbO8T3asCukJ
         6YPnGeWsQkWrAWCFHPWfomIop0ebwNuSgkqYUeJkeTcmAjdd+9aIxv7WIqQucjWwUBmz
         rBhLaHiIXRnjN/uWpSQMEviR94IhCLrMfKpKAffo366Xs4drvgDmTFDxNT/h0BmQThfV
         VH45ms5Xza1LyTEjKTMc8u8UrdxMyWgeu6dewTuhm9+t2mHK8Ywk2/sefzzWZgopIIMi
         UMTQ==
X-Gm-Message-State: AOAM5312c4BV5+mvmYFZDRMYnN0PvlRRbeNjPjH579mdBJM/1U7fk4Xn
        5ys1WwU8gFkZizN9FVFCyV8YEiIZVDcovwmUaDDT3g==
X-Google-Smtp-Source: ABdhPJxXbQWUGNUMQElrxCpcnrSK7G4S7/uSGvEizPe9UE7YdETr/ssdRHzUaHNu9Qf5AnoDXsJutvt7An4JgEB67kk=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr17412658oth.251.1605121509540;
 Wed, 11 Nov 2020 11:05:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VuM=4axS6ex7_MgCeZ47o+Scon1WuFGStF78T36sHayw@mail.gmail.com> <CAAeHK+xq2tuVYGOPx=_uj08Xwa_1o9Wv-ODrgN3yWXxAgEGV3w@mail.gmail.com>
In-Reply-To: <CAAeHK+xq2tuVYGOPx=_uj08Xwa_1o9Wv-ODrgN3yWXxAgEGV3w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 11 Nov 2020 20:04:58 +0100
Message-ID: <CANpmjNPkUJreN0YRSWB743L-nrJvMObdKXdL_b9pBAK7AaLGVQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/44] kasan: define KASAN_GRANULE_PAGE
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 at 19:48, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 3:13 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
> > > the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN code
> > > to simplify it.
> >
> > What's the physical sense behind KASAN_GRANULE_PAGE? Is it something
> > more than just a product of two constants?
>
> No, just a product.
>
> > The name suggests it might be something page-sized, but in reality it is not.
>
> What name would you prefer?

Is it actually KASAN_GRANULES_PER_SHADOW_PAGE ?   AFAIK we're trying
to calculate the granules that we can fit into a page of shadow
memory.
