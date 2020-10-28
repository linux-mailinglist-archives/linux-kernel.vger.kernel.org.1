Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5A29D7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbgJ1W02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgJ1W01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:26:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q199so502924qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EA88P84wG7kGfxM9G+4L3+CwyjZDcOPZBnLgcdYKwco=;
        b=cbY/uyv1cCh6c4oVgWj/70SyO8pIWpjKKYS24jIL8ftPfO8BZWFXtfKrzozYnJCUaJ
         eJKpqiICo94HYV9FZPpoIl9y1TYV/HUPAuccmo2xG6x97wDJN2wNPhkHcV/PmQoLTBAO
         opk2srUWE6ryeNqyO1otV0FCocX0IWzROBPY0aNwK9bwWbjajVs+7NwgVL4pOYUHAISo
         bvPV6EQ2ItsFWRI4fcbRGpdI+PFF2frNS7z/9TnVlSGOj7HLj/pnRmz/kADfKvRDVkJ3
         U6xDnw758nFkmx+UvIe37zMR3saHZ9/sPhYH68otLUJHA2QZ28A3E/79TV/oQlnxeIT7
         ZUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EA88P84wG7kGfxM9G+4L3+CwyjZDcOPZBnLgcdYKwco=;
        b=BGqUU/vJ8zuqAdgHfuoixzZIcpvBs49RsFM8IrrxtjwQIK3U24YRlc1n4f1FNa9N7B
         ztAn4KX8HvD4WNmL2feqTEQqeM/swOTTTrMkmXjsELHKZA4o733kaxDES8NDJHI2oRD0
         sS09dLkQJaAel64vt6JuXEQRCTo4lIgfPHxUNuczPs/PfR1BMPYac1jcU7pPu9APZGsA
         m/9Yy8Tn0P0dtjoOi0p6S+H97VmGNoQhjrZ12u9bY43rjilBv/dhyvf5xySYzNyqx90b
         M9zFI1UWT88gTxosQ+mbHCg/+EUG1abscZDylMZkcK/pVpPaYAqemfm44Z2DS7EnamQk
         qZVw==
X-Gm-Message-State: AOAM530uhZG8IeJVt57ca3vhN57qGqTNLnanB2sOr1zSw7N4PbIaU89U
        AqseJPKdNkdGJ9rBMeaJQf0QjV+1MV9I7PItbTPr+4HMHlA/sQ==
X-Google-Smtp-Source: ABdhPJxTS7XfOF1hOSGhrrT3dGmt5XHhPd9PotQKYgC0JpwNp0z3cpU1oZp83OQvirnXXXWdiSnJmLOpSs1e8J3LLtw=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr799887qke.231.1603882684633;
 Wed, 28 Oct 2020 03:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <84dc684519c5de460c58b85f0351c4f9ab57e897.1603372719.git.andreyknvl@google.com>
In-Reply-To: <84dc684519c5de460c58b85f0351c4f9ab57e897.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 11:57:53 +0100
Message-ID: <CACT4Y+Zqg475fdxWp_ARvb0APS=zKdLmzRW_0m4ZcoH6rADrzA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/21] kasan: remove __kasan_unpoison_stack
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> There's no need for __kasan_unpoison_stack() helper, as it's only
> currently used in a single place. Removing it also removes undeed
> arithmetic.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ie5ba549d445292fe629b4a96735e4034957bcc50

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a3e67d49b893..9008fc6b0810 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -59,18 +59,12 @@ void kasan_disable_current(void)
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  #if CONFIG_KASAN_STACK
> -static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
> -{
> -       void *base = task_stack_page(task);
> -       size_t size = sp - base;
> -
> -       kasan_unpoison_memory(base, size);
> -}
> -
>  /* Unpoison the entire stack for a task. */
>  void kasan_unpoison_task_stack(struct task_struct *task)
>  {
> -       __kasan_unpoison_stack(task, task_stack_page(task) + THREAD_SIZE);
> +       void *base = task_stack_page(task);
> +
> +       kasan_unpoison_memory(base, THREAD_SIZE);
>  }
>
>  /* Unpoison the stack for the current task beyond a watermark sp value. */
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
