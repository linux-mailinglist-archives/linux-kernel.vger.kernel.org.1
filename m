Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC392206D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgGOIPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGOIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:15:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K/b2gzLoXUAw2gDUZSlQlfPbeMDcCTrXkeWFcHteJ9E=; b=M9zfAwe4IWuymtjYzyffcH5NBQ
        Tc8CS5HMRap2tQUJ31MPk2PAxoJU/DiwZqE4e3lMt8ftk2EgUJIHMe19uAijoO0gGvl9ejZAIaU0C
        tZ/pUHF/F+RKqprtARg6n8L7r9TQ36tEYIMayX3epN9Kd04gBDdl34FK948FsnTpKllmc7r5aMe0V
        yzAdFgpHx5kkoMG0YzSeNyVW6tiADJslaKyi6G3DO3l3LSJcXT87WllSl4plJC3ZAF9+ArM0la2OK
        /bdvV+aBgm5CqxSpkpuQcf6aIplFccGngs2lWjRJySCUxk2sAeqX0UbDy+TI4vOF+FCT7qZPlfEmi
        KR6W9CwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvcYv-0005kx-Uh; Wed, 15 Jul 2020 08:14:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22DB2300130;
        Wed, 15 Jul 2020 10:14:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DC1823648704; Wed, 15 Jul 2020 10:14:43 +0200 (CEST)
Date:   Wed, 15 Jul 2020 10:14:43 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, jogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Message-ID: <20200715081443.GB43129@hirez.programming.kicks-ass.net>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
 <20200715081222.GB10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715081222.GB10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:12:22AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 15, 2020 at 07:56:50AM +0200, Ahmed S. Darwish wrote:
> > On Wed, Jul 15, 2020 at 10:05:07AM +0800, Leo Yan wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > ...
> > >
> > > Provide struct clock_read_data and two (seqcount) helpers so that
> > > architectures (arm64 in specific) can expose the numbers to userspace.
> > >
> > ...
> > >
> > > +struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > > +{
> > > +	*seq = raw_read_seqcount(&cd.seq);
> > > +	return cd.read_data + (*seq & 1);
> > > +}
> > > +
> > ...
> > 
> > Hmm, this seqcount_t is actually a latch seqcount. I know the original
> > code also used raw_read_seqcount(), but while at it, let's use the
> > proper read API for seqcount_t latchers: raw_read_seqcount_latch().
> > 
> > raw_read_seqcount_latch() has no read memory barrier though, and a
> > suspicious claim that READ_ONCE() pairs with an smp_wmb() (??). But if
> > its implementation is wrong, let's fix it there instead.
> 
> It's supposed to be a dependent load, so READ_ONCE() is sufficient.
> Except, of course, the C standard has other ideas, so a compiler is
> allowed to wreck that, but they mostly don't :-)

Also see:

  https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net
