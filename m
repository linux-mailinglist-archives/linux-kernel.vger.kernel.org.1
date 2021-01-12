Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD2E2F29FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404811AbhALI0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhALI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:26:46 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43ECC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:26:05 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so1091899qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u66Zz7BdRS7VV/vrWqqvG+i4Lg5S/n1M+J8zEYi5Ao4=;
        b=eYTicqMf968rsvZwqKjvQuowXZ1ZvCoYJ8cS57jF1fuYYcFHVXL0X8f2FXmKQaaseX
         Yj8sKvIfxE4xePzg/R3A/UvyS3tK3BxCfqwPBdGAyk+q9iYGZUJrLmR5MSrZTB5cD12I
         wK/mWGe4VbAx5cxeyAPmw82u/UVJFBhp23dXPcCJCLiOlIWWs5w4onEwCHo5DYe/Trzu
         ls7hIgmsNb3KTdS9LmtMr2Qfy3jjPfX2jnrICj2LUMA7DjSawuDB8QfsVFDmlsEmCthh
         jLUu7O7i/oCY/H+8llOL40lX2tjodU5LcDjjk211N4yUCBz/3ZxrkQ/mmZE8DyDDNmKl
         HIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u66Zz7BdRS7VV/vrWqqvG+i4Lg5S/n1M+J8zEYi5Ao4=;
        b=McKkPfzQcgr2/KLs8CdlmJN/9hS0xnos/hTAVeG3yBh9+iSRcaLJgpMwmShBXDKXsc
         zBamQbznmMpfllFJj7Ri23R4DwOeNKA0OXRtjhlSlCAyn/0nVgOY6nozdhkz+ttUegg2
         v+E02p5RC6ji+tN4rGbBRoO/XwnRp1OsLcljl6Yb9+dpehVaoCf4vk+wwJrIAZXxUEva
         jAuG4H9akGxLO5S4F6XUoayYdwyPUDZ3dPNoEDJyIIBR2flZ+kdu69kKl48eurcWinhP
         YtxXITFfsD13gHhWGf/AErnN4hrU3dNLpFoSLIgwRYnCt6EklzUHHlzcUsBSzjnaz11+
         tJ7A==
X-Gm-Message-State: AOAM530n1DxOpPeTNLxwCKpXmo+o3MuD5KTVPVNHXj4vBHf/uTpTPsb1
        nAC+QBT1kf+EPJXMbRy3eoEKlahIrKsFTV+l6QBYRQ==
X-Google-Smtp-Source: ABdhPJx0J5IDwFVF1k2QxS7V6i8xM+pxfMUSucnpGXb232MF3bwGZWdb89rCjAGill1SbeO56GioOR585B0L87SrwBw=
X-Received: by 2002:ac8:6f32:: with SMTP id i18mr3418479qtv.175.1610439964938;
 Tue, 12 Jan 2021 00:26:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
In-Reply-To: <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:25:53 +0100
Message-ID: <CAG_fn=X0YY8+FUWWyLqGUu5Z6-eEaSAOVGYj9PKzhzqyA1BvsA@mail.gmail.com>
Subject: Re: [PATCH 08/11] kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
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

Nit: s/adopt/adapt in the title.


> +again:
>         ptr1 = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
> @@ -384,6 +386,13 @@ static void kmalloc_uaf2(struct kunit *test)
>         ptr2 = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>
> +       /*
> +        * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
> +        * Allow up to 4 attempts at generating different tags.
> +        */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 4)
> +               goto again;
> +

Looks like we are leaking memory allocated for ptr2 here?
