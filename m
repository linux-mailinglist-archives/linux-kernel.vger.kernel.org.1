Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C006F2FF1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbhAURVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbhAURVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:21:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD36C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:20:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j12so2058652pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42oikTOcG3h7qaAKgY5xG16dol6URHxOGjSC7f21gjU=;
        b=sPQS8E+87PHGLgnMDQitks4WWJAzyeo4voTz/8HKQK99bnWInEXfYJ7tsEUeQe4hUK
         wYxB/YENDxR87poUbgsP+uH+HW2JUg0hzivo1kKSkyfqSfdZO6pwD0rziJBaCS/Rvz2n
         GSVRKFTcwVEzDdyA2HGYEt7N5pGrYkDegBb69sBHysC9YTngx1sWmR+ss7Ee1maJ7KFl
         vPT+I6Ldsy+1vLAuyTQ7ol5IyGZW+MrFw6v7zAk02YxPrsGjFhLU/AwY+0RX+eD2sAAR
         bmjCVNN+TgsHF/KWv+BFKWtII2SPWEbF+FprJ2xQhaiV6ijsb01kZObIMrZCxlJvUCxL
         FyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42oikTOcG3h7qaAKgY5xG16dol6URHxOGjSC7f21gjU=;
        b=D2vP2nSU+5Ytky5vGGIKo3DEG9nwsZb2UEzBukGEjMLtNOfN8fOJ9exlHfRcaUJMoZ
         WPO10MwKgBNgpKgjn0xvupBVYSHPP36NnMhhA7hKzRkoA6y6zQu3q/ZYoKfentryo1Jt
         zbitN017etU1/u8jSJxp65kwYoN8vxG/5AAW1qv3TREINZkAJJLwbFlIk5KGWa/Jr08I
         ZPAKOaYPQE55xORCb9ZFTJvKoUTrRI95p2/AQwweWZqtet2mMFoOPuTSFslLAXf5jw8o
         Ia6NROJgGd22R+nkhAhGwMRxDPjK5caxhVEkc/evEFcohL6j/XgmTAjm/kV7BLdcp9wY
         kvUQ==
X-Gm-Message-State: AOAM5333ZWA30i9jGeA0llcU/eDKLqFSdFoaMgWNBVYk8r00i4Fmgmsp
        qopdy3pKqUctiBXsNbYEJQAsMLfTrsoUxtxZrqWkoQ==
X-Google-Smtp-Source: ABdhPJyMk1qNapUs5suZMcCehTLdBoxpk5/kwzTkn0e27jOgeHFVKMiU/HgrEtBWQ+9YPtd7Ayn4BWxPHTIsReuoRLI=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr658090ple.85.1611249629456; Thu, 21 Jan
 2021 09:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20210121131956.23246-1-vincenzo.frascino@arm.com> <20210121131956.23246-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210121131956.23246-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:20:17 +0100
Message-ID: <CAAeHK+yCq+p-D8C+LgHUSkuGZmZscJPTan9p6GT8GoUAVdnOqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 2:20 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
> the address passed as a parameter.
>
> Add a comment to make sure that the preconditions to the function are
> explicitly clarified.
>
> Note: An invalid address (e.g. NULL) passed to the function when,
> KASAN_HW_TAGS is enabled, leads to a kernel panic.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/kasan/kasan.h  | 2 +-
>  mm/kasan/report.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc4d9e1d49b1..8c706e7652f2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -209,7 +209,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>
>  static inline bool addr_has_metadata(const void *addr)
>  {
> -       return true;
> +       return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>  }
>
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index c0fb21797550..8b690091cb37 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -403,6 +403,13 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>         end_report(&flags);
>  }
>
> +/**
> + * kasan_report - report kasan fault details

print a report about a bad memory access detected by KASAN

> + * @addr: valid address of the allocation where the tag fault was detected

address of the bad access

> + * @size: size of the allocation where the tag fault was detected

size of the bad access

> + * @is_write: the instruction that caused the fault was a read or write?

whether the bad access is a write or a read

(no question mark at the end)

> + * @ip: pointer to the instruction that cause the fault

instruction pointer for the accessibility check or the bad access itself

> + */

And please move this to include/kasan/kasan.h.

>  bool kasan_report(unsigned long addr, size_t size, bool is_write,
>                         unsigned long ip)
>  {
> --
> 2.30.0
>
