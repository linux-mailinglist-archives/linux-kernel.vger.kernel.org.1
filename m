Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588A3254546
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgH0MsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgH0Me4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:34:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF84C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:34:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x143so3383932pfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QQzTLJnBa36P3H2hTUyCcrUla2gQmiA7N8bvUye5ww=;
        b=uYOH6B48y6njJ6nOhh7bzhqeTJ3WdinzCFT9hIYxW7pf23M1KEtMkaICjyHIIwiEDq
         Kbsn9tO6FZclxYcMvNLidIbrOHlY6EsI1Uf5yHVFu2UW05R82qWxv6f4SajSvSUYY5wd
         o1Jo+t+JhODnJqU6BOGDHGZatMyUTgFPKUJvClaQHt7gTc8KMBmmt1okOso2IkCEHeu5
         /9ibjpOa5mKRBm6BW7OhWyU93dSuRCZIwDokWjVbp0VsnwBtMoHG0WDo0OQsNOMHWIYu
         RRJhyggJcTDJT7WlGga3bFYCCaPJ07RFE+iFNIGWfNZSlLTVIAgdDBHP41ECZTpzT6ty
         3utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QQzTLJnBa36P3H2hTUyCcrUla2gQmiA7N8bvUye5ww=;
        b=Ca1V3Trdooe8TfkGBrrD4Zst3itnfBp0hpbgnqWGttlfAr18IX2MmS1EEiC6RdHh/1
         aV1iJMGJQMuh2E2qKdajdaazGm6rGmhLZy02Rys0HjQTJ1ADUV2PZlbned8N2hqVM/pB
         L1IAItDXrI+b6ZRewgFHHVd75uwxbPqJt9C3CJMkKoZnopYgjd7dzwZCZk8KbQzM2q/O
         +UGvFtAGOxYmNnXl5ZBnQrmB4uN6ugzqerhL+SZFTQBtVYg0zqO7+OOu1n0F29NAW60A
         knjQ7FW4qIFsZFCnibrp0g/yLpZMyrLkQSbMIEHzTNeCklq7n+90BvY3sA7c++fzYgaK
         /jGQ==
X-Gm-Message-State: AOAM531VvasAGxkboEjBvaLmMzGnUXPQJBkmnGTTPGQeToe7A4dmphSL
        F3lw6Au4RJgOnqCoE7MKedLNX5n7QPph6gVAkJJhMg==
X-Google-Smtp-Source: ABdhPJwQvcLUtER5Ks8hleRdsk9c2HrTabX2FVUhlXdZKYuGVbjvNQk+xGe46zGntRyn3AgYfTecHAxmWoF1WxIPLG0=
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr16297954pls.115.1598531682160;
 Thu, 27 Aug 2020 05:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <4691d6019ef00c11007787f5190841b47ba576c4.1597425745.git.andreyknvl@google.com>
 <20200827104816.GI29264@gaia>
In-Reply-To: <20200827104816.GI29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:34:31 +0200
Message-ID: <CAAeHK+zO8EJrmX5NjkKTB35eot1rDLjoqGyfoqF_quDV=VEvrQ@mail.gmail.com>
Subject: Re: [PATCH 32/35] kasan, arm64: print report from tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:48 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:14PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index c62c8ba85c0e..cf00b3942564 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/init.h>
> > +#include <linux/kasan.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/page-flags.h>
> > @@ -314,11 +315,19 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
> >  {
> >       bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +     /*
> > +      * SAS bits aren't set for all faults reported in EL1, so we can't
> > +      * find out access size.
> > +      */
> > +     kasan_report(addr, 0, is_write, regs->pc);
> > +#else
> >       pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
> >       pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
> >       pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
> >                       mte_get_ptr_tag(addr),
> >                       mte_get_mem_tag((void *)addr));
> > +#endif
> >  }
>
> More dead code. So what's the point of keeping the pr_alert() introduced
> earlier? CONFIG_KASAN_HW_TAGS is always on for in-kernel MTE. If MTE is
> disabled, this function isn't called anyway.

I was considering that we can enable in-kernel MTE without enabling
CONFIG_KASAN_HW_TAGS, but perhaps this isn't what we want. I'll drop
this part in v2, but then we also need to make sure that in-kernel MTE
is only enabled when CONFIG_KASAN_HW_TAGS is enabled. Do we need more
ifdefs in arm64 patches when we write to MTE-related registers, or
does this work as is?
