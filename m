Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD627BDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgI2HNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgI2HNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:13:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ELXndXXTSP15bhYlf8giv2I6wKSj/3tGXdDNG1yeq8I=; b=fK104d7bBl2CIgFMxM8svO3BA1
        hY2IzK2/lLOU2NZ+jZUqL4qyCpZTmpGi8YXEz6Pfan/Xf0HwWHAQzDrxBLfie6SBHcgOem3oum6an
        S2POnkB9xQCAt/IyGv35e38B1boGtIrevNPp8BkSplBuUFqNM2cy7FDtx/yiNrH31Q/s+EW7p37P6
        vzjNO/kln+LGrfQ3CCRIEw8Esoo1a6En/LfUOoqTkGwPsNYd9bjBG0Phh6MPVDkPaSdPpexDJ/r8c
        ulvTjcoGhOoVJP8Aw2nYFy+86QjIMBIKNdLeYdOvEgzNMNwMhpxs6jctznJBzW4wzv2CpVBiHkrcF
        7TQ1bjBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN9pR-0000Hx-Hx; Tue, 29 Sep 2020 07:13:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E1B1300F7A;
        Tue, 29 Sep 2020 09:13:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0798D211CC1CC; Tue, 29 Sep 2020 09:13:34 +0200 (CEST)
Date:   Tue, 29 Sep 2020 09:13:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     quanyang.wang@windriver.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] time/sched_clock: mark sched_clock_read_begin as notrace
Message-ID: <20200929071333.GK2628@hirez.programming.kicks-ass.net>
References: <20200928104952.26892-1-quanyang.wang@windriver.com>
 <20200928105859.GF2628@hirez.programming.kicks-ass.net>
 <20200928173331.3ea3cfb7@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928173331.3ea3cfb7@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:33:31PM -0400, Steven Rostedt wrote:
> On Mon, 28 Sep 2020 12:58:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > > +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > >  {
> > >  	*seq = raw_read_seqcount_latch(&cd.seq);
> > >  	return cd.read_data + (*seq & 1);  
> > 
> > At the very least sched_clock_read_retry() should also be marked such.
> > 
> > But Steve, how come x86 works? Our sched_clock() doesn't have notrace on
> > at all.
> 
> It's because of that magic in the Makefile that you love so much ;-)
> 
> CFLAGS_REMOVE_tsc.o = -pg

ARGH!!, I really should write a script to fix up that mess :/
