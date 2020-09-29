Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2864927D931
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgI2Uqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgI2Uqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:46:53 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2511E21548
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601412412;
        bh=JHw1Uf5slsOiDNTKZL8Fbrvk/TKjzxBGYnnwKlEm5gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0sSaEX7L/mAwF2/mcK0erDt3iwi2ndSAx2EDoSq5NIUtHMvFTMsSdEvv3d28pe7Fl
         0gHNB/L03tXmgnWQmywMlehku1uM/tC1GCKRrI+vy4K04cSFiSHBbpxt9TzrcxZrm2
         FADoiAG4LgPLFKo/WBDiCWWfrp084QUhCC/CKQYI=
Received: by mail-ot1-f43.google.com with SMTP id q21so5825738ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:46:52 -0700 (PDT)
X-Gm-Message-State: AOAM532KI/EfJsPj5zOZB3yKi4V2AqgrRn6LLWcBGlQphoEqb1e6Xage
        h7RlZUnPOgvo+SPBCUifjmCWNBrrjm8Gbih2Eg==
X-Google-Smtp-Source: ABdhPJyfd913FA/oUSPfYTVepgeuEPzJPsvt3+EaI8pfiIXrX2MlunOw0oOWw+PHOFFHwB8bC9eH9CPQ/gI5julmCPk=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr3762612otp.107.1601412411216;
 Tue, 29 Sep 2020 13:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200911215118.2887710-2-robh@kernel.org>
 <20200928182601.GA11974@willie-the-truck> <CAL_Jsq+pNrqBN9TghXxPi2kT_T=pfMXf89diGXqo-RauuLYRuA@mail.gmail.com>
 <20200929174933.GF14317@willie-the-truck>
In-Reply-To: <20200929174933.GF14317@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 15:46:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tY+C7y75OYCFOKQZVQtp47HTXs3y4T_9AqaW7oCm+Eg@mail.gmail.com>
Message-ID: <CAL_Jsq+tY+C7y75OYCFOKQZVQtp47HTXs3y4T_9AqaW7oCm+Eg@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 12:49 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Sep 29, 2020 at 08:46:46AM -0500, Rob Herring wrote:
> > On Mon, Sep 28, 2020 at 1:26 PM Will Deacon <will@kernel.org> wrote:
> > > On Fri, Sep 11, 2020 at 03:51:09PM -0600, Rob Herring wrote:
> > > > +static int emulate_pmu(struct pt_regs *regs, u32 insn)
> > > > +{
> > > > +     u32 rt;
> > > > +     u32 pmuserenr;
> > > > +
> > > > +     rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
> > > > +     pmuserenr = read_sysreg(pmuserenr_el0);
> > > > +
> > > > +     if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
> > > > +         (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
> > > > +             return -EINVAL;
> > > > +
> > > > +
> > > > +     /*
> > > > +      * Userspace is expected to only use this in the context of the scheme
> > > > +      * described in the struct perf_event_mmap_page comments.
> > > > +      *
> > > > +      * Given that context, we can only get here if we got migrated between
> > > > +      * getting the register index and doing the MSR read.  This in turn
> > > > +      * implies we'll fail the sequence and retry, so any value returned is
> > > > +      * 'good', all we need is to be non-fatal.
> > > > +      *
> > > > +      * The choice of the value 0 is comming from the fact that when
> > > > +      * accessing a register which is not counting events but is accessible,
> > > > +      * we get 0.
> > > > +      */
> > > > +     pt_regs_write_reg(regs, rt, 0);
> > >
> > > Hmm... this feels pretty fragile since, although we may expect userspace only
> > > to trigger this in the context of the specific perf use-case, we don't have
> > > a way to detect that, so the ABI we're exposing is that EL0 accesses to
> > > non-existent counters will return 0. I don't really think that's something
> > > we want to commit to.
> > >
> > > When restartable sequences were added to the kernel, one of the proposed
> > > use-cases was to allow PMU access on big/little systems, because the
> > > sequence will abort on preemption. Taking that approach removes the need
> > > for this emulation hook entirely. Is that something we can rely on instead
> > > of this emulation hook?
> >
> > So back to the RFC version[1]!? That would mean pulling librseq into
> > the kernel based on the prior discussion. It doesn't look like that
> > has happened yet.
>
> Yeah, or just don't bother supporting heterogeneous systems with this
> for now.

But the people are asking for it. :)

> > Why not just drop the undef hook? For heterogeneous systems, we
> > require userspace to pin itself to cores for a specific PMU. See patch
> > 9. If userspace fails to do that, then it gets to keep the pieces.
>
> Dropping it works too!

Great. I asked Mark R to comment in case I'm forgetting some other reason.

Rob
