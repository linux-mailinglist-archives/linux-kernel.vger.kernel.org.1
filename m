Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89AB2DCF79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgLQK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLQK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:28:25 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:27:45 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u16so13011216qvl.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NP6eSDSojqskqJOR93wsgn5AO7yZNqVnPL0uMhSoHsQ=;
        b=mJYqIDVd0AhFSVL07HrT9HyQvC/w+/gW4285guL8JmxVc9c6bNYBBvGOBCdjDKgTBD
         HgEbk1W5jT3L5Rww43WHYW0jWip8HIJI951uwOFG8+bOgTgnfZaosvYkuC73CwPG6XFd
         G1KRhwbAUcxDt3mMWmuAiDoPW/a1lAJUEGDOrk06m8yhZCD/vlp2GIkRJVuVmSJi0ybj
         8qB/X8fkDhEhO0OE6YCgfna2tncpvTL5Y9xH0eZVwyCJUod/I3uzwZhxGEyR/GaN53QI
         eICA46+B/F3wjLI/ouER5GMxsQqHDOp5SUlr4teRHUOsabr4aEp4pUau9c20ViYBqnPx
         /2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP6eSDSojqskqJOR93wsgn5AO7yZNqVnPL0uMhSoHsQ=;
        b=tCsyms3PURGPjzvttLg8MFkF9Wp8RoeCSyFuKHuZJhHR+Evb39N5tSVPC8rsREento
         fvXw6zk9295rVbEQnXM8alC5FqWMurPihtZmdFk7gNURL7PN5l2rT4Aq3Hib66k01U3r
         JSMkWPdSYVeVkn57Kk4g+c3UifOUCVQ8QLXnuusPq1qmPyqjtDLUBMs5wvZSQ4B9VW37
         Dw4FER4QsRm7hbsNpVXTPQV/c+Qz5NqESDge/WkpFWSyGJp7FRrMNelhiAAxJB6T/9KA
         bgRmLKCQdKnGWAGuUENXm16tSZOlKEVsiB21C4PnqkmbD0ShihDtqtv4t9Uch+yLf9im
         8yNg==
X-Gm-Message-State: AOAM533cbZNg1NKktjgkfYkMO0KhYk86q9GJTvwR1EIKgU95iA7L8C1h
        s7w0/Nnr2KBH6EQKSbS/uUC3iGtPPkGJoK7OpFOcFg==
X-Google-Smtp-Source: ABdhPJx7nLSnR/Tis+HnXwzK66BwAeJfZseb7hStAC1jV7cxyazWFsnLkwrO4r4OnyHUkA4BG0LrJPxVyfBEq16QhFY=
X-Received: by 2002:a05:6214:487:: with SMTP id ay7mr48227770qvb.37.1608200864306;
 Thu, 17 Dec 2020 02:27:44 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org> <CACT4Y+bO+w50rgbAMPcMMTdyvRRe1nc97Hp-Gm81Ky2s6fOnMQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bO+w50rgbAMPcMMTdyvRRe1nc97Hp-Gm81Ky2s6fOnMQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 11:27:32 +0100
Message-ID: <CACT4Y+Zgg7dTeDtt73dQG1+v7kmb58fA-DQGv2NetwQB2brANg@mail.gmail.com>
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

On Thu, Dec 17, 2020 at 11:25 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Dec 10, 2020 at 6:04 AM <vjitta@codeaurora.org> wrote:
> >
> > From: Yogesh Lal <ylal@codeaurora.org>
> >
> > Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
> >
> > Aim is to have configurable value for STACK_HASH_SIZE, so that one
> > can configure it depending on usecase there by reducing the static
> > memory overhead.
> >
> > One example is of Page Owner, default value of STACK_HASH_SIZE lead
> > stack depot to consume 8MB of static memory. Making it configurable
> > and use lower value helps to enable features like CONFIG_PAGE_OWNER
> > without any significant overhead.
> >
> > Suggested-by: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> > Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> > ---
> >  lib/stackdepot.c | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 81c69c0..e0eebfd 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/stackdepot.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > +#include <linux/vmalloc.h>
> >
> >  #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
> >
> > @@ -141,14 +142,36 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
> >         return stack;
> >  }
> >
> > -#define STACK_HASH_ORDER 20
> > -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> > +#define MAX_STACK_HASH_ORDER 20
> > +#define MAX_STACK_HASH_SIZE (1L << MAX_STACK_HASH_ORDER)
> > +#define STACK_HASH_SIZE (1L << stack_hash_order)
> >  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
> >  #define STACK_HASH_SEED 0x9747b28c
> >
> > -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
> > -       [0 ...  STACK_HASH_SIZE - 1] = NULL
> > +static unsigned int stack_hash_order = 20;
> > +static struct stack_record *stack_table_def[MAX_STACK_HASH_SIZE] __initdata = {
> > +       [0 ...  MAX_STACK_HASH_SIZE - 1] = NULL
> >  };
> > +static struct stack_record **stack_table __refdata = stack_table_def;
> > +
> > +static int __init setup_stack_hash_order(char *str)
> > +{
> > +       kstrtouint(str, 0, &stack_hash_order);
> > +       if (stack_hash_order > MAX_STACK_HASH_ORDER)

Can interrupts happen here?

> > +               stack_hash_order = MAX_STACK_HASH_ORDER;
> > +       return 0;
> > +}
> > +early_param("stack_hash_order", setup_stack_hash_order);
> > +
> > +static int __init init_stackdepot(void)
> > +{
> > +       size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> > +
> > +       stack_table = vmalloc(size);
> > +       memcpy(stack_table, stack_table_def, size);
>
> Can interrupts happen at this point in time? If yes, they can
> use/modify stack_table_def concurrently.
>
> > +       return 0;
> > +}
> > +early_initcall(init_stackdepot);
> >
> >  /* Calculate hash for a stack */
> >  static inline u32 hash_stack(unsigned long *entries, unsigned int size)
> > --
> > 2.7.4
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
