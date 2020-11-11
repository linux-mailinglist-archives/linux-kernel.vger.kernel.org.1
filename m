Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42802AF597
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKKP6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgKKP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:58:30 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C8C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:58:28 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so1577579qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPphamhndc5tA5oV0qBp8MU+hvUN5gz++nbj/D+WAKU=;
        b=COznLUbdLfSz+Grag1y0yIGQ7uj9AaH68zxRGnOPXwX/9kMX1e2L4ImQ/EWB6MDkF3
         CFL4LKpTiwhxS2e25iAD/7T29HW/M8AYJnNJbXi9uixKg8J3xvwvr/Zyfq8hI4anMAZ5
         gTTtVxvEPh+31vNaWX9STH37tKHTemkj1MOIcIMvA9C2jq/8eGga+g0nBkKO5uiIUyzk
         LGy9QJTCC+5hvi+XYizh7M3/qL0182XvFtfDGEx7jjXRe6B54VpJD2r4wFjRdUX3faI3
         2ZMKAevaE2GyoJtS6D5M3Fptpuryg4OxqtP0wJWetOP9IFMeuDri0eik24OMY9MLaVHL
         GQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPphamhndc5tA5oV0qBp8MU+hvUN5gz++nbj/D+WAKU=;
        b=Bwlfx0NcuIP97E+EiWA9aaKwxwXm3mDySE3Sf/TKuRNHU+rRSCF0WYa8ria7gpetnp
         nbu001Ko6L+AK+A6TOylS65KewRBKYeGUefXscnbLwcwj9d44+fQbnzDNF3P/CyTjKoT
         KETX41/4L/SC8OWjEBLj2Ka11L+s3MGbKOtB43sB1yh9OLP1vJ4gSKN9JtfsTL+XSOzV
         TfhFgKmY7Xc6C/Cdh5SCg63hIiBHoCqb3ipAET48nRqLarZ7m3SZD11yM0bODL9gtfNL
         pTT6D2uTobhCNgvCQwyTGUr8Cg8pYHEbcpivJ9VRxQQR0xt7IHVGN7Z1a4uTYxLamF3m
         zcVA==
X-Gm-Message-State: AOAM533i59Z0O271g4kP+1NjG9jeYOJYi3hwZuS8pAF4ihux/2G63kQU
        wEZLhDCUYmrpLJMC3lyM1HRTIbXz8qQz7P5Vd4upVQ==
X-Google-Smtp-Source: ABdhPJxDwuUPOqURaQc8w5/xhR3E7lVJwVcgH9Io27RkTGSx5tkPrEqPqzqxmhj+vivlhB8C4m18UvoiS75CNDpY/qE=
X-Received: by 2002:ac8:364d:: with SMTP id n13mr3306339qtb.369.1605110307801;
 Wed, 11 Nov 2020 07:58:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <55d90be0a5815917f0e1bd468ea0a257f72e7e46.1605046192.git.andreyknvl@google.com>
In-Reply-To: <55d90be0a5815917f0e1bd468ea0a257f72e7e46.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:58:16 +0100
Message-ID: <CAG_fn=V1Pu1NED5K6rJJZ5ufeQwrjN_JShO4m_V=gbLwry7cyg@mail.gmail.com>
Subject: Re: [PATCH v9 25/44] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds a configuration option for a new KASAN mode called
> hardware tag-based KASAN. This mode uses the memory tagging approach
> like the software tag-based mode, but relies on arm64 Memory Tagging
> Extension feature for tag management and access checking.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> ---
>  lib/Kconfig.kasan | 58 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index ec59a0e26d09..e5f27ec8b254 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
>  config HAVE_ARCH_KASAN_SW_TAGS
>         bool
>
> -config HAVE_ARCH_KASAN_VMALLOC
> +config HAVE_ARCH_KASAN_HW_TAGS
> +       bool
> +
> +config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
>  config CC_HAS_KASAN_GENERIC
> @@ -20,11 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
It might make sense to add a comment to
CC_HAS_WORKING_NOSANITIZE_ADDRESS describing which modes need it (and
why).
