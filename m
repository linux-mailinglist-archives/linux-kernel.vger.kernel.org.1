Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C92D49AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgLITA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgLITA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:00:56 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4173C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 11:00:15 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id b18so2437565ots.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pG0gcuo9xEY2L/FAHV4bggSQ0KrdHynw2Uo10jca5Xk=;
        b=qVYCs76SZZySaqRu0eNDle3ruqCzKVJEySpCcfl+Xwx2/SMimVGrxw7+JaB0VpzxEU
         iztcoAGD//PQN+ZUh1tuc3isQJ905LHmgYeiH6Bzc0mTUeYtxGreKEk8uehYrKl5KasG
         a0mrVH8PKdm2VSTYHM1PWlV5vQxMBE86fpI/RUWW2hAOZm1eaQ4lLQTx+Q2dI9w5zHiM
         JA3mb20kisiJLsXbqwmOCS5Q50o+aSR13cS8olNJD1LGHYW9PJA01fcu58xYhrHE26YU
         bCTrts9SQHnB1ZGWRd2JRNBajtb75ygIVfpC86MELEKjahChUQrnfg+V+6xxbuCJ7VRo
         hgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pG0gcuo9xEY2L/FAHV4bggSQ0KrdHynw2Uo10jca5Xk=;
        b=jXukOOcKLcyA4tAjjtno11D9gwdj0EBZcinTMN56VaUw8w/sLNeqs1tXaDTGW17r9m
         z1ZARMUzZpOS0v1QkZyps5uQrAucVtdnTKJ75foxNSWMzrI89OczE+uKAiLE7xUMU9H0
         QMU/3ClVujOC3wvpOBccDYIZexp3X1spwGloF9wqJERrS3dIqJOU24fCX/upmQlmbDuN
         JmXuUQdGgvEmv/lfzQxJyyTP93v7ec4qOXg9+8o3fKOghcw0UqAwxPPXjCxol2YmfM36
         //vUjV26wRd4mt1DH3oxcgzYQxiJwd5V4+PG9PE8MuO06IPMFOHjw1O7OQ6bqT5eazfk
         X9tA==
X-Gm-Message-State: AOAM531G11kBJQnNqnTHtUghY2VAeygyhdR3EIS7fBTWycAg+DCp36yT
        3gJZ/c8s5kfqhh12Q63N+F+ZblYNTQpZKOj2Jq5Qdg==
X-Google-Smtp-Source: ABdhPJyToUKjQUeQ30m5HrXBl1dbn2qFLJY/z0NfIzE5Brxz7x13+SArwW5cZUmfFj0cqVAGkanaYzoZPB5RjNEFHeo=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3046880otk.251.1607540414777;
 Wed, 09 Dec 2020 11:00:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607537948.git.andreyknvl@google.com> <f2ded589eba1597f7360a972226083de9afd86e2.1607537948.git.andreyknvl@google.com>
 <CANpmjNMf1tOYTFojUQrHoscFxPPEed_vkBufgxVLduQ6dBvCUA@mail.gmail.com> <202012091057.50DEDCC@keescook>
In-Reply-To: <202012091057.50DEDCC@keescook>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Dec 2020 20:00:03 +0100
Message-ID: <CANpmjNPwmmvFzQW1Cv2kmphwPc7fC2MKdFLRgD+Ht5-ivzxp2Q@mail.gmail.com>
Subject: Re: [PATCH mm 1/2] kasan: don't use read-only static keys
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 19:57, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 09, 2020 at 07:49:36PM +0100, Marco Elver wrote:
> > On Wed, 9 Dec 2020 at 19:24, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > __ro_after_init static keys are incompatible with usage in loadable kernel
> > > modules and cause crashes. Don't use those, use normal static keys.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > > ---
> > >
> > > This fix can be squashed into
> > > "kasan: add and integrate kasan boot parameters".
> > >
> > > ---
> > >  mm/kasan/hw_tags.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > > index c91f2c06ecb5..55bd6f09c70f 100644
> > > --- a/mm/kasan/hw_tags.c
> > > +++ b/mm/kasan/hw_tags.c
> > > @@ -43,11 +43,11 @@ static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
> > >  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> > >
> > >  /* Whether KASAN is enabled at all. */
> > > -DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
> > > +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > Side-node: This appears to be just a bad interface; I think the macro
> > DEFINE_STATIC_KEY_FALSE_RO() is error-prone, if it can't be guaranteed
> > that this is always safe, since the presence of the macro encourages
> > its use and we'll inevitably run into this problem again.
> >
> > >  EXPORT_SYMBOL(kasan_flag_enabled);
> >
> > DEFINE_STATIC_KEY_FALSE_RO() + EXPORT_SYMBOL() is an immediate bug.
> > Given its use has not increased substantially since its introduction,
> > it may be safer to consider its removal.
>
> Right -- it seems the export is the problem, not the RO-ness. What is
> actually trying to change the flag after __init?

It seems to want to add it to a list on module loads:
https://lore.kernel.org/lkml/20201208125129.GY2414@hirez.programming.kicks-ass.net/

-- Marco
