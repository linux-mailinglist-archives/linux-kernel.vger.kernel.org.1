Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533572614D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgIHQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgIHQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E8C061A01
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:02:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so5710802pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB5vJBBCtNhXMgKB2GrADyceasBad1luqBoSGuNUjz8=;
        b=p9feilB1M35mHPB65haOwv2e+Ui0Qw1FZR6nJHx+HtJ5jdCWL+Vw+aGtIfvQo1r1OJ
         0aHmvXgoDtAt/sBoiUVFV59gpc7u5lw8lcsFx+Yj3j79cT4WAP1MKg/yMvt1A90Qnr8V
         sD47h4UkaS+Ytrx40Sw8u+S7bIUHR3X0fSnVhGHgJLbbSyVQN6TnKb/P8CQmNn6TI69v
         Vd+X3f7izf2lMBoCiIHx2Z3/Mn4O07a+wOiNjeYSiSi6/azINfDQiyib/FAzB+3VwhQU
         +MAAJBmSsxhesuQWvcBOlU6uNChiTz9g7zt9S1akiMJl+zb91tDeOjIiaIywtwJRjiVo
         LiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB5vJBBCtNhXMgKB2GrADyceasBad1luqBoSGuNUjz8=;
        b=hrwJnAdf9QagmWrdrGwhuVAdCjcyqF+kBHrTzMzqNJhcUUxYZz+97NwwZMwSTCq86T
         t3hZFfMleci5LGO/JkG7La09feXDRyW3pRqF4Nwm0do81KgkXwuIDi4LszU2LYGSG36z
         wuxz9L36n+QiKkMd0pn3DxIv+Hep5qlt3trJvUVCJlmDfu+iA2gC7dC/Qno9KEfvDQH5
         +zUn3ZHvF3VTFzv5bsZg5qYWvpZBSo11bV3HGFHD+RauhsH4E/di/5Z0bRwzsCYMqlFC
         ILAEx8UtAv9TA8p/A5aNF59b9eWp86hA9izyuhTM2lznRRkBys1GN1vTWCtsfAdtp8b1
         hHCw==
X-Gm-Message-State: AOAM530qyi0GzWPTnMnnBmxwOYyftgu30bKtBU4ZnLg787wDH5+pw2f1
        E0Ae5JJRqXz1z14vpc3wPeOwyjRhNmIJs/EkDoDEfw==
X-Google-Smtp-Source: ABdhPJwVsPMlGPGLSvUSlwAf67m6wSrtn8ecy42/I0lrRYwzO3XiWHqxki87TpJgnhSMr6md8e+Pc2LRgwAFcX0H4MU=
X-Received: by 2002:a17:90a:81:: with SMTP id a1mr3986021pja.136.1599573737858;
 Tue, 08 Sep 2020 07:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia> <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com> <20200827121604.GL29264@gaia>
In-Reply-To: <20200827121604.GL29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 16:02:06 +0200
Message-ID: <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Aug 27, 2020 at 2:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Aug 27, 2020 at 11:56:49AM +0100, Vincenzo Frascino wrote:
> > On 8/27/20 11:38 AM, Catalin Marinas wrote:
> > > On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> > >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > >> index 7717ea9bc2a7..cfac7d02f032 100644
> > >> --- a/arch/arm64/kernel/mte.c
> > >> +++ b/arch/arm64/kernel/mte.c
> > >> @@ -18,10 +18,14 @@
> > >>
> > >>  #include <asm/barrier.h>
> > >>  #include <asm/cpufeature.h>
> > >> +#include <asm/kasan.h>
> > >> +#include <asm/kprobes.h>
> > >>  #include <asm/mte.h>
> > >>  #include <asm/ptrace.h>
> > >>  #include <asm/sysreg.h>
> > >>
> > >> +u64 gcr_kernel_excl __read_mostly;
> > >
> > > Could we make this __ro_after_init?
> >
> > Yes, it makes sense, it should be updated only once through mte_init_tags().
> >
> > Something to consider though here is that this might not be the right approach
> > if in future we want to add stack tagging. In such a case we need to know the
> > kernel exclude mask before any C code is executed. Initializing the mask via
> > mte_init_tags() it is too late.
>
> It depends on how stack tagging ends up in the kernel, whether it uses
> ADDG/SUBG or not. If it's only IRG, I think it can cope with changing
> the GCR_EL1.Excl in the middle of a function.
>
> > I was thinking to add a compilation define instead of having gcr_kernel_excl in
> > place. This might not work if the kernel excl mask is meant to change during the
> > execution.
>
> A macro with the default value works for me. That's what it basically is
> currently, only that it ends up in a variable.

Some thoughts on the topic: gcr_kernel_excl is currently initialized
in mte_init_tags() and depends on the max_tag value dynamically
provided to it, so it's not something that can be expressed with a
define. In the case of KASAN the max_tag value is static, but if we
rely on that we make core MTE code depend on KASAN, which doesn't seem
right from the design perspective.
