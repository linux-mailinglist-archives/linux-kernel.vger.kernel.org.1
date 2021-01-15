Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A02F7DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbhAOOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbhAOOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:05:17 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C92EC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:04:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so11685805qkm.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvQ70dhce4kxItaPjGS90KL/Tl/xCqV5rnfXoeOdY6Q=;
        b=iNs2rix5PE/9M6DZaugvLM5dZTUu/qXgWiUJUEOp8LeJM7JHBO78YEaxojNu3nLj7w
         JBO4+iOHLKp6SJtHmhYK3TTKBjtg5HiyoNl6sjFxpcLYJQRvbfGbyjdXRk/o6CNbw/VW
         mtNOIlxRE9VmM3k7cFleLno1hAjUSBROFIQmASZtVV71vh7z24wSft7KKA261NNYZe0C
         NLmrs38ETte7qSTqfNtbH9YsMw77Kc+guNcJhHwsL6cEjVHt5x8q0n2lfPPUwZrS7xa9
         G5UT8o6cI3gvO6lLmV0S9dW1nfsZqqYXqk57AtSB+ulPqzBhROp639pdFLUd6xOYPkmq
         1XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvQ70dhce4kxItaPjGS90KL/Tl/xCqV5rnfXoeOdY6Q=;
        b=hgiCpFFHKpO8pyyzeQJqlCQ4XpKuCPUL+tHh66amEhQMSoPzEBC/nb86P8FdjDvl2h
         3KUX3U3H5YFkOdV82WjVGkvAlrqnx+bxHHI+8DiQ5x9F/S4ZqdT24Vb9haLScpGcN0mV
         fqn876tGwPuBPiVQhfNER9qH40bpHq2V/jKGh9rBgeQqGWDmTq9tgwcBBlaOQFklxH/n
         xnoDoLAEOCZ9eIBxDiL0FGYfZq5fo5V3Ja1wJ4cwn/6PV8f3tG8H5NSrj5UNpZv6/6LG
         gVOPjaKr02I+zXvGb1djIA3Svy5PUHn1J71J97bQWCZdRUFDUdmzt7Hi2LJh5b7yFFig
         DoBg==
X-Gm-Message-State: AOAM5301LQN7jMvno83XzZ7QWApjbak7/B9XY2TQ7qqLnAiuL879n8OO
        6KxvihT0PrmoTHT4Ki39h0U8pSctYCHGWf7RoghCbA==
X-Google-Smtp-Source: ABdhPJwQ79B5nh5gIqlZExb3wTEaa+Cmjyd1+L5Dedt96V2N2te0IOtyWoccQ+lDgGQyhWrFTCgncPs3zs9Q8G8pRDQ=
X-Received: by 2002:a37:70d:: with SMTP id 13mr12162251qkh.326.1610719476289;
 Fri, 15 Jan 2021 06:04:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <bb93ea5b526a57ca328c69173433309837d05b25.1610652890.git.andreyknvl@google.com>
 <YAGWA4EWQQd+7e+v@elver.google.com>
In-Reply-To: <YAGWA4EWQQd+7e+v@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 15:04:24 +0100
Message-ID: <CAG_fn=UqURzPmvP14ULhecDtpgHNOzgcdmm8O8w4iEOWJHu1LQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

On Fri, Jan 15, 2021 at 2:18 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> > The currently existing kasan_check_read/write() annotations are intended
> > to be used for kernel modules that have KASAN compiler instrumentation
> > disabled. Thus, they are only relevant for the software KASAN modes that
> > rely on compiler instrumentation.
> >
> > However there's another use case for these annotations: ksize() checks
> > that the object passed to it is indeed accessible before unpoisoning the
> > whole object. This is currently done via __kasan_check_read(), which is
> > compiled away for the hardware tag-based mode that doesn't rely on
> > compiler instrumentation. This leads to KASAN missing detecting some
> > memory corruptions.
> >
> > Provide another annotation called kasan_check_byte() that is available
> > for all KASAN modes. As the implementation rename and reuse
> > kasan_check_invalid_free(). Use this new annotation in ksize().
> > To avoid having ksize() as the top frame in the reported stack trace
> > pass _RET_IP_ to __kasan_check_byte().
> >
> > Also add a new ksize_uaf() test that checks that a use-after-free is
> > detected via ksize() itself, and via plain accesses that happen later.
> >
> > Link: https://linux-review.googlesource.com/id/Iaabf771881d0f9ce1b969f2a62938e99d3308ec5
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
