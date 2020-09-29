Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4127CFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgI2NrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgI2Nq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:46:59 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C8C21924
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387218;
        bh=g8XcAgcDdCLuUnEGsc4x5tUH7M2XpVkS8jU3ISBpim8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RTD2HHxYM7e/CJXp+98tgz6dnMbrFfMhcTmBottNdz3wL156TAmFU90+XU+XevIb+
         fhVOtCeRJwwZ49CBogToraL7lVha3Lj8AhQf/hwcg1gqVFffKB/njPh8n3gEQtrYkL
         8tAQ9AGASJ8/YdQBPQfi4syXGJExBvIpmiyjuWoM=
Received: by mail-oo1-f47.google.com with SMTP id g26so1277517ooa.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:46:58 -0700 (PDT)
X-Gm-Message-State: AOAM533a1ABtou1b1AQxXy0DV+ChR0JpVWa9h3maHwAyAadsir74kBcd
        Rjj4wekP1En5KcJ5nH2ffBn2RElXXNCEmd7NrQ==
X-Google-Smtp-Source: ABdhPJz6Pc0VWjIQlD0GF6Ki2VCDCnPNuQf2Vf7xpYiNkmwtih6mHNTieirGSSya3vQ0fufPg/uSnA+K5AJ7f40wHrw=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr4688913oos.25.1601387217467;
 Tue, 29 Sep 2020 06:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200911215118.2887710-2-robh@kernel.org>
 <20200928182601.GA11974@willie-the-truck>
In-Reply-To: <20200928182601.GA11974@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 08:46:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pNrqBN9TghXxPi2kT_T=pfMXf89diGXqo-RauuLYRuA@mail.gmail.com>
Message-ID: <CAL_Jsq+pNrqBN9TghXxPi2kT_T=pfMXf89diGXqo-RauuLYRuA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] arm64: pmu: Add hook to handle pmu-related
 undefined instructions
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 1:26 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 11, 2020 at 03:51:09PM -0600, Rob Herring wrote:
> > From: Raphael Gault <raphael.gault@arm.com>
> >
> > This patch introduces a protection for the userspace processes which are
> > trying to access the registers from the pmu registers on a big.LITTLE
> > environment. It introduces a hook to handle undefined instructions.
> >
> > The goal here is to prevent the process to be interrupted by a signal
> > when the error is caused by the task being scheduled while accessing
> > a counter, causing the counter access to be invalid. As we are not able
> > to know efficiently the number of counters available physically on both
> > pmu in that context we consider that any faulting access to a counter
> > which is architecturally correct should not cause a SIGILL signal if
> > the permissions are set accordingly.
> >
> > This commit also modifies the mask of the mrs_hook declared in
> > arch/arm64/kernel/cpufeatures.c which emulates only feature register
> > access. This is necessary because this hook's mask was too large and
> > thus masking any mrs instruction, even if not related to the emulated
> > registers which made the pmu emulation inefficient.
> >
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Fix warning for set but unused sys_reg
> > ---
> >  arch/arm64/kernel/cpufeature.c |  4 +--
> >  arch/arm64/kernel/perf_event.c | 54 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index a389b999482e..00bf53ffd9b0 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2811,8 +2811,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
> >  }
> >
> >  static struct undef_hook mrs_hook = {
> > -     .instr_mask = 0xfff00000,
> > -     .instr_val  = 0xd5300000,
> > +     .instr_mask = 0xffff0000,
> > +     .instr_val  = 0xd5380000,
> >       .pstate_mask = PSR_AA32_MODE_MASK,
> >       .pstate_val = PSR_MODE_EL0t,
> >       .fn = emulate_mrs,
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 462f9a9cc44b..70538ae684da 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -8,9 +8,11 @@
> >   * This code is based heavily on the ARMv7 perf event code.
> >   */
> >
> > +#include <asm/cpu.h>
> >  #include <asm/irq_regs.h>
> >  #include <asm/perf_event.h>
> >  #include <asm/sysreg.h>
> > +#include <asm/traps.h>
> >  #include <asm/virt.h>
> >
> >  #include <clocksource/arm_arch_timer.h>
> > @@ -1016,6 +1018,58 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
> >       return probe.present ? 0 : -ENODEV;
> >  }
> >
> > +static int emulate_pmu(struct pt_regs *regs, u32 insn)
> > +{
> > +     u32 rt;
> > +     u32 pmuserenr;
> > +
> > +     rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
> > +     pmuserenr = read_sysreg(pmuserenr_el0);
> > +
> > +     if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
> > +         (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
> > +             return -EINVAL;
> > +
> > +
> > +     /*
> > +      * Userspace is expected to only use this in the context of the scheme
> > +      * described in the struct perf_event_mmap_page comments.
> > +      *
> > +      * Given that context, we can only get here if we got migrated between
> > +      * getting the register index and doing the MSR read.  This in turn
> > +      * implies we'll fail the sequence and retry, so any value returned is
> > +      * 'good', all we need is to be non-fatal.
> > +      *
> > +      * The choice of the value 0 is comming from the fact that when
> > +      * accessing a register which is not counting events but is accessible,
> > +      * we get 0.
> > +      */
> > +     pt_regs_write_reg(regs, rt, 0);
>
> Hmm... this feels pretty fragile since, although we may expect userspace only
> to trigger this in the context of the specific perf use-case, we don't have
> a way to detect that, so the ABI we're exposing is that EL0 accesses to
> non-existent counters will return 0. I don't really think that's something
> we want to commit to.
>
> When restartable sequences were added to the kernel, one of the proposed
> use-cases was to allow PMU access on big/little systems, because the
> sequence will abort on preemption. Taking that approach removes the need
> for this emulation hook entirely. Is that something we can rely on instead
> of this emulation hook?

So back to the RFC version[1]!? That would mean pulling librseq into
the kernel based on the prior discussion. It doesn't look like that
has happened yet.

Why not just drop the undef hook? For heterogeneous systems, we
require userspace to pin itself to cores for a specific PMU. See patch
9. If userspace fails to do that, then it gets to keep the pieces.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20190625134117.r3gysn7mvzzdrytj@willie-the-truck/
