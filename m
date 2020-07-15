Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06BB220614
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGOHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:21:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGOHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:21:16 -0400
Date:   Wed, 15 Jul 2020 09:21:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594797674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQKcsIDOp9awa5wYn/MiS0JSdtaDZAuKW8Y1r7Tzr58=;
        b=EMD4enJkqUiQpN/+EBNUOaxkp0MoHUOrBxYA0mA4w9LWfPjvCoYpqcHWBE/kg36etyHmfg
        4pnUSyAfdwCs/LZN+Eu0lNJPKJbh4w7/hZKc/A+aHX9SCsGZr/oLWOl5l2twiTqcMW+rGX
        7Do2G2sAsLjfX7wJ8fob5RL5X+jzdXKi4hkEIhUeTuAZCQrnPaI7GGv0PuYFcigUsn1G/j
        gQ2oLQuRbMhKH5rKa5KW7a6qnUFjzj2GFgcypCvCR5wg8jeI05KmZJ/HtjFhO29TGXpyC+
        SfqbM/6BS99tlLwNIuy/w4GTXJTKRZbvGfe5IP0z+jzj4BUDtCo+gJHTW0jebQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594797674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQKcsIDOp9awa5wYn/MiS0JSdtaDZAuKW8Y1r7Tzr58=;
        b=EOP6n3WooIDvd/2I0f/ZqKRcpxwz12l7P0dSD1vrkYd4039Yq0sz2gktohTSTQiE3slkaW
        8CVrVCHbJH4HTZBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20200715072112.GA231369@debian-buster-darwi.lab.linutronix.de>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
 <20200715065407.GB19269@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715065407.GB19269@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:54:07PM +0800, Leo Yan wrote:
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
>
> Good point.  To be honest, I think myself cannot give a good judgement
> for memory barrier related thing :)
>
> I read a bit the document for the latch technique [1], comparing to
> raw_read_seqcount_latch(), the function raw_read_seqcount() contains
> smp_rmb(), IIUC, the *read* memory barrier is used to support for
> kcsan.
>

The smp_rmb() has no relation whatsoever to KCSAN. It pairs with the
write memory barriers in the seqcount_t write path.

AFAIK, PeterZ is the author of this patch, so let's wait for his input
here.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
