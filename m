Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3061300860
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbhAVQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbhAVQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:11:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FBC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:10:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kx7so4004460pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJPr/tLBjltEO+N+N4HLyjzEYnzxewBiyXdbKYJ2UPU=;
        b=O8DuFrQjwc4yNTH7kMXsdvv8nlBKGjqTIjA13aeB1j2D0c/RJuQcmMSEY6k/4wvsg/
         g72Le569M2Fp4tIDHjhbizLNpVnCg7PqQcAzhbybmYCkLcQqeikki+EhDdlu7bMg6GvM
         NVRYfmcvPxcd50W7HIF0dvxDGRuT4+BgTHoZaDy0RYPFgituoQP61RK9xbd0Y5RAVR7k
         JawyawZlMZnqVvI515QzGjWH71ub4pf03er43NvL8wjfLI0y12sC3i2tx0ksYycslD6l
         z/eKQFDGZ0w4B+sfYyfvs96sKdBxPZrCYSqKzFhS1XUZ7YaA+G2xwbFCNIkaA0V7TEMY
         Xpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJPr/tLBjltEO+N+N4HLyjzEYnzxewBiyXdbKYJ2UPU=;
        b=lpca7nKebJmF66kpWwIxyaYx+lTb1zV86r2Y4kVbbRiSwfiOfYNqPdDklu86vIu77j
         Npv1Aix7a9tiw02/VAgHnzGjdPXlGKfTJd35sq9qPqsoUk0hqy3kubP5R7q+E3hjRZHs
         RWkjW67ixIsLFgu9rLmUbRv5xcn0U9fmcUrdL2zNxP/ZZe87M60xmBACv8I+tJFEUg2W
         VebsyJM+3vL9LaEUf9cmncW7JkI1tbq6VWyKdY4kZ9dWHckersehzAwho1//nCgQBhH7
         0R4bU99Bu8Hixb7870Onc/2O5q6fruM4kF2P+UW2glm8szHLYh7JhJzDfYie8earCGIz
         G02Q==
X-Gm-Message-State: AOAM533LlneKmoNXmlaLOzZntzxjSs1qwvsMk/+4jRN5RlunWcJ/c5ir
        zDbKwtchc/ze3zMJgJ37j6luSwBD3JC66acT6/IRIg==
X-Google-Smtp-Source: ABdhPJwUji6AaLy8T8MSuRkIfBUxRmV/x2mtucf+DlLE5ok3+z9DBAMdJnHx4oBILcMqVS54CzRGJq5fBfHtbDbTA2k=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr5072205plp.57.1611331824008; Fri, 22 Jan
 2021 08:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20210122155642.23187-1-vincenzo.frascino@arm.com> <20210122155642.23187-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210122155642.23187-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 17:10:13 +0100
Message-ID: <CAAeHK+yc2c1x2cENQ03xcDpYNPCHgXDP1Sez85b+ohyz1CW6gA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 4:57 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> With the introduction of KASAN_HW_TAGS, kasan_report() accesses the
> metadata only when addr_has_metadata() succeeds.
>
> Add a comment to make sure that the preconditions to the function are
> explicitly clarified.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index fe1ae73ff8b5..0aea9e2a2a01 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -333,6 +333,13 @@ static inline void *kasan_reset_tag(const void *addr)
>         return (void *)arch_kasan_reset_tag(addr);
>  }
>
> +/**
> + * kasan_report - print a report about a bad memory access detected by KASAN
> + * @addr: address of the bad access
> + * @size: size of the bad access
> + * @is_write: whether the bad access is a write or a read
> + * @ip: instruction pointer for the accessibility check or the bad access itself
> + */
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> --
> 2.30.0

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
