Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D852F7C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbhAON0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbhAON0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:26:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A018C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:26:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b9so5953452qtr.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoaYJzIC4vPrLHOiSipsh4VQdU0Tic4GnbeNL7DPOG8=;
        b=QG4SkeTaSgE7Oa+70A5EvBmYqWmj894fpfPYlSOUhzgkPRJWy9kqtiJEg5uTt7q3Xp
         d/W0Lb4GPaYR9UseoxVjerp1FM5W2awwTNYqP6RLV9PA5wOi5xhliKlZRHYt7CrxEci0
         q+gMpae+7iPorFuAR489THOiUdnrYIi16lJ9F8bb4AkHipmeOWf/8c0zK4YHyde5tE6J
         ThvE/0E8BexQzDLrqK1RmBCO+ND8YwChQJg/oF9bU8Fa0e0W2w+Ij1RRUc6ldjfyUzr/
         wyOvDix424sgnThvPdSSgMfu70pfZV/frOOSuAI3Xw2f8RpeSotYpB6eoU3oCE0BOeNU
         t5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoaYJzIC4vPrLHOiSipsh4VQdU0Tic4GnbeNL7DPOG8=;
        b=f5kCPDTSFZZ3OOI0AR+QRVI+MeZDndJphqtDFPtSVxxu9JtoR8fHbi8qRF4pXe3BjB
         Bzw42QmSSNDVYR0rmWUVh+R9RWw/k/3h/YP55sx4AM4Ne7wuKO8ckfN5TphVtpDkw5vN
         /G35oBPPpOO1ZwoSQKY4zgSGPRebc2R3n7ayXX8AcfUHmX03m+MNk/eXO7F1vCjBFjkx
         jAjo3ex9FYKqZ/AXMOqmH/lCsad6PSwUOUS5MwV2bthi1d+ZCSyx6xIE1s0TWFJgXG4G
         uZREG9pHXMi9IMCZGb0SXMMpnsKYz6qo7NNqBhWyPEyiSVu2WXikpMIZTCeR7Kkb2vpI
         yYmg==
X-Gm-Message-State: AOAM533u8NQoR49PQzb0A6mrlUdrsk52bn/DaV1cXLzwsgPbBNiCX9fv
        Uvw+QgQ/ekx2+Hmi4Tspit/7oFPZeorlxTfOFM38wA==
X-Google-Smtp-Source: ABdhPJzDERapaaPrl3/DhHkCOpetp0UOA5E4uUWYvHEAEUn9nT3H8kCebzOnsRbbrg+6ts376Io4/ici0nPANpwyPuk=
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr11577066qth.180.1610717178400;
 Fri, 15 Jan 2021 05:26:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <e926efdba3a1d9cccccbabdfcc17cef0aa8a2860.1610652890.git.andreyknvl@google.com>
In-Reply-To: <e926efdba3a1d9cccccbabdfcc17cef0aa8a2860.1610652890.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 14:26:06 +0100
Message-ID: <CAG_fn=UfAbZ6J0WNzkg_XsYJx7zMioUtMwYX3j6-7NqcLZSrQg@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] kasan: clean up comments in tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
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

On Thu, Jan 14, 2021 at 8:36 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Clarify and update comments in KASAN tests.
>
> Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
