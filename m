Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0027827D4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgI2Rtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgI2Rtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:49:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F765207F7;
        Tue, 29 Sep 2020 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401779;
        bh=xATh57AZpIGmcCcmkus9aGduwYFcRZ27/bzDlNqyfw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qC/LlRTf54MKtIyIZaxFlRRjob6Mb9SKpsvDbkUBIKt5LsXJZ4KbTpUiybtOPrOrx
         2w3pzmlTNHYUQR54isna2dg1qbi1qav0PR4DK1nQlSWicZFQhu7vgNislYxQY98Cyz
         +x07H1ohKx6NTCnmB7jc8P+zbWrtKUetwjXQdQNg=
Date:   Tue, 29 Sep 2020 18:49:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v3 01/10] arm64: pmu: Add hook to handle pmu-related
 undefined instructions
Message-ID: <20200929174933.GF14317@willie-the-truck>
References: <20200911215118.2887710-1-robh@kernel.org>
 <20200911215118.2887710-2-robh@kernel.org>
 <20200928182601.GA11974@willie-the-truck>
 <CAL_Jsq+pNrqBN9TghXxPi2kT_T=pfMXf89diGXqo-RauuLYRuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+pNrqBN9TghXxPi2kT_T=pfMXf89diGXqo-RauuLYRuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:46:46AM -0500, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 1:26 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Sep 11, 2020 at 03:51:09PM -0600, Rob Herring wrote:
> > > +static int emulate_pmu(struct pt_regs *regs, u32 insn)
> > > +{
> > > +     u32 rt;
> > > +     u32 pmuserenr;
> > > +
> > > +     rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
> > > +     pmuserenr = read_sysreg(pmuserenr_el0);
> > > +
> > > +     if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
> > > +         (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
> > > +             return -EINVAL;
> > > +
> > > +
> > > +     /*
> > > +      * Userspace is expected to only use this in the context of the scheme
> > > +      * described in the struct perf_event_mmap_page comments.
> > > +      *
> > > +      * Given that context, we can only get here if we got migrated between
> > > +      * getting the register index and doing the MSR read.  This in turn
> > > +      * implies we'll fail the sequence and retry, so any value returned is
> > > +      * 'good', all we need is to be non-fatal.
> > > +      *
> > > +      * The choice of the value 0 is comming from the fact that when
> > > +      * accessing a register which is not counting events but is accessible,
> > > +      * we get 0.
> > > +      */
> > > +     pt_regs_write_reg(regs, rt, 0);
> >
> > Hmm... this feels pretty fragile since, although we may expect userspace only
> > to trigger this in the context of the specific perf use-case, we don't have
> > a way to detect that, so the ABI we're exposing is that EL0 accesses to
> > non-existent counters will return 0. I don't really think that's something
> > we want to commit to.
> >
> > When restartable sequences were added to the kernel, one of the proposed
> > use-cases was to allow PMU access on big/little systems, because the
> > sequence will abort on preemption. Taking that approach removes the need
> > for this emulation hook entirely. Is that something we can rely on instead
> > of this emulation hook?
> 
> So back to the RFC version[1]!? That would mean pulling librseq into
> the kernel based on the prior discussion. It doesn't look like that
> has happened yet.

Yeah, or just don't bother supporting heterogeneous systems with this
for now.

> Why not just drop the undef hook? For heterogeneous systems, we
> require userspace to pin itself to cores for a specific PMU. See patch
> 9. If userspace fails to do that, then it gets to keep the pieces.

Dropping it works too!

Will
