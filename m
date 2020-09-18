Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5AC26F7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIRIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:17:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D08C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:17:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so4658389wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=336DK+gr8bWeArYbXXeTUATGYeu4M+ZLn03audwBSjI=;
        b=P6hxU2ONsTj0tWsHoNwvfnSTvSCvHbA8sFwBTqHKDj+/wnfCSR6f37OyiP9P/BGuiY
         YlR7GkEXKyvELr7ERB7LBUyiwHh12AxmKVKClz5RGWfRg2BXjgtk7XgJq0LRwWJP1DkZ
         K0mU2vYlc5nfpqFT0BRlX9husFktvYox9/03lY6KbV/CEl7TMnZYCjhQaAh/xhvLqNGA
         s7vPhWrevFlzWBNBZZmdwJgACoQ7VicfnJrXHzhayBxqnqV9P+hVc2lICKhGOMD0RATj
         qR9Boez3eP+M1mNPpWfZx1CdNlAtvpyZWFdVQ2ZMmjJexuymGOT8bnRZOmn2BAwIfKto
         8EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=336DK+gr8bWeArYbXXeTUATGYeu4M+ZLn03audwBSjI=;
        b=L+3PR5Lgs19afakWLT5oGU8RiFpqLct68E6TMHrn7+Yi3kVxfj/EmjBiD4/XvGe95x
         6a4+p/FheEMitFk9dACT+iq6CI1Zo/MojeoQN6tFqxS1ohFYZ/SINBf4D/43tcJsw2iA
         7WMceWegdSwJ2OCcYlJc3xMH3Qn9ivl6kZB8E2lWbWtI+mWbqfRkI3k5L6btjGx0B8PB
         s7PkR4cSld8ckpOzSsXZS1VcFtNz/h+JNWr+s6Y4rXxAKUYYWTlFeOJeZCNSPc0QJ5vc
         zqIHipDNYeDeRU3YsRKRVMTRjQDAnFhiYAkG/dUuQ0PZ47Ketas0rB/Co6lKK7qdPYmt
         06TQ==
X-Gm-Message-State: AOAM530YBFiA0dVY/PwNPE4y4XxokmObK0HfnAtSmT+9dV9ZwD5WR/9i
        uDxupSQ0ZwivDhYTWHvgxIqR73gQIw0xh2PGj93X+A==
X-Google-Smtp-Source: ABdhPJwVuS5KBOyJsrvk5LUfGguAb+QpQ29tKswCawYdjjDY7nZkbxoog228YB/l/wtYWXDOlxUMcvjxCKk4qsa8ecw=
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr35980678wrt.196.1600417073613;
 Fri, 18 Sep 2020 01:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <88c275dc4eef13c8bcbe74ecec661733dcbc67b8.1600204505.git.andreyknvl@google.com>
In-Reply-To: <88c275dc4eef13c8bcbe74ecec661733dcbc67b8.1600204505.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Sep 2020 10:17:42 +0200
Message-ID: <CAG_fn=Vuu-hiaACaoyvpo7RCzvk4faz=AANX=oyAKEJdHDSxEg@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] kasan: split out shadow.c from common.c
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> new file mode 100644
> index 000000000000..4888084ecdfc
> --- /dev/null
> +++ b/mm/kasan/shadow.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains KASAN shadow runtime code.

I think it will be nice to mention here which KASAN modes are going to
use this file.



> +#undef memset
> +void *memset(void *addr, int c, size_t len)
> +{
> +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +               return NULL;
> +
> +       return __memset(addr, c, len);
> +}
> +

OOC, don't we need memset and memmove implementations in the
hardware-based mode as well?


> +       region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);

"PAGE_SIZE * KASAN_GRANULE_SIZE" seems to be a common thing, can we
give it a name?
