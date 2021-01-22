Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9C2FFECF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbhAVI41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbhAVIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:55:43 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A99C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:55:02 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id et9so2296845qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBh78Ul9GczjuYP9UDWZfNliAS7jv7SG97xIvLE8KOs=;
        b=r+0kcTQPJqoFhQRPAgQCK5lx9LQFY9iDBMMdWlX22lUS/HUIfLxrGFSxjjMG21I+nq
         /0wTc6Lm57a855bHPxpvfLa9oGRDFgDGRWv4oW1dY5ETzjmZRe56zpZJSw8VEIz5jLrm
         XuUCHYAP1/0oo7Naoyvanf+9ysqRbV4dquLnKFIEbnvRga2yp51oAGaDSqPDhIAbWaMk
         +GlxiKSDrhkL+eAUZusXu7a0F6MfUhfzZlx/uYi0fQm28COmtC1v6agTIV8isZpNwIo3
         ryZ99wiA7xipIzaSnip9IyowZqsvGGVdeWuXeIqJe8RcfogzQ6hDpUOJn2btlpYubEZf
         8Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBh78Ul9GczjuYP9UDWZfNliAS7jv7SG97xIvLE8KOs=;
        b=hXgEbVoeMY2laU+nZ2cHelmhlSfJ2KurbT5B2BA61fedeYePoWxRPDwJNz4aD5Ys4E
         m2LKDmXY/YapbbnmflRf4zAALYRlh9CeYUHlLPzJfW8zaZy/LrNLSettEvyAQ2P5agGa
         WAtjIMlKaymemmzFo07MgwlANF5iKpX0AydKjLYEbGg05IJ2GZkqiRUkXCBJHrWR/uG+
         xZPu1kJ5svq8xruyKVzqBMUwEbUzOyKlFnjCL+l8k6UMwPdkL3wwfDIET8HYX+wnCB84
         a1KLO3eRAJFP7Uifg9f6xd3lAw7fLjXgeheoTPYtoNSqfF6TzqD9cnoTCtGtDQq3QzjI
         PGGg==
X-Gm-Message-State: AOAM531/ZFKLdH4Z0+o631Saq4RJh8uDCwyrSU0fsY7R2ynET84k6mnk
        dSPvhoJJU01DdY57Y0296ag0v8ZFVSwsqBY8l88vdQ==
X-Google-Smtp-Source: ABdhPJz1LoHdsIggwjXMz6Q7Be2qtH11nG+tFY5xwSrvq12vmTrsbQ0sduj7RIu4W14P7giFQ36ajxJk0hS2XfcXR0w=
X-Received: by 2002:a0c:e850:: with SMTP id l16mr3705837qvo.38.1611305701379;
 Fri, 22 Jan 2021 00:55:01 -0800 (PST)
MIME-Version: 1.0
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org> <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
In-Reply-To: <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Jan 2021 09:54:50 +0100
Message-ID: <CAG_fn=X8SPyHWZnxzauAPY2SG-6fpCkjt-umLaDvC4wz3khLVw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:54 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/18/21 1:56 AM, vjitta@codeaurora.org wrote:
> > From: Yogesh Lal <ylal@codeaurora.org>
> >
> > Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
> >
> > Aim is to have configurable value for  STACK_HASH_SIZE,
> > so depend on use case one can configure it.
> >
> > One example is of Page Owner, default value of
> > STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> > Making it configurable and use lower value helps to enable features like
> > CONFIG_PAGE_OWNER without any significant overhead.
> >
> > Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> > Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> > Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>
> Hi,
>
> Did you see
> https://lore.kernel.org/lkml/202101050729.cwTd47Yw-lkp@intel.com/
>
> It seems that arch/arc/ does not have:
>    arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>    (.text+0x6): undefined reference to `__irqentry_text_start'
> >> arc-elf-ld: (.text+0x6): undefined reference to `__irqentry_text_start'
> >> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
> >> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
> >> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
> >> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
> >> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
> >> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
>
Hi Randy,

Could you try out the following patch?

Thanks,
Alex

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 33ce59d91461..94d3f9620d0b 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -83,6 +83,8 @@ SECTIONS

        .text : {
                _text = .;
+               IRQENTRY_TEXT
+               SOFTIRQENTRY_TEXT
                TEXT_TEXT
                SCHED_TEXT
                CPUIDLE_TEXT
