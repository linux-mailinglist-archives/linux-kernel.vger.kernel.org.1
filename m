Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC55E2FBF78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbhASSvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbhASS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE18C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:27:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g15so13469690pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFLxK6nMCFTrJXHPH6YcjllJugTgrT1zJQopVJstuMw=;
        b=Uiq65l8VHQUUomniFnXPyFjN2j9uJBxFm3ZdVt1sXfZuoZj2yZq1xHskyAuYBDn6wL
         8QMx2WjBZNZ/LWJbx1fbewgHMJTbphNmfkdYDNdvsQhB50qOxHSpxOrPM/MeNfwGxP3k
         HzT4u+xORbBlFrjoXvxSlJO5andEd4Bl9qjpO/t0oX52Jz/BFhDLDYWPjieHvXhmIIdv
         BpD/PPbwJnyLNc8F12xc2YhRfgK6frU5lymR51QuCZMMnwAfipI44kDccim1+CKWjr2f
         Q4jmbWq5TCYbpCGol42RZQWR4lPGo2b8V2PmgfspbssW9au3Xe+xcuoFEoe3VprcI7D/
         ldtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFLxK6nMCFTrJXHPH6YcjllJugTgrT1zJQopVJstuMw=;
        b=QfOwCg3nj58inxYcQ/j5+vHzTbHLRBlgcS5b7BXC8zNOcajlmfYUmL3o0dukaHLU6x
         e/vuK3WGVq5sxZGUf/LEy83aKlyOqiS7FVA4tu7ZEQbWIxNk/w1AZOvkpHWv6mzzbnJK
         oWtoyN91leHXemaMToBwKlAWyUBAGI52RU3Plv9xHx6yu3/2ZsgBrdPTp8TNjeuQTS0F
         jrSBJZfOn49t7+X1fJUdP2B0SPKJhz++/I1J0c7sNkQLZDZ3PmJS4YbETvhp2W9eG4Xu
         EDGILIlbgCyWST7xokoQmEivRjaPOXUc0oB4R+VFWYedGyuerUydvlrE3+fZxKRqUM56
         YamQ==
X-Gm-Message-State: AOAM530vp+7Jbc3d4RPk1y8ywm+HCUC7ih6+n4w9BZhFVAw6UT5OPj48
        TxjQB4fCDVLh6gc7fp3dpyM5DHEpcps6283BsDHLr/sUG+k=
X-Google-Smtp-Source: ABdhPJwvNeGH0oay9ckCTVbGBsbmjByax/oA/v8pejdFcZV3pWkrCsH/aS8XcOrIMxDT4JlNDjeohmFYwxPXVMOoeXg=
X-Received: by 2002:a63:5d3:: with SMTP id 202mr5563083pgf.286.1611080874934;
 Tue, 19 Jan 2021 10:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210119172607.18400-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:27:43 +0100
Message-ID: <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 6:26 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
> the address passed as a parameter.
>
> Add a comment to make sure that the preconditions to the function are
> explicitly clarified.
>
> Note: An invalid address (e.g. NULL pointer address) passed to the
> function when, KASAN_HW_TAGS is enabled, leads to a kernel panic.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/kasan/report.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index c0fb21797550..2485b585004d 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -403,6 +403,17 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>         end_report(&flags);
>  }
>
> +/**
> + * kasan_report - report kasan fault details
> + * @addr: valid address of the allocation where the tag fault was detected
> + * @size: size of the allocation where the tag fault was detected
> + * @is_write: the instruction that caused the fault was a read or write?
> + * @ip: pointer to the instruction that cause the fault
> + *
> + * Note: When CONFIG_KASAN_HW_TAGS is enabled kasan_report() dereferences
> + * the address to access the tags, hence it must be valid at this point in
> + * order to not cause a kernel panic.
> + */

It doesn't dereference the address, it just checks the tags, right?

Ideally, kasan_report() should survive that with HW_TAGS like with the
other modes. The reason it doesn't is probably because of a blank
addr_has_metadata() definition for HW_TAGS in mm/kasan/kasan.h. I
guess we should somehow check that the memory comes from page_alloc or
kmalloc. Or otherwise make sure that it has tags. Maybe there's an arm
instruction to check whether the memory has tags?
