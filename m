Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB82F29DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392291AbhALITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392247AbhALITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:19:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44205C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:18:36 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z20so1069482qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2O4oVCcY5rd2IeP/z10VBhkIJpOFPjzFWez+q+L4HJw=;
        b=vUtmN33he1absWSIk8T5Hy/Rn2xKLJBbD3vu62LbyvKvQrutrL+COtZNriH2/oqwKb
         +1T4Ds7sEblVyoTZRJvoYXkCy/bCMZbotiya2xYYphm6bW96Ok1+MInaL/093FxWbdu1
         DJmP+uPuvS/rGfZ21DJEdwRMPjbBxGRMUtXY0d/xX+GqqYSZ7SpsFf9/VIyUEB5zNY2N
         yfcZFwZeGPWz6hUDq/VV+3qnU9AdllYux0Cy/9h8WS6gxk8gPKRzU4P02Zop1h3PprjH
         viczQ1ojLSDC6A5Fhdbfxezk9ovpaFTADg/6fMoKRhTl08ThOFOL1S3IdBmVWijZLH4x
         kdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2O4oVCcY5rd2IeP/z10VBhkIJpOFPjzFWez+q+L4HJw=;
        b=gBStDHquZOrLPYQwep+xmphVUS8BiOVBePzIX+I7o7/XLTUNw44LTr4zjptJQGAtqL
         4yQieREtoNKuc8Qu1Vv8zOdBLmHKPDo/dg2kPkIae7EkD1RrtwG4QKPVlG2I2tn2RkwP
         USSE+Cs990JIxKU/w4x1eV+cH0/0mJa6kCska+ReYCQ0ebWzYooNt3mKSdAoWHIevPX+
         aKKsowf9Up4tYepcfn91EogTcLsjlSizjtmZZ6WiAiqFyhMttcpH4i1O8dYReBOJwT4d
         I1/bJPDu0RnT1bfR0I9jnG2ir/ng9XiUrYz9myk8OhpMvvREGVRaHYggPYO/qauWWf2Y
         eK5Q==
X-Gm-Message-State: AOAM531opo4hQvvA6aDzgD/Ft1EjWxXNWfV5YSQETCN8KGTK2H/Agj22
        zXEG8O0CX5bDH8IujJasgWIrBwhlLeY08TzNG9H79g==
X-Google-Smtp-Source: ABdhPJwDvS6XK8nVNZVXoR6ZYl97fk9N3dt0lEOcbwDGnr9y6hCPY5xR/Akfv7n+oIdi7Btxwd7tfnhfavX3rRpl01g=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr3452445qtq.300.1610439515331;
 Tue, 12 Jan 2021 00:18:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
In-Reply-To: <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:18:24 +0100
Message-ID: <CAG_fn=Uqp6dt5VGF8Dt6FeQzDgcEbVY8fs+5+wyMp2d1Z98sEw@mail.gmail.com>
Subject: Re: [PATCH 07/11] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> It might not be obvious to the compiler that the expression must be
> executed between writing and reading to fail_data. In this case, the
> compiler might reorder or optimize away some of the accesses, and
> the tests will fail.

Have you seen this happen in practice?
Are these accesses to fail_data that are optimized (in which case we
could make it volatile), or some part of the expression?
Note that compiler barriers won't probably help against removing
memory accesses, they only prevent reordering.

> +       barrier();                                              \
>         expression;                                             \
> +       barrier();                                              \

The need for barriers is not obvious to the reader, so a comment in
the code clarifying that would be nice.
