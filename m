Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C742D49AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgLIS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLIS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:58:30 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D246C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:57:50 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u4so1420756plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HbHFCoB8R2U+BDcqEYlrw7gF+YPMUNiEZ6niPgfo8aU=;
        b=cYU5nt87wRIfKVzsnNYau87fOCH5z/sRa7i126s9aDxDevOruw8u0Wun06dvfr8MB4
         BZAVrqG1azlGhSARjEeNsk7FEsiRw8yHKU96+YrUTIjaq+L4gA6028Te9sIqgyK7XVFW
         kq1oLl8XtVSa5BunNWismJAYzWLJMoJ1YfWB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbHFCoB8R2U+BDcqEYlrw7gF+YPMUNiEZ6niPgfo8aU=;
        b=qDFzr5zorS4/2sgk49xgk86LXkiRN0nD0yjvLHbal3lbZw4D1PTxER04Nvu5b7M2xk
         aWNmY8J4RbnhEZelDAWjhyJmYoRWRzm5CUbonAmFrAhljAzKNvgJGlGALlruaO16OfbY
         pCabcPte9vg5HPHBv26i0ZqbzsNHT+kE5eDMu3Fek3HZULwTc3O3BPoXwucN7y3dMI+Q
         dTRHzP3vyB60u8CitYaMmeZVF00PhSrWHFiryOgtptHb5za8Y7ykecGzsDF+e8PYsh+H
         M2bp2xSyxHocd60w2x4a/fc1XdbY6TYnsK4GjqkC2r3J72fNU8Bi5L1Sw1eE91kw+OtC
         8PNw==
X-Gm-Message-State: AOAM5311HhJ7Mqjko2EHvt2OAyHDupfLIzll9dkgosMdbRutkm05ra+G
        CFCH7BrqapAv3xtI3521fEGPSQ==
X-Google-Smtp-Source: ABdhPJw2aa8C8TQ0+dmgkCMPI+5W/moQ9A40sIYwl6R66lVUZVCsXzeGdFRGPrHB712GP6vnJfvpEQ==
X-Received: by 2002:a17:902:bf44:b029:da:d0ee:cef with SMTP id u4-20020a170902bf44b02900dad0ee0cefmr283733pls.12.1607540269922;
        Wed, 09 Dec 2020 10:57:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y21sm3609122pfr.90.2020.12.09.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:57:49 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:57:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
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
Subject: Re: [PATCH mm 1/2] kasan: don't use read-only static keys
Message-ID: <202012091057.50DEDCC@keescook>
References: <cover.1607537948.git.andreyknvl@google.com>
 <f2ded589eba1597f7360a972226083de9afd86e2.1607537948.git.andreyknvl@google.com>
 <CANpmjNMf1tOYTFojUQrHoscFxPPEed_vkBufgxVLduQ6dBvCUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMf1tOYTFojUQrHoscFxPPEed_vkBufgxVLduQ6dBvCUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:49:36PM +0100, Marco Elver wrote:
> On Wed, 9 Dec 2020 at 19:24, Andrey Konovalov <andreyknvl@google.com> wrote:
> > __ro_after_init static keys are incompatible with usage in loadable kernel
> > modules and cause crashes. Don't use those, use normal static keys.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> > ---
> >
> > This fix can be squashed into
> > "kasan: add and integrate kasan boot parameters".
> >
> > ---
> >  mm/kasan/hw_tags.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index c91f2c06ecb5..55bd6f09c70f 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -43,11 +43,11 @@ static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
> >  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> >
> >  /* Whether KASAN is enabled at all. */
> > -DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
> > +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> 
> Side-node: This appears to be just a bad interface; I think the macro
> DEFINE_STATIC_KEY_FALSE_RO() is error-prone, if it can't be guaranteed
> that this is always safe, since the presence of the macro encourages
> its use and we'll inevitably run into this problem again.
> 
> >  EXPORT_SYMBOL(kasan_flag_enabled);
> 
> DEFINE_STATIC_KEY_FALSE_RO() + EXPORT_SYMBOL() is an immediate bug.
> Given its use has not increased substantially since its introduction,
> it may be safer to consider its removal.

Right -- it seems the export is the problem, not the RO-ness. What is
actually trying to change the flag after __init?

-- 
Kees Cook
