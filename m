Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F922B9ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgKSSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbgKSSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:35:31 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46E0246CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605810930;
        bh=wlJ1GDVVeXAbBkkmi14KlMvU2urktf8h2JpAHV4i6jo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BaAKpY4B24EfvMT3uqE64Ferx5asNPPVeB0h3F6EBacxs0jOsVpc7iRJihmmQ/wP/
         ByW6zT0cCrSh8fWOt4udvaftg1fJreYzb3Bj6HEFpGGhCC4bEM+dLkn1GxtMeAEQk7
         bCXsuPXCMTCMBtNiYGWL+5ciHK9q+XcPGKpWoFfo=
Received: by mail-oi1-f172.google.com with SMTP id k26so7446562oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:35:29 -0800 (PST)
X-Gm-Message-State: AOAM5312U6/f70WI0kW42ULeufEdZ1l6k973y2yIxHVwHLIicq3AtYdN
        LSZfrcgAzCNENsvszBYWBmxu7q7uR7gkyb20wA==
X-Google-Smtp-Source: ABdhPJzKvl9CsPFgaFOYAfzD0LmkB3MDOIJ60Uiqq/uiyvYNpehQHZjQ+nSnD3RWjz7ENROuocGO/gSfIDABqVHFqhs=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr3863325oii.152.1605810928997;
 Thu, 19 Nov 2020 10:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20201001140116.651970-1-robh@kernel.org> <20201001140116.651970-3-robh@kernel.org>
 <20201113180633.GE44988@C02TD0UTHF1T.local>
In-Reply-To: <20201113180633.GE44988@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Nov 2020 12:35:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKM+91Meg+u07VRsD5=O1srQooe1Dd_M3NA+CZgcN4QcQ@mail.gmail.com>
Message-ID: <CAL_JsqKM+91Meg+u07VRsD5=O1srQooe1Dd_M3NA+CZgcN4QcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] arm64: perf: Enable pmu counter direct access for
 perf event on armv8
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:06 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Rob,
>
> Thanks for this, and sorry for the long delay since this was last
> reviewed. Overall this is looking pretty good, but I have a couple of
> remaining concerns.
>
> Will, I have a query for you below.
>
> On Thu, Oct 01, 2020 at 09:01:09AM -0500, Rob Herring wrote:
> > From: Raphael Gault <raphael.gault@arm.com>
> >
> > Keep track of event opened with direct access to the hardware counters
> > and modify permissions while they are open.
> >
> > The strategy used here is the same which x86 uses: everytime an event
> > is mapped, the permissions are set if required. The atomic field added
> > in the mm_context helps keep track of the different event opened and
> > de-activate the permissions when all are unmapped.
> > We also need to update the permissions in the context switch code so
> > that tasks keep the right permissions.
> >
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Move mapped/unmapped into arm64 code. Fixes arm32.
> >  - Rebase on cap_user_time_short changes
> >
> > Changes from Raphael's v4:
> >   - Drop homogeneous check
> >   - Disable access for chained counters
> >   - Set pmc_width in user page
> > ---
> >  arch/arm64/include/asm/mmu.h         |  5 ++++
> >  arch/arm64/include/asm/mmu_context.h |  2 ++
> >  arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
> >  arch/arm64/kernel/perf_event.c       | 41 ++++++++++++++++++++++++++++
> >  4 files changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index a7a5ecaa2e83..52cfdb676f06 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -19,6 +19,11 @@
> >
> >  typedef struct {
> >       atomic64_t      id;
> > +     /*
> > +      * non-zero if userspace have access to hardware
> > +      * counters directly.
> > +      */
> > +     atomic_t        pmu_direct_access;
> >  #ifdef CONFIG_COMPAT
> >       void            *sigpage;
> >  #endif
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index f2d7537d6f83..d24589ecb07a 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -21,6 +21,7 @@
> >  #include <asm/proc-fns.h>
> >  #include <asm-generic/mm_hooks.h>
> >  #include <asm/cputype.h>
> > +#include <asm/perf_event.h>
> >  #include <asm/sysreg.h>
> >  #include <asm/tlbflush.h>
> >
> > @@ -224,6 +225,7 @@ static inline void __switch_mm(struct mm_struct *next)
> >       }
> >
> >       check_and_switch_context(next);
> > +     perf_switch_user_access(next);
> >  }
> >
> >  static inline void
> > diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> > index 2c2d7dbe8a02..a025d9595d51 100644
> > --- a/arch/arm64/include/asm/perf_event.h
> > +++ b/arch/arm64/include/asm/perf_event.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <asm/stack_pointer.h>
> >  #include <asm/ptrace.h>
> > +#include <linux/mm_types.h>
> >
> >  #define      ARMV8_PMU_MAX_COUNTERS  32
> >  #define      ARMV8_PMU_COUNTER_MASK  (ARMV8_PMU_MAX_COUNTERS - 1)
> > @@ -251,4 +252,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
> >       (regs)->pstate = PSR_MODE_EL1h; \
> >  }
> >
> > +static inline void perf_switch_user_access(struct mm_struct *mm)
> > +{
> > +     if (!IS_ENABLED(CONFIG_PERF_EVENTS))
> > +             return;
> > +
> > +     if (atomic_read(&mm->context.pmu_direct_access)) {
> > +             write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
> > +                          pmuserenr_el0);
> > +     } else {
> > +             write_sysreg(0, pmuserenr_el0);
> > +     }
> > +}
>
> PMUSERENR.ER gives RW access to PMSELR_EL0. While we no longer use
> PMSELR_EL0 in the kernel, we can preempt and migrate userspace tasks
> between homogeneous CPUs, and presumably need to context-switch this
> with the task (like we do for TPIDR_EL0 and friends), or clear the
> register on context-switch to prevent it becoming an unintended covert
> channel.

Humm, now that I've read up on PMSELR_EL0 I'm now wondering if I
should be using PMSELR_EL0 in libperf. If you look at patch 7, the
counter read is pretty ugly because there's 32 possible mrs
instructions. If PMSELR_EL0 is used, we can have a single read path.
It's a msr and mrs vs. a function ptr load, branch/ret, and mrs. I'd
guess there's no guarantees on system reg access times, but I'd guess
typically the former is more optimal? It certainly simplifies the code
which I'd rather have given the limited users.

If I go that route and we don't context switch PMSELR_EL0, reads of
PMXEVCNTR_EL0 could be stale. But does that matter? No, because
reading PMEVCNTR<n>_EL0 can already be stale and the seq counter will
catch that.

> These bits also enable AArch32 access. Is there any way an AArch32 task
> can enable this? If so we should probably block that given we do not
> support this interface on 32-bit arm.

I'd assume this works for AArch32 given we don't do anything here to
prevent it. I suppose we could look at MMCF_AARCH32 flag in
mm_context_t? But is not implemented for arch/arm/ really a reason to
disable?

Rob
