Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9D2FBEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhASS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390688AbhASSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:11:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3553C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n7so13465003pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Opada1Nc74SeJLx5vNBWIsrWjBjEGuHxciJnJB2M/I=;
        b=PrWo7CyvRvlnmkJHGXRxgNV6sSvFovW9CNemZ8fokQZSgWP8V31DZu1C1PYhvv0ynG
         IWL55t28ju5ZT/08aPAz+L0P7pjWxaq7o9sMsX6QpZSOE1pywOsU3KEG3As9unvlnlIF
         8r/g/kK6Zsz5iK++ciGJdbTUZp2RbW4eCKcAoNrS4sczIyjpatnma53hlI3+dKI+ws4d
         z+cJs2bDIYtBpTqgqB+5vybHe5XyD0zQo/HzPSVPjcYIpcSzq83V5bmmfkcU1QwgeoSY
         gnMEtZAodQthIcttnuBXqMX8Z55qc6AO4piP0JnZeQSGMVUcZY7J77HdROvR4CwH6Qs1
         Rl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Opada1Nc74SeJLx5vNBWIsrWjBjEGuHxciJnJB2M/I=;
        b=kxGcsdkjUFCIoBqUmwNXS3Chb9CdK3t/0EHwyXjvjthgwxHBnAtKu4D6uAn5vwFOeb
         P+D5IJRWZd/ND6MacYm95DHoiLyQ1qyZ2HNNQeWnNIQp4dyTmsUu7UwwaYqdCgo/gtMh
         s1xb8/3FLjykoKyjZiL6aUlf7tx4lcvHQKH06cSdGdpvvtej04F7ff+g/67vwEByUr0s
         vDPSS+sytgBAGWXU1ssJNmVV3xATE2cW+gmZB15MLiTrPL26CKgtPMx+JbRLW7dkihJO
         Mf0XPhIsPstKIdsTQ0eoO4YjhEQjgzLWSbi1A5MslWNjHY3uH1q01cneXT9W+X/inK0M
         M5mg==
X-Gm-Message-State: AOAM531yN02yUl/Yp1jG/WHQ8DSoXORk+0d1/w6MAO16YKQ5BA4cQ0Zl
        OG4C+NykTfKxlUs10fcVHe4kjbci9tAFMhYD7rqrdA==
X-Google-Smtp-Source: ABdhPJyCvQ3D5bDj6KFutl+F42BJdq16wK/CTyP670Mqi3SF9xzP8xf3Ua/QkDHnmmF+uzAaspeGgSn1iuViAZlAK9E=
X-Received: by 2002:a63:4644:: with SMTP id v4mr5572351pgk.440.1611079831408;
 Tue, 19 Jan 2021 10:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com> <20210118183033.41764-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210118183033.41764-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:10:20 +0100
Message-ID: <CAAeHK+xCkkqzwYW+Q7zUOjbhrDE0fFV2dH9sRAqrFcCP6Df0iQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] kasan: Add KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 7:30 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -162,6 +162,9 @@ particular KASAN features.
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> +  synchronous or asynchronous mode of execution (default: ``sync``).

This needs to be expanded with a short explanation of the difference.

> +static inline void hw_enable_tagging_mode(void)
> +{
> +       if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
> +               hw_enable_tagging_async();
> +       else
> +               hw_enable_tagging_sync();
> +}

It's OK to open-code this in kasan_init_hw_tags_cpu(), no need for an
additional function.

> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -284,7 +284,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
>  #endif
>
> -#define hw_enable_tagging()                    arch_enable_tagging()
> +#define hw_enable_tagging_sync()               arch_enable_tagging_sync()
> +#define hw_enable_tagging_async()              arch_enable_tagging_async()

This is one of the places that conflicts with the testing patches.
You'll need to: add an else case definition of
hw_enable_tagging_sync(); change lib/test_kasan.c to use
hw_enable_tagging_sync().

I'll later add a patch on top that forbids running the tests with the
async mode.
