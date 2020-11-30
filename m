Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555252C7F81
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgK3III (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3III (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:08:08 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:07:21 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f9so17699373ejw.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sejjbzH1VPFW9nCTItPee2k0fSpsfkmZsIeiucrGOg=;
        b=SVdLFF7xWJW5PzYeW9PtVHqnHFgfFlnAz3/olfCk/llK8OyX90C4rRBhMB3CYrHmOe
         A7EpvTlnGEtmlofIG8Hgiq9r91C59oqB8tfqi1kuujktvDkKf8o7UlUTtlV1hf36aIoP
         ifQTGBWYcYhMS1ppQN/oUk/Q35LyHErN3ZSnwtDCCK6SIZsnvGj2bTD7P+hoviTsF/5M
         TNrdCHepOsPVkyAfaNLGCfPri1BI1J3qlk+oXe01glbyFhcSWSuN6NzPZkz75KIHLrxp
         5DU+d17e4kxx+hktfZ+VSAu9y6z9tVRrCQXh7mWdaQvVr/DNys2HPes/DASFldyXZ/Gd
         N/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sejjbzH1VPFW9nCTItPee2k0fSpsfkmZsIeiucrGOg=;
        b=r+sP4SyyRsKCL1/wehQjR5EjVfByZF/wt3Nikgn/EJ15stDedT5F0eOcRvSYdVli6u
         bbfHzDwVfQql75Tj3m0b63HJeRwJkfBwp2WbCrY1c5P9S4sadyJrJOWjXmpEH9TzgK+o
         uWweQ2EqzL1mldWT4f9ZyL6SEWc6nw9SAnc4x2EwrQ2GksN9Zbr2DFkS25mbHa2y/c1v
         6fTYnjiICJggxPwN+tXbW5FDxGUzpYZF8jgEb0aQPCeNPMquQpLI9gRgA63B1uVZFaxQ
         egCQ1ZPomslJ4MCfnejalZV4B+t3eVyhaKACo7feAsVVh1qf8J1QkOxPr2eLL19ksUv9
         envQ==
X-Gm-Message-State: AOAM530WA8Pky+mbphLe8CQ5gStboHojEWR7SKqg7t8h3Ho0be9GotRl
        SCvr7fwlTINnTw9JKMqnvnC2giY57++7GHF68uc=
X-Google-Smtp-Source: ABdhPJzbpC2c788iOfFVJUuzN0hpuqAqFwFMRkrHuYn24eb+BC3ZwkiRkTEK0k9onIQ08SzxIQAQ7/HQE38FSorlRm0=
X-Received: by 2002:a17:906:d8a9:: with SMTP id qc9mr19435353ejb.482.1606723640479;
 Mon, 30 Nov 2020 00:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20201130053037.27006-1-tesheng@andestech.com>
In-Reply-To: <20201130053037.27006-1-tesheng@andestech.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Mon, 30 Nov 2020 10:07:03 +0200
Message-ID: <CAOJsxLH-tCyvydX_+djXNMpOAxW2Zr7rAZizLUwQVNyU8YreBg@mail.gmail.com>
Subject: Re: [PATCH] riscv/mm: Prevent kernel module access user-space memory
 without uaccess routines
To:     Eric Lin <tesheng@andestech.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, dslin1010@gmail.com,
        Alan Kao <alankao@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 7:33 AM Eric Lin <tesheng@andestech.com> wrote:
>
> In the page fault handler, an access to user-space memory
> without get/put_user() or copy_from/to_user() routines is
> not resolved properly. Like arm and other architectures,
> we need to let it die earlier in page fault handler.

Fix looks good to me. Can you elaborate on how you found the issue and
how the bug manifests itself?

>
> Signed-off-by: Eric Lin <tesheng@andestech.com>
> Cc: Alan Kao <alankao@andestech.com>
> ---
>  arch/riscv/mm/fault.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 3c8b9e433c67..a452cfa266a2 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -232,6 +232,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>         if (user_mode(regs))
>                 flags |= FAULT_FLAG_USER;
>
> +       if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM)))
> +               die(regs, "Accessing user space memory without uaccess routines\n");

Let's introduce a die_kernel_fault() helper (similar to arm64, for
example) to ensure same semantics for the different kernel faults. You
can extract the helper from no_context().

> +
>         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>
>         if (cause == EXC_STORE_PAGE_FAULT)
> --
> 2.17.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
