Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB42AF6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgKKQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgKKQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:43:32 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:43:32 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so2244500qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCmNt8Y7TG2qC30JLVGE0QaE5aTQ8urrjUT5uMsrL4A=;
        b=N3Tu/9McrVluPFT0SSQ371uoqPA1FT6EYTax2BvhQv3QYHxGRfqhEY77v00wecumar
         qKjJEBFuKz+93htKIZCaQ4XcWikvj4cVquRrf6gIboEdpuxaM42emzxkE1CvLokWTxs5
         OwqBc++LTDtxaZaNnRR0ZxO7Cbr19XXvqPnihkLMJTOPvEjqvuam12U/11ma2fXMwNph
         gVuHnS9KaLDx6WMKclLIQrYjrHuTH91GfWFXGYDfIM1p1nksYjUNPYievHMhN1aFb1iV
         MLfbFu+IWCTvbeqYBWjdXxBPSTJEBoOymLmcESIVqdMYGlU4WWRJMawHvBDdKnvkShB2
         gqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCmNt8Y7TG2qC30JLVGE0QaE5aTQ8urrjUT5uMsrL4A=;
        b=HnORKlwFlXJ2b0Xe0GPCXoL6BN5CUlAF65wNJ1t3VwoNL7aTB2w2kJbh9ha8DnYTmI
         7/SGyauM+/VDjbRD6Uvf00a84SFhVjRfNN1BTII6qw1JZlNh5xGRyC8YoNCx/dglB5RR
         aT4OPYq/yLrvoP4bp8POdG/ZK9rqwnEnOu8GsjD6nM1DfmC5Zq9hpfKKSJb7K/LXDb/M
         WArwl05N02h7KrRZwSciuOMncwAkUNMAE4/9iBE7Ua5yReYSu26NO75hlJMfZO35pgS3
         JcQmz5k+NtzWvC3+cAItqKRvKqEQboywDDVzntj8yI47bTH+vufgAbdHTNyU75X7pNPK
         6/RQ==
X-Gm-Message-State: AOAM533IwcI/99BC/R3F/QEq/Od8qNamvcBH6S0Z/csgOB9DYqenhE9/
        E8eFR93VkFwmzZt2AW/jxisgqQsz3fWsMPftAFDUJw==
X-Google-Smtp-Source: ABdhPJx3u/lMLjOAM4Buf/5TnhtqfBq7l2lU0YA9YW8h6QT2mfA08cn83KzPwLiXhavZC/QVF8tHkPytRVppQLIct5o=
X-Received: by 2002:a05:620a:f95:: with SMTP id b21mr17412423qkn.403.1605113011275;
 Wed, 11 Nov 2020 08:43:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <fe78d723ba64456d68754a944fa93fe4a25c730f.1605046192.git.andreyknvl@google.com>
In-Reply-To: <fe78d723ba64456d68754a944fa93fe4a25c730f.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:43:19 +0100
Message-ID: <CAG_fn=VkuY7+oDOLWZEvvbxFw6Gduq-XK5r_dn7sEkmYqJA-tA@mail.gmail.com>
Subject: Re: [PATCH v9 40/44] kasan, arm64: print report from tag fault handler
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Add error reporting for hardware tag-based KASAN. When CONFIG_KASAN_HW_TA=
GS
> is enabled, print KASAN report from the arm64 tag fault handler.
>
> SAS bits aren't set in ESR for all faults reported in EL1, so it's
> impossible to find out the size of the access the caused the fault.
> Adapt KASAN reporting code to handle this case.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I3780fe7db6e075dff2937d3d8508f55c9322b095
> ---
>  arch/arm64/mm/fault.c | 14 ++++++++++++++
>  mm/kasan/report.c     | 11 ++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index fbceb14d93b1..7370e822e588 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
> +#include <linux/kasan.h>
>  #include <linux/kprobes.h>
>  #include <linux/uaccess.h>
>  #include <linux/page-flags.h>
> @@ -297,10 +298,23 @@ static void die_kernel_fault(const char *msg, unsig=
ned long addr,
>         do_exit(SIGKILL);
>  }
>
> +#ifdef CONFIG_KASAN_HW_TAGS
>  static void report_tag_fault(unsigned long addr, unsigned int esr,
>                              struct pt_regs *regs)
>  {
> +       bool is_write  =3D ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) !=
=3D 0;
> +
> +       /*
> +        * SAS bits aren't set for all faults reported in EL1, so we can'=
t
> +        * find out access size.
> +        */
> +       kasan_report(addr, 0, is_write, regs->pc);
>  }
> +#else
> +/* Tag faults aren't enabled without CONFIG_KASAN_HW_TAGS. */
> +static inline void report_tag_fault(unsigned long addr, unsigned int esr=
,
> +                                   struct pt_regs *regs) { }
> +#endif
>
>  static void do_tag_recovery(unsigned long addr, unsigned int esr,
>                            struct pt_regs *regs)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8afc1a6ab202..ce06005d4052 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -62,9 +62,14 @@ static void print_error_description(struct kasan_acces=
s_info *info)
>  {
>         pr_err("BUG: KASAN: %s in %pS\n",
>                 get_bug_type(info), (void *)info->ip);
> -       pr_err("%s of size %zu at addr %px by task %s/%d\n",
> -               info->is_write ? "Write" : "Read", info->access_size,
> -               info->access_addr, current->comm, task_pid_nr(current));
> +       if (info->access_size)
> +               pr_err("%s of size %zu at addr %px by task %s/%d\n",
> +                       info->is_write ? "Write" : "Read", info->access_s=
ize,
> +                       info->access_addr, current->comm, task_pid_nr(cur=
rent));
> +       else
> +               pr_err("%s at addr %px by task %s/%d\n",
> +                       info->is_write ? "Write" : "Read",
> +                       info->access_addr, current->comm, task_pid_nr(cur=
rent));
>  }
>
>  static DEFINE_SPINLOCK(report_lock);
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/fe78d723ba64456d68754a944fa93fe4a25c730f.1605046192.git.andreyk=
nvl%40google.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
