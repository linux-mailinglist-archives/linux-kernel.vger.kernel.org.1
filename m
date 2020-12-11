Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFB2D71E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbgLKIhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391957AbgLKIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:36:57 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:36:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 143so7708552qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dxbid0Ia6yZGyb4lUSC6Gr0oUo82+QX8jC8lSF5YfY=;
        b=RmNXu9p6jAeFq2XsLx0cM4WWcOpYs72EIzntZ8V0U7pQKYaFhljgGl1ZYntgRgxmkl
         +hMDtreDljBHM7rv9TwyQauj+AUAhbCDFcx8E67OussK9I7vtZ479QtJbQJcykg4kAjv
         xntVedjm+hzKLQV3cFed3l1pKT2hW+23F1aRHbWLyZ2t0Kz9XsvDkCa9AcerXytFHCb1
         MCHNnDpUuqG0JP5bR9mE9/e0FIPBVfzD1dnnXG7GR1vaNkd2CVcS5yUdkuJwjeboQpq2
         MEqTBUtv64XvRIpXMaqzZG/CUkdB/68x54LGgfoFIA54Yn+t3ac381syXynoRu6Rtefu
         P2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dxbid0Ia6yZGyb4lUSC6Gr0oUo82+QX8jC8lSF5YfY=;
        b=YGh/FO4o8H4fjObpfBtkEpZvHDOnloMTwshku1fbo0YrF2xrtEQL779k78Fk8uiIcz
         tozCn2Oj0liic88blDR3EYTx3pszf0ys63NPQUCSWf0nEJJbONyMNLlQUP0mUrlsA6aH
         jHKZfqTyynsIKi+OZZKjgTXyMpLXrQ59y0CF4FJKrGiXdQ3m2wHB1ZCK2BnjzQMlv8E3
         wMLuju54Cg+eHhmfnDbj6VGYFykPAZAmZoQ/SdD1181tWV7e9Vt22jk6053rEvj1Evpe
         fwWy3ZM8YmX0ZzgRSERCWCSGvIu08G8aBNRYABooOgsWH3cVKoAR2KlH5zOhigrhalHy
         LXdw==
X-Gm-Message-State: AOAM533PtCYHVB2SS27xH63yXv+FT0VpgoZ9yI/3OsaQj2wbmS+h3o7i
        aqWer1AEql+keuu6kvRJVQRlkFE8fuPZmgejYu3X8g==
X-Google-Smtp-Source: ABdhPJyuiaTN6g1PrT5j2Xt/5Nuv4F7g1Ca2C/HOWWjGHt/Xik6mBPA0LSTao+IeWl/ztz+aBH/67hkiC92mvzcaX9A=
X-Received: by 2002:a37:45d2:: with SMTP id s201mr14328842qka.326.1607675776124;
 Fri, 11 Dec 2020 00:36:16 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
In-Reply-To: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 11 Dec 2020 09:36:04 +0100
Message-ID: <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     vjitta@codeaurora.org
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
>
> From: Yogesh Lal <ylal@codeaurora.org>
>
> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
>
> Aim is to have configurable value for STACK_HASH_SIZE, so that one
> can configure it depending on usecase there by reducing the static
> memory overhead.
>
> One example is of Page Owner, default value of STACK_HASH_SIZE lead
> stack depot to consume 8MB of static memory. Making it configurable
> and use lower value helps to enable features like CONFIG_PAGE_OWNER
> without any significant overhead.

Can we go with a static CONFIG_ parameter instead?
Guess most users won't bother changing the default anyway, and for
CONFIG_PAGE_OWNER users changing the size at boot time is not strictly
needed.

> -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
> -       [0 ...  STACK_HASH_SIZE - 1] = NULL
> +static unsigned int stack_hash_order = 20;

Please initialize with MAX_STACK_HASH_ORDER instead.

> +static struct stack_record *stack_table_def[MAX_STACK_HASH_SIZE] __initdata = {
> +       [0 ...  MAX_STACK_HASH_SIZE - 1] = NULL
>  };
> +static struct stack_record **stack_table __refdata = stack_table_def;
> +
> +static int __init setup_stack_hash_order(char *str)
> +{
> +       kstrtouint(str, 0, &stack_hash_order);
> +       if (stack_hash_order > MAX_STACK_HASH_ORDER)
> +               stack_hash_order = MAX_STACK_HASH_ORDER;
> +       return 0;
> +}
> +early_param("stack_hash_order", setup_stack_hash_order);
> +
> +static int __init init_stackdepot(void)
> +{
> +       size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> +
> +       stack_table = vmalloc(size);
> +       memcpy(stack_table, stack_table_def, size);

Looks like you are assuming stack_table_def already contains some data
by this point.
But if STACK_HASH_SIZE shrinks this memcpy() above will just copy some
part of the table, whereas the rest will be lost.
We'll need to:
- either explicitly decide we can afford losing this data (no idea how
bad this can potentially be),
- or disallow storing anything prior to full stackdepot initialization
(then we don't need stack_table_def),
- or carefully move all entries to the first part of the table.

Alex
