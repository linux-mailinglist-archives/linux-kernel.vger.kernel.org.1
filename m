Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798D2A5A87
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgKCX1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:27:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:27:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id h62so783112wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 15:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nleQTGqvyY37bDvPtiFwPNAyFfPRKwZA1dXnS2tI+5Q=;
        b=qHEY/G07qTQ0SLqSVJ2/T1c/Lshc7PlMUnzZg5OR7hVlkXp4Yea6ZNQLIDuIzgIG+9
         WlP7VtBdHhVVT7YiBfvA1UEMO+jGRFEkdR1z8bSaKckS8lzaERsGxt+sR1JKxVDeWl/1
         PZcp3rzUOJaWTxK1QvwjNjXoUzYCADKeB6TXwTvH7sNC6gOtVxqqGIQzg5K12wYCQuI2
         JzO4jAKxavESAzbsZ8fXfZ3VXgJNnpe5579H7aeNwI0gJoBAQ2jpGKloKjbC4Xlee1o7
         B6hO9iNHlk/Gn/TIBcKvUXxlvO8fvu4jD6PQT8shbcEdCDsEuvujmTx/KosznVuaHlks
         jj7A==
X-Gm-Message-State: AOAM531ZdISkQWYsGfCWB0ttTIDwVzb7Z3arICmlev9xCdiprkwjyEUe
        /mHwP3sRR7/wetGoKwDI4HzKG8POzZM2w4dS9CU=
X-Google-Smtp-Source: ABdhPJyrn6W3/m3QdM+g6VA5EnAjyKatWc79M+cEsR4KLMUWeeXa8u6DAVD20RIIotwWRzHmvlQclaoYkPspnGtQWfU=
X-Received: by 2002:a1c:b487:: with SMTP id d129mr1608687wmf.38.1604446038443;
 Tue, 03 Nov 2020 15:27:18 -0800 (PST)
MIME-Version: 1.0
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
In-Reply-To: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
From:   Minchan Kim <minchan@kernel.org>
Date:   Tue, 3 Nov 2020 15:27:03 -0800
Message-ID: <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
Subject: Re: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     vjitta@codeaurora.org, linux-mm <linux-mm@kvack.org>
Cc:     glider@google.com, Dan Williams <dan.j.williams@intel.com>,
        broonie@kernel.org, mhiramat@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this mail corrupts the mail thread or had heavy mangling
since I lost this mail from my mailbox so I am sending this mail by
web gmail.

On Thu, Oct 22, 2020 at 10:18 AM <vjitta@codeaurora.org> wrote:
>
> From: Yogesh Lal <ylal@codeaurora.org>
>
> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
>
> Aim is to have configurable value for  STACK_HASH_SIZE,
> so depend on use case one can configure it.
>
> One example is of Page Owner, default value of
> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> Making it configurable and use lower value helps to enable features like
> CONFIG_PAGE_OWNER without any significant overhead.
>
> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  lib/Kconfig      | 9 +++++++++
>  lib/stackdepot.c | 3 +--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 18d76b6..b3f8259 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -651,6 +651,15 @@ config STACKDEPOT
>         bool
>         select STACKTRACE
>
> +config STACK_HASH_ORDER_SHIFT
> +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> +       range 12 20
> +       default 20
> +       depends on STACKDEPOT
> +       help
> +        Select the hash size as a power of 2 for the stackdepot hash table.
> +        Choose a lower value to reduce the memory impact.
> +
>  config SBITMAP
>         bool
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 2caffc6..413c20b 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
>         return stack;
>  }
>
> -#define STACK_HASH_ORDER 20
> -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> +#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)
>  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
>  #define STACK_HASH_SEED 0x9747b28c
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 2.7.4
>

1. When we don't use page_owner, we don't want to waste any memory for
stackdepot hash array.
2. When we use page_owner, we want to have reasonable stackdeport hash array

With this configuration, it couldn't meet since we always need to
reserve a reasonable size for the array.
Can't we make the hash size as a kernel parameter?
With it, we could use it like this.

1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
when we don't use page_owner
2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
when we use page_owner.


-- 
Kind regards,
Minchan Kim
