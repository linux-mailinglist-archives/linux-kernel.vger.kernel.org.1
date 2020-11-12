Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60B2B0EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKLUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgKLUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:11:56 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0476C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:11:55 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id w11so3366836pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2S2n4Y93UoJG9nL/klprM8z9XQcvbrv6CcFxLYZgtjg=;
        b=RNW8PZ9+tID0QSbR+rpTOcvI3kI7ebx4DXx6gAvjzcH3TLPaxKEz9At/oTpE9K3eWk
         zLQYhMMGcOz5YFxKA8FTnfipVDwDqCSZ/1QeqvUxu5ccf+qWzPAZSyWb68SjN3RR3wDF
         yyfJxNDonQnDg/+1fR5dfNMdh+RhSEexdb2rj3NJGdrmrqCelZde4KfnMZ2li6NUouwM
         k2wI0oK6L4GvBGymy315Vdo9dJqgnzWCOy47TCt3j+uFCcJUoDFeFLigu9N0vm8TR+Bz
         Oq9sGnU+Q4Hm6eQUbUcOL7tNrMQwydrYcSNUfuWs/v7i6OelIwjhENz9qIKbXUQOh2Rs
         p7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2S2n4Y93UoJG9nL/klprM8z9XQcvbrv6CcFxLYZgtjg=;
        b=OJ5W2T3N35rJrG9qqqxes3lqdea6q3wtcIfZh8bq7xZ2NfimR2i2TyT/3XXpZcCChj
         h+bDwd6QvQ1g54/HVTQhE2DKT0TKAAxIiCGcOlY61mdWdvGJtAdPHFssrtZyxv8b5nY6
         VbADwYwxEMnaJ5H3H9eRQoQaGK44ch4veF7KUEpVxV5Yh7v6kin+pXXO8f71TneOxAzQ
         LbMtuyiuYsvsQzkRl/8cHJ3hjdO6tRlu/r0qSlflXXgs9aFovcrYBr0fwSFAQfpAGeBb
         BoSMe4hJwjI3UUba17FZRgkOL4mjf5RoVD1JNydELLbyXqW81lDk9PSK7b+JvZUvRi/D
         SX8A==
X-Gm-Message-State: AOAM531T7/Mo60u7/wfmVMzHT0Lea9PGTlnSulpFFzzEksT6jurpemoT
        guNpmLaIxgnw/nLF+bp7YL8MkVJtdO9X0p47SWyGLQ==
X-Google-Smtp-Source: ABdhPJyQBAUXMmBZ3y1Mo+CJ+E5TUtrYfPLbY6wFDednABZ3IRhP/lxtBA0vTrNnfgnZYvuJFasFHpexl/ZMb46edN4=
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id
 c13-20020a170902d90db02900d6ecf9c1ddmr902814plz.13.1605211915059; Thu, 12 Nov
 2020 12:11:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <fe30e8ab5535e14f86fbe7876e134a76374403bf.1605046662.git.andreyknvl@google.com>
 <20201111230601.GA984367@elver.google.com>
In-Reply-To: <20201111230601.GA984367@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 21:11:43 +0100
Message-ID: <CAAeHK+wwC7zETg_0VQab-mMhssNwC0_aoh3HqRVqN9SrZTMSKA@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] kasan: clean up metadata allocation and usage
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Thu, Nov 12, 2020 at 12:06 AM Marco Elver <elver@google.com> wrote:
>
> > +     /* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
> > +     if (optimal_size > KMALLOC_MAX_SIZE)
> > +             optimal_size = KMALLOC_MAX_SIZE;
> > +     /* Use optimal size if the size with added metas is not large enough. */
>
> Uses the optimal size if it's not "too large" rather than "not large
> enough", right?

Not really. If the redzone composed from metas is begger than optimal
redzone - we're good. If it's not large enough to reach optimal
redzone - we need to make it bigger.

> As it is worded now makes me think this is a fallback,
> whereas ideally it's the common case, right?

It's hard to say which case is more common, as optimal redzone size
varies and depends on the object size.

[...]

Will fix the rest of the comments, thanks!
