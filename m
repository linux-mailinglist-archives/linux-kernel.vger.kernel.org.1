Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691A82DCF74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgLQK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLQK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:26:50 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919DEC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:26:10 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bd6so12999011qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dPMjrwUyVJ0SctrZbQ7QI+UYy17WeAuqUz3oRrGTfU=;
        b=YjBwGZ/ZowFcu1nU6IrRb8tl/pkkMdBn8V1gJ42p94EX1pGmEurG735ueO/5zZcpVQ
         a562shO7G5LPjfRei2CoR6R4JzTQmGO1mpAl81SP/lbx9sLBs7BGrHqWEoigd9y4gTc1
         u/BfUw6eVyPKuFVpkjvwHfKhLgS3L0TCD+W5YU0/YMwiHLXlfp+TTVPNsPJg3ZLsJmP/
         Xn+fqGt+kAlapzniITfUbYAU7VYLbqn7LP3x0ADwfala5zJ17IOsRipH5zsddhPAMMr5
         ebPlWHJT2vpcYkJ9MitZhe1NWm6Jp2laoi24TD3icAX5DxauBSzf6bkvekMtNUOE0J4U
         WvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dPMjrwUyVJ0SctrZbQ7QI+UYy17WeAuqUz3oRrGTfU=;
        b=RZJPIRavatFvOVv1X+n87WoJj+Qy6JXyAx96zJtjnghG7XvAgs48cOMuBMJcQ0IrKf
         /Dppnb/aVzAabigbubnAmqhIiRgmS9ioJqi5tbTsZMeB66BlDtKibwQ/u4oR/5dVIYqL
         NurOxO5QCFW6Caf0yzyMElmYncXgwb3AJDcmimu7bSDztqjWX+7nyerBUGhtwV7jl/bq
         G7vJ9jk4Xk0nkDdiQTlxzKBDy7jhA2dyK9r6+bv/vwO+qYdBpWPdVkCNt18oG49fL0Sx
         pvNMZFgYA/dF6KUglcVJqq6M8z/ao4iVZ7erONo13ALF2T/jdGD6aYeqfoAMobT6GHLC
         B10w==
X-Gm-Message-State: AOAM530Mi0Tpr+WmEkkVv1U3iDI2dNQ9MZR6Xp07rNEY7zYMByKYuEwo
        3fwdq+BFso/e05cOIIbL7QIZk/z7IXs4jE1Hu5ftgg==
X-Google-Smtp-Source: ABdhPJw6ViU81q3fKrlMj3BtsesB+w3yMtZcZratkm0amrb8si5yL+lPzc+hmJVrlYzF8GfTlPe/QxCEqS+JjKUZP/U=
X-Received: by 2002:a0c:b20d:: with SMTP id x13mr48172339qvd.18.1608200769366;
 Thu, 17 Dec 2020 02:26:09 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
In-Reply-To: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 11:25:57 +0100
Message-ID: <CACT4Y+bO+w50rgbAMPcMMTdyvRRe1nc97Hp-Gm81Ky2s6fOnMQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 6:04 AM <vjitta@codeaurora.org> wrote:
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
>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  lib/stackdepot.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 81c69c0..e0eebfd 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -30,6 +30,7 @@
>  #include <linux/stackdepot.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/vmalloc.h>
>
>  #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
>
> @@ -141,14 +142,36 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
>         return stack;
>  }
>
> -#define STACK_HASH_ORDER 20
> -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> +#define MAX_STACK_HASH_ORDER 20
> +#define MAX_STACK_HASH_SIZE (1L << MAX_STACK_HASH_ORDER)
> +#define STACK_HASH_SIZE (1L << stack_hash_order)
>  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
>  #define STACK_HASH_SEED 0x9747b28c
>
> -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
> -       [0 ...  STACK_HASH_SIZE - 1] = NULL
> +static unsigned int stack_hash_order = 20;
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

Can interrupts happen at this point in time? If yes, they can
use/modify stack_table_def concurrently.

> +       return 0;
> +}
> +early_initcall(init_stackdepot);
>
>  /* Calculate hash for a stack */
>  static inline u32 hash_stack(unsigned long *entries, unsigned int size)
> --
> 2.7.4
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
